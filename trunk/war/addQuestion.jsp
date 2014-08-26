<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = request.getParameter("id");
	String username = request.getSession().getAttribute("clientUserName")==null?null:request.getSession().getAttribute("clientUserName").toString();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>南北培训网</title>
</head>
<body>
<jsp:include page="head.jsp" flush="true"/>
<script>
	$(function(){
		var user =  "<%=username%>";
		if(user=="null" || user == ""){
			alert("请登录！");
			window.location.href = "login.jsp";
		}
	})

	function publicQuestion(){
		var user =  "<%=username%>";
		if(user=="null" || user == ""){
			alert("请登录！");
			window.location.href = "login.jsp";
			return;
		}
		$('#question-fm').form('submit', {
			url : 'struts/Wenda_saveQuestion',
			onSubmit : function() {
				return $('#question-fm').form('validate');
			},
			success : function(data) {
				var data = eval('(' + data + ')'); // change the JSON string to javascript object  
				if (data.success) {
					$.messager.show({
						title : 'Success',
						msg : data.message,
						timeout : 3000,
						showType : 'fade'
					});
					alert("成功发布！");
					$('#question-fm').form('clear');
				} else {
					$.messager.show({
						title : 'Error',
						msg : data.message,
						timeout : 3000,
						showType : 'fade'
					});
				}
			}
		});
	};

</script>
<!--当前路径 start-->
<div class="mainContent path" id="path">
	<div class="clear"></div>
</div>
<!--当前路径 end-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px;">
	
	<!--左边部分课程信息 start-->
	<div class="leftInPart">
		<form id="question-fm" method="post">
			<table cellspacing="0" cellpadding="0" class="formTable">
				<tr>
					<td class="itemText"><label>类别:</label></td>
					<td>
						<div id="courseTypeInForm">
							<input class="easyui-combobox"
							style="width: 600px;" name="category" id="category"
							data-options="  
								url:'struts/Course_queryComboCourseTypes',  
								valueField:'codeName',  
								textField:'showName',  
								panelHeight:'200'  ,
								editable:false ,
								required:true,
								missingMessage:'必填项'
							">
							</input>
					</td>
				</tr>
				<tr>
					<td class="itemText"><label>问题标题:</label></td>
					<td>
						<input id="title" name="title" style="width: 600px;"  data-options="required:true,missingMessage:'标题不能为空'"  class="easyui-validatebox" type="text"/>
					</td>
				</tr>
				<tr>
					<td class="itemText"><label>问题描述:</label></td>
					<td>
						<textarea  class="easyui-validatebox" id="content" name="content"
							data-options="required:true,missingMessage:'问题描述不能为空'"
							style="width: 600px; height: 100px;" maxlength="200" type="textarea"
							required="true"></textarea>
					</td>
				</tr>
				<tr>
					<td class="itemText" colspan="2"><button type="button" onclick="publicQuestion()">发布问题</button></td>
				</tr>
			</table>
		</form>
	</div>
	<!--左边部分课程信息 end-->
	
	<!--右边部分信息 start-->
	<div class="rightInPart">
			<div class="rightTeacher">
				<h5  class="first">热门文章</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:195px;"/>
					<div class="clear" style="height:5px;"></div>
					<ul class="list7" id="hotArticle">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="red">2</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="red">3</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>					
					</ul>	
					<div class="clear"></div>
				</div>
				<h5>推荐文章</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:195px;"/>
					<div class="clear" style="height:5px;"></div>
					<ul class="list7" id="recommandArticle">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span></a><div class="clear"></div></li>
						<li class="line"><a><span class="red">2</span><span class="text">人力资源 </span></a><div class="clear"></div></li>
						<li class="line"><a><span class="red">3</span><span class="text">人力资源 </span></a><div class="clear"></div></li>				
					</ul>
				<div class="clear"></div>
				</div>
			</div>
			<div style="height:30px">&nbsp;</div>
	</div>
	<!--右边部分信息 end-->
	
</div>

<div class="clear"></div>
<jsp:include page="foot.jsp" flush="true"/>

<style type="text/css">
#fm {
	margin: 0;
	padding: 10px 40px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

.itemText {
	width: 300px;
	text-align: left;
	height: 30px;
	padding-left: 10px;
	vertical-align: top
}

.formTable td {
	vertical-align: top
}
</style>
</body>
</html>