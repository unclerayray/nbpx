<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String category = request.getParameter("id");
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
			url:"struts/ViewArticle_getArticleList?&rows=10&page=0&id="+<%=category%>,
			success:function(data){
				var jsonObject = eval('('+data+')');				
				//路径
				var path = "<ul><li>当前位置:&nbsp;</li><li><a href='index.jsp'>首页</a></li><li class='bread'>&gt;&gt;</li>";
				path += "<li>"+jsonObject.categoryName+"</li>";
				$('#path').html(path);				
								
				//添加行数
				var rows = jsonObject.rows;
				var valueStr = "";
	
				for(var i=0;i<rows.length;i++){
					var curr = rows[i];
					valueStr += "<div class='tdDiv'><a href='viewArticle.jsp?id="+curr.articleId+"' class='title'>"+curr.articleTitle+"</a><span class='articleTime'>"+curr.lastUpdateDate+"</span></div>";
				}
				$('#articles').html(valueStr);				
			}
		});
		//加载热门文章
		//loadHotArticle();
		//加载推荐文章
		//loadRecommandArticle();
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
<div class="clear"></div>
<!--当前路径 end-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px;">
	
	<!--左边部分课程信息 start-->
	<div class="leftInPart">
	<style>
		.tdDiv{border-bottom:1px dashed #c7c7c7;height:24px;padding-top:7px;padding-left:10px;padding-right:10px}
		.tdDiv .title:hover{color:red;text-decoration:none}
		.tdDiv .title{float:left;color:#234a35}	
		.tdDiv .articleTime{float:right;};
	</style>
	<div id="articles" style="padding-right:10px">
		<div class="tdDiv"><a href='#' class="title">我是一个经理人</a><span class="articleTime">2013-11-1</span></div>
		<div class="tdDiv"><span class="title">我是一个经理人</span><span class="articleTime">2013-11-1</span></div>
	</div>
	<!--课程介绍 end-->
	<div class="resultFoot" id="pageDiv" style='display:none'>
					<a href="javascript:void(0)" onclick="javascript:page.seeFirst();">第一页</a>			
					<a href="javascript:void(0)" onclick="javascript:page.seePre();">上一页</a>				
					<a href="javascript:void(0)" onclick="javascript:page.seeNext();">下一页</a>
					<a href="javascript:void(0)" onclick="javascript:page.seeLast();">最后一页</a>
					&nbsp;&nbsp;跳转至<input id="jump"/>页&nbsp;<button style="height:22px;" onclick="javascript:page.jump();">跳转</button>,当前是第<span id="currPage"></span>页,共<span id="pages">60</span>页
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
					<ul class="list7" id="hotArticle"></ul>	
					<div class="clear"></div>
				</div>
				<h5>推荐文章</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:195px;"/>
					<div class="clear" style="height:5px;"></div>
					<ul class="list7" id="recommandArticle"></ul>
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