package com.nb.nbpx.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.IOrgInfoDao;
import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.user.IOrgInfoService;
import com.nb.nbpx.utils.JsonUtil;

@Component("OrgInfoService")
public class OrgInfoServiceImpl extends BaseServiceImpl implements IOrgInfoService{
	
	private IOrgInfoDao orgInfoDao;
	
	public String getOrgInfo(String state,Integer rows,Integer start){
		List<OrgInfo> orgInfoList = orgInfoDao.getOrgList(state, rows, start);
		String json = "";
		if (orgInfoList.isEmpty()) {
			json = JsonUtil.formatToJsonWithNoTimeStamp(0,
					ResponseStatus.SUCCESS, "", orgInfoList);
		} else {
			int count = orgInfoDao.getOrgListRows(state, rows, start).intValue();
			json = JsonUtil.formatToJsonWithNoTimeStamp(count,
					ResponseStatus.SUCCESS, "", orgInfoList);
		}
		return json;
	}
	
	public String getOrgListBySeries(final String series,final Integer rows,final Integer start){
		List<OrgInfo> orgInfoList = orgInfoDao.getOrgListBySeries(series, rows, start);
		String json = "";
		if (orgInfoList.isEmpty()) {
			json = JsonUtil.formatToJsonWithNoTimeStamp(0,
					ResponseStatus.SUCCESS, "", orgInfoList);
		} else {
			int count = orgInfoDao.getOrgListBySeriesCount(series, rows, start).intValue();
			json = JsonUtil.formatToJsonWithNoTimeStamp(count,
					ResponseStatus.SUCCESS, "", orgInfoList);
		}
		return json;
	}
	public String getOrgInfoById(Integer orgID){
		List<OrgInfo> orgList = orgInfoDao.getOrgByID(orgID);
		String json = "";
		
		if(orgList != null&& orgList.size()!= 0)
			json = JsonUtil.getJsonString(orgList.get(0));
		else
			json = JsonUtil.getJsonString(null);
		return json;
	}
	
	@Override
	public String getOrgInfoByUserId(Integer userID) {
		List<OrgInfo> orgInfoList = orgInfoDao.getOrgInforByUserId(userID);
		String json = "";
		
		if(orgInfoList != null&& orgInfoList.size()!= 0)
			json = JsonUtil.getJsonString(orgInfoList.get(0));
		else
			json = JsonUtil.getJsonString(null);
		return json;
	}

	@Override
	public String saveOrgInfor(OrgInfo orgInfor) {
		String json = "";
		Boolean result = this.orgInfoDao.saveOrgInfo(orgInfor);
		if(result)
			json = JsonUtil.formatToSuccessJson(result, "更新成功!");
		else
			json = JsonUtil.formatToSuccessJson(result, "更新失败!");
		return json;
	}
	
	@Resource
	public void setOrgInfoDao(IOrgInfoDao orgInfoDao) {
		this.orgInfoDao = orgInfoDao;
	}

	@Override
	public String queryOrgInfo(String userName, String orgName, Integer rows,
			Integer start, String sort, String order) {
		String json = "";
		List<OrgInfo>  list = orgInfoDao.queryOrgInfo(userName, orgName, rows, start, sort, order);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithNoTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = orgInfoDao.queryOrgInfoCount(userName, orgName).intValue();
			json = JsonUtil.formatToJsonWithNoTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}
		return json;
	}

	@Override
	public void deleteOrgInfo(Integer orgId) {
		orgInfoDao.deleteByKey(orgId);
	}

	@Override
	public void auditOrgInfo(Integer orgId, boolean state)  throws Exception {
		Map<String,Object> propertyMap = new HashMap<String,Object>();
		propertyMap.put("state", state);
		orgInfoDao.updateWithPK(OrgInfo.class, orgId, propertyMap);
	}

}
