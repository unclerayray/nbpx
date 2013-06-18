package com.nb.nbpx.service.user.impl;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.ICompInfoDao;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.user.ICompInfoService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.pojo.user.CompInfo;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

@Component("CompInfoService")
public class CompInfoServiceImpl extends BaseServiceImpl implements ICompInfoService{


	private ICompInfoDao compInfoDao;

	@Override
	public String getCompInfoByUserId(Integer userId) {
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
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
	
}
