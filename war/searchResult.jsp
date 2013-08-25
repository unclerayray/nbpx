<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="css/face.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<script src="js/easyui/jquery-1.8.0.min.js"></script>
<script src="js/easyui/jquery.easyui.min.js"></script>
<link type="text/css" href="css/face.css" rel="stylesheet" />
<script src="js/project.js"></script>
<title>搜索结果</title>
</head>

<script>
	function search(page){
		var key = $('#searchWord').val();
		$.ajax({
			url:"struts/Search_queryBySolr?page="+page+"&rows=10&key="+key,
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var pages = jsonObject.pages;
				var rows = jsonObject.rows;
				//alert("rows = " + rows);
				$.each(rows,function(n,value){
					var outClass= "classDesc last";
					if(n<rows.length-1)
						outClass="classDesc";
					var schedules = '';//课程安排
					var courseInfo = value.courseInfo;
					//alert("courseInfo = "+courseInfo);
					if(courseInfo!=null){
						schedules += "<div class='left' style='width:60px;'><span>课程安排：</span></div><div style='float:right;width:630px;'><table id='scheduleTable'><tr>";
						$.each(courseInfo,function(n,info){
							if(n!=0&&n%3==0){
								schedules += "</tr><tr><td>"+info+"</td>";
							}else{
								schedules += "<td>"+info+"</td>";
							}
						});
						schedules += "</tr></table></div>";
					}
					//alert("schedules="+schedules);
					valueStr += "<div  class='"+outClass+"'><h3><a href='viewClass.jsp?id="+value.courseId+"'>"+value.title+"</a></h3>"+
							"<div class='classInfor'>编号："+value.courseId+"&nbsp;&nbsp;培训费用：￥"+value.price+"&nbsp;&nbsp;讲师："+value.teacherName+"</div>"
							+ schedules +
							"<div class='classDetail'>"+
							"<div class='left' style='width:60px;'><span>培训内容：</span></div><div style='float:right;width:630px;'>"+value.content+"...[<a href='viewClass.jsp?id="+value.courseId+"'>详细内容</a>]</div></div>"+
							"<div class='clear'></div>";
				});
				//alert("valueStr " + valueStr);
				if(valueStr == ""){
					valueStr = "<div class='notice'>未搜索到相关课程信息</div>";
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
		<li><a href="main.html" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>深圳培训网</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<div class="searchBox">
	<input id="searchWord" name="searchWord"/>
	<button type="button" class="formBtn"
					onclick="search(1);">
					<img src="images/icon_submit.png"> 搜索
				</button>
</div>

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
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
					<div class="tabOn half">深圳培训排行</div>
					<div class="tabOff half">本月最热</div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 15px 4px 15px;">
					<ul class="list7" style="padding-top:10px">
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
			<h5 class=" first">深圳培训师</h5>
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
			<h5>深圳培训机构</h5>
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
				<h5  class="first">深圳培训动态</h5>
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
				<h5>深圳培训问答</h5>
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
