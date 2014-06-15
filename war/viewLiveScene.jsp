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
	String id = request.getParameter("id");
	String flag = request.getParameter("flag");
	String typeName = "";
	if("1".equals(flag))
		  typeName = "培训现场";
	else 
		  typeName = "内训现场";
%>
<script>
	$(function(){
		//加载热门下载
		//getHotDownLoads();
		//加载相关课程
		getLiveScene();
		getHotDownLoads();
	})
	//加载热门下载
	function getHotDownLoads(){
		$.ajax({
			url:encodeURI("struts/Main_getDownLoads?flag="+2),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					if(n<3)
						valueStr +="<li class='line'><a><span class='red'>"+(n+1)+"</span><span class='text tooLong w150'>"+value.title+" </span><span class='count'>"+value.downloadCnt+"</span></a><div class='clear'></div></li>";
					else
						valueStr +="<li class='line'><a><span class='blue'>"+(n+1)+"</span><span class='text tooLong w150'>"+value.title+"</span><span class='count'>"+value.downloadCnt+"</span></a><div class='clear'></div></li>";
				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>没有下载记录</div>";
				}
				$('#hotDownload').html(valueStr);
			}
		})
	}
	//加载下载列表，按照时间顺序
	function getLiveScene(){

		$.ajax({
			url:"struts/LiveScene_viewLiveScene?liveSceneId="+$('#id').val(),
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var name = jsonObject.name;
				$('#name').html(name);
				$('#nameTitle').html(name);
				var rows = jsonObject.images;
	
				$.each(rows,function(n,value){
					valueStr += "<li><img src='"+value.url+"'/></li>";
				});

				if(valueStr == ""){
					valueStr = "<div class='notice'>没有最新的现场信息</div>";
				}
				$('#container').html(valueStr);
			}
		});
	}

</script>

<body>
<jsp:include page="head.jsp" flush="true"/>
<input type="hidden" id="id" value="<%=id%>">
<!--当前路径 start-->
<div class="mainContent path">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><a href="seeLiveScene.jsp?flag=<%=flag %>" target="_self"><%=typeName %></a></li>
		<li class="bread">&gt;&gt;</li>
		<li><span id="name"></span></li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<!--最新的下载 start-->
		<div class="resultPart">
			<h2 id="nameTitle"></h2>
			<div class="resultContent">
					<style>
						.imgContainer{list-style:none}
						.imgContainer li{width:600px;margin-bottom:15px;margin-left:5px}
						.imgContainer img{border:1px solid #ccc;height:200px;width:400px}	
					</style>
					<ul class="imgContainer" id="container">

					</ul>	
					<div class="clear" style="height:10px"></div>
			</div>
		</div>
		<!--消费者相关企业培训 end-->	
		
	</div>
	<!--右边部分 start-->
	<div class="rightInPart">
		<!--培训关键词 start-->	
		<div class="rightTeacher">
				<h5  class="first">相关课程</h5>
				<ul class="list7" style="padding-top:10px;padding-left:20px" id="hotDownload">
				</ul>
				<div class="clear" style="height:20px"></div>
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