package com.nb.nbpx.server.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.user.IUserService;

@Component("UserAction")
@Scope("prototype")
public class UserAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public String username;
	public String password;
	public int userType;
	private IUserService UserService;
	
	
	public String register(){
		
		return "";
	}
	
	public String queryUserByType(){
		String json = "";
		try {
//			json = UserService.queryUserByType(userType,limit,start);
			json = UserService.queryUserByType(1,limit,start);
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
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

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	public IUserService getUserService() {
		return UserService;
	}

	@Resource
	public void setUserService(IUserService userService) {
		UserService = userService;
	}

	
}
