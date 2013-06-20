package com.nb.nbpx.server.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.user.ITeacherInfoService;

@Component("TeacherInfoAction")
@Scope("prototype")
public class TeacherInfoAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	public TeacherInfo teacherInfor;
	public Integer userId;
	
	private ITeacherInfoService teacherInfoService;
	
	public String getTeacherInforByUserId(){
		String json = "";
		try {

			json = teacherInfoService.getTeacherInfoByUserId(userId);
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String saveTeacherInfor(){
		String json = "";
		try {

			json = teacherInfoService.saveTeacherInfor(teacherInfor);
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	
	public TeacherInfo getTeacherInfor() {
		return teacherInfor;
	}

	public void setTeacherInfor(TeacherInfo teacherInfor) {
		this.teacherInfor = teacherInfor;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public ITeacherInfoService getTeacherInfoService() {
		return teacherInfoService;
	}
	
	@Resource
	public void setTeacherInfoService(ITeacherInfoService teacherInfoService) {
		this.teacherInfoService = teacherInfoService;
	}


	
	

}
