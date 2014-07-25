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
<script>
	function submitNeed(){
		$('#needForm').form('submit',{  
			url: encodeURI('struts/Requirement_addRequirement'),  
			onSubmit: function(){  
					if($('#requiredCourse').val() == ''){
						alert('需求描述不能为空!');
						return false;
					}
					if($('#contact').val() == ''){
						alert('联系人不能为空!');
						return false;
					}
					if($('#telephone').val() == ''){
						alert('固定电话不能为空!');
						return false;
					}
					if($('#email').val() == ''){
						alert('电子邮件不能为空!');
						return false;
					}
					if($('#comp_name').val() == ''){
						alert('所在单位不能为空!');
						return false;
					}
				
				//return $(this).form('validate');  
			},  
			success: function(data){
				alert(data);
				$('#needForm').form("clear");
			}
		});
	}
	function clearForm(){
		$('#needForm').form("clear");
	}
</script>
<body>
<jsp:include page="head.jsp" flush="true"/>
<div class="mainContent path" style="border-bottom:1px solid #ccc">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>发布需求</li>
	</ul>
	<div class="clear"></div>
</div>
<div class="mainContent needForm">
		<h1>发布需求信息</h1>
		<form id="needForm">
		<table cellspacing="0" cellpadding="0" class="need" align="center">
		<tr>
			<td colspan="2" align="left">需求描述:&nbsp;<input style="width:450px;" name="requiredCourse" id="requiredCourse"/><em class="black">(20字以内)</em></td>
		</tr>
		<tr>
			<td>开始时间:&nbsp;<input class="easyui-datebox" name="startTime" id="startTime"/></td>
			<td>结束时间:&nbsp;<input class="easyui-datebox" name="endTime" id="endTime"/></td>
		</tr>
		<tr>
			<td>所在地区:&nbsp;<input name="city" id="city"/></td>
			<td>参加人数:&nbsp;<input name="headCount" id="headCount"/></td>
		</tr>
		<tr>
			<td colspan="2">有效时间:&nbsp;<select name="validDays" id="validDays"><option value="10">10天</option><option value="20">20天</option><option value="30">30天</option></select></td>
		</tr>
		<tr>
			<td colspan="2" valign="top" height="100px" >需求说明:&nbsp;<textarea name="description" id="description"></textarea></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;联系人:&nbsp;<input name="contact" id="contact"/><em>*</em></td>
		</tr>
		<tr>
			<td colspan='2'>固定电话:&nbsp;<input name="telephone" id="telephone"/><em>*</em></td>
		</tr>
		<tr>
			<td colspan='2'>移动电话:&nbsp;<input name="cellphone" id="cellphone"/></td>
		</tr>
		<tr>
			<td colspan='2'>电子邮箱:&nbsp;<input name="email" id="email"/><em>*</em></td>
		</tr>
		<tr>
			<td colspan='2'>所在单位:&nbsp;<input name="comp_name" id="comp_name"/><em>*</em></td>
		</tr>
		<tr >
			<td colspan="2" align="center" style='padding-top:30px;padding-bottom:30px'><a href='#' onclick="javascript:submitNeed()" class="normalButton">发布需求</a><a href='javascript:void(0)' onclick="javascript:clearForm()" class="normalButton">清空</a></td>
		</tr>
		</table>
		</form>
</div>


<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>