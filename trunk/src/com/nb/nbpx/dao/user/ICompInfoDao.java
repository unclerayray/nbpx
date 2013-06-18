package com.nb.nbpx.dao.user;
import com.nb.nbpx.dao.IBaseDao;
import java.util.List;
import com.nb.nbpx.pojo.user.CompInfo;


public interface ICompInfoDao extends IBaseDao<CompInfo, Integer>{
	
	public List<CompInfo> getCompInforByUserId(Integer userId);
	public Boolean saveCompInfor(CompInfo compInfor);
	
}
