package frame.server.aspect;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.fastjson.JSON;

import frame.server.annotation.OperationAnnotation;
import frame.server.constant.JwtClaimConstant;
import frame.server.domain.Operation;
import frame.server.service.OperationService;
import frame.server.utils.IpUtil;
import frame.server.utils.JwtUtil;
import frame.server.utils.RandomUtil;
import frame.server.utils.StringUtil;

@Aspect
@Component
public class OperationAspect {

	@Autowired
	private OperationService operationService;

	@Pointcut("@annotation(frame.server.annotation.OperationAnnotation)")
	public void OperationPoinCut() {
	}

	@Around("OperationPoinCut()")
	public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
		long startTime = System.currentTimeMillis();
		String params = getParams(joinPoint.getArgs());
		String className = joinPoint.getTarget().getClass().getName();
		MethodSignature signature = (MethodSignature) joinPoint.getSignature();
		String methodName = signature.getMethod().getName();
		Method method = signature.getMethod();
		OperationAnnotation annotation = method.getAnnotation(OperationAnnotation.class);
		String operationDesc = annotation != null ? annotation.value() : "";

		try {
			Object result = joinPoint.proceed();
			long duration = System.currentTimeMillis() - startTime;
			saveOperation(className, methodName, operationDesc, params, null, duration, true);
			return result;
		} catch (Throwable e) {
			long duration = System.currentTimeMillis() - startTime;
			saveOperation(className, methodName, operationDesc + "【失败:" + e.getMessage() + "】",
					params, e.getMessage(), duration, false);
			throw e;
		}
	}

	private String getParams(Object[] args) {
		if (args == null || args.length == 0) {
			return "";
		}
		List<Object> list = new ArrayList<>();
		for (Object arg : args) {
			if (arg != null && arg.getClass() != BeanPropertyBindingResult.class) {
				list.add(arg);
			}
		}
		return list.isEmpty() ? "" : JSON.toJSONString(list);
	}

	private void saveOperation(String className, String methodName, String operationDesc,
	                           String params, String errorMsg, long duration, boolean success) {
		Operation operation = new Operation();
		operation.setId(RandomUtil.genarateId());

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String token = request.getHeader("Authorization");
		if (StringUtil.isBlank(token)) {
			operation.setUserId("");
		} else {
			operation.setUserId(operationService.getUserId(JwtUtil.getClaim(token, JwtClaimConstant.ACCOUNT)));
		}

		operation.setOperation(operationDesc);
		operation.setMethod(className + "." + methodName + " [" + duration + "ms]");
		operation.setParams(params);
		operation.setIp(IpUtil.getIpAddr(request));
		operation.setCreateTime(new Date());
		operationService.saveOperation(operation);
	}
}