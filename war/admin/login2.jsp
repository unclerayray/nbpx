<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://code.google.com/p/jcaptcha4struts2/taglib/2.0" prefix="jcaptcha" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
</head>
<body>
	<div align="center" id = "login_panel">
		<s:form action="../struts/AdminLogin_login">
			<table>
				<tr>
					<td>用户名:</td><td><input id="username" name="username"></td><td></td>
				</tr>
				<tr>
					<td>密码:</td><td><input type="password" id="pwd" name="pwd"></td>
				</tr>
				<tr>
					<td>验证码:</td><td><input name="jCaptchaResponse" id="txtVerifyCode"></td><td><img align="center" height="80px" src="/nbpx/admin/jcaptcha_image.action" /></td>
				</tr>
				<!--  
				<tr>
					<td>验证码:</td><td><jcaptcha:image width="2px" height="10px" label=""/></td><td><input id="ma"></td>
				</tr>
				-->
				<tr><td colspan="3"><s:submit type="submit" label="登录" value="登录"/></td></tr>
			</table>
		</s:form>
	</div>
</body>
</html>