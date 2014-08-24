package com.nb.nbpx.dao.user;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.pojo.user.TeacherInfo;

public interface IOrgInfoDao  extends IBaseDao<OrgInfo, Integer> {
	public Long getOrgListRows(String state,Integer rows,Integer start);
	public List<OrgInfo> getOrgList(String state,Integer rows,Integer start);
	public List<OrgInfo> getOrgByID(Integer orgID);
	
	public List<OrgInfo> getOrgInforByUserId(Integer userId);
	public OrgInfo getOrgInforByName(String orgName);
	public List<OrgInfo> queryOrgInfo(String userName,String orgName,Integer rows,
			Integer start, String sort, String order);
	public List<OrgInfo> getOrgListBySeries(String series,Integer rows,Integer start);
	public Long getOrgListBySeriesCount(String series,Integer rows,Integer start);
	public Long queryOrgInfoCount(String userName,String orgName);
}
