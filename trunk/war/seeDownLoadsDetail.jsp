<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = request.getParameter("id");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>南北培训网</title>
<link type="text/css" href="css/face.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<script src="js/easyui/jquery-1.8.0.min.js"></script>
<script src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/part14.js"></script>
</head>
<body>
<jsp:include page="head.jsp" flush="true"/>
<script>
	$(function(){
		$.ajax({
			url:"struts/Download_viewDownloads?id="+<%=id%>,
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				$('#title').html("<h1>"+jsonObject.title+"</h1>");
				$('#courseId').html("上传人:"+jsonObject.author+"&nbsp;&nbsp;下载次数:"+jsonObject.hot+"&nbsp;&nbsp;"+jsonObject.createdate);
				$('#classContent').html(jsonObject.content);
				
				//路径
				var path = "<ul><li>当前位置:&nbsp;</li><li><a href='index.jsp'>首页</a></li><li class='bread'>&gt;&gt;</li>";
				path += "<li><a href='seeDownLoads.jsp'>培训下载</a></li>";
				path += "<li class='bread'>&gt;&gt;</li>";
				path += "<li>"+jsonObject.title+"</li></ul><div class='clear'></div>";
				$('#path').html(path);				
				$('#downPart').html("<a href='struts/Download_downLoadFile?downloadId="+jsonObject.id+"' style='color:red;'>点此下载资料</a>");

				//添加关键词
				var queryKeyWords = "";
				var keyWords = jsonObject.keyWords;
				var keyWordsStr = "<span>关键词：</span>";
				for(var i=0;i<keyWords.length;i++){
					keyWordsStr += "<a href='seeKey.jsp?key="+keyWords[i].name+"'>"+keyWords[i].name+"</a>";
					queryKeyWords += keyWords[i].name;
					if(i<keyWords.length-1)
						keyWordsStr += "、";
				}
				$('#keyWords').html(keyWordsStr+"<br>");
				loadRelatedKeyWords(queryKeyWords ==""?"下载":queryKeyWords);
				
				//添加专题
				var querySubjects = "";
				var series = jsonObject.series;
				var seriesStr = "<span>专题：</span>";
				for(var i=0;i<series.length;i++){
					seriesStr += "<a href='seeKey.jsp?id="+series[i].id+"'>"+series[i].name+"</a>";
					querySubjects += series[i].name;
					if(i<series.length-1)
						seriesStr += "、";
				}
				$('#series').html(seriesStr+"<br>");
				loadRelatedSubjects(querySubjects == ""?"下载":querySubjects);
				
			}
		});
		
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
			<div><span id="title"></span>
			<div class="classNum" id="courseId"></div></div>
			<div class="detail">
			<div class="classLeftPart" id="courseInfo">
			<div class="time" id="keyWords"></div>
			<div class="time" id="series"></div>
			</div>
			
			<div class="clear"></div>
			</div>
			<div class="clear"></div>
			<div id="courseContent">
					<p id="classContent"></p>
			</div>
			<div style="text-align:center" id="downPart">
			</div>
	</div>
	<div class="clear"></div>
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
	
</div>

<div class="clear"></div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>