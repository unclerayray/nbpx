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
		loadTeachers(1);
		//加载热门关键词
		loadHotKeyWord();
		//加载热门专题
		loadHotSubjects()
	});
	function loadTeachers(page){
		$.ajax({
			url:"struts/TeacherInfo_getTeacherList?page="+page+"&rows=10",
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var pages = jsonObject.total;
				if(pages == 0)
					pages=0;
				else
					pages = parseInt(pages/10) + 1;

				var rows = jsonObject.rows;
				$.each(rows,function(n,value){
					valueStr += "<div class='teacherList'><ul >"+
								"<li><img src='"+value.photo+"'></li>"+
								"<li>"+
								"<div style='width:600px;padding-top:10px'>"+
								"<table>"+
								"<tr><td colspan='2'><h3 class='th3'><a href='teacherClass.jsp?id="+value.teacherId+"'>"+value.realName+"</a></h3></td><td width='60px'>邀请费用:</td><td align='left'>"+(value.externalPayment == 0?"面议":value.externalPayment)+"</td></tr>"+
								"<tr><td width='60px'>擅长领域:</td><td align='left' width='180px'>"+(value.expertIn == undefined?"暂无介绍":value.expertIn)+"</td><td width='60px'>联系方式:</td><td align='left'>"+(value.cellphone == undefined?"暂无联系方式":value.cellphone)+"</td></tr>"+
								"<tr><td valign='top'>个人简介:</td><td valign='top' align='left' colspan='3'><span class='tooLong' style='width:500px;display:block'>"+(value.introduction == undefined?"暂无介绍":value.introduction)+"</span></td></tr>"+
								"</table>"+
								"</div>"+
								"</li>"+
								"</ul>"+
								"<div class='clear'></div></div>";
				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>暂时没有任何讲师信息</div>";
				}else
					$('#coursePagesDiv').css('display','block');
				$('#classes').html(valueStr);
				$('#coursePages').html(pages);
				$('#courseCurrPage').html(page);
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
					valueStr = "<div class='notice'>暂时没有关键词信息</div>";
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
					valueStr = "<div class='notice'>暂时没有专题信息</div>";
				$('#hotSubjects').html(valueStr);
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
					loadTeachers(pages);
				else
					loadTeachers(currPage+1);
			},
			'seePre':function(){
				var currPage = parseInt($('#courseCurrPage').html());
				//alert(currPage);
				if(currPage-1 > 0)
					loadTeachers(currPage-1);
				else
					loadTeachers(1);
			},
			'seeFirst':function(){
				loadTeachers(1);
			},
			'seeLast':function(){
				var pages = $('#coursePages').html();
				loadTeachers(pages);
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
				loadTeachers(jumpTo);
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
		<li>企业讲师</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart" id="leftPart">
		<div id="classes">
		<!--课程介绍 start-->
		<div class="teacherList">
			<ul >
			<li><img src='images/824.jpg'></li>
			<li>
				<div style="width:600px;padding-top:10px;">
					<table>
					<tr><td colspan='2' width="250px"><h3 class='th3'>讲师1</h3></td><td width="60px">邀请费用:</td><td align="left">1000元</td></tr>
					<tr><td width="60px">擅长领域:</td><td align="left">xxx</td><td width="60px">联系方式:</td><td align="left">13640713242</td></tr>
					<tr><td>个人简介:</td><td align="left" colspan="3"><span class="tooLong" style="width:500px;display:block">哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈</span></td></tr>
					</table>
				</div>
			</li>
			</ul>
			<div class='clear'></div>
			</div>
			
			<div class="teacherList">
			<ul >
			<li><img src='images/824.jpg'></li>
			<li>
				<div style="width:600px;padding-top:10px;">
					<table>
					<tr><td colspan='2' width="250px"><h3 class='th3'>讲师1</h3></td><td width="60px">邀请费用:</td><td align="left">1000元</td></tr>
					<tr><td width="60px">擅长领域:</td><td align="left">xxx</td><td width="60px">联系方式:</td><td align="left">13640713242</td></tr>
					<tr><td>个人简介:</td><td align="left" colspan="3"><span class="tooLong" style="width:500px;display:block">哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈哈哈哈啊哈</span></td></tr>
					</table>
				</div>
			</li>
			</ul>
			<div class='clear'></div>
			</div>
		<!--课程介绍 end-->
		</div>
		<div class="resultFoot" id="coursePagesDiv" style='display:none;padding-top:20px'>
						<a href="javascript:void(0)" onclick="javascript:pager.seeFirst();">第一页</a>			
						<a href="javascript:void(0)" onclick="javascript:pager.seePre();">上一页</a>				
						<a href="javascript:void(0)" onclick="javascript:pager.seeNext();">下一页</a>
						<a href="javascript:void(0)" onclick="javascript:pager.seeLast();">最后一页</a>
						&nbsp;&nbsp;跳转至<input id="jump"/>页&nbsp;<button style="height:22px;" onclick="javascript:pager.jump();">跳转</button>,当前是第<span id="courseCurrPage"></span>页,共<span id="coursePages">60</span>页
					</div>
		<div class="clear"></div>
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