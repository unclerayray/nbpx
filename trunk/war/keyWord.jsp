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
		getLastedKeyWords();
		
		//加载关键词
		for(var i=1;i<=8;i++)
			getKeywords(i);
		
		for(var i=1;i<=3;i++)
			getSideKeyWords(i);
	})
	function rand(num){ 
		return parseInt(Math.random()*num+1); 
	}
	function randomcolor(){ 
		var str=Math.ceil(Math.random()*16777215).toString(16); 
		if(str.length<6){ 
			str="0"+str; 
		} 
		return str; 
	}
	function initTags(){
		var obj = $("#wrap").children();
		for(len=obj.length,i=len;i--;){ 
			//obj[i].style.left=rand(600)+"px"; 
			obj[i].style.top=rand(400)+"px"; 
			obj[i].className="color"+rand(5); 
			obj[i].style.zIndex=rand(5); 
			obj[i].style.fontSize=rand(12)+12+"px"; 
			obj[i].style.color="#"+randomcolor(); 
		} 	
	}
	function getLastedKeyWords(){
		var urlStr = 'struts/Keyword_getLastedKeyWords';
		$.ajax({
			url:encodeURI(urlStr),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr += "<a href=\"seeKey.jsp?key="+value.name+"\">"+value.name+"</a>";
				});
				if(valueStr == '')
					valueStr = "<div class='notice'>没有推荐的关键词</div>";
				$('#wrap').html(valueStr);
				initTags();
			}		
		})
	}
	
	function getKeywords(type){
		var urlStr = 'struts/Keyword_getKeyWordsByType?category='+type;
		$.ajax({
			url:encodeURI(urlStr),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr += "<li><a href=\"seeKey.jsp?key="+value.name+"\">"+value.name+"</a></li>";
				});
				if(valueStr == '')
					valueStr = "<div class='notice'>没有推荐的关键词</div>";
				$('#keys'+type).html(valueStr);
			}		
		})
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
		<li><a href="main.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>关键词</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<div style="float:left">
		<div class="lastedKeys" style="width:700px">
			<h2>最新关键词</h2>
			<div style="padding:10px 15px 10px 15px" class="keyWrap" id="wrap">
			
			</div>
		</div>
		<div class="clear"></div>
		</div>
	<!--广告 start-->
	<img  src="images/peixunAd.jpg"  style="width:700px; height:60px;float:left"/>
	<!--广告 end-->
		<ul>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">财务管理关键词</div>
					<div class="more"><a href="keyWordMore.jsp?type=1" target="_self">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="keys1">
					</ul>
				</div>
			</div>
		</li>
				<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">采购供应链仓储关键词</div>
					<div class="more"><a href="keyWordMore.jsp?type=2" target="_self">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="keys2">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">人力资源关键词</div>
					<div class="more"><a href="keyWordMore.jsp?type=3" target="_self">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="keys3">
					</ul>
				</div>
			</div>
		</li>
				<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn" >生产管理关键词</div>
					<div class="more"><a href="keyWordMore.jsp?type=4" target="_self">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="keys4">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">市场营销关键词</div>
					<div class="more"><a href="keyWordMore.jsp?type=5" target="_self">更多</a></div>
				<div class="clear"></div>
			</div>
<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="keys5">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">项目管理关键词</div>
					<div class="more"><a href="keyWordMore.jsp?type=6" target="_self">更多</a></div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="keys6">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">战略管理关键词</div>
					<div class="more"><a href="keyWordMore.jsp?type=7" target="_self">更多</a></div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="keys7">
					</ul>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="tabOn">职业技能关键词</div>
					<div class="more"><a href="keyWordMore.jsp?type=8" target="_self">更多</a></div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding-left:10px;">
					<ul class="list10" style="padding-top:15px" id="keys8">
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
				<h5  class="first">热门关键词排行</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:270px"/>
					<div class="clear" style="height:10px;"></div>
					<ul class="list7" id="part1">
					</ul>
				</div>
			</div>
		<!--内训关键词 end-->
		
		<!--内训专题start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
				<h5  class="first">热搜关键词排行</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:270px"/>
					<div class="clear" style="height:10px"></div>
					<ul class="list7" id="part3">
					</ul>
				</div>
		</div>
		<!--培训专题end-->

	<!--内训专题start-->
		<div style="height:10px; display:block"></div>
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