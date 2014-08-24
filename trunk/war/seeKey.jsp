<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="css/face.css" rel="stylesheet" />
<script type="text/javascript" src="js/easyui/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/part14.js"></script>
<title>南北培训网</title>
</head>
<%
	String key = request.getParameter("key");
%>
<script>
	$(function(){
		//加载相关关键字
		getRelatedKeys();
		//加载相关专题
		getRelatedSubjects();
		//加载相关课程
		getRelatedCourse(1);
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
	})
	//加载相关关键字
	function getRelatedKeys(){
		var condition = $('#keyValue').val();
		$.ajax({
			url:encodeURI("struts/SeeKeyword_getRelatedKeys?key="+condition),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr +="<li><a href=\"seeKey.jsp?key="+value.keyword+"\">"+value.keyword+"</a></li>";
				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>没有相关的关键字</div>";
				}
				$('#relatedKeywords').html(valueStr);
			}
		})
	}
	//加载相关专题
	function getRelatedSubjects(){
		var condition = $('#keyValue').val();
		$.ajax({
			url:encodeURI("struts/SeeKeyword_getRelatedSubejcts?key="+condition),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href=\"seeKey.jsp?key="+value.subject+"\">"+value.subject+"</a></li>";
				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>没有相关的专题</div>";
				}
				$('#relatedSubjects').html(valueStr);
			}
		})
	}
	function getRelatedCourse(page){
		var condition = $('#keyValue').val();
		$.ajax({
			url:"struts/SeeKeyword_getRelatedCourses?page="+page+"&rows=10&key="+condition,
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
						"<div class='left' style='width:60px;'><span>培训内容：</span></div><div style='float:right;width:630px;'>"+value.content+"...[<a href='viewClass.jsp?id="+value.courseId+"'>详细内容</a>]</div></div></div>"+
						"<div class='clear'></div>";
					});
					//alert("valueStr " + valueStr);
					if(valueStr == ""){
						valueStr = "<div class='notice'>未搜索到相关课程信息</div>";
					}else
						$('#coursePagesDiv').css('display','block');
					$('#classes').html(valueStr);
					$('#coursePages').html(pages);
					$('#courseCurrPage').html(parseInt(page));
				}
			});
	}

	var pager = {
		'test':function(){
			alert('1');
		},
		'seeNext':function(){
			var currPage = parseInt($('#courseCurrPage').html());
			var pages = parseInt($('#coursePages').html());
			if(currPage +1 >= pages)
				getRelatedCourse(pages);
			else
				getRelatedCourse(currPage+1);
		},
		'seePre':function(){
			var currPage = parseInt($('#courseCurrPage').html());
			if(currPage-1 > 0)
				getRelatedCourse(currPage-1);
			else
				getRelatedCourse(1);
		},
		'seeFirst':function(){
			getRelatedCourse(1);
		},
		'seeLast':function(){
			var pages = $('#coursePages').html();
			getRelatedCourse(pages);
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
			getRelatedCourse(jumpTo);
		}
	};
</script>

<body>
<input type="hidden" id="keyValue" value="<%=key%>">
<jsp:include page="head.jsp" flush="true"/>

<!--当前路径 start-->
<div class="mainContent path">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><a href="keyWord.jsp">关键词</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><%=key %></li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<!--消费者相关关键词 start-->
		<div class="resultPart">
			<h2><span><%=key %></span>相关关键词</h2>
			<div class="resultContent">
					<ul class="list10" id="relatedKeywords">
					</ul>
					<div class="clear" style="height:10px"></div>
			</div>
		</div>
		<!--消费者相关关键词 end-->
		
		<!--消费者相关专题 start-->
		<div class="resultPart padding10">
			<h2><span><%=key %></span>相关专题</h2>
			<div class="resultContent">
					<ul class="list10" id="relatedSubjects">
					</ul>
					<div class="clear"  style="height:10px"></div>
			</div>
		</div>
		<!--消费者相关专题 end-->
		
		<!--消费者相关企业培训 start-->
		<div class="resultPart padding10">
			<h2><span><%=key %></span>相关企业培训</h2>
			<div class="resultContent">
					<div id="classes"></div>
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
		</div>
		<!--消费者相关企业培训 end-->	
		
	</div>
	<!--右边部分 start-->
		<!--右边部分信息 start-->
	<div class="rightInPart">
		<div class="rightTeacher">
			<h5  class="first">相关培训课程</h5>
			<div class="bg" style="padding:0px 15px 10px 15px;border:none;height:auto">
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
	<!--右边部分 end-->
	<div class="clear">
	
	
	</div>
</div>
<!--主体部分二 end-->

<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>