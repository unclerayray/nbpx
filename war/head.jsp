<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	HttpSession currSession = request.getSession();
	String userName = (String)currSession.getAttribute("clientUserName");
	String userRole = (String)currSession.getAttribute("userRole");
	String flag = "0";
	if(userName != null && userName != "")
		flag = "1";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link type="text/css" href="css/face.css" rel="stylesheet" />
<script type="text/javascript" src="js/project.js"></script>
<script src="js/myjs/index.js"></script>

<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="js/easyui/jquery-1.8.0.min.js"></script>
<script src="js/easyui/jquery.easyui.min.js"></script>
<script src="ui/jquery.ui.core.js"></script>
<script src="ui/jquery.ui.widget.js"></script>
<script src="ui/jquery.ui.position.js"></script>
<script src="ui/jquery.ui.menu.js"></script>
<script src="ui/jquery.ui.autocomplete.js"></script>

</head>
<script>
$(function(){
		$.ajax({
			url:encodeURI('struts/Main_getKeywords?isInner=0&flag=1'),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "<ul>";
				$.each(jsonObject,function(n,value){
						//valueStr += "<li><a href='searchCourse.jsp?key="+value.name+">"+value.name+"</a></li>";
						valueStr += "<li><a href='searchCourse.jsp?key="+value.name +"'>"+value.name+"</a></li>";
				});
				valueStr += "</ul>";
				$('#quickKeys').html(valueStr);
			}
		});
		
		//init header search box
		$( "#searchWord" ).autocomplete({
			minLength: 1,
			source: function(request, response) {
				$.ajax({
					url: "struts/Search_queryKeywordsByKeyword",
					contentType: "application/x-www-form-urlencoded; charset=utf-8", 
					delay: 500,
					dataType:'json',
					timeout: 5000,
					data: {
						featureClass: "P",
						style: "full",
						maxRows: 12,
						wt:"json",
						q:$("#searchWord").val(),
						name_startsWith: request.term
					},
					success: function(data) {
						response($.map(data, function(item) {
							return {
								label: item.keyword,
								value: item.keyword
							};
						}));
					}
				});
			}
		});
	});
	function gotoPage(t){
		if($('#flag').val() != "1"){
			alert("请先登陆!");
			return false;
		}
		if(t == 1)//发布课程
			window.location.href='publishClass.jsp';
		else if(t == 5)//发布课程
			window.location.href='publishNXClass.jsp';
		else if(t == 2)//发布需求
			window.location.href='publishNeed.jsp';
		else if(t == 3)//内训申请
			window.location.href='publishNeixun.jsp';
		else if(t == 4)//发布文章
			window.location.href='publishArticel.jsp';
	}
	function logout(){
		if(confirm("确定要注销吗?")){
			$.ajax({
				url: 'struts/Login_logOut',
				success:function(data){
					//alert(data);
					var returnObject = eval('(' + data + ')');
					if(returnObject.rows[0].success == true){
						alert("注销成功!");
						window.location.href='index.jsp';
					}
				}
			});
		}
		
	}

</script>
<body>
<!--顶部start -->
<div class="mininav">
	<div class="mininavInner">
		<div class="mininavLeft">
			<div class="fl"><%="1".equals(flag)?("欢迎登陆,"+userName):"" %></div>
		</div>
		<input type="hidden" id="flag" value="<%=flag %>"/>
		<div class="mininavRight">
			<ul>
				<li><a href="index.jsp" class="navButton index">返回首页</a></li>
				<% if((flag =="1" && (userRole == "001_02"|| userRole == "001_03")) || flag == "0") //教师或者机构
				{%>
				<li><a href="javascript:void(0)" onclick="javascript:gotoPage(1)" class="navButton publishClass">发布培训课程</a></li>
				<li><a href="javascript:void(0)" onclick="javascript:gotoPage(5)" class="navButton publishClass">发布内训课程</a></li>
				<%} %>
				<% if((flag =="1" && (userRole == "001_01"|| userRole == "001_02")) || flag == "0") //教师或者机构
				{%>
				<li><a href="javascript:void(0)" onclick="javascript:gotoPage(4)" class="navButton apply">发布文章</a></li>
				<%} %>
				<li><a href="publishNeed.jsp"  class="navButton publishClass">发布需求</a></li>
				<li><a href="javascript:void(0)" onclick="javascript:gotoPage(3)" class="navButton publishRequest">内训申请</a></li>
				<%if(flag == "0") {%>
				<li><a href="login.jsp" class="navButton login">会员登录</a></li>
				<%} %>
				<li><a href="zhaosheng.jsp"  class="navButton student">招生合作</a></li>
				<li><a href="tousu.jsp" class="navButton complain">客户投诉</a></li>
				<li><a href="#" onclick="window.external.addFavorite('http://localhost:8080/')" class="navButton add">加入收藏</a></li>
				<%if(flag == "1") {%>
					<li><a href="javascript:void(0)" onclick="javascript:logout();" class="navButton login">注销登录</a></li>
				<%} %>
			</ul>
		</div>
 	</div>
</div>
<!--顶部end -->

