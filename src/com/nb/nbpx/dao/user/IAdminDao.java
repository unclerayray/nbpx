package com.nb.nbpx.dao.user;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.user.Admin;

public interface IAdminDao  extends IBaseDao<Admin, Integer> {

	/**
	 * find users by type
	 * @param userType
	 * @return
	 */
	public List<Admin> queryAdmin(String userName,Integer rows, Integer start, String sort, String order);
	
	
	public boolean checkDuplicateProp(String username);
}
