<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="css/face.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="js/easyui/themes/gray/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css"/>
<title>南北培训网</title>
<script type="text/javascript" src="js/easyui/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
</head>
<script>
function selectType(){
	var currSelect = $('#userType').val();
	if(currSelect == '1'){
		$('#comp').css('display','block');
		$('#org').css('display','none');
		$('#teacher').css('display','none');
	}else if(currSelect == '2'){
		$('#comp').css('display','none');
		$('#org').css('display','none');
		$('#teacher').css('display','block');
	}else{
		$('#comp').css('display','none');
		$('#org').css('display','block');
		$('#teacher').css('display','none');
	}	
}
function register(){
	var currSelect = $('#userType').val();
	if(currSelect == '1'){//提交注册公司
		$('#compForm').form('submit',{  
			url: 'struts/Login_saveCompany',  
			//url: 'struts/Login_checkUser',  
			onSubmit: function(){  
				if($('#c_company').val() == '' || $('#c_company').val() == null){
					alert('公司名称不能为空!');
					return false;
				}
				if($('#c_city').val() == '' || $('#c_city').val() == null){
					alert('城市不能为空!');
					return false;
				}
				if($('#c_password').val() == '' || $('#c_password').val() ==null){
					alert("密码不能为空!");
					return false;
				}
				if($('#c_password').val() != $('#c_confirmPassword').val()){
					alert('两次输入的密码不同!');
					return false;
				}
				if($('#c_contact').val() == ''){
					alert('联系人不能为空!');
					return false;
				}
				if($('#c_department').val() == ''){
					alert('任职部门不能为空!');
					return false;
				}
				if($('#c_department').val() == ''){
					alert('任职部门不能为空!');
					return false;
				}
				if($('#c_email').val() == ''){
					alert('电子邮件不能为空!');
					return false;
				}
				if(!validateEmail($('#c_email').val()))
					return false;
				if($('#c_cellphone').val() != $('#c_cellphone').val()){
					alert('移动号码不能为空!');
					return false;
				}
				if(!validateCell($('#c_cellphone').val()))
					return false;
				if($('#c_telephone').val() != $('#c_telephone').val()){
					alert('联系电话不能为空!');
					return false;
				}
				if(!validateTel($('#c_telephone').val()))
					return false;
				if($('#c_fax').val() == ''){
					alert('传真号码不能为空!');
					return false;
				}
				if(!validateFax($('#c_fax').val()))
					return false;
			},  
			success: function(data){
				var returnObject = eval('(' + data + ')');
				if(!returnObject.success){
					alert(returnObject.message);
				}else{
					alert('注册成功!请耐心等待管理员审核');
					window.location.href='index.jsp';
				}
			}
		})
	}else if(currSelect == '2'){//提交注册讲师
		$('#teacherForm').form('submit',{  
			url: 'struts/Login_saveTeacher',  
			//url: 'struts/Login_checkUser',  
			onSubmit: function(){  
				if($('#t_realName').val() == '' || $('#t_realName').val() == null){
					alert('姓名不能为空!');
					return false;
				}
				if($('#t_birthday').val() == ''){
					alert('出生日期不能为空!');
					return false;
				}
				if(!validateDate($('#t_birthday').val()))
					return false;
				
				if($('#t_password').val() == '' || $('#t_password').val() == null){
					alert("密码不能为空!");
					return false;
				}
				if($('#t_password').val() != $('#t_confirmPassword').val()){
					alert('两次输入的密码不同!');
					return false;
				}
				//
				if($('#t_internalPayment').val() == ''){
					alert('对内课酬不能为空!');
					return false;
				}
				var numReg = new RegExp("^[0-9]*$");
				if(!numReg.test($('#t_internalPayment').val())){
			        alert("对内课酬只能为数字!");
			        return false;
			    }
				if($('#t_externalPayment').val() == ''){
					alert('对外课酬不能为空!');
					return false;
				}
				if(!numReg.test($('#t_internalPayment').val())){
			        alert("对内课酬只能为数字!");
			        return false;
			    }
				if($('#t_telephone').val() == ''){
					alert('联系电话不能为空!');
					return false;
				}
				if(!validateTel($('#t_telephone').val()))
					return false;
				
				if($('#t_email').val() != '' && !validateEmail($('#t_email').val()))
					return false;

				if($('#t_cellphone').val() != '' && !validateCell($('#t_cellphone').val()))
					return false;
			},  
			success: function(data){
				var returnObject = eval('(' + data + ')');
				if(!returnObject.success){
					alert(returnObject.message);
				}else{
					alert('注册成功!请耐心等待管理员审核');
					window.location.href='index.jsp';
				}
			}
		})
	}else{//提交注册培训机构
		$('#orgForm').form('submit',{  
			url: 'struts/Login_saveOrg',  
			//url: 'struts/Login_checkUser',  
			onSubmit: function(){ 
				if($('#o_orgName').val() == ''){
					alert('机构名称不能为空!');
					return false;
				}
				if($('#o_city').val() == ''){
					alert('所在地区不能为空!');
					return false;
				}
				
				if($('#o_password').val() == '' || $('#o_password').val() == null){
					alert("密码不能为空!");
					return false;
				}
				if($('#o_password').val() != $('#o_confirmPassword').val()){
					alert('两次输入的密码不同!');
					return false;
				}
				if($('#o_contact').val() == ''){
					alert('联系人不能为空!');
					return false;
				}
				if($('#o_email').val() == ''){
					alert('电子邮件不能为空!');
					return false;
				}
				if(!validateEmail($('#o_email').val()))
					return false;
				if($('#o_cellphone').val() ==''){
					alert('移动电话不能为空!');
					return false;
				}
				if(!validateCell($('#o_cellphone').val()))
					return false;
				if($('#o_telephone').val() ==''){
					alert('联系电话不能为空!');
					return false;
				}
				if(!validateTel($('#o_telephone').val()))
					return false;
				
				if($('#o_postCode').val() ==''){
					alert('邮政编码不能为空!');
					return false;
				}
			},  
			success: function(data){
				var returnObject = eval('(' + data + ')');
				if(!returnObject.success){
					alert(returnObject.message);
				}else{
					alert('注册成功!请耐心等待管理员审核');
					window.location.href='index.jsp';
				}
			}
		})
	}
	
}
function validateDate(date){
	var dateReg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})/;
	if(!dateReg.test(date)){
		alert('日期格式不正确!');
		return false;
	}
	return true;
}
function validateTel(tel){
	var telReg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	if(!telReg.test(tel)){
		alert('联系电话格式不正确!');
		return false;
	}
	return true;
}
function validateFax(fax){
	var telReg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	if(!telReg.test(fax)){
		alert('传真号码格式不正确!');
		return false;
	}
	return true;
}
function validateEmail(email){
	var emailReg = /^(?:\w+\.?)*\w+@(?:\w+\.)*\w+$/;
	if(!emailReg.test(email)){
		alert('电子邮件格式不正确!');
		return false;
	}
	return true;
}
function validateCell(cell){
	var cellReg = /^(?:13\d|15[89])-?\d{5}(\d{3}|\*{3})$/;
	if(!cellReg.test(cell)){
		alert('移动号码格式不正确!');
		return false;
	}
	return true;
}
function clearForm(){
	$('#compForm').form('clear');
	$('#orgForm').form('clear');
	$('#teacherForm').form('clear');
}
</script>
<body>
<jsp:include page="head.jsp" flush="true"/>
<div class="mainContent path" style="border-bottom:1px solid #ccc">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>注册用户</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->
<style>
	.loginForm dd select{float:left;width:150px;height:29px;margin-top:5px;border:1px solid #ccc}
	.loginForm dd textarea{float:left;width:280px;height:100px;margin-top:5px;border:1px solid #ccc}
</style>

<div class="mainContent loginForm" style="padding-top:50px">

	<div class='registerBg'></div>
	<dd><span>用户类别:</span><select id="userType" name="userType" onchange="javascript:selectType()"><option value="2" selected>讲师</option><option value="1">企业用户</option><option value="3">培训机构</option></select></dd>
	
	<div id="comp"  style='display:none'>
	<form id="compForm" method="post" >
		<dd><span>用户名:</span><input type="text" name="username" id="c_username"/><em>*</em></dd>
		<dd><span>公司名称:</span><input type="text" name="company" id="c_company"/><em>*</em></dd>
		<dd><span>城市:</span><input type="text"  name="city" id="c_city"/><em>*</em></dd>
		<dd><span>密码:</span><input type="password"  name="password" id="c_password"/><em>*</em></dd>
		<dd><span>确认密码:</span><input type="password"  name="confirmPassword" id="c_confirmPassword"/><em>*</em></dd>
		<dd><span>联系人:</span><input type="text" name="contact" id="c_contact"/><em>*</em></dd>
		<dd><span>任职部门:</span><input type="text" name="department" id="c_department"/><em>*</em></dd>
		<dd><span>电子邮箱:</span><input type="text" name="email" id="c_email"/><em>*</em></dd>
		<dd><span>移动电话:</span><input type="text" name="cellphone" id="c_cellphone"/><em>*</em></dd>
		<dd><span>联系电话:</span><input type="text" name="telephone" id="c_telephone"/><em>*</em><em class="black">&nbsp;(格式为：020-61908283)</em></dd>
		<dd><span>传真号码:</span><input type="text" name="fax" id="c_fax"/><em>*</em></dd>
		<dd><span>联系QQ:</span><input type="text" name="assistQq" id="t_aaassistQq"/></dd>
	</form>
	</div>

	<div id="org" style='display:none'>
		<form id="orgForm"  method="post" enctype="multipart/form-data">
		<dd><span>用户名:</span><input type="text" name="username" id="o_username"/><em>*</em></dd>
		<dd><span>logo:</span><input type="file" name="file" id="t_file"/></dd>
		<dd><span>机构名称:</span><input type="text" name="orgName" id="o_orgName"/><em>*</em></dd>
		<dd><span>地址:</span><input type="text"  name="address" id="o_address"/><em>*</em></dd>
		<dd><span>公司网址:</span><input type="text" name="website" id="o_website"/></dd>
		<dd><span>培训类别:</span><select name="category" id="t_category" ><option value="003_01" selected>财务管理</option><option value="003_02">采购供应链仓储</option><option value="003_03">人力资源管理</option><option value="003_04">生产管理</option><option value="003_05">市场营销</option><option value="003_06">战略管理</option><option value="003_07">项目管理</option><option value="003_08">职业技能</option></select></dd>
		<dd><span>密码:</span><input type="password"  name="password" id="o_password"/><em>*</em></dd>
		<dd><span>确认密码:</span><input type="password"  name="confirmPassword" id="o_confirmPassword"/><em>*</em></dd>
		<dd><span>联系人:</span><input type="text" name="contact" id="o_contact"/><em>*</em></dd>
		<dd><span>电子邮箱:</span><input type="text" name="email" id="o_email"/><em>*</em></dd>
		<dd><span>移动电话:</span><input type="text" name="cellphone" id="o_cellphone"/><em>*</em></dd>
		<dd><span>联系电话:</span><input type="text" name="telephone" id="o_telephone"/><em>*</em></dd>
		<dd><span>传真号码:</span><input type="text" name="fax" id="o_fax"/></dd>
		<dd><span>邮编:</span><input type="text" name="postCode" id="o_postCode"/><em>*</em></dd>
		<dd><span>联系QQ:</span><input type="text" name="assistQq" id="t_aassistQq"/></dd>
		<dd><span>公司简介:</span><textarea name="introduction" id="o_introduction"></textarea></dd>
		</form>
	</div>

	<div id="teacher">
		<form id="teacherForm"  method="post"  enctype="multipart/form-data">
		<dd><span>用户名:</span><input type="text" name="username" id="t_username"/><em>*</em></dd>
		<dd><span>讲师名:</span><input type="text" name="realName" id="t_realName"/><em>*</em></dd>
		<dd><span>真实姓名:</span><input type="text" name="realRealName" id="t_realRealName"/></dd>
		<dd><span>男士/女士:</span><select name="isMale" id="isMale" >
		<option value="true" selected>男</option><option value="false">女</option></select></dd>
		<dd><span>头像:</span><input type="file" name="file" id="file"/></dd>
		<dd><span>所在城市:</span><input type="text"  name="city" id="t_city"/><em class="black">（您当前工作或居住的城市）</em></dd>
		<dd><span>出生日期:</span><input type="text" name="birthday" id="t_birthday"/><em>*&nbsp;格式请用03/12/1976</em></dd>
		<dd><span>主讲类别:</span><select name="majorCatgory" id="t_majorCatgory" >
		<option value="003_01" selected>财务管理</option><option value="003_02">采购供应链仓储</option>
		<option value="003_03">人力资源管理</option><option value="003_04">生产管理</option>
		<option value="003_05">市场营销</option><option value="003_06">战略管理</option><option value="003_07">项目管理</option>
		<option value="003_08">职业技能</option></select></dd>
		<dd><span>密码:</span><input type="password"  name="password" id="t_password"/><em>*</em></dd>
		<dd><span>确认密码:</span><input type="password"  name="confirmPassword" id="t_confirmPassword"/><em>*</em></dd>
		<dd><span>对内课酬:</span><input type="text" name="internalPayment" id="t_internalPayment"/><em>*</em></dd>
		<dd><span>对外课酬:</span><input type="text" name="externalPayment" id="t_externalPayment"/><em>*</em></dd>
		<dd><span>电子邮箱:</span><input type="text" name="email" id="t_email"/><em>*</em></dd>
		<dd><span>移动电话:</span><input type="text" name="cellphone" id="t_cellphone"/></dd>
		<dd><span>联系电话:</span><input type="text" name="telephone" id="t_telephone"/><em>*&nbsp;如020-12345678</em></dd>
		<dd><span>传真号码:</span><input type="text" name="fax" id="t_fax"/></dd>
		<dd><span>助理姓名:</span><input type="text" name="assistName" id="t_assistName"/></dd>
		<dd><span>助理QQ:</span><input type="text" name="assistQq" id="t_assistQq"/></dd>
		<dd><span>助理电话:</span><input type="text" name="assistPhone" id="t_assistPhone"/></dd>
		<dd><span>助理邮箱:</span><input type="text" name="assistEmail" id="t_assistEmail"/></dd>
		<dd><span>个人简介:</span><textarea name="introduction" id="t_introduction"></textarea></dd>
		<div class="clear"></div>
		<dd style="display:none"><span>擅长项目:</span><textarea name="expertIn" id="t_expertIn"></textarea></dd>
		</form>
	</div><div class="clear"></div>
	<dd class="button"><a href='#' onclick="javascript:register();">提交</a><a href='#' onclick="javascript:clearForm();">重置</a></dd>
	
</div>

<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>