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
	public List<User> queryUserByType(String userName,String userType,Integer rows, Integer start, String sort, String order);
	
	/**
	 * find count of users by type
	 * @param userType
	 * @return
	 */
	public Long queryUserCountByType(String userName,String userType);
	
	public boolean checkDuplicateProp(String username,String email);
	
	public List<User> queryUserByUserName(String username);

}