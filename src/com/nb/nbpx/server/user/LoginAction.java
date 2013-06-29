package com.nb.nbpx.server.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.pojo.user.*;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.user.IUserService;

@Component("LoginAction")
@Scope("prototype")
public class LoginAction  extends BaseAction {
	
	private static final long serialVersionUID = 1L;
	
	private String username;
	private String password;
	private String city;
	private String email;
	private CompInfo compInfo;
	private OrgInfo orgInfo;
	private TeacherInfo teacherInfo;
	
	private IUserService UserService;
	
	//验证登陆
	public String checkUser(){
		String json = "";
		
		json = UserService.checkLogin(username, password);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public CompInfo getCompInfo() {
		return compInfo;
	}

	public void setCompInfo(CompInfo compInfo) {
		this.compInfo = compInfo;
	}

	public OrgInfo getOrgInfo() {
		return orgInfo;
	}

	public void setOrgInfo(OrgInfo orgInfo) {
		this.orgInfo = orgInfo;
	}

	public TeacherInfo getTeacherInfo() {
		return teacherInfo;
	}

	public void setTeacherInfo(TeacherInfo teacherInfo) {
		this.teacherInfo = teacherInfo;
	}

	public IUserService getUserService() {
		return UserService;
	}

	@Resource
	public void setUserService(IUserService userService) {
		UserService = userService;
	}

}
