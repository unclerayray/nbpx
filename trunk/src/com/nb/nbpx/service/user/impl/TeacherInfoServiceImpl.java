package com.nb.nbpx.service.user.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.user.ITeacherInfoDao;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.user.ITeacherInfoService;
import com.nb.nbpx.utils.JsonUtil;

@Component("TeacherInfoService")
public class TeacherInfoServiceImpl extends BaseServiceImpl implements ITeacherInfoService{
	
	private ITeacherInfoDao teacherInfoDao;

	@Override
	public String getTeacherInfoByUserId(Integer userID) {
		List<TeacherInfo> teacherInfoList = teacherInfoDao.getTeacherInforByUserId(userID);
		String json = "";
		
		if(teacherInfoList != null&& teacherInfoList.size()!= 0)
			json = JsonUtil.getJsonString(teacherInfoList.get(0));
		else
			json = JsonUtil.getJsonString(null);
		return json;
	}

	@Override
	public String saveTeacherInfor(TeacherInfo teacherInfor) {
		String json = "";
		Boolean result = this.teacherInfoDao.saveTeacherInfor(teacherInfor);
		if(result)
			json = JsonUtil.formatToSuccessJson(result, "更新成功!");
		else
			json = JsonUtil.formatToSuccessJson(result, "更新失败!");
		return json;
	}
	
	
	@Resource
	public void setTeacherInfoDao(ITeacherInfoDao teacherInfoDao) {
		this.teacherInfoDao = teacherInfoDao;
	}

}
