package com.nb.nbpx.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.ICompInfoDao;
import com.nb.nbpx.pojo.user.CompInfo;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.user.ICompInfoService;
import com.nb.nbpx.utils.JsonUtil;

@Component("CompInfoService")
public class CompInfoServiceImpl extends BaseServiceImpl implements ICompInfoService{


	private ICompInfoDao compInfoDao;

	@Override
	public String getCompInfoByUserId(Integer userId) {
		List<CompInfo> compInfoList = compInfoDao.getCompInforByUserId(userId);
		String json = "";
		
		if(compInfoList != null&& compInfoList.size()!= 0)
			json = JsonUtil.getJsonString(compInfoList.get(0));
		else
			json = JsonUtil.getJsonString(null);
		return json;
	}
	public ICompInfoDao getCompInfoDao() {
		return compInfoDao;
	}
	
	@Override
	public String saveCompInfor(CompInfo compInfor) {
		String json = "";
		Boolean result = this.compInfoDao.saveCompInfor(compInfor);
		if(result)
			json = JsonUtil.formatToSuccessJson(result, "更新成功!");
		else
			json = JsonUtil.formatToSuccessJson(result, "更新失败!");
		return json;
	}
	
	@Resource
	public void setCompInfoDao(ICompInfoDao compInfoDao) {
		this.compInfoDao = compInfoDao;
	}
	@Override
	public String queryCompInfo(String userName, String company, String contact,
			 String department, Integer rows,
			Integer start, String sort, String order) {
		String json = "";
		List<CompInfo>  list = compInfoDao.queryCompInfo(userName, company,contact,department, rows, start, sort, order);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithNoTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = compInfoDao.queryCompInfoCount(userName, company,contact,department).intValue();
			json = JsonUtil.formatToJsonWithNoTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}
		return json;
	}
	@Override
	public void deleteCompInfo(Integer compInforId) {
		compInfoDao.deleteByKey(compInforId);
	}
	@Override
	public void auditCompInfo(Integer compId, boolean state) throws Exception {
		Map<String,Object> propertyMap = new HashMap<String,Object>();
		propertyMap.put("state", state);
		compInfoDao.updateWithPK(CompInfo.class, compId, propertyMap);
	}
	
}
