package com.nb.nbpx.service.user;

import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.pojo.user.CompInfo;

public interface ICompInfoService extends IBaseService{

	public String getCompInfoByUserId(Integer userID);
	public void deleteCompInfo(Integer compInforId);
	public String saveCompInfor(CompInfo compInfor);
	
	public String queryCompInfo(String userName,String company, String contact,
			 String department,Integer rows,
			Integer start, String sort, String order);
	public void auditCompInfo(Integer compId, boolean state) throws Exception ;
}
