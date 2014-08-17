<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
		for(var i=1;i<=8;i++)
			loadOrgSeries(i);
		//loadOrgSeries(1);
		//加载热门关键词
		loadHotKeyWord();
		//加载热门专题
		loadHotSubjects();
	});
	function loadOrgSeries(type){

		$.ajax({
			url:"struts/OrgInfo_getOrgListBySeries?series=003_0"+type+"&page=1&rows=10",
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var rows = jsonObject.rows;
				$.each(rows,function(n,value){
					valueStr += "<li><a href='orgView.jsp?id="+value.orgId+"'>"+value.orgName+"</a></li>";
				});
				if(valueStr == "")
					valueStr = "<div class='notice'>没有最新的培训机构</div>";
				$('#part'+type).html(valueStr);
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
						valueStr += "<li class='line'><a href='seeKey.jsp?key="+value.name+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'>"+value.count+"</span></a><div class='clear'></div></li>";
					else
						valueStr += "<li class='line'><a href='seeKey.jsp?key="+value.name+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'></span></a><div class='clear'></div></li>";
				});
				if(valueStr == "")
					valueStr = "<div class='notice'>没有推荐的关键词</div>";
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
						valueStr += "<li class='line'><a href='seeKey.jsp?key="+value.name+"'><span class=\""+color+"\">"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'></span></a><div class='clear'></div></li>";
					else
						valueStr += "<li class='line'><a href='seeKey.jsp?key="+value.name+"'><span class=\""+color+"\">"+(n+1)+"</span><span class='text'>"+value.name+"</span><span class='count'>"+value.count+"</span></a><div class='clear'></div></li>";
				});
				if(valueStr == "")
					valueStr = "<div class='notice'>没有推荐的专题</div>";
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
		<li>培训机构</li>
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
					<div class="tabOn" >财务管理</div>
					<div class="more"><a href="orgList.jsp?type=003_01">更多</a></div>
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
					<div class="more"><a href="orgList.jsp?type=003_02">更多</a></div>
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
					<div class="more"><a href="orgList.jsp?type=003_03">更多</a></div>
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
					<div class="more"><a href="orgList.jsp?type=003_04">更多</a></div>
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
					<div class="more"><a href="orgList.jsp?type=003_05">更多</a></div>
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
					<div class="more"><a href="orgList.jsp?type=003_06">更多</a></div>
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
					<div class="more"><a href="orgList.jsp?type=003_07">更多</a></div>
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
					<div class="more"><a href="orgList.jsp?type=003_08">更多</a></div>
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