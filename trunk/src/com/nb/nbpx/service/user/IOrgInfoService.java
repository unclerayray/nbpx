package com.nb.nbpx.service.user;

import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

public interface IOrgInfoService extends IBaseService{
	public String getOrgInfo(String state,Integer rows,Integer start);
	public String getOrgListBySeries(String series,Integer rows,Integer start);
	
	public String getOrgInfoById(Integer orgID);
	
	public String getOrgInfoByUserId(Integer userID);
	public void deleteOrgInfo(Integer orgId);
	public OrgInfo saveOrgInfor(OrgInfo orgInfor) throws NbpxException ;
	public String queryOrgInfo(String userName,String orgName,Integer rows,
			Integer start, String sort, String order);
	public void auditOrgInfo(Integer orgId, boolean state) throws Exception ;
}
