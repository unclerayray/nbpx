package com.nb.nbpx.service.user;

import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.pojo.user.CompInfo;

public interface ICompInfoService extends IBaseService{

	public String getCompInfoByUserId(Integer userID);
	public String saveCompInfor(CompInfo compInfor);
	
	public String queryCompInfo(String userName,String company,Integer rows,
			Integer start, String sort, String order);
}
