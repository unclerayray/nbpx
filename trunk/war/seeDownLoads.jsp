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
						valueStr +="<li class='line'><a href='struts/Download_downLoadFile?downloadId="+value.downloadId+"'><span class='red'>"+(n+1)+"</span><span class='text tooLong w150'>"+value.title+" </span><span class='count'>"+value.downloadCnt+"</span></a><div class='clear'></div></li>";
					else
						valueStr +="<li class='line'><a href='struts/Download_downLoadFile?downloadId="+value.downloadId+"'><span class='blue'>"+(n+1)+"</span><span class='text tooLong w150'>"+value.title+"</span><span class='count'>"+value.downloadCnt+"</span></a><div class='clear'></div></li>";
				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>没有下载记录</div>";
				}
				$('#hotDownload').html(valueStr);
			}
		})
	}
	//加载下载列表，按照时间顺序
	function getDownLoads(page){

		$.ajax({
			url:"struts/Download_queryDownloads?page="+page+"&rows=30" ,
			success:function(data){
		
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var total = jsonObject.total;
				var rows = jsonObject.rows;
	
				$.each(rows,function(n,value){
					valueStr += "<li style='border-bottom:1px dashed #ccc;width:95%'>"+value.title+"<span><a href='seeDownLoadsDetail.jsp?id="+value.downloadId+"'>查看</a></span></li>";
				});

				if(valueStr == ""){
					valueStr = "<div class='notice'>未搜索到相关下载信息</div>";
				}

				$('#dContents').html(valueStr);
				$('#coursePagesDiv').css('display','block');
				$('#coursePages').html(parseInt(total/30)+1);
				$('#courseCurrPage').html(parseInt(page));
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
					<ul class="list11" id="dContents" style="font-size:12px">	
					</ul>
					
					</div>
				
					<!--课程介绍 end-->
					<div class="resultFoot" id="coursePagesDiv" style='display:none;padding-top:20px'>
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