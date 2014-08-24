<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
		getAllQuestion(1);
		//加载热门文章
		loadHotArticle();
		//加载推荐文章
		loadRecommandArticle();
	});
	
	function getAllQuestion(page){
		var urlStr = 'struts/Wenda_queryQuestions?rows=30&page='+page;
		
		$.ajax({
			url:encodeURI(urlStr),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var lines = jsonObject.rows;
				var total = jsonObject.total;
				var valueStr = "";
				$.each(lines,function(n,value){
					valueStr += "<div class='tdDiv'><a href='question"+value.questionId+".html' class='title'>"+value.title+"</a><span class='articleTime'>"+value.askDate+"</span></div>";
				});
				if(valueStr == '')
					valueStr = "<div class='notice'>该类别暂时还没有问答</div>";
				$('#articles').html(valueStr);
				$('#coursePagesDiv').css('display','block');
				$('#coursePages').html(parseInt(parseInt(total)/30)+1);
				$('#courseCurrPage').html(parseInt(page));
			}		
		})
	}

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
					valueStr += "<li class='line'><a href='viewArticle.jsp?id="+value.id+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text tooLong w150'>"+value.title+"</span><span class='count'>"+value.hot+"</span></a><div class='clear'></div></li>";
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
					valueStr += "<li class='line'><a href='viewArticle.jsp?id="+value.id+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text tooLong w160'>"+value.title+"</span></a><div class='clear'></div></li>";
				});
				$('#recommandArticle').html(valueStr);
			}
		})
	}
	var pager = {
			'test':function(){
				alert('1');
			},
			'seeNext':function(){
				var currPage = parseInt($('#courseCurrPage').html());
				var pages = parseInt($('#coursePages').html());
				if(currPage +1 >= pages)
					getMoreKeywords(pages);
				else
					getMoreKeywords(currPage);
			},
			'seePre':function(){
				var currPage = parseInt($('#courseCurrPage').html());
				if(currPage-1 > 0)
					getMoreKeywords(currPage-1);
				else
					getMoreKeywords(1);
			},
			'seeFirst':function(){
				getMoreKeywords(1);
			},
			'seeLast':function(){
				var pages = $('#coursePages').html();
				getMoreKeywords(pages);
			},
			'jump':function(){
				if($('#jump').val() == ''){
					alert('请输入页码！');
					return false;
				}
				var jumpTo = parseInt($('#jump').val());
				var allPages = parseInt($('#coursePages').html());
				if(jumpTo <=0 || jumpTo> allPages){
					alert('页码范围不正确！');
					return false;
				}
				getMoreKeywords(jumpTo);
			}
		};
</script>
<!--当前路径 start-->
<div class="mainContent path">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>积分问答</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px;">
	
	<!--左边部分课程信息 start-->
	<div class="leftInPart">
	<style>
		.tdDiv{border-bottom:1px dashed #c7c7c7;height:24px;padding-top:7px;padding-left:10px;padding-right:10px;font-size:12px}
		.tdDiv .title:hover{color:red;text-decoration:none}
		.tdDiv .title{float:left;color:#234a35}	
		.tdDiv .articleTime{float:right;};
	</style>
	<div ><a style="display:block;height:29px;;line-height:29px;width:70px;border-left:1px solid #ccc;border-right:1px solid #ccc;background:url(images/split.png) no-repeat -180px -5px;margin-left:10px;float:left;font-size:12px" href='addQuestion.jsp'>发布问题</a></div>
	<div class="clear"></div>
	<div id="articles" style="padding-right:10px">
		<!--<div class="tdDiv"><a href='#' class="title">干嘛</a><span class="articleTime">2013-11-1</span></div>
		<div class="tdDiv"><span class="title">为啥</span><span class="articleTime">2013-11-1</span></div>-->
	</div>
	<!--课程介绍 end-->
					<div class="resultFoot" id="coursePagesDiv" style='display:none'>
						<a href="javascript:void(0)" onclick="javascript:pager.seeFirst();">第一页</a>			
						<a href="javascript:void(0)" onclick="javascript:pager.seePre();">上一页</a>				
						<a href="javascript:void(0)" onclick="javascript:pager.seeNext();">下一页</a>
						<a href="javascript:void(0)" onclick="javascript:pager.seeLast();">最后一页</a>
						&nbsp;&nbsp;跳转至<input id="jump"/>页&nbsp;<button style="height:22px;" onclick="javascript:pager.jump();">跳转</button>,当前是第<span id="courseCurrPage"></span>页,共<span id="coursePages">60</span>页
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