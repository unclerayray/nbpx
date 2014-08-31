<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/easyui/jquery-1.8.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="js/poshytip-1.2/src/tip-skyblue/tip-skyblue.css">
<link rel="stylesheet" type="text/css" href="js/poshytip-1.2/src/tip-darkgray/tip-darkgray.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<script src="ckeditor/ckeditor.js"></script>
<script src="js/poshytip-1.2/src/jquery.poshytip.min.js"></script>
<script src="js/easyui/plugins/jquery.validatebox.js"></script>
<title>南北培训网</title>
</head>
<script>
	
	function clearForm(){
		$('#fm').form("clear");
	}
	function saveCourse() {

		var submitUrl = 'struts/Course_saveUserNXCourse?objectName=courseAllInfo';
		//alert(1);
		$('#fm').form('submit',
						{url:submitUrl,
							onSubmit : function() {
								return $('#fm').form('validate');
							},
							success : function(data) {
								var data = eval('(' + data + ')'); // change the JSON string to javascript object  
								//alert('data = ' + data);
								if (data.success) {
									alert("发布成功，稍后管理员会对课程进行审核!");
									clearForm();
								}
							}
						});
	}

</script>
<body>
<jsp:include page="head.jsp" flush="true"/>
<div class="mainContent path" style="border-bottom:1px solid #ccc">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>发布内训课程</li>
	</ul>
	<div class="clear"></div>
</div>
<div class="mainContent needForm">
		<h1>发布内训课程</h1>
<style>
	#fm tr{height:35px}
</style>
<form id="fm" method="post" enctype="multipart/form-data">
			<table cellspacing="0" cellpadding="0" width="900px" style="font-size:12px">
				<tr>
					<td width="100px" align="right" valign="top">课程标题:</td>
					<td colspan="3" align="left" valign="top"><input
						class="easyui-validatebox" id="courseTitle" name="title"
						data-options="required:true,tipPositionY:'center',tipPositionX:'right',className:'tip-darkgray',missingMessage:'必填项'"
						style="width: 600px;"></td>
				</tr>
				<tr>
					<td width="100px" align="right" valign="top">课程类别:</td>
					<td  align="left" colspan='3' valign="top"><input class="easyui-combobox" style="width: 200px;"
						name="category" id="category"
						data-options="  
							url:'struts/Course_queryComboCourseTypes',  
							valueField:'codeName',  
							textField:'showName',  
							panelHeight:'auto'  ,
							editable:false ,
							required:true,
							tipPositionY:'center',
							tipPositionX:'right',
							className:'tip-darkgray',
							missingMessage:'必填项'
							">
						</td>
				</tr>
				<tr>
					<td width="100px" align="right" valign="top">课程对象:</td>
					<td colspan="3" align="left" valign="top"><input name="targets" id="courseTarget"
						class="easyui-combobox"
						data-options="  
							url:'struts/Dictionary_queryComboDics?p_dicType=010',   
							valueField:'codeName',  
							textField:'showName',
							panelHeight:'200',
							multiple:true,
							editable:true"
						style="width: 600px;"></td>
				</tr>
				<tr>
					<td width="100px" align="right" valign="top">课程视频:</td>
					<td colspan="3" align="left" valign="top">
							<input name="hasVideo" id="hasVideo" type="checkbox">
					</td>
				</tr>
	
				<tr>
					<td width="100px" align="right" valign="top">课程内容:</td>
					<td colspan="3" align="left" valign="top">
						<textarea name="content" id="content" style="width:600px;height:300px"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="8"  colspan="4" style="padding-top:30px;padding-bottom:50px;padding-left:90px" align="right"><a href='#' onclick="javascript:saveCourse(true)" class="normalButton">发布课程</a><a href='javascript:void(0)' onclick="javascript:clearForm()" class="normalButton">清空</a>
				</tr>
			</table>
			
		</form>
</div>

<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>