<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String year = request.getParameter("year");
	String month = request.getParameter("month");
%>
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
<script src="js/part14.js"></script>
<script src="js/myjs/index.js"></script>
<title>南北培训网-培训计划</title>
</head>
<script>
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0
	var yyyy = today.getFullYear();
	var yearParam = yyyy;
	$(function(){
		//加载培训计划
		if(<%= year%>!=null&&<%= month%>!=null){
			yearParam = <%= year%>;
			mm = <%= month%>;
			searchPlans(1);
		}else{
			searchPlans(1);
		}
		//加载培训计划相关关键词
		loadPlanKeyWords();
		//加载培训计划相关专题
		loadPlanSubjects();
		//01.加载相关关键词
		loadRelatedKeyWords("培训计划");
		//02.加载相关专题
		loadRelatedSubjects("培训计划");
		//03.加载热门课程
		getHotCourse();
		//04.加载内训课程
		getNXCourse();
		//05.加载内训视频
		getVedioCourse();
		//06.加载相关讲师
		getTeacher();
		//07.加载相关文章
		loadHotArticle();
		//08.加载相关问答
		loadQuestion();
		//09.加载培训下载
		getHotDownLoads();
		//10.相关培训机构
		loadPXOrg();
		//11.相关客户群
		loadCustomer();
		//12.相关评价
		loadComments();
		//13.相关培训计划、内训计划
		seePartTab('plan',1,1);
		//14.相关培训现场、内训现场
		seePartTab('place',1,1);
	});
	//01.加载相关关键词
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
	//02.加载相关专题
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
	function searchPlans(init){
		$('#search_year').val(yyyy);
		$('#this_year').html(yyyy);
		$('#next_year').html(yyyy+1);
		$('#search_month').val(mm);
		changePlanTabs('month_option', document.getElementById("month_option_tab"+mm));
		changePlanTabs('year_option', document.getElementById("year_option_tab"+(yearParam - yyyy)));
		var month = mm;
		var url = 'struts/TrainPlan_getTrainPlanInfo?year='+$('#search_year').val()+'&isInner=false'+'&month='+$('#search_month').val();
		if(!init){
			url = 'struts/TrainPlan_getTrainPlanInfo?isInner='+$('#search_inner').val()+'&month='+$('#search_month').val()+'&year='+$('#search_year').val()+'&cate='+$('#search_category').val() + '&city='+$('#search_city').val();
			month = $('#search_month').val();
			alert('sdfsdf');
		}
		$.ajax({
			url:encodeURI(url),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var monthValueStr = "<div class='resultPart padding10'><h2>"+$('#search_year').val()+"年"+month+"月培训计划</h2>"+
				"<div class='resultContent'>"+
				"<table class='planTable' cellpadding='0' cellpadding='0'>";
				monthValueStr += "<tr><th class='time'>课程时间</th><th class='className'>课程主题</th><th class='category'>类别</th><th class='month'>月份</th><th class='place'>地点</th><th class='planTeacher'>讲师</th><th class='price'>￥元/人</th><th class='download'>相关下载</th></tr>";
				$.each(jsonObject,function(n,row){
					monthValueStr+= "<tr>"
						+"<td>"+row.startDate + "至" + row.endDate +"</td>"
						+"<td class='className'><a href='viewClass.jsp?id="+row.courseId+"'>"+row.title+"</a></td>"
						+"<td>"+row.category+"</td>"
						+"<td>"+row.month+"</td>"
						+"<td>"+row.city+"</td>"
						+"<td>"+row.teacher+"</td>"
						+"<td>"+row.price+"</td>"
						+"<td><a href='struts/TrainPlan_exportKegang?courseId="+row.courseId+"'>课纲下载</a></td>"
					    +"</tr>";
				});
				valueStr += monthValueStr +"</table><div class='clear' style='height:10px;'></div></div></div>";
				
				$('#leftPart').html(valueStr);
			}
		});
	}
	
	function set_search_year(add){
		$('#search_year').val(yyyy+add);
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
		});
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
		});
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
			.planSearchType{float:left;text-align:right;padding-right:2px;font-size:14px;font-weight:bold;color:#2D4545}
			.planSearchOption{float:left;width:590px;font-size:14px}
			.planSearchOption ul{list-style:none;}
			.planSearchOption li{float:left;font-size:12px;padding-right:2px;padding-left:2px;}
			.planSearchOption li a{color:#333;text-decoration:none;font-size:12px;}
			.planSearchOption li a.on{background:#2D4545;color:white;font-weight:bold;padding:2px;font-size:12px}
			.planSearchOption li a.off{color:#333;text-decoration:none;font-size:12px;}
		</style>
		<!--消费者相关专题 start-->
		<div class="resultPart"  style="width:700px;float:left">
			<h2>按条件检索</h2>
		 	<div class="resultContent" style="padding-left:20px;height:150px;">
				<input type="hidden" value="false" id="search_inner" NAME="search_inner">
				<div class="clear"></div>
				<div style='padding-top:10px'>
					<input type="hidden" value="2014" id="search_year" NAME="search_year">
					<div class='planSearchType'>按年度:</div>
					<div id="year_option" class='planSearchOption'>
						<ul>
						<li id="year_option_tab0" onclick="changePlanTabs('year_option',this);set_search_year(0);">
						<a  href='javascript:void(0)' id="year_option_tab0_a" class="on"><label id="this_year"></label></a>
						</li>
						<li id="year_option_tab1" onclick="changePlanTabs('year_option',this);set_search_year(1);">
						<a  href='javascript:void(0)' id="year_option_tab1_a" ><label id="next_year"></label></a>
						</li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
				<div style='padding-top:10px'>
					<input type="hidden" value="13" id="search_month" NAME="search_month">
					<div class='planSearchType'>按月份:</div>
					<div id="month_option" class='planSearchOption'>
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
					<div class='planSearchType'>按类别:</div>
					<div id="category_option" class='planSearchOption'>
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
					<div class='planSearchType'>按城市:</div>
					<div id='city_option' class='planSearchOption'>
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
			<button onclick="searchPlans(null)" href='javascript:void(0)'>查询培训计划</button>
			<button onclick="exportExcel()" href='javascript:void(0)'>导出培训计划</button>
			<div class="clear"></div>
		</div>
		<div class="clear" style="height:10px"></div>
		
		<!--消费者相关专题 end-->
		<div id="leftPart">
		<!--培训计划 start-->
		<div class="resultPart">
			<h2 id="result_header">培训计划</h2>
			<div class="resultContent">
					<table class="planTable" cellpadding="0" cellpadding="0">
						<tr>
							<th class="time">课程时间</th>
							<th class="className">课程主题</th>
							<th class="category">类别</th>
							<th class="month">月份</th>
							<th class="place">地点</th>
							<th class="planTeacher">讲师</th>
							<th class="price">￥元/人</th>
							<th class="download">相关下载</th>
						</tr>
					</table>
					<div class="clear" style="height:10px;"></div>
			</div>
		</div>
		<!--培训计划 end-->
		</div>
	</div>
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
	
		<!--内训 end-->
		<!--地点 start-->
		<!-- <div class="head">开课地点</div>
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
		</div> -->
		<!--地点 end-->
		<!--热门培训 培训计划 培训下载 start-->
		
		<!--培训计划 培训下载 end-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
			<h5  class="first">相关培训课程</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9" id="hotCourse">
					<!--  <li><a>2013年4月培训计划</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5  class="first">相关内训课程</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9" id="NXCourse">
					<!--  <li><a>2013年4月培训计划</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关内训视频</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9" id="NXVideo">
					<!--  <li><a>2013年4月培训计划</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关讲师</h5>
			<div class="bg" style="padding:10px 0px 10px 12px;border:none;height:auto;">
				<ul class="teacher" id="teacherPart">
					<!--<li><a href="#">刘强</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关文章</h5>
			<div class="bg" style="padding:10px 0px 10px 12px;border:none;height:auto;">
				<ul class="list9" id="hotArticle">
					<!--<li><a href="#">刘强</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关问答</h5>
			<div class="inQuesiton">	
					<dl id="questions">
						<!--<dd><a href="#">如何解除劳动合同?</a></dd>-->
					</dl>
			</div>
			<h5 >培训下载</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto;">
				<ul class="list9" id="hotDownloads">
					<!-- <li><a>经典资料：行政管理怎样做...</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关培训机构</h5>
			<ul class="list7" style="padding-top:10px;padding-left:15px;" id="PXOrgs">
				<!--  <li class="line"><a><span class="red">1</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="red">2</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">3</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="blue">4</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">5</span><span class="text">众行机构</span></a></li>-->
			</ul>
			<div class="clear"></div>
			<h5>相关客户群</h5>
			<dl class="bestCustomer leftPart left" style="width:200px;" id="customer">
				<!-- <dd><a href="#">华夏基金</a></dd>-->
			</dl>
			<div class="clear"></div>
			<h5>相关评价</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9" id="comments">
					<!--  <li><a>2013年4月培训计划</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
		</div>
		
		<div style="height:10px; display:block"></div>
		 <div class="sortList">
			<div class="head">
						<div class="tabOn half" id="plan11"><a href='javascript:void(0)' onclick="javascript:seePartTab('plan',1,1)">培训计划</a></div>
						<div class="tabOff half" id="plan12"><a href='javascript:void(0)' onclick="javascript:seePartTab('plan',2,1)">内训计划</a></div>
						<div class="clear"></div>
					</div>
					<div class="bg h315" style="padding:0px 15px 4px 15px;">
						<ul class="list7" style="padding-top:10px" id="plan1">
							<!--<li class="line"><a>企业资本运作与投融资顾问</a></li>  -->
						</ul>
						<div class="clear"></div>
					</div>
		</div>
		<div style="height:10px; display:block"></div>
		 <div class="sortList">
			<div class="head">
						<div class="tabOn half" id="place11"><a  href='javascript:void(0)' onclick="javascript:seePartTab('place',1,1)">培训现场</a></div>
						<div class="tabOff half" id="place12"><a  href='javascript:void(0)' onclick="javascript:seePartTab('place',2,1)">内训现场</a></div>
						<div class="clear"></div>
					</div>
					<div class="bg h315" style="padding:0px 15px 4px 15px;">
						<ul class="list7" style="padding-top:10px" id="place1">
							<!--<li class="line"><a>企业资本运作与投融资顾问</a></li>  -->
						</ul>
						<div class="clear"></div>
					</div>
		</div>
		<div style="height:10px; display:block"></div>
	</div>
	<!--右边部分信息 end-->
	<div class="clear">
	
	
	</div>
</div>
<!--主体部分二 end-->
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>