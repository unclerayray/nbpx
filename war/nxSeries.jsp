<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
	//加载前6个,003_01~003_06
	for(var i=1;i<=6;i++){
		loadSubjects("003_0"+i,i,1);
	}
	//研修班part7
	
	//行业培训、职位培训、产品培训、专业培训
	for(var i=1;i<=4;i++){
		loadSubjects(i,i+7,3);
	}
	//加载排行
	for(var i=1;i<=3;i++){
		getTopSeries(i);
	}
});

function loadSubjects(category,flag,type){
	var method="";
	if(type == 1)
		method = "getSubjectsByCategory";
	else if(type == 2)
		method = "";
	else
		method = "getSubjectsByOthers";
	$.ajax({
		url:encodeURI('struts/ViewSubject_'+method+'?isInner=1&category='+category),
		success:function(data){
			var jsonObject = eval('('+data+')');
			var valueStr = "";
			$.each(jsonObject,function(n,value){
				valueStr += "<li><a href='#?id="+value.id+"'>"+value.name+"</a></li>";
			});
			if(valueStr == ""){
				valueStr = "<div class='notice'>该课程类别暂无专题信息</div>";
			}
			$('#part'+flag).html(valueStr);
		}
	});
}

function getTopSeries(flag){
	var	urlStr = "struts/Main_getSubjects?isInner=1";
	var sortType;
	if(flag == 1)
		sortType = "2";
	else if(flag == 2)
		sortType = "3";
	else
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
			if(valueStr == "")
				valueStr = "<div class='notice'>暂无任何专题</div>";
			$('#hot'+flag).html(valueStr);
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
		<li>内训专题</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<ul>
		<li class="noneStyle" style="padding-top:0px">
			<div class="part left" >
				<div class="head">
					<div class="tabOn" >财务管理专题</div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part1">
						<li><a href="#">EMBA</a></li>
					</ul>
				</div>
			</div>
		</li>
				<li class="noneStyle" style="padding-top:0px">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">物流供应链专题</div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part2">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">人力资源专题</div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part3">
					</ul>
				</div>
			</div>
		</li>
				<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn" >生产管理专题</div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part4">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">营销客服专题</div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part5">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">综合战略专题</div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part6">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">研修班专题</div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part7">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">行业培训专题</div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part8">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">职位培训专题</div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part9">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">产品培训专题</div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part10">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">专业培训专题</div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="part11">
					</ul>
				</div>
			</div>
		</li>
		</ul>
	</div>
	<!--右边部分 start-->
	<div class="rightInPart">
		<!--培训关键词 start-->	
		<div class="rightTeacher">
				<h5  class="first">类别专题冠军</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:270px"/>
					<div class="clear" style="height:10px;"></div>
					<ul class="list7" id="hot1">
					</ul>
				</div>
			</div>
		<!--内训关键词 end-->
		
		<!--内训专题start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
				<h5  class="first">专题热搜排行</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:270px"/>
					<div class="clear" style="height:10px"></div>
					<ul class="list7" id="hot2">
					</ul>
				</div>
		</div>
		<!--培训专题end-->

	<!--内训专题start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
				<h5  class="first">专题点击排行</h5>
					<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:270px"/>
					<div class="clear" style="height:10px"></div>
					<ul class="list7" id="hot3">
					</ul>
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