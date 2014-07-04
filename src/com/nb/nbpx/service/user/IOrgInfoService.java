package com.nb.nbpx.service.user;

import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.service.IBaseService;

public interface IOrgInfoService extends IBaseService{

	public String getOrgInfoByUserId(Integer userID);
	public void deleteOrgInfo(Integer orgId);
	public String saveOrgInfor(OrgInfo orgInfor);
	public String queryOrgInfo(String userName,String orgName,Integer rows,
			Integer start, String sort, String order);
	public void auditOrgInfo(Integer orgId, boolean state) throws Exception ;
}
