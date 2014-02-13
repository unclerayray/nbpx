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
		//加载热门下载
		//getHotDownLoads();
		//加载相关课程
		getDownLoads(1);
	})
	//加载热门下载
	function getHotDownLoads(){
		$.ajax({
			url:encodeURI("struts/SeeKeyword_getRelatedKeys?key="+condition),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href=\"seeKey.jsp?key="+value.keyword+"\">"+value.keyword+"</a></li>";
				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>没有相关的关键字</div>";
				}
				$('#relatedKeywords').html(valueStr);
			}
		})
	}
	//加载下载列表，按照时间顺序
	function getDownLoads(page){

		$.ajax({
			url:"struts/Download_queryDownloads?page="+page+"&rows=20" ,
			success:function(data){
				alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var pages = jsonObject.pages;
				var rows = jsonObject.rows;
				//alert("rows = " + rows);
				$.each(rows,function(n,value){
					
				});
					//alert("valueStr " + valueStr);
				if(valueStr == ""){
					valueStr = "<div class='notice'>未搜索到相关课程信息</div>";
				}
				//$('#coursePagesDiv').css('display','block');
				//$('#classes').html(valueStr);
				//$('#coursePages').html(pages);
				//$('#courseCurrPage').html(parseInt(page));
			}
		});
	}

	var pager = {
		'test':function(){
			alert('1');
		},
		'seeNext':function(){
			var currPage = parseInt($('#courseCurrPage').html());
			var pages = parseInt($('#coursePages').html());
			if(currPage +1 >= pages)
				getDownLoads(pages);
			else
				getDownLoads(currPage+1);
		},
		'seePre':function(){
			var currPage = parseInt($('#courseCurrPage').html());
			if(currPage-1 > 0)
				getDownLoads(currPage-1);
			else
				getDownLoads(1);
		},
		'seeFirst':function(){
			getDownLoads(1);
		},
		'seeLast':function(){
			var pages = $('#coursePages').html();
			getDownLoads(pages);
		},
		'jump':function(){
			if($('#jump').val() == ''){
				alert('请输入页码！');
				return false;
			}
			var jumpTo = parseInt($('#jump').val());
			var allPages = parseInt($('#coursePages').html());
			if(jumpTo <=0 || jumpTo> allPages){
				alert('页码范围不正确！');
				return false;
			}
			getDownLoads(jumpTo);
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
		<li>培训下载</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<!--最新的下载 start-->
		<div class="resultPart">
			<h2>最新培训资料下载</h2>
			<div class="resultContent">
					<div id="downloads">
					<ul class="list11">
						<li><a>财务人员必须掌握的28个Excel</a><span><a href="#">下载</a></span></li>
						<li><a>财务人员必须掌握的28个Excel</a><span><a href="#">下载</a></span></li>
						
					</ul>
					
					
					</div>
					<!--课程介绍 end-->
					<div class="resultFoot" id="coursePagesDiv" style='display:none'>
						<a href="javascript:void(0)" onclick="javascript:pager.seeFirst();">第一页</a>			
						<a href="javascript:void(0)" onclick="javascript:pager.seePre();">上一页</a>				
						<a href="javascript:void(0)" onclick="javascript:pager.seeNext();">下一页</a>
						<a href="javascript:void(0)" onclick="javascript:pager.seeLast();">最后一页</a>
						&nbsp;&nbsp;跳转至<input id="jump"/>页&nbsp;<button style="height:22px;" onclick="javascript:pager.jump();">跳转</button>,当前是第<span id="courseCurrPage"></span>页,共<span id="coursePages">60</span>页
					</div>
					<div class="clear" style="height:10px"></div>
			</div>
		</div>
		<!--消费者相关企业培训 end-->	
		
	</div>
	<!--右边部分 start-->
	<div class="rightInPart">
		<!--培训关键词 start-->	
		<div class="rightTeacher">
				<h5  class="first">热门下载</h5>
				<div class="bg" style="padding:0px 0px 4px 0px;border:none;height:280px"/>
					<div class="clear" style="height:0px"></div>
					<dl class="bestCustomer leftPart left" style="width:110px;">
						<dd><a href="#">消费者培训</a></dd>
						<dd><a href="#">消费者市场</a></dd>
						<dd><a href="#">消费者行为</a></dd>
						<dd><a href="#">大众消费</a></dd>
						<dd><a href="#">消费市场</a></dd>
						<dd><a href="#">投诉处理流程</a></dd>
						<dd><a href="#">团队培训</a></dd>
						<dd><a href="#">客户服务</a></dd>
						<dd><a href="#">投诉处理流程</a></dd>
						<dd><a href="#">客户服务</a></dd>
						<dd><a href="#">投诉处理流程</a></dd>
					</dl>
					<dl class="bestCustomer rightPart right" style="width:130px;">
						<dd><a href="#">绩效考核</a></dd>
						<dd><a href="#">新社会保险法</a></dd>
						<dd><a href="#">员工关系管理</a></dd>
						<dd><a href="#">风险管理</a></dd>
						<dd><a href="#">目标管理</a></dd>
						<dd><a href="#">商务考察</a></dd>
						<dd><a href="#">经理人培训</a></dd>
						<dd><a href="#">绩效考核</a></dd>
						<dd><a href="#">新社会保险法</a></dd>
						<dd><a href="#">绩效考核</a></dd>
						<dd><a href="#">新社会保险法</a></dd>
					</dl>
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