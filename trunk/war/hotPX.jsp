<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>南北培训网</title>
</head>
<script>
	$(function(){
		loadCourses(0);
		//加载热门关键词
		loadHotKeyWord();
		//加载热门专题
		loadHotSubjects()
	});
	function loadCourses(page){
		var currMonth = $('#currMonth').val();
		var currYear = $('#currYear').val();
		$.ajax({
			url:"struts/HotCourse_getHotPXCourse?page="+page+"&rows=10",
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
					valueStr = "<div class='notice'>暂时没有任何课程信息</div>";
				}else
					$('#pageDiv').css('display','block');
				$('#classes').html(valueStr);
				$('#pages').html(pages);
				$('#currPage').html(parseInt(page)+1);
			}
		});
	}
	function loadHotKeyWord(){
		var urlStr;var sortType;
		sortType = '1';//点击率排行
		urlStr = 'struts/Main_getKeywords?isInner=0';
		$.ajax({
			url:encodeURI(urlStr+"&flag="+sortType),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					var color = "red";
					if(n>2)
						color = "blue";
					if(sortType != '2' )//不是推荐的 会有访问次数
						valueStr += "<li class='line'><a><span class='"+color+"'>"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'>"+value.count+"</span></a><div class='clear'></div></li>";
					else
						valueStr += "<li class='line'><a><span class='"+color+"'>"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'></span></a><div class='clear'></div></li>";
				});
		
				$('#hotKeywords').html(valueStr);
			}		
		})
	}
	function loadHotSubjects(){
		var urlStr;var sortType;
		urlStr = "struts/Main_getSubjects?isInner=0";
		sortType = "1";
		$.ajax({
			url:encodeURI(urlStr+"&flag="+sortType),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					var color = "red";
					if(n>2)
						color = "blue";
					if(sortType == '2')//推荐的 没有次数
						valueStr += "<li class='line'><a href='#'><span class=\""+color+"\">"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'></span></a><div class='clear'></div></li>";
					else
						valueStr += "<li class='line'><a href='#'><span class=\""+color+"\">"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'>"+value.count+"</span></a><div class='clear'></div></li>";
				});
				$('#hotSubjects').html(valueStr);
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
		<li>热门培训</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart" id="leftPart">
		<div id="classes">
		<!--课程介绍 start-->
			<div  class="classDesc">
				<h3>企业培训体系设计</h3>
				<div class="classInfor">培训时间：2013-0-20&nbsp;&nbsp;培训天数：2天&nbsp;&nbsp;培训地点：深圳&nbsp;&nbsp;培训费用：￥3500&nbsp;&nbsp;编号：1234</div>
				<div class="classDetail">
					<div class="left" style="width:60px;"><span>培训内容：</span></div><div style="float:right;width:630px;">使参训人员了解企业架构与IT战略规划全套流程与方法，通过案例学习相关架构工具Togaf9.0，认识到架构方法在信息化规划中的重要性，了解企业架构中的核心理念与实践方法，掌握业务架构、应用架构、技术架构...<a href="#">[详细内容]</a></div></div>
					<div class="clear"></div>
				<div class="classDownload"><span>课纲下载：</span><a href="#">企业培训体系设计.doc</a></div>
			</div>
		<!--课程介绍 end-->
		</div>
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
		<!--培训关键词 start-->	
		<div class="rightTeacher">
				<h5  class="first">热门关键字</h5>
				<div class="bg" style="padding:0px 0px 4px 15px;border:none;height:290px"/>
				<div class="clear" style="height:10px;"></div>
					<ul class="list7" id="hotKeywords">
					</ul>
				</div>
			</div>
		<!--内训关键词 end-->	
		
		<!--培训关键词 start-->	
		<div class="clear" style="height:10px"></div>
		<div class="rightTeacher">
				<h5  class="first">热门专题</h5>
				<div class="bg" style="padding:0px 0px 4px 20px;border:none;height:290px"/>
					<div class="clear" style="height:0px"></div>
					<ul class="list7" style="padding-top:10px" id="hotSubjects">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
					</ul>
				</div>
			</div>
		<!--内训关键词 end-->	
    </div>
	<!--右边部分 end-->
	<div class="clear">
	
	
	</div>
</div>
<!--主体部分二 end-->
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>