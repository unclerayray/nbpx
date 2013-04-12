package com.nb.nbpx.service.user;

import com.nb.nbpx.service.IBaseService;

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
	public String queryUserByType(int userType,Integer limit, Integer start); 
}
