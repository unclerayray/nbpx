package com.nb.nbpx.server.user;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.google.code.jcaptcha4struts2.common.actions.JCaptchaBaseAction;

@Component("AdminLoginAction")
@Scope("prototype")
public class AdminLoginAction   extends JCaptchaBaseAction  {

	@Override
	public void validateInput() {
		// TODO Auto-generated method stub
		super.validateInput();
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String username;
	public String pwd;
	private String message;

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

	public String login(){
		System.out.println("username = " + username + ", pwd = "+pwd);
		//this.validateInput();
		return SUCCESS;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
