package com.nb.nbpx.service.user.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.IUserDao;
import com.nb.nbpx.pojo.user.User;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.user.IUserService;
import com.nb.nbpx.utils.JsonUtil;

/**
 * <p>
 * 类的简介说明
 * </p>
 * 创建时间：2013-4-10 9:49:51
 * 
 * @author leilichao
 * @version V1.0
 */

@Component("UserService")
public class UserServiceImpl extends BaseServiceImpl implements IUserService {

	private IUserDao userDao;

	@Override
	public String queryUserByType(int userType, Integer limit, Integer start) {
		String json = "";
		List<User> userList = userDao.queryUserByType(userType, limit, start);
		if (userList.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", userList);
		} else {
			int count = userDao.queryUserCountByType(userType).intValue();
			userList.get(0).setTotalCount(count);
			//json = JsonUtil.formatToJsonWithTotalCount(count, userList);
			json = JsonUtil.formatListToJson(userList);
		}
		return json;
	}

	@Resource
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}

	public IUserDao getUserDao() {
		return userDao;
	}

}
