package frame.server.controller.consumables;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;

import frame.server.annotation.OperationAnnotation;
import frame.server.constant.Messages;
import frame.server.constant.PermissionsConstant;
import frame.server.controller.BaseController;
import frame.server.domain.OperationSnapshot;
import frame.server.dao.OperationSnapshotDao;
import frame.server.service.OperationService;
import frame.server.utils.ApiResultUtil;
import frame.server.utils.StringUtil;
import frame.server.vo.ApiResult;
import frame.server.vo.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Api(tags = "消耗品管理系统-操作日志管理控制器")
@RequestMapping("/cOperationLog")
@RestController
public class COperationLogController extends BaseController {

    @Autowired
    private OperationService operationService;

    @Autowired
    private OperationSnapshotDao operationSnapshotDao;

    @ApiOperation(value = "消耗品管理系统：获取系统操作日志(分页)")
    @OperationAnnotation(value = "消耗品管理系统：获取系统操作日志")
    @RequiresPermissions(PermissionsConstant.C_USEROPERATE_SELECT_STR)
    @RequestMapping(value = "/getLogs", method = RequestMethod.POST)
    public ApiResult getLogs(Page page) {
        return ApiResultUtil.success(operationService.getLogs(page));
    }

    @ApiOperation(value = "消耗品管理系统：获取某条操作的字段变更详情")
    @OperationAnnotation(value = "消耗品管理系统：获取操作字段变更详情")
    @RequestMapping(value = "/getSnapshot", method = RequestMethod.GET)
    public ApiResult getSnapshot(String operationId) {
        if (StringUtil.isBlank(operationId)) {
            return ApiResultUtil.badRequest(Messages.badRequest);
        }
        return ApiResultUtil.success(operationSnapshotDao.selectByOperationId(operationId));
    }
}