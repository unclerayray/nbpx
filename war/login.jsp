<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="css/face.css" rel="stylesheet" />
<script type="text/javascript" src="js/easyui/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<title>南北培训网</title>
</head>
<body>
<jsp:include page="head.jsp" flush="true"/>
<div class="mainContent path" style="border-bottom:1px solid #ccc">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>登陆</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->
<script>
	function login(){
		$('#loginForm').form('submit',{  
			url: 'struts/Login_checkUser',  
			onSubmit: function(){  
				if($('#username').val() == '' || $('#username').val() == null){
					alert("用户名不能为空!");
					return false;
				}
				if($('#password').val() == '' || $('#password').val() == null){
					alert("密码不能为空!");
					return false;
				}
			},  
			success: function(data){
				var returnObject = eval('(' + data + ')')
				if(!returnObject.success){
					alert(returnObject.message);
				}else
					window.location.href='main.html';
			}
		});
	}
	
</script>
<style>
.regDesc{padding-top:20px}
.regDesc li{font-size:12px;line-height:25px;width:100%;padding-left:250px;text-align:left;list-style:none}
.regDesc li span{color:red}
</style>
<div class="mainContent loginForm">
	<form id="loginForm">
	<div class='loginFormBg'></div>
		<dd><span>用户名:</span><input type="text" id="username" name="username"/></dd>
		<dd><span>密码:</span><input type="password" id="password" name="password"/><a href='#' class="forget">忘记密码?</a></dd>
		<dd class="button"><a href='#' onclick="javascript:login()">登陆</a><a href='agree.html'>注册</a></dd>
	<div class="regDesc">
	<li>【<span>注册企业会员</span>】：立即享受当年任何公开课程原价的9.5折！和当年企业内训9.8折！</li>
	<li>【<span>注册培训机构</span>】：免费注册培训机构，在中国南北培训网免费发布您的课程信息，通过中国南北培训网在线招生！</li>
	<li>【<span>注册培训讲师</span>】：通过中国南北培训网发布内训课程，让更多企业聘请您授课！</li>
	</div>
	
	</form>
</div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>