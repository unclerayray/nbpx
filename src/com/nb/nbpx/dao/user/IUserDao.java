package com.nb.nbpx.dao.user;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.user.User;

public interface IUserDao extends IBaseDao<User, Integer> {
	/**
	 * find users by type
	 * @param userType
	 * @return
	 */
	public List<User> queryUserByType(int userType,Integer limit, Integer start);
	
	/**
	 * find count of users by type
	 * @param userType
	 * @return
	 */
	public Long queryUserCountByType(int userType);
}
