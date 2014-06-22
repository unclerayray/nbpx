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
										+"<td><a href='struts/TrainPlan_exportKegang'>课纲下载</a></td>"
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
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href='#'>"+value.keyword+"</a></li>";
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
						valueStr1 +="<dd><a href='#'>"+subject+"</a></dd>";
					else
						valueStr2 +="<dd><a href='#'>"+subject+"</a></dd>";
				});
				$('#relatedSubjects1').html(valueStr1);
				$('#relatedSubjects2').html(valueStr2);
			}
		})
	}
	
	function exportExcel(){
		$.ajax({
			url:"struts/TrainPlan_exportCoursePlan?isInner=false&month=6&year=2014&cate=003_01",
			success:function(data){
			}
		});
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
			.searchType{width:70px;float:left;text-align:right;padding-right:5px;font-size:14px;font-weight:bold;color:#2D4545}
			.searchOption{float:left;width:570px;font-size:14px}
			.searchOption ul{list-style:none;}
			.searchOption li{float:left;font-size:12px;padding-right:5px;padding-left:5px;}
			.searchOption li a{color:#333;text-decoration:none;font-size:12px;}
			.searchOption li a.on{background:#2D4545;color:white;font-weight:bold;padding:2px;font-size:12px}
		</style>
		<!--消费者相关专题 start-->
		<div class="resultPart"  style="width:700px;float:left">
			<h2>按条件检索</h2>
		 	<div class="resultContent" style="padding-left:20px;height:120px;">
				<div style='padding-top:10px'>
					<div class='searchType'>按年度:</div>
					<div class='searchOption'>
						<ul><li><a href='#' class="on">全部</a></li><li><a href='#'>2013</a></li><li><a href='#'>2012</a></li></ul>
					</div>
				</div>
				<div class="clear"></div>
				<div style='padding-top:10px'>
					<div class='searchType'>按月份:</div>
					<div class='searchOption'>
						<ul><li><a href='#' class="on">全部</a></li><li>1月</li><li>2月</li><li>3月</li><li>4月</li><li>5月</li><li>6月</li><li>7月</li><li>8月</li><li>9月</li><li>10月</li><li>11月</li><li>12月</li></ul>
					</div>
				</div>
				<div class="clear"></div>
				<div style='padding-top:10px'>
					<div class='searchType'>按专题:</div>
					<div class='searchOption'>
						<ul><li><a href='#' class="on">全部</a></li><li>财务管理</li><li>物流供应链</li><li>人力资源</li><li>生产管理</li><li>营销培训</li><li>综合战略</li></ul>
					</div>
				</div>			
				<div class="clear"></div>
				<div style='padding-top:10px'>
					<div class='searchType'>按城市:</div>
					<div class='searchOption'>
						<ul><li><a href='#' class="on">全部</a></li><li>广州</li><li>北京</li><li>苏州</li><li>南京</li><li>上海</li><li>无锡</li></ul>
					</div>
				</div>
			</div>
			<!-- 测试函数 -->
			<a href='struts/TrainPlan_exportCoursePlan?isInner=false&month=6&year=2014&cate=003_01'>导出培训计划</a>
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