<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link type="text/css" href="css/face.css" rel="stylesheet" />
<script type="text/javascript" src="js/project.js"></script>
<title>Insert title here</title>
<script>
	$(function(){
		loadOrgs();
		loadLinks();
		

		//init header ad
		//<a href=""><img  src="/ad/30_0000.jpg" width="960" height="60px"/></a>

		$.ajax({
			url:encodeURI('struts/Dictionary_getAdDictionary?p_dicType=30&p_codeName=30_12'),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var imgStr = "<img src='/ad/30_12.jpg' width='960' height='60px'/>";
				if(jsonObject.orderNum){
					valueStr += "<a href='viewClass.jsp?id=" + jsonObject.orderNum +"'>";
					valueStr += imgStr;
					valueStr += "</a>";
				}else{
					valueStr += imgStr;
				}
				$('#30_12').html(valueStr);
			}
		});
	})
	function loadOrgs(){
		$.ajax({
				url: 'struts/ViewDic_getMoreDicItems?codeName=005&rows=30&page=1',
				success:function(data){
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject.rows,function(n,value){
						valueStr += "<li><a class='left tooLong w230' href=\"seeKey.jsp?key="+value.showName+"\">"+value.showName+"</a></li>";	
					});
		
					if(valueStr == "")
						valueStr ="<div class='notice'>暂时没有字典信息</div>";
					
					$('#orgs').html(valueStr);
				}
		});
		
	}
	function loadLinks(){
		$.ajax({
				url: 'struts/ViewDic_getMoreDicItems?codeName=31&rows=30&page=1',
				success:function(data){
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject.rows,function(n,value){
						var url = value.discription;
						if(url.indexOf("http") < 0){
							url = "http://"+value.discription;
						}
						valueStr += "<li><a class='left tooLong w230' target='_blank' href=\""+url+"\">"+value.showName+"</a></li>";	
					});
		
					if(valueStr == "")
						valueStr ="<div class='notice'>暂时没有字典信息</div>";
					
					$('#links').html(valueStr);
				}
		});
		
	}
</script>
</head>
<body>
<!--flash start-->
<div class="clear"></div>
<div class="mainContent flash" id="30_12" style="padding-bottom:10px">
	<img  src="/ad/30_12.jpg" width="960"/>
</div>
<!--flash end -->

<!--字母查找 start-->
<div class="mainContent wordFindContent">
	<!--  <ul class="wordFind">
	<li>
		<div class="title">按字母查找<span>培训课程</span>:</div>
		<div class="word"><a href="#">A</a><a href="#">B</a><a href="#">C</a><a href="#">D</a><a href="#">E</a><a href="#">F</a><a href="#">G</a><a href="#">H</a><a href="#">I</a><a href="#">J</a><a href="#">K</a><a href="#">L</a><a href="#">M</a><a href="#">N</a><a href="#">O</a><a href="#">P</a><a href="#">R</a><a href="#">S</a><a href="#">T</a><a href="#">U</a><a href="#">V</a><a href="#">W</a><a href="#">X</a><a href="#">Y</a><a href="#">Z</a>
	</div>
	<li >
		<div class="title distance">按字母查找<span>内训课程</span>:</div>
		<div class="word"><a href="#">A</a><a href="#">B</a><a href="#">C</a><a href="#">D</a><a href="#">E</a><a href="#">F</a><a href="#">G</a><a href="#">H</a><a href="#">I</a><a href="#">J</a><a href="#">K</a><a href="#">L</a><a href="#">M</a><a href="#">N</a><a href="#">O</a><a href="#">P</a><a href="#">R</a><a href="#">S</a><a href="#">T</a><a href="#">U</a><a href="#">V</a><a href="#">W</a><a href="#">X</a><a href="#">Y</a><a href="#">Z</a></div>
	</li>
	<li >
		<div class="title ">按字母查找<span>文章新闻</span>:</div>
		<div class="word"><a href="#">A</a><a href="#">B</a><a href="#">C</a><a href="#">D</a><a href="#">E</a><a href="#">F</a><a href="#">G</a><a href="#">H</a><a href="#">I</a><a href="#">J</a><a href="#">K</a><a href="#">L</a><a href="#">M</a><a href="#">N</a><a href="#">O</a><a href="#">P</a><a href="#">R</a><a href="#">S</a><a href="#">T</a><a href="#">U</a><a href="#">V</a><a href="#">W</a><a href="#">X</a><a href="#">Y</a><a href="#">Z</a>
	</div>
	<li>
		<div class="title distance">按字母查找<span>下载内容</span>:</div>
		<div class="word"><a href="#">A</a><a href="#">B</a><a href="#">C</a><a href="#">D</a><a href="#">E</a><a href="#">F</a><a href="#">G</a><a href="#">H</a><a href="#">I</a><a href="#">J</a><a href="#">K</a><a href="#">L</a><a href="#">M</a><a href="#">N</a><a href="#">O</a><a href="#">P</a><a href="#">R</a><a href="#">S</a><a href="#">T</a><a href="#">U</a><a href="#">V</a><a href="#">W</a><a href="#">X</a><a href="#">Y</a><a href="#">Z</a></div>
	</li>
	</ul>-->
