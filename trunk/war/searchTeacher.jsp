<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String keyw = (String)request.getParameter("key");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link type="text/css" href="css/face.css" rel="stylesheet" />
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
	<script src="js/myjs/index.js"></script>

	<link type="text/css" href="css/search.css" rel="stylesheet" />
	<link type="text/css" href="css/face.css" rel="stylesheet" />
	<title>搜索结果</title>
	<style>
	.ui-autocomplete-loading {
		background: white url('images/ui-anim_basic_16x16.gif') right center no-repeat;
	}
	#searchWord { width: 25em; }
	</style>
	<script language="JavaScript">
		window.onload = function(){
			if("<%= keyw%>"!="null"){
				$('#searchWord').val("<%= keyw%>");
			}
		};
	</script>
	<script>
	$(function() {
		if("<%= keyw%>"!="null"){
			$.ajax({
				url:"struts/Search_queryTeacherBySolr?page=1&rows=10&key="+"<%=keyw%>",
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
						//alert("schedules="+schedules);
						valueStr += "<div  class='"+outClass+"'><h3><a target='_blank'  href='teacherClass.jsp?type=1&id"+value.teacherId+"'>"+value.realName+"</a></h3>"+
						"<div class='classInfor'>编号："+value.teacherId+"&nbsp;&nbsp;主讲类别："+value.majorCatgory+"&nbsp;&nbsp;擅长："+value.expertIn+"</div>"+
						"<div class='classDetail'>"+
						"<div class='left' style='width:60px;'><span>个人介绍：</span></div><div style='float:right;width:630px;'>"+value.introduction+"...[<a  target='_blank' href='viewTeacher.jsp?id="+value.teacherId+"'>详细内容</a>]</div></div></div>"+
						"<div class='clear'></div>";
					});
					//alert("valueStr " + valueStr);
					if(valueStr == ""){
						valueStr = "<div class='notice'>未搜索到相关讲师信息</div>";
					}else
					$('#pageDiv').css('display','block');
					$('#classes').html(valueStr);
					$('#pages').html(pages);
					$('#currPage').html(1);
					}
			});
		}

		var cache = {};
		//
		//			jsonp: "json.wrf",
		//url: "http://localhost:8080/solr/core_keyword/select",
		$( "#searchWord" ).autocomplete({
			minLength: 1,
			source: function(request, response) {
				$.ajax({
					url: "struts/Search_queryTeacherTip",
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
							}
						}));
					}
				});
			}
		});
	});
	</script>

</head>

<script>
function search(page){
	var key = $('#searchWord').val();
	$.ajax({
		url:"struts/Search_queryTeacherBySolr?page="+page+"&rows=10&key="+key,
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
					//alert("schedules="+schedules);
					valueStr += "<div  class='"+outClass+"'><h3><a target='_blank'  href='teacherClass.jsp?type=1&id"+value.teacherId+"'>"+value.realName+"</a></h3>"+
					"<div class='classInfor'>编号："+value.teacherId+"&nbsp;&nbsp;主讲类别："+value.majorCatgory+"&nbsp;&nbsp;擅长："+value.expertIn+"</div>"+
					"<div class='classDetail'>"+
					"<div class='left' style='width:60px;'><span>个人介绍：</span></div><div style='float:right;width:630px;'>"+value.introduction+"...[<a  target='_blank' href='viewTeacher.jsp?id="+value.teacherId+"'>详细内容</a>]</div></div></div>"+
					"<div class='clear'></div>";
				});
				//alert("valueStr " + valueStr);
				if(valueStr == ""){
					valueStr = "<div class='notice'>未搜索到相关讲师信息</div>";
				}else
				$('#pageDiv').css('display','block');
				$('#classes').html(valueStr);
				$('#pages').html(pages);
				$('#currPage').html(parseInt(page));
			}
		});
}

