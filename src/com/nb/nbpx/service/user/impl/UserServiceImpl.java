package com.nb.nbpx.service.user.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.IUserDao;
import com.nb.nbpx.pojo.user.User;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.user.IUserService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

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
	public String queryUserByType(String userType, Integer rows, Integer start) {
		Map<String, Object> propsMap = new LinkedHashMap<String, Object>();
		if(userType != null){
			propsMap.put("userType", userType);
		}
		String json = "";
		//List<User> userList = userDao.queryEntityListByProperties(User.class, rows, start, propsMap);
		List<User> userList = userDao.queryUserByType(userType, rows, start);
		if (userList.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.FAIL, "", userList);
		} else {
			int count = userDao.queryUserCountByType(userType).intValue();
			//json = JsonUtil.formatToJsonWithTotalCount(count, userList);
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", userList);
		}
		return json;
	}

	@Override
	public void saveUser(User user) throws NbpxException {
		if(user.getUserId()==null){
			if(userDao.checkDuplicateProp(user.getUserName(), user.getEmail())){
				throw new NbpxException("用户名或email重复");
			}
			userDao.save(user);//新增用户
		}else{
			userDao.saveOrUpdate(user);//修改用户
		}
	}

	@Override
	public void deleteUser(User user) {
		userDao.delete(user);
	}
	
	@Override
	/**
	 * 登陆验证
	 */
	public String checkLogin(String username,String password){
		String json = "";
		List<User> userList = userDao.queryUserByUserName(username);
		if(userList == null || userList.size() == 0){
			json = JsonUtil.format2Json(false, "不存在此用户!");
			return json;
		}
		
		for(int i=0;i<userList.size();i++){
			User temp = userList.get(i);
			if(password.equals(temp.getPassWord())){
				json = JsonUtil.format2Json(true, "验证成功!");
				return json;
			}
		}
		json = JsonUtil.format2Json(false, "密码不正确!");
		
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
