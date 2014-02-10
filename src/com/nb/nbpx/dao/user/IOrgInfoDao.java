package com.nb.nbpx.dao.user;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.user.OrgInfo;

public interface IOrgInfoDao  extends IBaseDao<OrgInfo, Integer> {
	
	public Boolean saveOrgInfo(OrgInfo orgInfor);
	public List<OrgInfo> getOrgInforByUserId(Integer userId);
	public List<OrgInfo> queryOrgInfo(String userName,String orgName,Integer rows,
			Integer start, String sort, String order);
	public Long queryOrgInfoCount(String userName,String orgName);
}
