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

<script>
	$(function(){
		getTop100Keywords();
		//加载推荐关键词
		getSideKeyWords(2);
	})
	function getTop100Keywords(){
		$.ajax({
			url:encodeURI("struts/Keyword_getTopKeyWords"),
			success: function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr="";
				$.each(jsonObject,function(n,value){
					valueStr += "<li><a href=\"seeKey.jsp?key="+value.name+"\">"+value.name+"</a></li>";
				});
				if(valueStr == '')
					valueStr = "<div class='notice'>暂时没有关键词搜索记录</div>";
				$('#keysList').html(valueStr);
			}
		});
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

</script>

<body>
<jsp:include page="head.jsp" flush="true"/>

<!--当前路径 start-->
<div class="mainContent path">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>热门关键词</li>
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
			<h2>热门关键词</h2>
			<div style="padding:10px 15px 10px 15px">
			<ul class="list8 keyMore" id="keysList">
						<!--  <li><a href="#">EMBA</a></li>
						<li><a href="#">KPI</a></li>-->
				</ul>
			<!--课程介绍 end-->
					
			</div>
		</div>
		<div class="clear"></div>
		</div>
	</div>
	<!--右边部分 start-->
	<div class="rightInPart">		
	<!--内训专题start-->
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