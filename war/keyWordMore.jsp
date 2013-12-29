<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="css/face.css" rel="stylesheet" />
<script type="text/javascript" src="js/easyui/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<title>南北培训网</title>
</head>
<%
	String type = request.getParameter("type");
%>
<script>
	$(function(){
		//加载关键词
		getMoreKeywords(1);
		getTypeName();
		for(var i=1;i<=3;i++)
			getSideKeyWords(i);
	})
	function getTypeName(){
		var type  = $('#typeValue').val();
		var urlStr = 'struts/Keyword_getTypeName?category='+type;
		$.ajax({
			url:encodeURI(urlStr),
			success: function(data){
				var jsonObject = eval('('+data+')');
				$('#showName').html(jsonObject.showName);
			}		
		})
	}
	
	function getMoreKeywords(page){
		var type  = $('#typeValue').val();
		var urlStr = 'struts/Keyword_getMoreKeyWordsByType?category='+type+"&rows=120&page="+page;
		$.ajax({
			url:encodeURI(urlStr),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var lines = jsonObject.lines;
				var pages = jsonObject.pages;
				var valueStr = "";
				$.each(lines,function(n,value){
					valueStr += "<li><a href=\"seeKey.jsp?key="+value.name+"\">"+value.name+"</a></li>";
				});
				if(valueStr == '')
					valueStr = "<div class='notice'>该类别暂时还没有关键词</div>";
				$('#keysList').html(valueStr);
				$('#coursePagesDiv').css('display','block');
				$('#coursePages').html(pages);
				$('#courseCurrPage').html(parseInt(page));
			}		
		})
	}
	//1代表点击率，2代表推荐，3代表热搜
	function getSideKeyWords(sortType){
		$.ajax({
			url:encodeURI("struts/Main_getKeywords?isInner=0&flag="+sortType),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					var color = "red";
					if(n>2)
						color = "blue";
					if(sortType != '2' )//不是推荐的 会有访问次数
						valueStr += "<li class='line'><a href=\"seeKey.jsp?key="+value.name+"\"><span class='"+color+"'>"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'>"+value.count+"</span></a><div class='clear'></div></li>";
					else
						valueStr += "<li class='line'><a href=\"seeKey.jsp?key="+value.name+"\"><span class='"+color+"'>"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'></span></a><div class='clear'></div></li>";
				});
				if(valueStr == "")
					valueStr = "<div class='notice'>没有符合条件的关键词</div>";
				$('#part'+sortType).html(valueStr);
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

<body>
<input type="hidden" id="typeValue" value="<%=type%>"/>
<jsp:include page="head.jsp" flush="true"/>

<!--当前路径 start-->
<div class="mainContent path">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="main.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><a href="keyWord.jsp" target="_self">关键词</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><span id="showName"></span>关键词</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
	<!--广告 end-->
<div style="float:left">
		<div class="lastedKeys" style="width:700px">
			<h2>所有关键词</h2>
			<div style="padding:10px 15px 10px 15px">
			<ul class="list8 keyMore" id="keysList">
						<li><a href="#">EMBA</a></li>
						<li><a href="#">KPI</a></li>
				</ul>
			<!--课程介绍 end-->
					<div class="resultFoot" id="coursePagesDiv" style='display:none'>
						<a href="javascript:void(0)" onclick="javascript:pager.seeFirst();">第一页</a>			
						<a href="javascript:void(0)" onclick="javascript:pager.seePre();">上一页</a>				
						<a href="javascript:void(0)" onclick="javascript:pager.seeNext();">下一页</a>
						<a href="javascript:void(0)" onclick="javascript:pager.seeLast();">最后一页</a>
						&nbsp;&nbsp;跳转至<input id="jump"/>页&nbsp;<button style="height:22px;" onclick="javascript:pager.jump();">跳转</button>,当前是第<span id="courseCurrPage"></span>页,共<span id="coursePages">60</span>页
					</div>
			</div>
		</div>
		<div class="clear"></div>
		</div>
	</div>
	<!--右边部分 start-->
	<div class="rightInPart">
		<!--培训关键词 start-->	
		<div class="rightTeacher">
				<h5  class="first">热门关键词排行</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:270px"/>
					<div class="clear" style="height:10px;"></div>
					<ul class="list7" id="part1">
					</ul>
				</div>
			</div>
		<!--内训关键词 end-->
		
		<!--内训专题start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
				<h5  class="first">热搜关键词排行</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:270px"/>
					<div class="clear" style="height:10px"></div>
					<ul class="list7" id="part3">
					</ul>
				</div>
		</div>
		<!--培训专题end-->

	<!--内训专题start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
				<h5  class="first">推荐关键词</h5>
				<div class="bg"  style="padding:0px 15px 4px 15px;border:none;height:270px"/>
					<div class="clear" style="height:10px"></div>
					<ul class="list7" id="part2"></ul>
				</div>
		</div>
		<!--培训专题end-->

	
    </div>
	<!--右边部分 end-->
	<div class="clear">
	
	
	</div>
</div>
<!--主体部分二 end-->

<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>