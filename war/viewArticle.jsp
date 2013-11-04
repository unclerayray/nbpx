<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = request.getParameter("id");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看课程</title>
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
			url:"struts/ViewClass_ViewClass?id="+<%=id%>,
			success:function(data){
				var jsonObject = eval('('+data+')');
				$('#title').html("<h1>"+jsonObject.title+"</h1>");
				$('#courseId').html("课程编号："+jsonObject.classNum);
				$('#blockContent').html(jsonObject.bloclContent);
				$('#classContent').html(jsonObject.content);
				$('#teacher').html("<span>培训师：</span>"+jsonObject.teacher);
				$('#price').html("<span>课程费用：</span>"+jsonObject.price);
				if(jsonObject.isInner == '0'){
					$('#inAttend').css('display','block');
					$('#outAttend').css('display','none');
				}
				else{
					$('#inAttend').css('display','none');
					$('#outAttend').css('display','block');
				}
				
				//路径
				var path = "<ul><li>当前位置:&nbsp;</li><li><a href='index.jsp'>首页</a></li><li class='bread'>&gt;&gt;</li>";
				if(jsonObject.isInner == '0')
					path += "<li><a href='#'>企业培训</a></li>";
				else
					path += "<li><a href='#'>企业内训</a></li>";
				path += "<li class='bread'>&gt;&gt;</li><li><a href='xx.jsp?id="+jsonObject.categoryID+"'>"+jsonObject.categoryName+"</a></li><li class='bread'>&gt;&gt;</li>";
				path += "<li>"+jsonObject.title+"</li></ul><div class='clear'></div>";
				$('#path').html(path);
				
				//添加时间 地点
				var places = jsonObject.time;
				var placeStr="<span>上课地点：</span>";
				var timeStr = "<span>举办时间：</span>";
			
				$.each(places,function(n,value){
					timeStr += value.from+"至"+value.to;
					placeStr += value.city;
					if(n<places.length-1){
						timeStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
						placeStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
					}
				});
				$('#place').html(placeStr);
				$('#time').html(timeStr);
				
				//添加培训对象
				var object = jsonObject.object;
				var objectStr = "<span>培训对象：</span>";
				for(var i=0;i<object.length;i++){
					objectStr += "<a href='xx.jsp?id="+object[i].id+"'>"+object[i].name+"</a>";
					if(i<object.length-1)
						objectStr += ",";
				}
				$('#object').html(objectStr);
				
				//添加适用行业
				var indestory = jsonObject.indestory;
				var indestoryStr = "<span>适用行业：</span>";
				for(var i=0;i<indestory.length;i++){
					indestoryStr += "<a href='xx.jsp?id="+indestory[i].id+"'>"+indestory[i].name+"</a>";
					if(i<indestory.length-1)
						indestoryStr += ",";
				}
				$('#indestory').html(indestoryStr);
				
				//添加适用专业
				var major = jsonObject.major;
				var majorStr = "<span>适用专业：</span>";
				for(var i=0;i<major.length;i++){
					majorStr += "<a href='xx.jsp?id="+major[i].id+"'>"+major[i].name+"</a>";
					if(i<major.length-1)
						majorStr += ",";
				}
				$('#major').html(majorStr);
				
				//添加关键词
				var queryKeyWords = "";
				var keyWords = jsonObject.keyWords;
				var keyWordsStr = "<span>关键词：</span>";
				for(var i=0;i<keyWords.length;i++){
					keyWordsStr += "<a href='xx.jsp?id="+keyWords[i].id+"'>"+keyWords[i].name+"</a>";
					queryKeyWords += keyWords[i].name;
					if(i<keyWords.length-1)
						keyWordsStr += ",";
				}
				$('#keyWords').html(keyWordsStr);
				loadRelatedKeyWords(queryKeyWords);
				
				//添加专题
				var querySubjects = "";
				var series = jsonObject.series;
				var seriesStr = "<span>专题：</span>";
				for(var i=0;i<series.length;i++){
					seriesStr += "<a href='xx.jsp?id="+series[i].id+"'>"+series[i].name+"</a>";
					querySubjects += series[i].name;
					if(i<series.length-1)
						seriesStr += ",";
				}
				loadRelatedSubjects(querySubjects);
				$('#series').html(seriesStr);

				
			}
		});
	});
	
	function loadRelatedKeyWords(condition){
		$.ajax({
			url:encodeURI("struts/ViewClass_getRelatedKeyWords?condition="+condition),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href='#'>"+value.keyword+"</a></li>";
				});
				$('#relatedKeywords').html(valueStr);
			}
		})
	}
	
	function loadRelatedSubjects(condition){
		$.ajax({
			url:encodeURI("struts/ViewClass_getRelatedSubjects?condition="+condition),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href='#'>"+value.subject+"</a></li>";
				});
				$('#relatedSubjects').html(valueStr);
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
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;"/>
					<div class="clear" style="height:10px;"></div>
				<ul class="list8" id="relatedKeywords"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
				<h5>推荐文章</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;"/>
					<div class="clear" style="height:10px;"></div>
				<ul class="list8" id="relatedSubjects"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
			</div>
			
	</div>
	<!--右边部分信息 end-->
	
</div>

<div class="clear"></div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>