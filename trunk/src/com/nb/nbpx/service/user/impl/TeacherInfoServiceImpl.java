package com.nb.nbpx.service.user.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.ITeacherInfoDao;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.user.ITeacherInfoService;
import com.nb.nbpx.utils.JsonUtil;

@Component("TeacherInfoService")
public class TeacherInfoServiceImpl extends BaseServiceImpl implements ITeacherInfoService{
	
	private ITeacherInfoDao teacherInfoDao;

	@Override
	public String getTeacherInfo(Boolean isInner,String state,Integer rows,Integer start){
		List<TeacherInfo> teacherInfoList = teacherInfoDao.getTeacherList(isInner, state, rows, start);
		String json = "";
		if (teacherInfoList.isEmpty()) {
			json = JsonUtil.formatToJsonWithNoTimeStamp(0,
					ResponseStatus.SUCCESS, "", teacherInfoList);
		} else {
			int count = teacherInfoDao.getTeacherListRows(isInner, state, rows, start).intValue();
			json = JsonUtil.formatToJsonWithNoTimeStamp(count,
					ResponseStatus.SUCCESS, "", teacherInfoList);
		}
		return json;
	}
	
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

	@Override
	public String queryTeacherInfo(String userName, String teacherName,
			Boolean inner, Integer rows, Integer start, String sort,
			String order) {
		String json = "";
		if(inner){
			List<TeacherInfo>  list = teacherInfoDao.queryInnerTeacherInfo(teacherName, rows, start, sort, order);
			if (list.isEmpty()) {
				json = JsonUtil.formatToJsonWithNoTimeStamp(0,
						ResponseStatus.SUCCESS, "", list);
			} else {
				int count = teacherInfoDao.queryInnerTeacherInfoCount(teacherName).intValue();
				json = JsonUtil.formatToJsonWithNoTimeStamp(count,
						ResponseStatus.SUCCESS, "", list);
			}
		}else{
			List<TeacherInfo>  list = teacherInfoDao.queryOutTeacherInfo(userName, teacherName,  rows, start, sort, order);
			if (list.isEmpty()) {
				json = JsonUtil.formatToJsonWithNoTimeStamp(0,
						ResponseStatus.SUCCESS, "", list);
			} else {
				int count = teacherInfoDao.queryOutTeacherInfoCount(userName, teacherName ).intValue();
				json = JsonUtil.formatToJsonWithNoTimeStamp(count,
						ResponseStatus.SUCCESS, "", list);
			}
		}
		return json;
	}

}
