<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String cityName = "广州";//request.getParameter("city");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
		loadCourses(0);
		loadHot(1);
	})
	
	function loadArroundCity(){
		
	}
	
	function loadHot(flag){
		if(flag == '1'){
			$('#tab1').attr('class','tabOn half');
			$('#tab2').attr('class','tabOff half');
		}else{
			$('#tab1').attr('class','tabOff half');
			$('#tab2').attr('class','tabOn half');
		}
		$.ajax({
			url:encodeURI('struts/SeePlace_getHotCourse?flag='+flag+'&city='+$('#currCity').val()),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var color = "red";
				$.each(jsonObject,function(n,value){
					if(n>=2)
						color="blue";
					valueStr += "<li class='line'><a href='viewClass.jsp?id="+value.id+"'><span class='"+color+"'>"+(n+1)+"</span>"+value.title+"</a></li>";
				});
				$('#tabContent').html(valueStr);
			}
		});
	}
	
	function loadCourses(page){
		$.ajax({
			url:encodeURI('struts/SeePlace_getCityCourse?page='+page+'&rows=10&city='+"xx"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var pages = jsonObject.pages;
				var rows = jsonObject.rows;
				$.each(rows,function(n,value){
					var outClass= "classDesc last";
					if(n<rows.length-1)
						outClass="classDesc";
					valueStr += "<div  class='"+outClass+"'><h3><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></h3>"+
								"<div class='classInfor'>培训时间："+value.startDate+"&nbsp;&nbsp;培训费用：￥"+value.price+"&nbsp;&nbsp;编号："+value.id+"</div>"+
								"<div class='classDetail'>"+
								"<div class='left' style='width:60px;'><span>培训内容：</span></div><div style='float:right;width:630px;'>"+value.content+"...[<a href='viewClass.jsp?id="+value.id+"'>详细内容</a>]</div></div>"+
								"<div class='clear'></div>"+
								"<div class='classDownload'><span>课纲下载：</span><a href='#'>"+value.title+".doc</a></div></div>";
				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>该城市暂时没有任何课程信息</div>";
				}else
					$('#pageDiv').css('display','block');
				$('#classes').html(valueStr);
				$('#pages').html(pages);
				$('#currPage').html(parseInt(page)+1);
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
		<li><%=cityName %>培训网</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->
<input type="hidden" value="<%=cityName %>" id="currCity"/>
<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<!--消费者相关关键词 start-->
		<div class="resultPart">
			<h2><%=cityName %>周边培训</h2>
			<div class="resultContent">
					<ul class="list10">
						<li><a href="#">中山</a></li>
						<li><a href="#">东莞</a></li>
						<li><a href="#">珠海</a></li>
						<li><a href="#">茂名</a></li>
						<li><a href="#">广州</a></li>
						<li><a href="#">湛江</a></li>
					</ul>
					<div class="clear" style="height:10px"></div>
			</div>
		</div>
		<!--消费者相关关键词 end-->
		
		<!--消费者相关专题 start-->
		<div class="resultPart padding10"  style="width:345px;float:left">
			<h2><%=cityName %>培训日历</h2>
			<div class="resultContent" style="padding-left:20px">
					<ul class="list2" style="width:340px">
						<li ><a href="seePlaceMonth.jsp?month=1&city=<%=cityName %>>">01月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=2&city=<%=cityName %>>">02月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=3&city=<%=cityName %>>">03月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=4&city=<%=cityName %>>">04月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=5&city=<%=cityName %>>">05月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=6&city=<%=cityName %>>">06月</a><span>&nbsp;</span></li>
						<li><a href="seePlaceMonth.jsp?month=7&city=<%=cityName %>>">07月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=8&city=<%=cityName %>>">08月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=9&city=<%=cityName %>>">09月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=10&city=<%=cityName %>>">10月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=11&city=<%=cityName %>>">11月</a><span>|</span></li>
						<li><a href="seePlaceMonth.jsp?month=12&city=<%=cityName %>>">12月</a></li>
					</ul>
					<div class="clear" style="height:10px"></div>
			</div>
		</div>
		<!--消费者相关专题 end-->
		<!--消费者相关专题 start-->
		<div class="resultPart padding10"  style="width:345px;float:right">
			<h2><%=cityName %>培训计划</h2>
				<div class="resultContent" style="padding-left:20px">
					<ul class="list2" style="width:340px">
						<li ><a href="#">01月</a><span>|</span></li>
						<li><a href="#">02月</a><span>|</span></li>
						<li><a href="#">03月</a><span>|</span></li>
						<li><a href="#">04月</a><span>|</span></li>
						<li><a href="#">05月</a><span>|</span></li>
						<li><a href="#">06月</a><span>&nbsp;</span></li>
						<li><a href="#">07月</a><span>|</span></li>
						<li ><a href="#">08月</a><span>|</span></li>
						<li><a href="#">09月</a><span>|</span></li>
						<li><a href="#">10月</a><span>|</span></li>
						<li><a href="#">11月</a><span>|</span></li>
						<li><a href="#">12月</a></li>
					</ul>
					<div class="clear" style="height:10px"></div>
			</div>
		</div>
		<!--消费者相关专题 end-->
		<div id="classes"></div>
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
	<!--右边部分 start-->
	<div class="rightInPart">
		<!--热门培训 培训计划 培训下载 start-->
		<div class="sortList">
		<div class="head">
					<div class="tabOn half" id="tab1"><a href="javascript:void(0)" onclick="javascript:loadHot(1);"><%=cityName %>培训排行</a></div>
					<div class="tabOff half" id="tab2"><a href="javascript:void(0)" onclick="javascript:loadHot(2);">本月最热</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 15px 4px 15px;">
					<ul class="list7" style="padding-top:10px" id="tabContent">
						<li class="line"><a><span class="red">1</span>企业资本运作与投融资顾问</a></li>
						<li  class="line"><a><span class="red">2</span>企业资本运作与投融资顾问</a></li>
						<li class="line"><a><span class="blue">3</span>企业资本运作与投融资顾问</a></li>
						<li class="line"><a><span class="blue">4</span>企业资本运作与投融资顾问</a></li>
						<li class="line"><a><span class="blue">5</span>企业资本运作与投融资顾问</a></li>
					</ul>
					<div class="clear"></div>
				</div>
		</div>
		<!--热门培训 培训计划 培训下载 end-->
		<!--企业培训师 start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher" >
			<h5 class=" first"><%=cityName %>培训师</h5>
			<div style="padding-left:15px;padding-bottom:10px">
			<img  src="images/824.jpg" style="height:50px;width:40px" class="left"/>
			<dl class="left">
			<dt>王麻子</dt>
			<dd>擅长人力资源以及薪酬制度等</dd>
			</dl>
			<div class="clear"></div>
			<img  src="images/824.jpg" style="height:50px;width:40px" class="left"/>
			<dl class="left">
			<dt>王麻子</dt>
			<dd>擅长人力资源以及薪酬制度等</dd>
			</dl>
			<div class="clear"></div>
			<img  src="images/824.jpg" style="height:50px;width:40px" class="left"/>
			<dl class="left">
			<dt>王麻子</dt>
			<dd>擅长人力资源以及薪酬制度等</dd>
			</dl>
			<div class="clear"></div>
			<img  src="images/824.jpg" style="height:50px;width:40px" class="left"/>
			<dl class="left">
			<dt>王麻子</dt>
			<dd>擅长人力资源以及薪酬制度等</dd>
			</dl>
			<div class="clear"></div>
			<h4>名字热搜</h4>
			<ul class="teacher">
				<li><a href="#">刘强</a></li>
				<li><a href="#">张三</a></li>
				<li><a href="#">刘强</a></li>
				<li><a href="#">张三</a></li>
				<li><a href="#">刘强</a></li>
				<li><a href="#">张三</a></li>
				<li><a href="#">刘强</a></li>
				<li><a href="#">张三</a></li>
			</ul>
			<div class="clear"></div>
			</div>
			<h5><%=cityName %>培训机构</h5>
			<ul class="list7" style="padding-top:10px;padding-left:15px;">
				<li class="line"><a><span class="red">1</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="red">2</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">3</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="blue">4</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">5</span><span class="text">众行机构</span></a></li>
			</ul>
			<div class="clear" style="height:10px"></div>
		</div>
		<!--企业培训动态 start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
				<h5  class="first"><%=cityName %>培训动态</h5>
				<div style="padding:0px 0px 10px 15px;height:140px">
					<marquee  direction="up" scrollamount="3" behavior="scroll" class="lasted" height="150px" onmouseover="this.stop();" onMouseOut="this.start()">
					<ul class="list5" style="width:230px;">
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
					</ul>
					</marquee>
					<div class="clear"></div>
				</div>
				<h5><%=cityName %>培训问答</h5>
				<div class="inQuesiton">	
					<dl>
						<dd><a href="#">如何解除劳动合同?</a></dd>
						<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
						<dd><a href="#">如何分配股权?</a></dd>
						<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
						<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
						<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
					</dl>
				</div>
			</div>
		
		<!--企业培训动态end-->
    </div>
	
	<!--右边部分 end-->
	<div class="clear">
	
	
	</div>
</div>
<!--主体部分二 end-->
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>