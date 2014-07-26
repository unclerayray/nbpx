<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link type="text/css" href="css/face.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<script src="js/easyui/jquery-1.8.0.min.js"></script>
<script src="js/easyui/jquery.easyui.min.js"></script>
<script src="js/project.js"></script>
<script src="js/myjs/index.js"></script>
<title>南北培训网</title>
</head>
<script>
	$(function(){
		//加载培训计划
		initMonth(1);
		//加载培训计划相关关键词
		loadPlanKeyWords();
		//加载培训计划相关专题
		loadPlanSubjects();
	});

	function initMonth(page){
		$.ajax({
			url:encodeURI('struts/TrainPlan_getTrainPlanInfo?page='+page+'&rows=4'),
			success:function(data){
				var jsonObject = eval('('+data+')');
				//var pageCount = jsonObject.pageCount;
				var monthInfo = jsonObject.monthInfo;
				
				var valueStr = "";
				$.each(monthInfo,function(n,value){
					var className ="resultPart padding10";
					if(n == 0)
						className ="resultPart";
					var monthValueStr = "<div class='"+className+"'><h2>"+value.month+"培训计划</h2>"+
										"<div class='resultContent'>"+
										"<table class='planTable' cellpadding='0' cellpadding='0'>";
					var tableRows = value.rows;
					monthValueStr += "<tr><th class='className'>课程主题</th><th class='place'>地点</th><th class='planTeacher'>讲师</th><th class='price'>￥元/人</th><th class='download'>相关下载</th></tr>";
					//遍历下面的行
					$.each(tableRows,function(n,row){
						monthValueStr+= "<tr>"
										+"<td class='className'><a href='viewClass.jsp?id="+row.id+"'>"+row.name+"</a></td>"
										+"<td>"+row.city+"</td>"
										+"<td>"+row.teacherName+"</td>"
										+"<td>"+row.price+"</td>"
										+"<td><a href='struts/TrainPlan_exportKegang?courseId="+row.id+"'>课纲下载</a></td>"
									    +"</tr>";
					});
					valueStr += monthValueStr +"</table><div class='clear' style='height:10px;'></div></div></div>";
				});
				
				$('#leftPart').html(valueStr);
			}
		});
	}
	
	function loadPlanKeyWords(){
		$.ajax({
			url:"struts/TrainPlan_getPlanRelatedKeyWords",
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
	
	function loadPlanSubjects(){
		$.ajax({
			url:"struts/TrainPlan_getPlanRelatedSubjects",
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr1 = "";
				var valueStr2 = "";
				$.each(jsonObject.rows,function(n,value){
					var subject = value.subject;
					if(subject.length > 5)
						subject = subject.substring(0,5)+"...";
					if(n<=9)
						valueStr1 +="<dd><a href='seeKey.jsp?key="+subject+"'>"+subject+"</a></dd>";
					else
						valueStr2 +="<dd><a href='seeKey.jsp?key="+subject+"'>"+subject+"</a></dd>";
				});
				$('#relatedSubjects1').html(valueStr1);
				$('#relatedSubjects2').html(valueStr2);
			}
		})
	}
	
	function exportExcel(){
		var urlStr = 'struts/TrainPlan_exportCoursePlan?isInner='+$('#search_inner').val()+'&month='+$('#search_month').val()+'&year='+$('#search_year').val()+'&cate='+$('#search_category').val() + '&city='+$('#search_city').val();
		window.location=urlStr;
	}
</script>
<body>
<jsp:include page="head.jsp" flush="true"/>
<!--当前路径 start-->
<div class="mainContent path">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>培训计划</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart" >
		<style>
			.searchType{float:left;text-align:right;padding-right:2px;font-size:14px;font-weight:bold;color:#2D4545}
			.searchOption{float:left;width:590px;font-size:14px}
			.searchOption ul{list-style:none;}
			.searchOption li{float:left;font-size:12px;padding-right:2px;padding-left:2px;}
			.searchOption li a{color:#333;text-decoration:none;font-size:12px;}
			.searchOption li a.on{background:#2D4545;color:white;font-weight:bold;padding:2px;font-size:12px}
			.searchOption li a.off{color:#333;text-decoration:none;font-size:12px;}
		</style>
		<!--消费者相关专题 start-->
		<div class="resultPart"  style="width:700px;float:left">
			<h2>按条件检索</h2>
		 	<div class="resultContent" style="padding-left:20px;height:150px;">
				<div style='padding-top:10px'>
					<input type="hidden" value="false" id="search_inner" NAME="search_inner">
					<div class='searchType'>按类型:</div>
					<div id="inner_option" class='searchOption'>
						<ul>
						<li id="inner_option_tab0" onclick="changePlanTabs('inner_option',this);document.getElementById('search_year').value='false';"><a  href='javascript:void(0)' id="inner_option_tab0_a"  class="on">培训课程</a></li>
						<li id="inner_option_tab1" onclick="changePlanTabs('inner_option',this);document.getElementById('search_year').value='true';"><a  href='javascript:void(0)' id="inner_option_tab1_a" >内训课程</a></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
				<div style='padding-top:10px'>
					<input type="hidden" value="2014" id="search_year" NAME="search_year">
					<div class='searchType'>按年度:</div>
					<div id="year_option" class='searchOption'>
						<ul>
						<li id="year_option_tab0" onclick="changePlanTabs('year_option',this);document.getElementById('search_year').value='2014';"><a  href='javascript:void(0)' id="year_option_tab0_a" class="on">2014</a></li>
						<li id="year_option_tab1" onclick="changePlanTabs('year_option',this);document.getElementById('search_year').value='2015';"><a  href='javascript:void(0)' id="year_option_tab1_a" >2015</a></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
				<div style='padding-top:10px'>
					<input type="hidden" value="13" id="search_month" NAME="search_month">
					<div class='searchType'>按月份:</div>
					<div id="month_option" class='searchOption'>
						<ul>
						<li id="month_option_tab0" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='13';"><a id="month_option_tab0_a" href='javascript:void(0)' class="on">全部</a></li>
						<li id="month_option_tab1" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='01';"><a id="month_option_tab1_a" href='javascript:void(0)'>1月</a></li>
						<li id="month_option_tab2" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='02';"><a id="month_option_tab2_a" href='javascript:void(0)'>2月</a></li>
						<li id="month_option_tab3" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='03';"><a id="month_option_tab3_a" href='javascript:void(0)'>3月</a></li>
						<li id="month_option_tab4" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='04';"><a id="month_option_tab4_a" href='javascript:void(0)'>4月</a></li>
						<li id="month_option_tab5" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='05';"><a id="month_option_tab5_a" href='javascript:void(0)'>5月</a></li>
						<li id="month_option_tab6" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='06';"><a id="month_option_tab6_a" href='javascript:void(0)'>6月</a></li>
						<li id="month_option_tab7" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='07';"><a id="month_option_tab7_a" href='javascript:void(0)'>7月</a></li>
						<li id="month_option_tab8" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='08';"><a id="month_option_tab8_a" href='javascript:void(0)'>8月</a></li>
						<li id="month_option_tab9" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='09';"><a id="month_option_tab9_a" href='javascript:void(0)'>9月</a></li>
						<li id="month_option_tab10" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='10';"><a id="month_option_tab10_a" href='javascript:void(0)'>10月</a></li>
						<li id="month_option_tab11" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='11';"><a id="month_option_tab11_a" href='javascript:void(0)'>11月</a></li>
						<li id="month_option_tab12" onclick="changePlanTabs('month_option',this);document.getElementById('search_month').value='12';"><a id="month_option_tab12_a" href='javascript:void(0)'>12月</a></li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
				<div style='padding-top:10px'>
					<input type="hidden" value="003" id="search_category" NAME="search_category">
					<div class='searchType'>按类别:</div>
					<div id="category_option" class='searchOption'>
						<ul>
							<li id="category_option_tab0" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003';"><a id="category_option_tab0_a" href='javascript:void(0)' class="on">全部</a></li>
							<li id="category_option_tab1" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003_01';"><a id="category_option_tab1_a" href='javascript:void(0)'>财务管理</a></li>
							<li id="category_option_tab2" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003_02';"><a id="category_option_tab2_a" href='javascript:void(0)'>采购供应</a></li>
							<li id="category_option_tab3" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003_03';"><a id="category_option_tab3_a" href='javascript:void(0)'>人力资源</a></li>
							<li id="category_option_tab4" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003_04';"><a id="category_option_tab4_a" href='javascript:void(0)'>生产管理</a></li>
							<li id="category_option_tab5" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003_05';"><a id="category_option_tab5_a" href='javascript:void(0)'>市场营销</a></li>
							<li id="category_option_tab6" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003_06';"><a id="category_option_tab6_a" href='javascript:void(0)'>综合战略</a></li>
							<li id="category_option_tab7" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003_07';"><a id="category_option_tab7_a" href='javascript:void(0)'>项目管理</a></li>
							<li id="category_option_tab8" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003_08';"><a id="category_option_tab8_a" href='javascript:void(0)'>职业技能</a></li>
							<li id="category_option_tab9" onclick="changePlanTabs('category_option',this);document.getElementById('search_category').value='003_9';"><a id="category_option_tab9_a" href='javascript:void(0)'>研修班</a></li>
						</ul>
					</div>
				</div>			
				<div class="clear"></div>
				<div style='padding-top:10px'>
					<input type="hidden" value="007" id="search_city" NAME="search_city">
					<div class='searchType'>按城市:</div>
					<div id='city_option' class='searchOption'>
						<ul>
						<li id="city_option_tab0" onclick="changePlanTabs('city_option',this);document.getElementById('search_city').value='007';"><a id="city_option_tab0_a" href='javascript:void(0)' class="on">全部</a></li>
						<li id="city_option_tab1" onclick="changePlanTabs('city_option',this);document.getElementById('search_city').value='007_215';"><a id="city_option_tab1_a" href='javascript:void(0)'>广州</a></li>
						<li id="city_option_tab2" onclick="changePlanTabs('city_option',this);document.getElementById('search_city').value='007_3';"><a id="city_option_tab2_a" href='javascript:void(0)'>北京</a></li>
						<li id="city_option_tab3" onclick="changePlanTabs('city_option',this);document.getElementById('search_city').value='007_27';"><a id="city_option_tab3_a" href='javascript:void(0)'>苏州</a></li>
						<li id="city_option_tab4" onclick="changePlanTabs('city_option',this);document.getElementById('search_city').value='007_216';"><a id="city_option_tab4_a" href='javascript:void(0)'>深圳</a></li>
						<li id="city_option_tab5" onclick="changePlanTabs('city_option',this);document.getElementById('search_city').value='007_4';"><a id="city_option_tab5_a" href='javascript:void(0)'>上海</a></li>
						<li id="city_option_tab6" onclick="changePlanTabs('city_option',this);document.getElementById('search_city').value='007_212';"><a id="city_option_tab6_a" href='javascript:void(0)'>东莞</a></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- 测试函数 -->
			<button onclick="exportExcel()" href='javascript:void(0)'>导出培训计划</button>
			<div class="clear"></div>
		</div>
		<div class="clear" style="height:10px"></div>
		
		<!--消费者相关专题 end-->
		<div id="leftPart">
		<!--培训计划 start-->
		<div class="resultPart">
			<h2>2013年5月培训计划</h2>
			<div class="resultContent">
					<table class="planTable" cellpadding="0" cellpadding="0">
						<tr>
							<th class="className">课程主题</th>
							<th class="place">地点</th>
							<th class="planTeacher">讲师</th>
							<th class="price">￥元/人</th>
							<th class="download">相关下载</th>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
							<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
					</table>
					<div class="clear" style="height:10px;"></div>
			</div>
		</div>
		<!--培训计划 end-->
		
		<!--培训计划 start-->
		<div class="resultPart padding10">
			<h2>2013年6月培训计划</h2>
			<div class="resultContent">
					<table class="planTable" cellpadding="0" cellpadding="0">
						<tr>
							<th class="className">课程主题</th>
							<th class="place">地点</th>
							<th class="planTeacher">讲师</th>
							<th class="price">￥元/人</th>
							<th class="download">相关下载</th>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
							<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
					</table>
					<div class="clear" style="height:10px;"></div>
			</div>
		</div>
		<!--培训计划 end-->
		
		<!--培训计划 start-->
		<div class="resultPart padding10">
			<h2>2013年7月培训计划</h2>
			<div class="resultContent">
					<table class="planTable" cellpadding="0" cellpadding="0">
						<tr>
							<th class="className">课程主题</th>
							<th class="place">地点</th>
							<th class="planTeacher">讲师</th>
							<th class="price">￥元/人</th>
							<th class="download">相关下载</th>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
							<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
					</table>
					<div class="clear" style="height:10px;"></div>
			</div>
		</div>
		<!--培训计划 end-->
		<!--培训计划 start-->
		<div class="resultPart padding10">
			<h2>2013年8月培训计划</h2>
			<div class="resultContent">
					<table class="planTable" cellpadding="0" cellpadding="0">
						<tr>
							<th class="className">课程主题</th>
							<th class="place">地点</th>
							<th class="planTeacher">讲师</th>
							<th class="price">￥元/人</th>
							<th class="download">相关下载</th>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
							<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
						<tr>
							<td class="className"><a href="#">企业研发中的知识产权管理和专利挖掘</a></td>
							<td >北京</td>
							<td>杨静安</td>
							<td>2800</td>
							<td><a href="#">课纲下载</a></td>
						</tr>
					</table>
					<div class="clear" style="height:10px;"></div>
			</div>
		</div>
		<!--培训计划 end-->
		<div class="resultFoot padding10">
			<a href="#">下一页</a>
			<a href="#">最后一页</a>
			共有56页,当前第1页(共200条记录),快速跳到第<input  type="text" value="1"/>页
		</div>
		</div>
	</div>
	<!--右边部分 start-->
	<div class="rightInPart">
		<!--培训关键词 start-->	
		<div class="rightTeacher">
				<h5  class="first">培训计划相关关键字</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:280px"/>
				<div class="clear" style="height:10px;"></div>
					<ul class="list8" id="relatedKeywords">
						<li><a href="#">EMBA</a></li>
						<li><a href="#">KPI</a></li>
						<li><a href="#">财务管理</a></li>
						<li><a href="#">差异化</a></li>
						<li><a href="#">产品研发</a></li>
						<li><a href="#">产品质量</a></li>
						<li><a href="#">成本控制</a></li>
						<li><a href="#">消费者</a></li>
						<li><a href="#">领导力</a></li>
						<li><a href="#">品牌定位</a></li>
						<li><a href="#">企业文化</a></li>
						<li><a href="#">渠道</a></li>
						<li><a href="#">产品定位</a></li>
						<li><a href="#">服务</a></li>
						<li><a href="#">竞争优势</a></li>
						<li><a href="#">营销</a></li>
						<li><a href="#">影响力</a></li>
						<li><a href="#">招商</a></li>
						<li><a href="#">EMBA</a></li>
						<li><a href="#">KPI</a></li>
						<li><a href="#">财务管理</a></li>
						<li><a href="#">差异化</a></li>
						<li><a href="#">产品研发</a></li>
						<li><a href="#">产品质量</a></li>
						<li><a href="#">成本控制</a></li>
						<li><a href="#">消费者</a></li>
						<li><a href="#">领导力</a></li>
						<li><a href="#">品牌定位</a></li>
						<li><a href="#">企业文化</a></li>
						<li><a href="#">渠道</a></li>
						<li><a href="#">产品定位</a></li>
						<li><a href="#">服务</a></li>
						<li><a href="#">竞争优势</a></li>
						<li><a href="#">营销</a></li>
						<li><a href="#">影响力</a></li>
					</ul>
				</div>
			</div>
		<!--内训关键词 end-->	
		
		<!--培训关键词 start-->	
		<div class="clear" style="height:10px"></div>
		<div class="rightTeacher">
				<h5  class="first">培训计划相关专题</h5>
				<div class="bg" style="padding:0px 0px 4px 0px;border:none;height:280px"/>
					<div class="clear" style="height:0px"></div>
					<dl class="bestCustomer leftPart left" style="width:110px;" id="relatedSubjects1">
						<dd><a href="#">消费者培训</a></dd>
						<dd><a href="#">消费者市场</a></dd>
						<dd><a href="#">消费者行为</a></dd>
						<dd><a href="#">大众消费</a></dd>
						<dd><a href="#">消费市场</a></dd>
						<dd><a href="#">投诉处理流程</a></dd>
						<dd><a href="#">团队培训</a></dd>
						<dd><a href="#">客户服务</a></dd>
						<dd><a href="#">投诉处理流程</a></dd>
						<dd><a href="#">客户服务</a></dd>
						<dd><a href="#">投诉处理流程</a></dd>
					</dl>
					<dl class="bestCustomer rightPart right" style="width:130px;" id="relatedSubjects2">
						<dd><a href="#">绩效考核</a></dd>
						<dd><a href="#">新社会保险法</a></dd>
						<dd><a href="#">员工关系管理</a></dd>
						<dd><a href="#">风险管理</a></dd>
						<dd><a href="#">目标管理</a></dd>
						<dd><a href="#">商务考察</a></dd>
						<dd><a href="#">经理人培训</a></dd>
						<dd><a href="#">绩效考核</a></dd>
						<dd><a href="#">新社会保险法</a></dd>
						<dd><a href="#">绩效考核</a></dd>
						<dd><a href="#">新社会保险法</a></dd>
					</dl>
				</div>
			</div>
		<!--内训关键词 end-->	
		
    </div>
	<!--右边部分 end-->
	<div class="clear">
	
	
	</div>
</div>
<!--主体部分二 end-->
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>