<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="css/face.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="js/easyui/themes/gray/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css"/>
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
		<li>内训申请</li>
	</ul>
	<div class="clear"></div>
</div>
<div class="mainContent needForm">
		<h1>发布内训申请</h1>
		<table cellspacing="0" cellpadding="0" class="need" align="center">
		<tr>
			<td colspan="2">我单位预计<input style='width:40px'/>人，计划进行企业内训</td>
		</tr>
		<tr>
			<td>邀请贵公司<input />老师上门，</td><td>举办:<input />课程</td>
		</tr>
		<tr>
			<td>单位名称:&nbsp;<input /></td>
			<td>联系人:&nbsp;<input/><em>*</em></td>
		</tr>
		<tr>
			<td>联系电话:&nbsp;<input /><em>*</em></td>
			<td>传真:&nbsp;<input/></td>
		</tr>
		<tr>
			<td>移动电话:&nbsp;<input /></td>
			<td>电子邮箱:&nbsp;<input/></td>
		</tr>
		<tr>
			<td>任职部门:&nbsp;<input /></td>
			<td>MSN:&nbsp;<input/></td>
		</tr>
		<tr>
			<td>企业类型:&nbsp;<input /></td>
			<td>业务范围:&nbsp;<input/></td>
		</tr>
		<tr>
			<td>开始时间:&nbsp;<input class="easyui-datebox"></td>
			<td>结束时间:&nbsp;<input class="easyui-datebox" ></td>
		</tr>
		<tr>
			<td>财务预算:&nbsp;<input /></td>
			<td>教学语种:&nbsp;<input/></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:18px;">参训对象简单描述:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><textarea></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">学员基础简单说明:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><textarea></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">企业简介:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><textarea></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">具体那个环节出问题:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><textarea></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">培训内容说明:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><textarea></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">预期目标:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><textarea></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><input type="radio" name='group1' id="r1" style="border:0px;"/><label  for="r1">确认报名</label>&nbsp;<input style="border:0px;" type="radio" name='group1' id="r2"/><label for="r2">正在申请中</label></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:12px;">备注:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><textarea></textarea></td>
		</tr>


		<tr >
			<td colspan="2" align="center" style='padding-top:30px;padding-bottom:30px'><a href='#' onclick="javascript:login()" class="normalButton">确定报名</a><a href='#' onclick="javascript:login()" class="normalButton">重新填写</a></td>
		</tr>
		</table>
</div>

<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>