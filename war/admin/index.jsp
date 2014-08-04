<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String username = (String)session.getAttribute( "userName" );
if(username==null||username==""){
	response.sendRedirect("login.jsp");
}
String visible = (String)session.getAttribute( "xxx" );
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>南北培训网后台</title>
	<link rel="stylesheet" type="text/css" href="../js/easyui/themes/gray/easyui.css">
	<link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css"/>
	<script type="text/javascript" src="../js/easyui/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript">
	var firstLogin = true;
	var poped = false;
	var myVar=setInterval(function(){popUpRelogin();}, 1000*60*45);
	var xx ="<%=visible%>"+"";
	//setVisible();
	function popUpRelogin(){
		//console.log(xx);
		if(!firstLogin&&!poped){
			$('#relogin-dlg').dialog('open').dialog('setTitle', 'session过期，请重新登录。');
			//$("#relogin-dlg").dialog("widget").find(".panel-tool-close").hide();
			//$('.panel window.panel-header.panel-tool.panel-tool-close').css( "display", "none" );
			$('#relogin-dlg').parent().find('.panel-tool-close').hide();
		}
		firstLogin = false;
	}
	function setVisible(){
		if(firstLogin&&xx=="xxx"){
			$('.not-visible-to-normal-admin').hide();
			//var node = $('#menue-tree').find('.not-visible-to-normal-admin');
			//$('#menue-tree').tree('hide',node.target);
			var cls = $('#menue-tree').parent().find('.not-visible-to-normal-admin');
			console.log($('#menue-tree').parent().find('.not-visible-to-normal-admin'));
			var xtsznode = $('#menue-tree').tree('find', 'xtsz');
			$('#menue-tree').tree('remove', xtsznode.target);
			var zlglnode = $('#menue-tree').tree('find', 'zlgl');
			$('#menue-tree').tree('remove', zlglnode.target);
		}else{
			$('#menue-tree').parent().find('.not-visible-to-normal-admin').show();
		}
	}
	function relogin(){
		$('#relogin-fm').form('submit', {
			url : '../struts/Admin_relogin',
			onSubmit : function() {
				return $('#relogin-fm').form('validate');
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
					$('#relogin-fm').form('clear');
					$('#relogin-dlg').dialog('close');
					setVisible();
				}else {
					$.messager.show({
						title : 'Error',
						msg : data.message,
						timeout : 3000,
						showType : 'fade'
					});
				}
			}
		});
	}
	function addTab(menuID,src){ 
		if("<%=username%>"==""){
			$.messager.confirm(
				'Confirm',
				'session过期，请重新登录。',
				function(r) {
					if (r) {
						response.sendRedirect("login.jsp");
					}else{
						return;
					}
			});
		}
		var tt = $('#tabs');
		var tabName = menuID;
		if(tt.tabs('exists', tabName)){//如果tab已经存在,则选中并刷新该tab    	
	        tt.tabs('select', tabName);
	        //tt.tabs('update',{tab:tt,options:tt.tabs('options')});
		}else {
			tt.tabs('add',{
				title: tabName,
				content: "<iframe frameborder='0'  src='"+src+".html' style='width:100%;height:100%;'></iframe>",
				closable: true
			});
		}
	}
	function open1(plugin){
		if ($('#tabs').tabs('exists',plugin)){
			$('#tabs').tabs('select', plugin);
		} else {
			$('#tabs').tabs('add',{
				title:plugin,
				href:plugin+'.html',
				closable:true,
				extractor:function(data){
					data = $.fn.panel.defaults.extractor(data);
					var tmp = $('<div></div>').html(data);
					data = tmp.find('#content').html();
					tmp.remove();
					return data;
				}
			});
		}
	}
	function changeProfile(){
		$('#pwd-dlg').dialog('open').dialog('setTitle', '修改密码');
	}
	function closeDlg(){
		//alert('sdfsdf');
		$('pwd-dlg').dialog('close');
	}
	
	function changePwd(){
		var message = '';
		if($('#pwd').val()==null||$('#pwd').val()==''||$('#cfpwd').val()==null||$('#cfpwd').val()==''||$('#newPwd').val()==null||$('#newPwd').val()==''){
			message += '请填写所有密码';
		}else{
			if($('#newPwd').val()==$('#cfpwd').val()){
				if($('#newPwd').val().length<6){
					message += '密码不能少于6位';
				}
			}else{
				message += '密码与确认密码不符';
			}
		}
		
		if(message!=''){
			$.messager.show({
				title : '温馨提示',
				msg : message,
				timeout : 3000,
				showType : 'fade'
			});
		}else{
			$.ajax({
				url:'../struts/Admin_changePwd?pwd='+$('#pwd').val()+'&newPwd='+$('#newPwd').val(),
				success: function(data){
					var data = eval('(' + data + ')'); // change the JSON string to javascript object  
					if(data.success){
						alert("成功修改密码，请重新登录");
						window.location.href = "login.jsp";
					}else{
						$.messager.show({
							title : '温馨提示',
							msg : data.message,
							timeout : 3000,
							showType : 'fade'
						});
					}
				}
			});
		}
	}
	
	function logout(){
		$.messager.confirm(
				'Confirm',
				'注销登录？',
				function(r) {
					if (r) {
						$.ajax({
							url:'../struts/Admin_logout',
							success: function(data){
								window.location.href = "login.jsp";
							}
						});
					}else{
						return;
					}
			});
	}
	</script>
	<style>
		dd{font-size:12px;padding:0;margin:0;padding-left:30px;padding-top:8px;height:12px;}
		dd a{text-decoration:none;color:#333}
		dd a:hover{text-decoration:underline;color:red}
		.userInfor{float:right;padding-right:20px}
		.userInfor ul{list-style:none}
		.userInfor li{float:left;display:inline;padding-left:10px;}
		.userInfor li a,.userInfor li span{color:white;text-decoration:none;font-size:12px;}
		.userInfor li a:hover{text-decoration:underline}
	</style>
</head>

<body class="easyui-layout" style="min-width:1000px;overflow:auto"  onLoad="setVisible()">>
	<div region="north" style="height:60px;line-height:60px;border:none;overflow:hidden;font-weight:normal;font-size:16px;background:url(../images/adminLogoBg.jpg) repeat-x">
		<img src="../images/adminLogo.jpg" style='float:left'></img>
		<div class="userInfor"><ul><li><span>当前用户:<%=username%></span></li><li><a href="javascript:changeProfile()">修改密码</a></li><li><a href="javascript:logout()">退出登录</a></li></ul></div>
	</div>

	<div region="west" split="true" style="width:220px;overflow:hidden" title="功能菜单">
			<ul id="menue-tree" class="easyui-tree">
				<li iconCls="icon-base"><span>课程管理</span>
					<ul>
						<li iconCls="icon-gears">
							<a href="javascript:addTab('发布公开课','addCourse')">发布公开课</a>
						</li>
						
						<li iconCls="icon-gears">
							<a href="javascript:addTab('公开课管理','courses')">公开课管理</a>
						</li>
						<li iconCls="icon-gears">
							<a href="javascript:addTab('内训课管理','innerCourses')">内训课管理</a>
						</li>
						<li iconCls="icon-gears">
							<a href="javascript:addTab('需求管理','requirements')">需求管理</a>
						</li>
						<li iconCls="icon-gears">
							<a href="javascript:addTab('报名管理','applications')">报名管理</a>
						</li>
					</ul>
				</li>
				
				<li iconCls="icon-base"><span>资讯管理</span>
					<ul>
						<li iconCls="icon-gears">
							<a href="javascript:addTab('文章列表','articles')">文章列表</a>
						</li>
						
						<li iconCls="icon-gears">
							<a href="javascript:addTab('现场管理','liveScenes')">现场管理</a>
						</li>
						<li iconCls="icon-gears">
							<a href="javascript:addTab('拓展管理','tuozhan')">拓展管理</a>
						</li>
						<li iconCls="icon-gears">
							<a href="javascript:addTab('下载管理','downloads')">下载管理</a>
						</li>
					</ul>
				</li>
				
				<li iconCls="icon-base"><span>问答管理</span>
					<ul>
						<li iconCls="icon-gears">
							<a href="javascript:addTab('问答管理','wendas')">问答管理</a>
						</li>
						
					</ul>
				</li>
				
				<li iconCls="icon-base"  id="zlgl" class="not-visible-to-normal-admin"><span>资料管理</span>
					<ul>
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('外部注册讲师资料管理','outTeacherList')">外部注册讲师资料管理</a>
						</li>
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('内部发布讲师资料管理','teacherList')">内部发布讲师资料管理</a>
						</li>
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('机构资料管理','orgList')">机构资料管理</a>
						</li>
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('企业资料管理','compList')">企业资料管理</a>
						</li>
					</ul>
				</li>
				<li iconCls="icon-base" id="xtsz"><span>系统设置</span>
					<ul>
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('字典管理','dictionary')">字典管理</a>
						</li>
						
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('关键词管理','keywords')">关键词管理</a>
						</li>
						
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('专题管理','subjects')">专题管理</a>
						</li>
						
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('系统用户','userList')">系统用户</a>
						</li>
						
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('后台用户管理','adminList')">后台用户管理</a>
						</li>
 
						<li iconCls="icon-gears">
							<a href="javascript:void(0)" onclick="javascript:addTab('广告设置','guanggao')">广告设置</a>
						</li>
					</ul>
				</li>
			</ul>
	</div>

	<div region="center" border="false">
			<div id="tabs" class="easyui-tabs" fit="true" border="false" plain="true">
				<div title="首页">
					<p style='padding:20px;padding-left:20px'><%=username%>,欢迎登录南北培训网后台管理系统</p>
				</div>
			</div>
	</div>

	<div id="menu" class="easyui-menu" style="width:150px;">
		<div id="m-refresh">刷新</div>
		<div class="menu-sep"></div>
		<div id="m-closeall">全部关闭</div>
		<div id="m-closeother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="m-close">关闭</div>
	</div>
	
	<div id="pwd-dlg" class="easyui-dialog"
	style="width: 240px; height: 150px; padding: 5px 5px" closed="true"
	modal="true"  data-options="buttons: [{
											text:'确定',
											iconCls:'icon-ok',
											handler:function(){
											changePwd(); } 
										}]">
		<form id="pwd-fm" method="post">
			<table cellspacing="0" cellpadding="0" class="formTable">
				<tr>
					<td class="itemText"><label>旧密码:</label></td>
					<td>
						<input id="pwd" name="pwd" data-options="required:true,missingMessage:'不能为空'"  class="easyui-validatebox" type="password"/>
					</td>
				</tr>
				<tr>
					<td class="itemText"><label>新密码:</label></td>
					<td>
						<input id="newPwd" name="newPwd" data-options="required:true,missingMessage:'不能为空'"  class="easyui-validatebox" type="password"/>
					</td>
				</tr>
				<tr>
					<td class="itemText"><label>确认密码:</label></td>
					<td>
						<input id="cfpwd" name="cfpwd" data-options="required:true,missingMessage:'不能为空'"  class="easyui-validatebox" type="password"/>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div id="relogin-dlg" class="easyui-dialog"
	style="width: 250px; height: 150px; padding: 5px 5px" closed="true"
	modal="true"  data-options="buttons: [{
											text:'重新登录',
											iconCls:'icon-ok',
											handler:function(){
											relogin(); } 
										}],
								closeOnEscape: false,
								open: function(event, ui) { 
									$('.ui-dialog-titlebar-close', ui.dialog || ui).hide();
									alert('hahahahahdifdif');
									}
								">
		<form id="relogin-fm" method="post">
			<table cellspacing="0" cellpadding="0" class="formTable">
				<tr>
					<td class="itemText"><label>用户名:</label></td>
					<td colspan="2">
						<input id="username" name="username" data-options="required:true,missingMessage:'必填'"  class="easyui-validatebox" type="text"/>
					</td>
				</tr>
				<tr>
					<td class="itemText"><label>密码:</label></td>
					<td colspan="2">
						<input id="relogin-pwd" name="pwd" data-options="required:true,missingMessage:'必填'"  class="easyui-validatebox" type="password"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>


