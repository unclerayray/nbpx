<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = request.getParameter("id");
	Calendar c=Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	int nextYear = year + 1;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看课程</title>
<link type="text/css" href="css/face.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<script src="js/easyui/jquery-1.8.0.min.js"></script>
<script src="js/easyui/jquery.easyui.min.js"></script>
</head>
<body>
<jsp:include page="head.jsp" flush="true"/>
<script>
	$(function(){
		//加载课程信息
		$.ajax({
			url:"struts/ViewClass_ViewClass?id="+<%=id%>,
			success:function(data){
				var jsonObject = eval('('+data+')');
				$('#title').html("<h1>"+jsonObject.title+"</h1>");
				$('#courseId').html("课程编号："+jsonObject.classNum);
				$('#blockContent').html(jsonObject.bloclContent);
				$('#classContent').html(jsonObject.content);
				$('#teacher').html("<span>培训师：</span>"+jsonObject.teacher);
				$('#price').html("<span>课程费用：</span>"+jsonObject.price);
				if(jsonObject.isInner == '0'){
					$('#inAttend').css('display','block');
					$('#outAttend').css('display','none');
				}
				else{
					$('#inAttend').css('display','none');
					$('#outAttend').css('display','block');
				}
				
				//路径
				var path = "<ul><li>当前位置:&nbsp;</li><li><a href='index.jsp'>首页</a></li><li class='bread'>&gt;&gt;</li>";
				if(jsonObject.isInner == '0')
					path += "<li><a href='#'>企业培训</a></li>";
				else
					path += "<li><a href='#'>企业内训</a></li>";
				path += "<li class='bread'>&gt;&gt;</li><li><a href='seeKey.jsp?key="+jsonObject.categoryID+"'>"+jsonObject.categoryName+"</a></li><li class='bread'>&gt;&gt;</li>";
				path += "<li>"+jsonObject.title+"</li></ul><div class='clear'></div>";
				$('#courseName').val(jsonObject.title);
				$('#path').html(path);
				
				//添加时间 地点
				var places = jsonObject.time;
				var placeStr="<span>上课地点：</span>";
				var timeStr = "<span>举办时间：</span>";
			
				$.each(places,function(n,value){
					timeStr += value.from+"至"+value.to;
					placeStr += value.city;
					if(n<places.length-1){
						timeStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
						placeStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
					}
				});
				$('#place').html(placeStr);
				$('#time').html(timeStr);
				
				//添加培训对象
				var object = jsonObject.object;
				var objectStr = "<span>培训对象：</span>";
				for(var i=0;i<object.length;i++){
					objectStr += "<a href='seeKey.jsp?key="+object[i].name+"'>"+object[i].name+"</a>";
					if(i<object.length-1)
						objectStr += ",";
				}
				$('#object').html(objectStr+"<br>");
				
				//添加适用行业
				var indestory = jsonObject.indestory;
				var indestoryStr = "<span>适用行业：</span>";
				for(var i=0;i<indestory.length;i++){
					indestoryStr += "<a href='seeKey.jsp?key="+indestory[i].name+"'>"+indestory[i].name+"</a>";
					if(i<indestory.length-1)
						indestoryStr += ",";
				}
				$('#indestory').html(indestoryStr+"<br>");
				
				//添加适用专业
				var major = jsonObject.major;
				var majorStr = "<span>适用专业：</span>";
				for(var i=0;i<major.length;i++){
					majorStr += "<a href='seeKey.jsp?key="+major[i].name+"'>"+major[i].name+"</a>";
					if(i<major.length-1)
						majorStr += ",";
				}
				$('#major').html(majorStr+"<br>");
				
				//添加关键词
				var queryKeyWords = "";
				var keyWords = jsonObject.keyWords;
				var keyWordsStr = "<span>关键词：</span>";
				for(var i=0;i<keyWords.length;i++){
					keyWordsStr += "<a href='seeKey.jsp?key="+keyWords[i].name+"'>"+keyWords[i].name+"</a>";
					queryKeyWords += keyWords[i].name+'';
					if(i<keyWords.length-1)
						keyWordsStr += ",";
				}
				$('#keyWords').html(keyWordsStr+"<br>");
				loadRelatedKeyWords(queryKeyWords);
				
				//添加专题
				var querySubjects = "";
				var series = jsonObject.series;
				var seriesStr = "<span>专题：</span>";
				for(var i=0;i<series.length;i++){
					seriesStr += "<a href='seeKey.jsp?key="+series[i].name+"'>"+series[i].name+"</a>";
					querySubjects += series[i].name+'';
					if(i<series.length-1)
						seriesStr += ",";
				}
				loadRelatedSubjects(querySubjects);
				$('#series').html(seriesStr+"<br>");

				
			}
		});
		
		//加载热门课程
		getHotCourse();
		//加载热门下载信息
		getHotDownLoads();
		//加载讲师信息
		getTeacher();
		//加载客户
		loadCustomer();
	});
	function getHotCourse(){
		$.ajax({
			url:encodeURI("struts/Main_getHotCourseWithNoTime?rows=5"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr += "<li><a class='left tooLong w230' href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></li>";
				});
				$('#hotCourse').html(valueStr);
			}
		});
	}
	//加载典型客户
	function loadCustomer(){
		$.ajax({
				url: 'struts/ViewDic_getMoreDicItems?codeName=005&rows=7&page=1',
				success:function(data){
					//alert(data);
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject.rows,function(n,value){
						valueStr += "<dd><a class='left tooLong w230' href=\"seeKey.jsp?key="+value.showName+"\">"+value.showName+"</a></dd>";
					});
		
					if(valueStr == "")
						valueStr ="<div class='notice'>暂时没有客户信息</div>";

					$('#customer').html(valueStr);
				}
		});
	}
	//获取讲师信息
	function getTeacher(){
		$.ajax({
			url:"struts/Main_getTeachers?page=1&rows=6&flag=1",
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href='teacherClass.jsp?type=1&id="+value.teacherId+"'>"+value.realName+"</a></li>";
				});
				if(valueStr == "")
					valueStr ="<div class='notice'>暂时没有讲师信息</div>";
				$('#teacherPart').html(valueStr);
			}
		});
	}
	//加载热门下载
	function getHotDownLoads(){
		$.ajax({
			url:encodeURI("struts/Main_getDownLoads?flag="+2),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					if(n<5)
						valueStr +="<li  style='width:200px;text-align:left;'><a class='left' href='struts/Download_downLoadFile?downloadId="+value.downloadId+"'><span class='text tooLong left' style='width:200px;display:block'>"+value.title+"</span></a><div class='clear'></div></li>";

				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>没有下载记录</div>";
				}
				$('#hotDownloads').html(valueStr);
			}
		})
	}
	
	function loadRelatedKeyWords(condition){
		$.ajax({
			url:encodeURI('struts/ViewClass_getRelatedKeyWords?condition='+condition),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr +="<li><a href='seeKey.jsp?key="+value.keyword+"'>"+value.keyword+"</a></li>";
				});
				$('#relatedKeywords').html(valueStr);
			}
		})
	}
	
	function loadRelatedSubjects(condition){
		$.ajax({
			url:encodeURI('struts/ViewClass_getRelatedSubjects?condition='+condition),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href='#'>"+value.subject+"</a></li>";
				});
				$('#relatedSubjects').html(valueStr);
			}
		})
	}
	function submitNeed(){
		$('#needForm').form('submit',{  
			url: encodeURI('struts/CourseApply_addApply'),  
			onSubmit: function(){  
					if($('#contact').val() == ''){
						alert('联系人不能为空!');
						return false;
					}
					if($('#telephone').val() == ''){
						alert('固定电话不能为空!');
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
<!--当前路径 start-->
<div class="mainContent path" id="path">
	<div class="clear"></div>
</div>
<!--当前路径 end-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px;">
	
	<!--左边部分课程信息 start-->
	<div class="leftInPart">
		<div class="classDetail" >
			<div ><span id="title"></span>
			<div class="classNum" id="courseId">课程编号：12345</div></div>
			<div class="detail">
			<div class="classLeftPart" id="courseInfo">
			<div class="time" id="time"><span>举办时间：</span><a href="#">2013-5-10 至 2013-5-15</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">2013-6-10 至 2013-6-19</a></div>
			<div class="time" id="place"><span>上课地点：</span><a href="#">广州</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">北京</a></div>
			<div class="time" id="price"><span>课程费用：</span>2800元/位; 7980元/3位; 13300元/5位;(包含上课所有中午餐,茶水和培训教材)</div>
			<div class="time" id="teacher"><span>培训师：</span>李老师</div>
			<div class="time" id="object"><span>培训对象：</span><a href="#">总经理</a>、<a href="#">CEO</a>、<a href="#">高级管理人员</a></div>
			<div class="time" id="indestory"><span>适用行业：</span><a href="#">电力行业</a>、<a href="#">生产行业</a></div>
			<div class="time" id="major"><span>适用专业：</span><a href="#">工商管理</a>、<a href="#">行政管理</a>、<a href="#">人力资源</a></div>
			<div class="time" id="keyWords"><span>关键词：</span><a href="#">管理</a>、<a href="#">团队建设</a></div>
			<div class="time" id="series"><span>专题：</span><a href="#">企业管理</a></div>
			</div>
			<div class="classRightPart">
				<!--<dd><a href="#">打印课程提纲</a></dd>
				<dd><a href="#">打印报名表格</a></dd>
				<dd><a href="#">先加入收藏夹</a></dd>
				<dd><a href="#">引入内训申请</a></dd>
				<dd><a href="#">先发送至邮箱</a></dd>
				<dd><a href="#">保存电脑桌面</a></dd>
				<dd><a href="#">下载课程提纲</a></dd>  -->
				</div>
			<div class="clear"></div>
			</div>
			<div class="clear"></div>
			<div id="courseContent">
			<!-- 
				<div class="intro">推荐理由</div>
					<p id="blockContent"></p> -->
				<div class="intro">课程内容</div>
					<p id="classContent"></p>
			</div>
	</div>
	<div class="clear"></div>
	<!--报名表 start-->
	<div class="attend" id="inAttend">
		<h2>报名/咨询</h2>
		<div style="height:15px; display:block" class="clear"></div>
		<div ><h3>企业培训:</h3><span>020-61908283</span><span>020-39948135</span></div>
		<div class="clear"></div>
	</div>
	
	<div class="attendTable" id="outAttend">
		<Form id="needForm">
		<input type="hidden" id="courseName" >
		<table cellspacing="0" cellpadding="0" class="need" align="center" style="font-size:12px">
			<thead><h2>报名/咨询表</h2></thead>
			<tr>
			<td>单位名称:&nbsp;<input id="compName" name="compName"/></td>
			<td>&nbsp;&nbsp;联系人:&nbsp;<input id="contact" name="contact"/><em style="color:red">*</em></td>
		</tr>
		<tr>
			<td>联系电话:&nbsp;<input id="telephone" name="telephone"/><em style="color:red">*</em></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;传真:&nbsp;<input id="fax" name="fax"/></td>
		</tr>
		<tr>
			<td>移动电话:&nbsp;<input id="celphone" name="celphone"/></td>
			<td>电子邮箱:&nbsp;<input id="email" name="email"/></td>
		</tr>
		<tr>
			<td>任职部门:&nbsp;<input id="departName" name="departName"/></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MSN:&nbsp;<input id="msn" name="msn"/></td>
		</tr>
		<tr>
			<td>企业类型:&nbsp;<input id="compType" name="compType"/></td>
			<td>业务范围:&nbsp;<input id="comRange" name="comRange"/></td>
		</tr>
		<tr>
			<td>开始时间:&nbsp;<input class="easyui-datebox" id="starttime" name="starttime"></td>
			<td>结束时间:&nbsp;<input class="easyui-datebox" id="endtime" name="endtime"></td>
		</tr>
		<tr>
			<td>财务预算:&nbsp;<input id="budget" name="budget"/></td>
			<td>教学语种:&nbsp;<input id="languaue" name="languaue"/></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:18px;">参训对象简单描述:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><textarea id="studentDesc" name="studentDesc"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">学员基础简单说明:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><textarea id="basicDesc" name="basicDesc"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">企业简介:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><textarea id="compDesc" name="compDesc"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">具体那个环节出问题:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><textarea id="questionDesc" name="questionDesc"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">培训内容说明:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><textarea id="contentDesc" name="contentDesc"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:23px;">预期目标:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><textarea id="targetDesc" name="targetDesc"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="top" ><input type="radio" name='state' id="r1" value="1" checked style="border:0px;width:60px"/><label  for="r1">确认报名</label>&nbsp;<input style="border:0px;width:60px" type="radio" value="2" name='state' id="r2"/><label for="r2">正在申请中</label></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:12px;">备注:</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><textarea id="notice" name="notice"></textarea></td>
		</tr>
		<tr >
			<td colspan="2" align="center" style='padding-top:30px;padding-bottom:30px'><a href='javascript:void(0)' onclick="javascript:submitNeed()" class="normalButton">确定报名</a><a href='javascript:void(0)' onclick="javascript:clearForm()" class="normalButton">重新填写</a></td>
		</tr>
		</table></form>
	</div>
	<!--报名表 end-->
	</div>
	<!--左边部分课程信息 end-->
	
	<!--右边部分信息 start-->
	<div class="rightInPart">
			<div class="rightTeacher">
				<h5  class="first">相关关键词</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;"/>
					<div class="clear" style="height:10px;"></div>
				<ul class="list8" id="relatedKeywords"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
				<h5 >相关专题</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;"/>
					<div class="clear" style="height:10px;"></div>
				<ul class="list8" id="relatedSubjects"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
			</div>
	<!--月份 start-->
		<div style="display:block;height:10px"></div>
		<div class="head"><%=year %>年企业培训计划</div>
		<div class="bg p5 h40">
			<ul class="list2">
				<li><a href="trainPlan.jsp?year=<%=year %>&month=1">01月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=2">02月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=3">03月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=4">04月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=5">05月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=6">06月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=7">07月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=8">08月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=9">09月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=10">10月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=11">11月</a></li>
				<li><a href="trainPlan.jsp?year=<%=year %>&month=12">12月</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<!--月份 end-->
		
		<!--内训 start-->
		<div class="head"><%=nextYear %>年企业培训计划</div>
		<div class="bg p5 h40" >
				<ul class="list2">
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=1">01月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=2">02月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=3">03月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=4">04月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=5">05月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=6">06月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=7">07月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=8">08月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=9">09月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=10">10月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=11">11月</a></li>
					<li><a href="trainPlan.jsp?year=<%=nextYear %>&month=12">12月</a></li>
				</ul>
			<div class="clear"></div>
		</div>
		<!--内训 end-->
		<!--地点 start-->
		<div class="head">开课地点</div>
		<div class="bg h45" style="border-bottom:1px solid #ebebeb">
			<ul class="list2 city">
				<li><a href="seePlace.jsp?city=北京">北京</a></li>
				<li><a href="seePlace.jsp?city=上海">上海</a></li>
				<li><a href="seePlace.jsp?city=深圳">深圳</a></li>
				<li><a href="seePlace.jsp?city=广州">广州</a></li>
				<li><a href="seePlace.jsp?city=杭州">杭州</a></li>
				<li><a href="seePlace.jsp?city=东莞">东莞</a></li>
				<li><a href="seePlace.jsp?city=苏州">苏州</a></li>
				<li><a href="seePlace.jsp?city=全国">全国</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<!--地点 end-->
		<!--热门培训 培训计划 培训下载 start-->
		<div style="height:10px; display:block"></div>
		<!--  <div class="sortList">
			<div class="head">
						<div class="tabOn half">热门培训</div>
						<div class="tabOff half">热门排行</div>
						<div class="clear"></div>
					</div>
					<div class="bg h315" style="padding:0px 15px 4px 15px;">
						<ul class="list7" style="padding-top:10px">
							<li class="line"><a><span class="red">1</span>企业资本运作与投融资顾问</a></li>
							<li  class="line"><a><span class="red">2</span>企业资本运作与投融资顾问</a></li>
							<li class="line"><a><span class="blue">3</span>企业资本运作与投融资顾问</a></li>
							<li class="line"><a><span class="blue">4</span>企业资本运作与投融资顾问</a></li>
							<li class="line"><a><span class="blue">5</span>企业资本运作与投融资顾问</a></li>
						</ul>
						<div class="clear"></div>
					</div>
		</div>-->
		<!--培训计划 培训下载 end-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
			<!-- <h5  class="first">培训计划</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9">
					<li><a>2013年4月培训计划</a></li>
					<li><a>2013年5月培训计划</a></li>
					<li><a>2013年6月培训计划</a></li>
					<li><a>2013年7月培训计划</a></li>
					<li><a>2013年8月培训计划</a></li>
				</ul>
				<div class="clear"></div>
			</div> -->
			<h5  class="first">热门培训</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9" id="hotCourse">
					<!--  <li><a>2013年4月培训计划</a></li>
					<li><a>2013年5月培训计划</a></li>
					<li><a>2013年6月培训计划</a></li>
					<li><a>2013年7月培训计划</a></li>
					<li><a>2013年8月培训计划</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5 >培训下载</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto;">
				<ul class="list9" id="hotDownloads">
					<!-- <li><a>经典资料：行政管理怎样做...</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>培训老师</h5>
			<div class="bg" style="padding:10px 0px 10px 12px;border:none;height:auto;">
				<ul class="teacher" id="teacherPart">
					<!--<li><a href="#">刘强</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			
			<h5>典型客户</h5>
			<dl class="bestCustomer leftPart left" style="width:200px;" id="customer">
				<!-- <dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
				<dd><a href="#">阿里巴巴</a></dd>
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd> -->
			</dl>
			<div class="clear"></div>
		</div>
		
	</div>
	<!--右边部分信息 end-->
	
</div>

<div class="clear"></div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>