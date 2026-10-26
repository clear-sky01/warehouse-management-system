package frame.server.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import frame.server.dao.OperationDao;
import frame.server.dao.UserDao;
import frame.server.domain.Operation;
import frame.server.domain.User;
import frame.server.dto.OperationDto;
import frame.server.service.OperationService;
import frame.server.utils.StringUtil;
import frame.server.vo.Page;

@Service("operationService")
public class OperationServiceImpl implements OperationService {

	@Autowired
	private OperationDao operationDao;

	@Autowired
	private UserDao userDao;

	@Override
	public String getUserId(String account) {
		User user = userDao.selectUserByAccount(account);
		if (user == null) {
			return null;
		}
		return user.getId();
	}

	@Override
	public void saveOperation(Operation operation) {
		operationDao.insert(operation);
	}

	@Override
	public PageInfo<OperationDto> getLogs(Page page) {
		PageHelper.startPage(page.getPageNum(), page.getPageSize());

		JSONObject searchCondition = page.getSearchCondition();
		if (searchCondition == null) {
			return new PageInfo<>(operationDao.selectAll());
		}

		String searchType = searchCondition.getString("searchType");
		String searchStr = searchCondition.getString("searchStr");
		String startTime = searchCondition.getString("startTime");
		String endTime = searchCondition.getString("endTime");

		// 有时间范围筛选
		if (!StringUtil.isBlank(startTime) && !StringUtil.isBlank(endTime)) {
			return new PageInfo<>(operationDao.selectByTimeRange(startTime, endTime));
		}

		// 有搜索关键词
		if (!StringUtil.isBlank(searchStr)) {
			if ("1".equals(searchType)) {
				return new PageInfo<>(operationDao.selectByUserId(searchStr));
			} else if ("2".equals(searchType)) {
				return new PageInfo<>(operationDao.selectByUserIdAndOperation(searchStr, searchStr));
			} else {
				return new PageInfo<>(operationDao.selectByOperation(searchStr));
			}
		}

		return new PageInfo<>(operationDao.selectAll());
	}
}