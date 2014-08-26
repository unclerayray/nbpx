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
		CKEDITOR.instances.content.setData('');
	}
	$(function(){
		createCkeditor();
		CKEDITOR.instances.content.setData('');
		createInfoGrid(null);
	});
	function createInfoGrid(row) {
		var infoUrl = 'struts/Course_queryCourseInfo?selected_courseId=none';
		if (row) {
			infoUrl = 'struts/Course_queryCourseInfo?selected_courseId='
					+ row.courseId;
		}
		$('#dg_info_in')
				.datagrid(
						{
							title : '课程安排',
							url : infoUrl,
							cache : 'false',
							idField : 'courseInfoId',
							width : 350,
							height : 'auto',
							onDblClickCell : function(index, field, value) {
								$(this).datagrid('beginEdit', index);
								var ed = $(this).datagrid('getEditor', {
									index : index,
									field : field
								});
								$(ed.target).focus();
							},
							pagination : false,
							singleSelect : true,
							fitColumns : true,
							loadMsg : '正在加载，请稍候!',
							columns : [ [
									{
										field : 'courseInfoId',
										title : '主键ID',
										width : 80,
										hidden : true
									},
									{
										field : 'startDate',
										title : '开始时间',
										width : 140,
										required : true,
										editor : {
											type : 'datebox',
											options : {
												required : true
											}
										}
									},
									{
										field : 'endDate',
										title : '结束时间',
										width : 140,
										required : true,
										editor : {
											type : 'datebox',
											options : {
												required : true
											}
										}
									},
									{
										field : 'city',
										title : '城市',
										width : 100,
										formatter : function(value, row) {
											return row.cityName;
										},
										editor : {
											type : 'combobox',
											options : {
												url : 'struts/Dictionary_queryComboDics?p_dicType=007',
												valueField : 'codeName',
												textField : 'showName',
												panelHeight : '200',
												editable : false,
												required : true,
												tipPositionY : 'center',
												tipPositionX : 'right',
												className : 'tip-darkgray',
												missingMessage : '必填项'
											}
										}
									} ] ]
						});
	}
	function saveCourse() {
		//var data = CKEDITOR.instances.content.getData();
		//$('#teacherName').val($('#teacherId').combobox('getText'));
		var submitUrl = 'struts/Course_saveUserCourse?objectName=courseAllInfo';
		alert(1);
		$('#fm').form('submit',
						{url:submitUrl,
							onSubmit : function() {
								//$('#isInner').val('false');
								$('#dg_info_in').datagrid('acceptChanges');
								alert(2);
								alert($('#fm').form('validate'));
								return $('#fm').form('validate');
							},
							success : function(data) {
								var data = eval('(' + data + ')'); // change the JSON string to javascript object  
								alert('data = ' + data);
								if (data.success) {
									//upload gloden pic to server
									//uploadGlodenPic(data.dlg_inner_courseId);
									var rows = $('#dg_info_in').datagrid('getRows');
									var infos = {};
									for ( var i = 0; i < rows.length; i++) {
										infos["infos[" + i + "].startDate"] = rows[i].startDate;
										infos["infos[" + i + "].endDate"] = rows[i].endDate;
										infos["infos[" + i + "].city"] = rows[i].city;
										infos["infos[" + i + "].courseId"] = data.dlg_courseId;
									}
									if (rows.length > 0) {
										$.ajax('struts/Course_deleteAndSaveCourseInfo',
														{
															type : 'POST',
															dataType : 'json',
															data : infos,
															success : function(msg) {
																$.messager.show({
																			title : 'Success',
																			msg : '发布成功！',
																			timeout : 3000,
																			showType : 'fade'
																		});
															}
														});
									}
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
	}

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
	
	
	function insertEmptyRow() {
		$('#dg_info_in').datagrid('acceptChanges');
		var index = 0;
		$('#dg_info_in').datagrid('insertRow', {
			index : index,
			row : {}
		});
		$('#dg_info_in').datagrid('selectRow', index);
		$('#dg_info_in').datagrid('beginEdit', index);
	}

	function getRowIndex() {
		var tr = $('#dg_info_in').closest('tr.datagrid-row');
		return parseInt(tr.attr('datagrid-row-index'));
	}

	function removeSelectedRow() {
		var row = $('#dg_info_in').datagrid('getSelected');
		if(row){
			var rowNum = $('#dg_info_in').datagrid('getRowIndex', row);
			$('#dg_info_in').datagrid('deleteRow', rowNum);
		}else{
			if($('#dg_info_in').datagrid('getRows').length>0){
				$('#dg_info_in').datagrid('deleteRow', 0);
			}
		}
	}
</script>
<body>
<jsp:include page="head.jsp" flush="true"/>
<div class="mainContent path" style="border-bottom:1px solid #ccc">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>发布课程</li>
	</ul>
	<div class="clear"></div>
</div>
<div class="mainContent needForm">
		<h1>发布课程</h1>
<style>
	#fm tr{height:35px}
</style>
<form id="fm" method="post" enctype="multipart/form-data">
			<table cellspacing="0" cellpadding="0" width="900px">
				<tr>
					<td width="100px" align="right">标题:</td>
					<td colspan="7"><input
						class="easyui-validatebox" id="courseTitle" name="title"
						data-options="required:true,tipPositionY:'center',tipPositionX:'right',className:'tip-darkgray',missingMessage:'必填项'"
						style="width: 800px;"></td>
				</tr>
				<tr>
					<td width="100px" align="right">关键字:</td>
					<td colspan="7"><input class="easyui-validatebox"
						id="courseKeywords" name="keywords"
						data-options="required:true,tipPositionY:'center',tipPositionX:'right',className:'tip-darkgray',missingMessage:'关键字是必填项'"
						style="width: 800px;"></td>
				</tr>
				<tr>
					<td width="100px" align="right">专题:</td>
					<td colspan="7"><input class="easyui-validatebox"
						id="courseSubject" name="subject"
						data-options="required:true,tipPositionY:'center',tipPositionX:'right',className:'tip-darkgray',missingMessage:'专题是必填项'"
						style="width: 800px;"></td>
				</tr>
				<tr>
					<td width="100px" align="right">类型:</td>
					<td colspan="3" align="left"><input class="easyui-combobox" style="width: 130px;"
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
					<td width="100px" align="right">费用:</td>
					<td colspan="3" align="left"><input class="easyui-validatebox" name="price"
						data-options="required:true,tipPositionY:'center',tipPositionX:'right',className:'tip-darkgray',validType:'num'"
						style="width: 100px;"></td>
				</tr>
				<tr>
					<td width="100px" align="right">对象:</td>
					<td colspan="7"><input name="targets" id="courseTarget"
						class="easyui-combobox"
						data-options="  
							url:'struts/Dictionary_queryComboDics?p_dicType=010',   
							valueField:'codeName',  
							textField:'showName',
							panelHeight:'200',
							multiple:true,
							editable:true"
						style="width: 800px;"></td>
				</tr>
				<!--  <tr>
					<td class="itemText">金牌:</td>
					<td colspan="7"><input name="goldenPic" id="goldenPic" type="file"></td>
				</tr>-->
				<tr>
					<td width="100px" align="right">专业:</td>
					<td colspan="7"><input name="major" id="courseMajor"
						class="easyui-combobox"
						data-options="  
							url:'struts/Dictionary_queryComboDics?p_dicType=009',   
							valueField:'codeName',  
							textField:'showName',
							panelHeight:'200',
							multiple:true,
							editable:true"
						style="width: 800px;"></td>
				</tr>
				<tr>
					<td width="100px" align="right">行业:</td>
					<td colspan="7"><input name="industry" id="courseIndustry"
						class="easyui-combobox"
						data-options="  
							url:'struts/Dictionary_queryComboDics?p_dicType=008',   
							valueField:'codeName',  
							textField:'showName',
							panelHeight:'200',
							multiple:true,
							editable:true "
						style="width: 800px;"></td>
				</tr>
				<tr>
					<td width="100px" align="right">产品:</td>
					<td colspan="7"><input name="product" id="courseProduct"
						class="easyui-combobox"
						data-options="  
							url:'struts/Dictionary_queryComboDics?p_dicType=011',   
							valueField:'codeName',  
							textField:'showName',
							panelHeight:'200',
							multiple:true,
							editable:true "
						style="width: 800px;"></td>
				</tr>
				<tr>
					<td colspan="8" align="left" nowrap>
						<div style="margin-bottom: 5px">
							<a href="#" class="easyui-linkbutton" iconCls="icon-add"
								plain="true" onclick="insertEmptyRow()">新增开课安排</a> <a href="#"
								class="easyui-linkbutton" iconCls="icon-remove" plain="true"
								onclick="removeSelectedRow();">删除开课安排</a>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="8" nowrap>
						<table id="dg_info_in">
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="8">
						<textarea name="content" id="content"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="8"  colspan="4" style="padding-top:30px;padding-bottom:50px" align="right"><a href='#' onclick="javascript:saveCourse(true)" class="normalButton">发布课程</a><a href='javascript:void(0)' onclick="javascript:clearForm()" class="normalButton">清空</a>
				</tr>
			</table>
			
		</form>
</div>

<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>