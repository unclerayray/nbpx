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
</head>
<body>
<jsp:include page="head.jsp" flush="true"/>
<script>
	$(function(){
		
		
		$.ajax({
			url:"struts/ViewArticle_viewArticle?id="+<%=id%>,
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				$('#title').html("<h1>"+jsonObject.title+"</h1>");
				$('#courseId').html("阅读次数:"+jsonObject.hot+"&nbsp;&nbsp;"+jsonObject.createdate);
				$('#classContent').html(jsonObject.content);
				
				//路径
				var path = "<ul><li>当前位置:&nbsp;</li><li><a href='index.jsp'>首页</a></li><li class='bread'>&gt;&gt;</li>";
				path += "<li><a href='allArticles.jsp'>企业文库</a></li>";
				path += "<li class='bread'>&gt;&gt;</li>";
				path += "<li><a href='viewArticleType.jsp?id="+jsonObject.categoryID+"'>"+jsonObject.categoryName+"</a></li>";
				path += "<li class='bread'>&gt;&gt;</li>";
				path += "<li>"+jsonObject.title+"</li></ul><div class='clear'></div>";
				$('#path').html(path);				
				
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
				
				//添加专题
				var querySubjects = "";
				var series = jsonObject.series;
				var seriesStr = "<span>专题：</span>";
				for(var i=0;i<series.length;i++){
					seriesStr += "<a href='xx.jsp?id="+series[i].id+"'>"+series[i].name+"</a>";
					querySubjects += series[i].name;
					if(i<series.length-1)
						seriesStr += "、";
				}
				$('#series').html(seriesStr+"<br>");				
			}
		});
		//加载热门文章
		loadHotArticle();
		//加载推荐文章
		loadRecommandArticle();
	});
	

	function loadHotArticle(){
		$.ajax({
			url:encodeURI("struts/ViewArticle_getHotArticle"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					var color = "red";
					if(n>2)
						color = "blue";
					valueStr += "<li class='line'><a href='viewArticle?id="+value.id+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text tooLong w150'>"+value.title+"</span><span class='count'>"+value.hot+"</span></a><div class='clear'></div></li>";
				});
				$('#hotArticle').html(valueStr);
			}
		})
	}
	
	function loadRecommandArticle(){
		$.ajax({
			url:encodeURI("struts/ViewArticle_getRecommandArticle"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					var color = "red";
					if(n>2)
						color = "blue";
					valueStr += "<li class='line'><a href='viewArticle?id="+value.id+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text tooLong w160'>"+value.title+"</span></a><div class='clear'></div></li>";
				});
				$('#recommandArticle').html(valueStr);
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
			<div ><span id="title">我是一个文章</span>
			<div class="classNum" id="courseId">2013-11-1</div></div>
			<div class="detail">
			<div class="classLeftPart" id="courseInfo">
			<div class="time" id="keyWords"><span>关键词：</span><a href="#">管理</a>、<a href="#">团队建设</a></div>
			<div class="time" id="series"><span>专题：</span><a href="#">企业管理</a></div>
			</div>
			
			<div class="clear"></div>
			</div>
			<div class="clear"></div>
			<div id="courseContent">
					<p id="classContent">我是一个人</p>
			</div>
	</div>
	<div class="clear"></div>
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
</body>
</html>