package com.nb.nbpx.service.user;

import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.service.IBaseService;

public interface IOrgInfoService extends IBaseService{

	public String getOrgInfoByUserId(Integer userID);
	public String saveOrgInfor(OrgInfo orgInfor);
}