<!--头部 start -->
<div class="channel_nav">
	<div class="logo">
		<!--<a href="#"><img  src="images/logo.gif" /></a>-->
	</div>
	<div class="logoRight">
		<ul class="menuUl">
			<li><a href="training.jsp">企业培训</a><span>|</span></li>
			<li><a href="trainPlan.jsp">培训计划</a><span>|</span></li>
			<li><a href="pxSeries.jsp">培训专题</a><span>|</span></li>
			<li><a href="seeDownLoads.jsp">培训下载</a><span>|</span></li>
			<li><a href="hotPX.jsp">热门培训</a><span>|</span></li>
			<li><a href="seeLiveScene.jsp?flag=1">培训现场</a><span>|</span></li>
			<li><a href="seeLiveScene.jsp?flag=2">内训现场</a><span>|</span></li>
			<li><a href="viewAllQuestion.jsp">积分问答</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=009" class="red">专业培训</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=008" class="red">行业培训</a><span>|</span></li>
			<li><a href="teacherPX.jsp">企业讲师</a></li>
			
			
			
			<li><a href="viewDic.jsp?type=011">产品培训</a><span>|</span></li>
			<li><a href="innerTraining.jsp">企业内训</a><span>|</span></li>
			<li><a href="classiscNX.jsp" class="red">经典内训</a><span>|</span></li>
			<li><a href="vedioNX.jsp">内训视频</a><span>|</span></li>
			<li><a href="nxSeries.jsp">内训专题</a><span>|</span></li>
			<li><a href="goldNX.jsp">金牌内训</a><span>|</span></li>
			<li><a href="customTrainPlan.jsp">内训计划</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=23">高校词典</a><span>|</span></li>
			<li><a href="allArticles.jsp">企业文库</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=020">题目词典</a><span>|</span></li>
			<!--  <li><a href="teacherNX.jsp">企业内训师</a></li>-->
			
			<li><a href="hotKey.jsp">热门搜索</a><span>|</span></li>
			<li><a href="#">培训动态</a><span>|</span></li>
			<li><a href="keyWord.jsp">关键词</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=005">客户群</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=016">研修班</a><span>|</span></li>
			<li><a href="seeTuoZhan.jsp">户外拓展</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=25">客户评价</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=21">术语词典</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=22">品牌词典</a><span>|</span></li>
			<li><a href="viewCity.jsp">城市词典</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=004">机构词典</a></li>

			<li><a href="orgSeries.jsp">培训机构</a><span>|</span></li>
			
			<li><a href="viewTarget.jsp">职位词典</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=26">培训类别</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=27">内训类别</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=28">文库类别</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=35">研修类别</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=32">机构类别</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=33">下载类别</a><span>|</span></li>
			<li><a href="viewDic.jsp?type=34">问答类别</a><span>|</span></li>
		</ul>
	</div>
	<div class="clear"></div>
</div>

<!--flash start-->
<div class="mainContent flash" style="padding-top:5px;">
	<img  src="images/adv1.gif" width="960" height="60px"/>
</div>
<!--flash end -->

<!--搜索start-->
<div class="mainContent search">
	<div class="rightContent">
		<input type="hidden" value="qypx" id="search_type" NAME="search_type">
		<div  id="searchTab"  class="searchType">
			<ul>
				<li id="searchTab_Title0" class="on" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='qypx';"><a href='javascript:void(0)' >企业培训</a></li>
				<li id="searchTab_Title1" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='pxs';"><a href='javascript:void(0)'>培训师</a></li>
				<li id="searchTab_Title2" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='qynx';"><a href='javascript:void(0)'>企业内训</a></li>
				<li id="searchTab_Title3" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='nxsp';"><a href='javascript:void(0)'>内训视频</a></li>
				<li id="searchTab_Title4" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='xz';"><a href='javascript:void(0)'>下载</a></li>
				<li id="searchTab_Title5" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='wk';"><a href='javascript:void(0)'>文库</a></li>
				<li id="searchTab_Title6" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='jg';"><a href='javascript:void(0)'>机构</a></li>
				<li id="searchTab_Title7" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='wd';"><a href='javascript:void(0)'>问答</a></li>
				<li id="searchTab_Title8" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='khpj'"><a href='javascript:void(0)'>客户评价</a></li>
				<li id="searchTab_Title9" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='khq';"><a href='javascript:void(0)'>客户群</a></li>
			</ul>
		</div>
	</div>
	<div class="clear"></div>
	<div class="searchInput"><input style='width:830px;' id="searchWord" value="请输入关键字,如: 员工 管理" onfocus="if (this.value=='请输入关键字,如: 员工 管理'){this.value='';}" 
	onblur="if (this.value==''){this.value='请输入关键字,如: 员工 管理';}" onkeydown="fnt_top_search2(event);" />
	<button class="searchButton"  onclick="fnt_top_search(document.getElementById('search_type').value);">搜&nbsp;索</button></div>
</div>
<!--搜索end-->

<!--按子母检索 start-->
<div class="quickFind">
	<div class="title">热门搜索:</div>
	<div id="quickKeys" class="condition">
		<ul>
		</ul>
	</div>
	<div  class="clear"></div>
</div>

<!--头部 end-->
</body>
</html>