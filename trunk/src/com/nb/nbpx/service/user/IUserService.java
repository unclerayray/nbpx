package com.nb.nbpx.service.user;

import com.nb.nbpx.pojo.user.User;
import com.nb.nbpx.service.IBaseService;
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
public interface IUserService extends IBaseService {
	/**
	 * 
	 * @param userType
	 * @param limit
	 * @param start
	 * @return
	 */
	public String queryUserByType(String userName,String userType,Integer rows, Integer start, String sort, String order); 
	
	/**
	 * 
	 * @param user
	 * @return
	 */
	public void saveUser(User user) throws NbpxException ;
	
	/**
	 * 
	 * @param user
	 */
	public void deleteUser(User user);
	
	/**
	 * 根据用户名查找用户
	 * @param username
	 * @return
	 */
	public String checkLogin(String username,String password);
	
	/**
	 * 管理员登录
	 * @param username
	 * @return
	 */
	public boolean verifyLogin(String username,String password) throws NbpxException;
	
	
	public User queryById(Integer id);
	
	public User queryByUserName(String userName);
}