var pager = {
	'test':function(){
		alert('1');
	},
	'seeNext':function(){
		var currPage = parseInt($('#currPage').html());
		var pages = parseInt($('#pages').html());
		if(currPage +1 >= pages)
			search(pages);
		else
			search(currPage);
	},
	'seePre':function(){
		var currPage = parseInt($('#currPage').html());
		if(currPage-1 > 0)
			search(currPage-1);
		else
			search(1);
	},
	'seeFirst':function(){
		search(1);
	},
	'seeLast':function(){
		var pages = $('#pages').html();
		search(pages);
	},
	'jump':function(){
		if($('#jump').val() == ''){
			alert('请输入页码！');
			return false;
		}
		var jumpTo = parseInt($('#jump').val());
		var allPages = parseInt($('#pages').html());
		if(jumpTo <=0 || jumpTo> allPages){
			alert('页码范围不正确！');
			return false;
		}
		search(jumpTo);
	}
};
</script>
<body>
	<jsp:include page="head.jsp" flush="true"/>
	<!--当前路径 start-->
	<div class="mainContent path">
		<ul>
			<li>当前位置:&nbsp;</li>
			<li><a href="index.jsp" target="_self">首页</a></li>
			<li class="bread">&gt;&gt;</li>
			<li>搜索结果</li>
		</ul>
		<div class="clear"></div>
	</div>
	<!--当前路径 end-->

	<!--<div class="ui-widget">
		<input id="searchWord" class="input_txt border_radius" name="searchWord"/>
		<button type="button" class="formBtn"
		onclick="search(1);">
		<img src="images/7.gif"> 搜索
	</button>
</div> -->

	<div class="mainContent search">
		<div class="rightContent">
			<input type="hidden" value="pxs" id="search_type" NAME="search_type">
			<div  id="searchTab"  class="searchType">
				<ul>
					<li id="searchTab_Title0" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='qypx';"><a href='javascript:void(0)' >企业培训</a></li>
					<li id="searchTab_Title1" class="on" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='pxs';"><a href='javascript:void(0)'>培训师</a></li>
					<li id="searchTab_Title2" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='pxjh';"><a href='javascript:void(0)'>培训计划</a></li>
					<li id="searchTab_Title3" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='qynx';"><a href='javascript:void(0)'>企业内训</a></li>
					<!-- <li id="searchTab_Title4" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='nxs';"><a href='javascript:void(0)'>内训师</a></li> -->
					<li id="searchTab_Title5" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='nxsp';"><a href='javascript:void(0)'>内训视频</a></li>
					<li id="searchTab_Title6" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='xz';"><a href='javascript:void(0)'>下载</a></li>
					<li id="searchTab_Title7" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='wk';"><a href='javascript:void(0)'>文库</a></li>
					<li id="searchTab_Title8" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='jg';"><a href='javascript:void(0)'>机构</a></li>
					<li id="searchTab_Title9" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='wd';"><a href='javascript:void(0)'>问答</a></li>
					<li id="searchTab_Title10" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='khpj'"><a href='javascript:void(0)'>客户评价</a></li>
					<li id="searchTab_Title11" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='khq';"><a href='javascript:void(0)'>客户群</a></li>
				</ul>
			</div>
		</div>
		<div class="clear"></div>
		<div class="searchInput"><input style='width:830px;' id="searchWord" value="请输入关键字,如: 员工 管理" onfocus="if (this.value=='请输入关键字,如: 员工 管理'){this.value='';}" 
		onblur="if (this.value==''){this.value='请输入关键字,如: 员工 管理';}" onkeydown="fnt_top_search2(event);" />
		<button class="searchButton"  onclick="fnt_top_search(document.getElementById('search_type').value);">搜&nbsp;索</button></div>
	</div>


