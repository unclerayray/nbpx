package com.nb.nbpx.server.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.user.User;
import com.nb.nbpx.dto.user.CompInfoDto;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.user.IUserService;
import com.nb.nbpx.utils.JsonUtil;

@Component("UserAction")
@Scope("prototype")
/**
 * 
 */
public class UserAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public String username;
	public String password;
	public int userType;
	public User user;
	public CompInfoDto compInfoDto;
	
	public String commitType;

	private IUserService UserService;

	
	public String queryUserByType() {
		String json = "";
		try {
			// json = UserService.queryUserByType(userType,limit,start);
			//System.out.println(" hh " + rows + page);
			json = UserService.queryUserByType(null, rows,
					getStartPosi());
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	public String editComp(){
		try {
			System.out.println(compInfoDto.getCompany());
			//UserService.saveUser(user);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, ResponseStatus.SAVE_FAILED+e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
		
	}
	public String saveUser() {
		try {
			UserService.saveUser(user);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, ResponseStatus.SAVE_FAILED+e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}
	
	public String deleteUser() {
		try{
			UserService.deleteUser(user);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, ResponseStatus.DELETE_FAILED+e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
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
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getCommitType() {
		return commitType;
	}

	public void setCommitType(String commitType) {
		this.commitType = commitType;
	}

	public CompInfoDto getCompInfoDto() {
		return compInfoDto;
	}

	public void setCompInfoDto(CompInfoDto compInfoDto) {
		this.compInfoDto = compInfoDto;
	}

	public IUserService getUserService() {
		return UserService;
	}

	@Resource
	public void setUserService(IUserService userService) {
		UserService = userService;
	}

}