</div>
<div class="clear" style="height:10px; display:block"></div>
<!--字母查找 end-->

<!-- 友情链接 start-->
<div class="mainContent customer" >
	<div class="head">部分培训客户<span class="more"><a href="viewDic.jsp?type=005">更多</a></span></div>
	<div class="bg">
		<ul id="orgs">
			<li><a href="#">电信</a></li>
			<li><a href="#">TCL</a></li>
			<li><a href="#">美的</a></li>
			<li><a href="#">格力电器</a></li>
			<li><a href="#">中石油</a></li>
			<li><a href="#">中石化</a></li>
			<li><a href="#">美联地产</a></li>
			<li><a href="#">电信</a></li>
			<li><a href="#">TCL</a></li>
			<li><a href="#">美的</a></li>
			<li><a href="#">格力电器</a></li>
			<li><a href="#">中石油</a></li>
			<li><a href="#">中石化</a></li>
			<li><a href="#">美联地产</a></li>
			<li><a href="#">电信</a></li>
			<li><a href="#">TCL</a></li>
			<li><a href="#">美的</a></li>
			<li><a href="#">格力电器</a></li>
			<li><a href="#">中石油</a></li>
			<li><a href="#">中石化</a></li>
			<li><a href="#">美联地产</a></li>
			<li><a href="#">电信</a></li>
			<li><a href="#">TCL</a></li>
			<li><a href="#">美的</a></li>
			<li><a href="#">格力电器</a></li>
			<li><a href="#">中石油</a></li>
			<li><a href="#">中石化</a></li>
			<li><a href="#">美联地产</a></li>
			<li><a href="#">电信</a></li>
			<li><a href="#">TCL</a></li>
			<li><a href="#">美的</a></li>
			<li><a href="#">格力电器</a></li>
			<li><a href="#">中石油</a></li>
			<li><a href="#">中石化</a></li>
			<li><a href="#">美联地产</a></li>
			<li><a href="#">电信</a></li>
			<li><a href="#">TCL</a></li>
			<li><a href="#">美的</a></li>
			<li><a href="#">格力电器</a></li>
			<li><a href="#">中石油</a></li>
			<li><a href="#">中石化</a></li>
			<li><a href="#">美联地产</a></li>
			<li><a href="#">电信</a></li>
			<li><a href="#">TCL</a></li>
			<li><a href="#">美的</a></li>
			<li><a href="#">格力电器</a></li>
			<li><a href="#">中石油</a></li>
			<li><a href="#">中石化</a></li>
			<li><a href="#">美联地产</a></li>
			<li><a href="#">电信</a></li>
		</ul>
		<div class="clear"></div>
	</div>
</div>
<!--友情链接 end--->

<!-- 友情链接 start-->
<div class="mainContent customer">
	<div class="head">友情链接</div>
	<div class="bg">
		<ul id = "links">
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
			<li><a href="#">南北培训网</a></li>
		</ul>
		<div class="clear"></div>
	</div>
</div>
<!--友情链接 end--->

<!--底部 start-->
<div class="mainContent foot">
	<div class="desc">
		<ul>
			<li><a href="#">返回首页</a></li>
			<li>-</li>
			<li><a href="#">广告服务</a></li>
			<li>-</li>
			<li><a href="#">客户中心</a></li>
			<li>-</li>
			<li><a href="#">免责声明</a></li>
			<li>-</li>
			<li><a href="#">友情链接</a></li>
			<li>-</li>
			<li><a href="#">培训公司</a></li>
		</ul>
		<div class="clear"></div>
	</div>
	
	<div class="privage">Copyleft 2007-2011 NanBeiPX.com All lefts reserved.中国南北培训网版权所有 常年法律顾问：广东安国律师事务所 谢乐安 技术支持：Slobby</div>
	<div><img  src="images/foot.jpg"/></div>
</div>
<!--底部 end-->
</body>
</html>