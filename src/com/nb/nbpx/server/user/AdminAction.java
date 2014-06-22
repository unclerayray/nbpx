package com.nb.nbpx.server.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ResultPath;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.pojo.user.Admin;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.system.IDictionaryService;
import com.nb.nbpx.service.user.IAdminService;
import com.nb.nbpx.service.user.IUserService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.mapTool.NbpxDicMap;

@Component("AdminAction")
@Scope("prototype")
@Namespace("/admin")
@ResultPath(value="/admin")
public class AdminAction  extends BaseAction {

	/**
	 * 
	 */
	public static Logger         logger           = LogManager
            .getLogger(AdminAction.class);
	private static final long serialVersionUID = 1L;
	public IUserService userService;
	public IDictionaryService dictionaryService;
	public IAdminService adminService;
	public IAdminService getAdminService() {
		return adminService;
	}

	@Resource
	public void setAdminService(IAdminService adminService) {
		this.adminService = adminService;
	}

	public IDictionaryService getDictionaryService() {
		return dictionaryService;
	}

	@Resource
	public void setDictionaryService(IDictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public IUserService getUserService() {
		return userService;
	}

	@Resource
	public void setUserService(IUserService userService) {
		this.userService = userService;
	}

	public String username;
	public String pwd;
	public String newPwd;
	public String getNewPwd() {
		return newPwd;
	}

	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}

	public String txtVerifyCode;
	public String code;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getTxtVerifyCode() {
		return txtVerifyCode;
	}

	public void setTxtVerifyCode(String txtVerifyCode) {
		this.txtVerifyCode = txtVerifyCode;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	
	private Admin admin;
	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	
	public String queryAdmins(){
		String json = adminService.queryAdmins(username, rows, getStartPosi(), sort, order);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String saveAdmin(){
		try {
			if(admin.getUserName().equals("leo")||admin.getUserName().equals("leo")){
				throw new NbpxException("超级管理员不能被修改！");
			}
			adminService.saveAdmin(admin);
		} catch (NbpxException e) {
			addActionError(e.getMessage());
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"操作失败! " + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}

	public String login(){
		logger.info("user [" + username + "] tring to log in.");
		try {
			if(!validateUser(username,pwd)){
				logger.info("user [" + username + "] tring to log in failed.");
				throw new NbpxException("密码不正确或此用户已被锁定。");
			}else{
				logger.info("user [" + username + "] logged in successfully at ["+new Date()+"]");
				session.setAttribute("userName", username);
				if(username.equals("leo")||username.equals("amanda")||username.equals("admin")){
					//session.setAttribute("super", true);
					//xxx means normal admin
				}else{
					session.setAttribute("xxx", "xxx");
				}
				initDicMap();
			}
		} catch (Exception e) {
			addActionError(e.getMessage());
			return "relogin";
		}
		return "index";
	}
	

	public String relogin(){
		logger.info("user [" + username + "] tring to re-log in.");
		try {
			if(!validateUser(username,pwd)){
				logger.info("user [" + username + "] tring to log in failed.");
				throw new NbpxException("密码不正确或此用户已被锁定。");
			}else{
				logger.info("user [" + username + "] logged in successfully at ["+new Date()+"]");
				session.setAttribute("userName", username);
				if(username.equals("leo")||username.equals("amanda")||username.equals("admin")){
					//session.setAttribute("super", true);
					//xxx means normal admin
				}else{
					session.setAttribute("xxx", "xxx");
				}
				initDicMap();
			}
		} catch (Exception e) {
			addActionError(e.getMessage());
			return "relogin";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, "重新登录成功!"));
		return SUCCESS;
	}
	

	public String changePwd(){
		String userName = getSessionUserName();
		logger.info("user [" + userName + "] tring to change password.");
		//TODO verify current password
		try {
			if(userName==null||"".equals(userName)){
				throw new NbpxException("session已失效，请重新登录");
			}
			
			//User user = userService.queryByUserName(userName);
			Admin admin = adminService.searchAdmin(userName);
			if(admin != null) {
				if(admin.getPassWord().equals(pwd)){
					admin.setPassWord(newPwd);
					//userService.saveUser(user);
					adminService.saveAdmin(admin);
					logger.info("user [" + userName + "] has changed his password.");
				}else{
					throw new NbpxException("旧密码不正确！");
				}
			}else{
				throw new NbpxException("无此管理员？！！");
			}
			destroyDicMap();
			session.setAttribute("userName", null);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"密码修改失败! " + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}

	public String logout(){
		logger.info("user [" + username + "] tring to log out.");
		try {
			destroyDicMap();
			session.setAttribute("userName", null);
			logger.info("user [" + username + "] logged out successfully at ["+new Date()+"]");
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"登出失败" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, "登出成功"));
		return SUCCESS;
	}
	
	public String removeAdmin(){
		try {
			if(admin.getUserName().equals("leo")||admin.getUserName().equals("amanda")||admin.getUserName().equals("admin")){
				throw new Exception("超级管理员不能被删除！");
			}else{
				adminService.deleteAdmin(admin);
			}
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"删除失败" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, "登出成功"));
		return SUCCESS;
	}
	
	private boolean validateUser(String username,String password) throws NbpxException{
		if(getMeCode()==null||txtVerifyCode==null||txtVerifyCode.isEmpty()){
			throw new NbpxException("验证码不能为空");
		}else{
			if(!getMeCode().toLowerCase().equals(txtVerifyCode.toLowerCase())){
				throw new NbpxException("验证码不正确");
			}
		}
		if(username==null||username.isEmpty()){
			throw new NbpxException("用户名不能为空");
		}
		if(password==null||password.isEmpty()){
			throw new NbpxException("密码不能为空");
		}
		
		//return userService.verifyLogin(username, password);
		return adminService.checkLogin(username, password);
	}
	
	private void initDicMap(){
		List<Dictionary> userTypeList = dictionaryService.getDicListByType(NbpxDicMap.userTypeCode);
		NbpxDicMap.userTypeMap = new HashMap<String,Object>();
		NbpxDicMap.courseTypeMap = new HashMap<String,Object>();
		for(Dictionary dic:userTypeList){
			NbpxDicMap.userTypeMap.put(dic.getCodeName(), dic.getShowName());
		}
		
		List<Dictionary> courseTypeList = dictionaryService.getDicListByType(NbpxDicMap.courseTypeCode);
		for(Dictionary dic:courseTypeList){
			NbpxDicMap.courseTypeMap.put(dic.getCodeName(), dic.getShowName());
		}
	}
	

	private void destroyDicMap(){
		NbpxDicMap.userTypeMap = null;
		NbpxDicMap.courseTypeMap = null;
	}
}
