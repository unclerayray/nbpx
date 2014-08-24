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
<title>南北培训网-培训计划</title>
</head>
<script>
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0
	var yyyy = today.getFullYear();
	$(function(){
		//加载培训计划
		searchPlans(1);
		//加载培训计划相关关键词
		loadPlanKeyWords();
		//加载培训计划相关专题
		loadPlanSubjects();
	});

	function searchPlans(init){
		$('#search_year').val(yyyy);
		$('#this_year').html(yyyy);
		$('#next_year').html(yyyy+1);
		var month = mm;
		var url = 'struts/TrainPlan_getTrainPlanInfo?year='+$('#search_year').val()+'&isInner=false';
		if(!init){
			url = 'struts/TrainPlan_getTrainPlanInfo?isInner='+$('#search_inner').val()+'&month='+$('#search_month').val()+'&year='+$('#search_year').val()+'&cate='+$('#search_category').val() + '&city='+$('#search_city').val();
			month = $('#search_month').val();
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