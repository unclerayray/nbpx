package com.nb.nbpx.dao.user;
import com.nb.nbpx.dao.IBaseDao;

import java.util.List;

import com.nb.nbpx.pojo.user.CompInfo;


public interface ICompInfoDao extends IBaseDao<CompInfo, Integer>{
	
	public List<CompInfo> getCompInforByUserId(Integer userId);
	public Boolean saveCompInfor(CompInfo compInfor);
	
	public List<CompInfo> queryCompInfo(String userName,String company, String contact,
			 String department, Integer rows,
			Integer start, String sort, String order);
	public Long queryCompInfoCount(String userName,String company, String contact,
			 String department);
}
