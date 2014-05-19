package com.nb.nbpx.service.user;

import com.nb.nbpx.pojo.user.Admin;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

public interface IAdminService extends IBaseService {
	/**
	 * 
	 * @param userName
	 * @param rows
	 * @param start
	 * @param sort
	 * @param order
	 * @return
	 */
	public String queryAdmins(String userName,Integer rows, Integer start, String sort, String order); 
	
	/**
	 * 
	 * @param user
	 * @return
	 */
	public void saveAdmin(Admin admin) throws NbpxException ;
	
	/**
	 * 
	 * @param user
	 */
	public void deleteAdmin(Admin admin);
	
	/**
	 * 根据用户名查找用户
	 * @param username
	 * @return
	 */
	public boolean checkLogin(String username,String password);
	
	/**
	 * @param username
	 * @return
	 */
	public Admin searchAdmin(String username);
}
