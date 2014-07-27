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
		CKEDITOR.instances.content.setData('');
	}
	$(function(){
		createCkeditor();
		CKEDITOR.instances.content.setData('');
	});
	
	function createCkeditor() {

		var config = {
			uiColor : '#cccccc',
			language : 'zh-cn'
		};
		var editor = CKEDITOR.instances['content'];
		if (editor) {
			editor.destroy(true);
		}
		CKEDITOR.replace('content', config);
	}
	
	function saveArticle() {
		$('#fm').form('submit', {
			url : 'struts/Article_saveUserArticle?objectName=articleDetail',
			onSubmit : function() {
				//alert('keywords we got = ' + $('#articleKeywords').combobox('getValues'));
				return $('#fm').form('validate');
			},
			success : function(data) {
				var data = eval('(' + data + ')'); // change the JSON string to javascript object  
				//alert('data = ' + data);
				if (data.success) {
					alert("发布成功，稍后管理员会对文章进行审核");
					 clearForm();
				} else {
					alert("发布失败，请联系管理员");
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
		<li>发布文章</li>
	</ul>
	<div class="clear"></div>
</div>
<div class="mainContent needForm">
		<h1>发布文章</h1>
		<form id="fm" method="post">
			<table cellspacing="0" cellpadding="0" class="formTable" style="font-size:12px">
				<div>
					<input id="dlg-articleId" name="articleId" type="hidden">
				</div>
				<tr height="35">
					<td align="right" width="100px">文章标题:</td>
					<td colspan="3" align="left"><input class="easyui-validatebox"
								id="articleTitle" name="articleTitle"
								data-options="required:true,tipPositionY:'center',tipPositionX:'right',className:'tip-darkgray',missingMessage:'必填项'"
								style="width: 800px;"></td>
				</tr>
				<tr height="35">
					<td align="right">文章关键字:</td>
					<td colspan="3" align="left"><input class="easyui-validatebox"
								id="articleKeywords" name="keywords"
								data-options="required:true,tipPositionY:'center',tipPositionX:'right',className:'tip-darkgray',missingMessage:'文章关键字是必填项'"
								style="width: 800px;"></td>
				</tr>
				<tr height="35">
					<td align="right">文章专题:</td>
					<td colspan="3" align="left"><input class="easyui-validatebox"
								id="articleSubject" name="subjects"
								data-options="required:true,tipPositionY:'center',tipPositionX:'right',className:'tip-darkgray',missingMessage:'文章专题是必填项'"
								style="width: 800px;">
					</td>
				</tr>
				<tr height="35">
					<td width="100px" align="right">文章类型:</td>
					<td align="left"><input class="easyui-combobox"
								style="width: 800px;" name="category" id="category"
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
				<tr >
					<td colspan="4" style="padding-top:20px">
						<div id="contentDiv">
							<textarea name="content" id="content" style="width: 940px"></textarea>
						</div>
					</td>
				</tr>
				<tr><td colspan="4" style="padding-top:30px;padding-bottom:50px" align="right"><div><a href='#' onclick="javascript:saveArticle()" class="normalButton right">发布文章</a><a href='javascript:void(0)' onclick="javascript:clearForm()" class="normalButton right">清空</a></td></tr>
			</table>
		</form>
</div>


<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>