<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<div id="classes"></div>
		<!--课程介绍 end-->
		<div class="resultFoot" id="pageDiv" style='display:none'>
			<a href="javascript:void(0)" onclick="javascript:pager.seeFirst();">第一页</a>			
			<a href="javascript:void(0)" onclick="javascript:pager.seePre();">上一页</a>				
			<a href="javascript:void(0)" onclick="javascript:pager.seeNext();">下一页</a>
			<a href="javascript:void(0)" onclick="javascript:pager.seeLast();">最后一页</a>
			&nbsp;&nbsp;跳转至<input id="jump"/>页&nbsp;<button style="height:22px;" onclick="javascript:pager.jump();">跳转</button>,当前是第<span id="currPage"></span>页,共<span id="pages">60</span>页
		</div>
		<div class="clear"></div>
	</div>
	<!--右边部分 start-->
	<div class="rightInPart">
		<!--热门培训 培训计划 培训下载 start-->
		<div class="sortList">
			<div class="head">
				<div class="tabOn half">深圳培训排行</div>
				<div class="tabOff half">本月最热</div>
				<div class="clear"></div>
			</div>
			<div class="bg h315" style="padding:0px 15px 4px 15px;">
				<ul class="list7" style="padding-top:10px">
					<li class="line"><a><span class="red">1</span>企业资本运作与投融资顾问</a></li>
					<li  class="line"><a><span class="red">2</span>企业资本运作与投融资顾问</a></li>
					<li class="line"><a><span class="blue">3</span>企业资本运作与投融资顾问</a></li>
					<li class="line"><a><span class="blue">4</span>企业资本运作与投融资顾问</a></li>
					<li class="line"><a><span class="blue">5</span>企业资本运作与投融资顾问</a></li>
				</ul>
				<div class="clear"></div>
			</div>
		</div>
		<!--热门培训 培训计划 培训下载 end-->
		<!--企业培训师 start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher" >
			<h5 class=" first">深圳培训师</h5>
			<div style="padding-left:15px;padding-bottom:10px">
				<img  src="images/824.jpg" style="height:50px;width:40px" class="left"/>
				<dl class="left">
					<dt>王麻子</dt>
					<dd>擅长人力资源以及薪酬制度等</dd>
				</dl>
				<div class="clear"></div>
				<img  src="images/824.jpg" style="height:50px;width:40px" class="left"/>
				<dl class="left">
					<dt>王麻子</dt>
					<dd>擅长人力资源以及薪酬制度等</dd>
				</dl>
				<div class="clear"></div>
				<img  src="images/824.jpg" style="height:50px;width:40px" class="left"/>
				<dl class="left">
					<dt>王麻子</dt>
					<dd>擅长人力资源以及薪酬制度等</dd>
				</dl>
				<div class="clear"></div>
				<img  src="images/824.jpg" style="height:50px;width:40px" class="left"/>
				<dl class="left">
					<dt>王麻子</dt>
					<dd>擅长人力资源以及薪酬制度等</dd>
				</dl>
				<div class="clear"></div>
				<h4>名字热搜</h4>
				<ul class="teacher">
					<li><a href="#">刘强</a></li>
					<li><a href="#">张三</a></li>
					<li><a href="#">刘强</a></li>
					<li><a href="#">张三</a></li>
					<li><a href="#">刘强</a></li>
					<li><a href="#">张三</a></li>
					<li><a href="#">刘强</a></li>
					<li><a href="#">张三</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<h5>深圳培训机构</h5>
			<ul class="list7" style="padding-top:10px;padding-left:15px;">
				<li class="line"><a><span class="red">1</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="red">2</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">3</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="blue">4</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">5</span><span class="text">众行机构</span></a></li>
			</ul>
			<div class="clear" style="height:10px"></div>
		</div>
		<!--企业培训动态 start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
			<h5  class="first">深圳培训动态</h5>
			<div style="padding:0px 0px 10px 15px;height:140px">
				<marquee  direction="up" scrollamount="3" behavior="scroll" class="lasted" height="150px" onmouseover="this.stop();" onMouseOut="this.start()">
					<ul class="list5" style="width:230px;">
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
						<li><a class="left">广州TCL集团2013年4月1日余...</a></li>
					</ul>
				</marquee>
				<div class="clear"></div>
			</div>
			<h5>深圳培训问答</h5>
			<div class="inQuesiton">	
				<dl>
					<dd><a href="#">如何解除劳动合同?</a></dd>
					<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
					<dd><a href="#">如何分配股权?</a></dd>
					<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
					<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
					<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
				</dl>
			</div>
		</div>
		
		<!--企业培训动态end-->
	</div>
	
	<!--右边部分 end-->
	<div class="clear">
		
		
	</div>
</div>
<!--主体部分二 end-->
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>
