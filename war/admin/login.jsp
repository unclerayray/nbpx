<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<script src="../js/easyui/jquery-1.8.0.min.js"></script>
<script src="../js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">  
	window.onload = function() {
		if (window != top) 
			top.location.href = location.href; 
	};
    function refresh() {  
        //IE存在缓存,需要new Date()实现更换路径的作用  
        document.getElementById("image").src="image.jsp?"+new Date();  
    }  

    function login() {
    	$('#login_form').form('submit', {
			url : '../struts/Admin_login',
			success : function(data) {
				var data = eval('(' + data + ')'); // change the JSON string to javascript object 
				alert("what the fuck " + data.success) ;
				if (data.success) {
					window.location.href = "/nbpx/admin/index.html";
				} else {
					$('#login_form').form('clear');
				}
			}
		});
    }
</script> 
<style type="text/css">
html {
	background-color:#b0c4de;
}
.errors {
	background-color:#FFCCCC;
	border:1px solid #CC0000;
	width:400px;
	margin-bottom:8px;
}
.errors li{ 
	list-style: none; 
}
</style>
</head>
<body>
	<div align="center" id = "login_panel" style="margin-top: 12%;">
		<s:if test="hasActionErrors()">
		   <div class="errors">
		      <s:actionerror/>
		   </div>
		</s:if>
		<s:form id="login_form" action="Admin_login" method="post" namespace="/admin">
			<table>
				<tr>
					<td>用户名:</td>
					<td colspan="2" ><input id="username" name="username"/></td>
				</tr>
				<tr>
					<td>密码:</td>
					<td colspan="2" ><input id="pwd" type="password" name="pwd"/></td>
				</tr>
				<tr>
					<td>验证码:</td>
					<td><input name="txtVerifyCode" id="txtVerifyCode"  style="width: 83px;" ></td>
					<td><img id="image" border="0"  onclick="refresh()" src="image.jsp" title="点击更换图片"></td>
				</tr>
				<tr>
					<td colspan="3" align="center"><s:submit type="submit" label="登录" value="登录"/></td>
				</tr>
			</table>
		</s:form>
	</div>
</body>
</html>