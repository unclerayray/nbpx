<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    	String currMonth = request.getParameter("month");
    	String currYear = request.getParameter("year");
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
	});
	function loadCourses(page){
		var currMonth = $('#currMonth').val();
		var currYear = $('#currYear').val();
		$.ajax({
			url:"struts/SeeMonthCourse_getCourseByMonth?page="+page+"&rows=10&month="+currMonth+"&year="+currYear,
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
							"<div class='classInfor'>培训时间："+value.startDate+"至"+value.endDate+"&nbsp;&nbsp;培训地点："+value.city+"&nbsp;&nbsp;培训费用：￥"+value.price+"&nbsp;&nbsp;编号："+value.id+"</div>"+
							"<div class='classDetail'>"+
							"<div class='left' style='width:60px;'><span>培训内容：</span></div><div style='float:right;width:630px;'>"+value.content+"...[<a href='viewClass.jsp?id="+value.id+"'>详细内容</a>]</div></div>"+
							"<div class='clear'></div>"+
							"<div class='classDownload'><span>课纲下载：</span><a href='#'>"+value.title+".doc</a></div></div>";
				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>该月份暂时没有任何课程信息</div>";
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
		<li><a href="training.jsp" target="_self">企业培训</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><%=currYear%>年<%=currMonth %>月份培训课程</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->
<input type="hidden" value="<%=currMonth%>" id="currMonth"/><input type="hidden" value="<%=currYear%>" id="currYear"/>
<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<!--消费者相关专题 start-->
		<div class="resultPart padding10"  style="width:700px;float:left">
			<h2><%=currYear%>年培训日历</h2>
			<div class="resultContent" style="padding-left:20px">
					<ul class="list2" style="width:690px">
						<li ><a href="seeMonthCourse.jsp?month=1&year=<%=currYear%>">01月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=2&year=<%=currYear%>">02月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=3&year=<%=currYear%>">03月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=4&year=<%=currYear%>">04月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=5&year=<%=currYear%>">05月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=6&year=<%=currYear%>">06月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=7&year=<%=currYear%>">07月</a><span>&nbsp;</span></li>
						<li ><a href="seeMonthCourse.jsp?month=8&year=<%=currYear%>">08月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=9&year=<%=currYear%>">09月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=10&year=<%=currYear%>">10月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=11&year=<%=currYear%>">11月</a><span>&nbsp;</span></li>
						<li><a href="seeMonthCourse.jsp?month=12&year=<%=currYear%>">12月</a></li>
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
		<!--企业培训动态 start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
				<h5  class="first">培训动态</h5>
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
				<h5>培训问答</h5>
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