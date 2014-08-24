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
	//加载文章
	for(var i=1;i<=8;i++){
		loadArticle(i);
	}
	//加载热门文章
	loadHotArticle();
	//加载推荐文章
	loadRecommandArticle();
});

//加载文章
function loadArticle(type){
	$.ajax({
		url:encodeURI('struts/Main_getArticle?&type='+type+"&flag=1"),
		success: function(data){
			var jsonObject = eval('('+data+')');
			var valueStr = "";
			$.each(jsonObject,function(n,value){
				valueStr += "<li><a href='viewArticle.jsp?id="+value.articleId+"'>"+value.articleTitle+"</a></li>";
			});
			if(valueStr == "")
				valueStr = "<div class='notice'>没有最新的文章</div>";
			$('#part'+type).html(valueStr);
		}		
	})
}

function loadHotArticle(){
	$.ajax({
		url:encodeURI("struts/ViewArticle_getHotArticle"),
		success:function(data){
			var jsonObject = eval('('+data+')');
			var valueStr = "";
			$.each(jsonObject,function(n,value){
				var color = "red";
				if(n>2)
					color = "blue";
				valueStr += "<li class='line'><a href='viewArticle.jsp?id="+value.id+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text tooLong w150'>"+value.title+"</span><span class='count'>"+value.hot+"</span></a><div class='clear'></div></li>";
			});
			$('#hotArticle').html(valueStr);
		}
	})
}

function loadRecommandArticle(){
	$.ajax({
		url:encodeURI("struts/ViewArticle_getRecommandArticle"),
		success:function(data){
			var jsonObject = eval('('+data+')');
			var valueStr = "";
			$.each(jsonObject,function(n,value){
				var color = "red";
				if(n>2)
					color = "blue";
				valueStr += "<li class='line'><a href='viewArticle.jsp?id="+value.id+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text tooLong w160'>"+value.title+"</span></a><div class='clear'></div></li>";
			});
			$('#recommandArticle').html(valueStr);
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
		<li>企业文库</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo gray" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<ul>
		<li class="noneStyle" style="padding-top:0px">
			<div class="part left" >
				<div class="head">
					<div class="tabOn" >财务管理</div>
					<div class="more"><a href="viewArticleType.jsp?id=003_01">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:30px;">
					<ul class="list4" style="padding-top:5px" id="part1">
						<li></li>
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle" style="padding-top:0px">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">采购供应链仓储</div>
					<div class="more"><a href="viewArticleType.jsp?id=003_02">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:30px;">
					<ul class="list4" style="padding-top:5px" id="part2">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">人力资源管理</div>
					<div class="more"><a href="viewArticleType.jsp?id=003_03">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list4" style="padding-top:15px" id="part3">
					</ul>
				</div>
			</div>
		</li>
				<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn" >生产管理</div>
					<div class="more"><a href="viewArticleType.jsp?id=003_04">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list4" style="padding-top:15px" id="part4">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">市场营销</div>
					<div class="more"><a href="viewArticleType.jsp?id=003_05">更多</a></div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list4" style="padding-top:15px" id="part5">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">战略管理</div>
					<div class="more"><a href="viewArticleType.jsp?id=003_06">更多</a></div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list4" style="padding-top:15px" id="part6">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">项目管理</div>
					<div class="more"><a href="viewArticleType.jsp?id=003_07">更多</a></div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list4" style="padding-top:15px" id="part7">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">职业技能</div>
					<div class="more"><a href="viewArticleType.jsp?id=003_08">更多</a></div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list4" style="padding-top:15px" id="part8">
					</ul>
				</div>
			</div>
		</li>
		</ul>
	</div>
	<!--右边部分信息 start-->
	<div class="rightInPart">
			<div class="rightTeacher">
				<h5  class="first">热门文章</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:195px;"/>
					<div class="clear" style="height:5px;"></div>
					<ul class="list7" id="hotArticle"></ul>	
					<div class="clear"></div>
				</div>
				<h5>推荐文章</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:195px;"/>
					<div class="clear" style="height:5px;"></div>
					<ul class="list7" id="recommandArticle"></ul>
				<div class="clear"></div>
				</div>
			</div>
			<div style="height:30px">&nbsp;</div>
	</div>
	<!--右边部分信息 end-->
	<div class="clear">
	
	
	</div>
</div>
<!--主体部分二 end-->
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>