package com.nb.nbpx.dao.user;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.user.OrgInfo;

public interface IOrgInfoDao  extends IBaseDao<OrgInfo, Integer> {
	
	public Boolean saveOrgInfo(OrgInfo orgInfor);
	public List<OrgInfo> getOrgInforByUserId(Integer userId);
}
