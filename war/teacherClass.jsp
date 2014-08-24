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
<%
	//String type= request.getParameter("type");
	String teacherID = request.getParameter("id");
	//String front = "企业培训师";
	String frontUrl = "teacherPX.jsp";
	/*if("2".equals(type))
	{
		front = "企业内训师";
		frontUrl = "teacherNX.jsp";
	}*/
%>
</head>
<script>
	$(function(){
		//加载讲师信息
		loadTeacherInfo();
		//加载培训课程
		loadPXClass(1);
		//加载内训课程
		loadNXClass(1);
		//加载热门关键词
		loadHotKeyWord();
		//加载热门专题
		loadHotSubjects();
	});
	function loadTeacherInfo(){
		$.ajax({
			url:"struts/TeacherInfo_getTeacherInforByTeacherId?teacherID="+$('#teacherID').val(),
			success:function(data){
				var jsonObject = eval('('+data+')');
				$('#name').html(jsonObject.realName);
				$('#money').html(jsonObject.externalPayment == 0?"面议":(jsonObject.externalPayment+"元"));
				$('#expectIn').html(jsonObject.expertIn);
				$('#teacherDesc').html(jsonObject.introduction);
				$('#tel').html(jsonObject.cellphone);
				if(jsonObject.photo != "" && jsonObject.photo != undefined)
					$('#pic').html("<img src='"+jsonObject.photo+"' />");
				else
					$('#pic').html("<img src='images/824.jpg' />");
			}
		});
	}
	
	function loadPXClass(page){
		$.ajax({
			url:"struts/TeacherInfo_getCourseByTeacher?type=1&page="+page+"&rows=10&teacherID="+$('#teacherID').val(),
			success:function(data){
				var valueStr = "";
				if(data != ""){
					//alert(1);
					var jsonObject = eval('('+data+')');
					var pages = jsonObject.pages;
					var rows = jsonObject.rows;
					$.each(rows,function(n,value){
						valueStr +="<div  class='classDesc' style='width:680px'>"+
								   "<h3><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></h3>"+
						           "<div class='classInfor'>培训费用：￥"+value.price+"&nbsp;&nbsp;编号："+value.id+"</div>"+
								   "<div class='classDetail'>"+
								   "<div class='left' style='width:60px;'><span>培训内容：</span></div><div style='float:right;width:610px;'>"+value.content+"...<a href='viewClass.jsp?id="+value.id+"'>[详细内容]</a></div></div>"+
								   "<div class='clear'></div>"+
								   "</div>";
					});

					$('#coursePages').html(pages);
					$('#courseCurrPage').html(page);
				}
				//alert(valueStr);
				if(valueStr == ""){
					valueStr = "<div class='notice'>暂时没有任何课程信息</div>";
					$('#coursePagesDiv').css('display','none');
				}else
					$('#coursePagesDiv').css('display','block');
				$('#classes').html(valueStr);
			}
		});
	}
	function loadNXClass(page){
		$.ajax({
			url:"struts/TeacherInfo_getCourseByTeacher?type=2&page="+page+"&rows=10&teacherID="+$('#teacherID').val(),
			success:function(data){
				var valueStr = "";
				if(data != ""){
					//alert(1);
					var jsonObject = eval('('+data+')');
					var pages = jsonObject.pages;
					var rows = jsonObject.rows;
					$.each(rows,function(n,value){
						valueStr +="<div  class='classDesc' style='width:680px'>"+
								   "<h3><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></h3>"+
						           "<div class='classInfor'>培训费用：面议&nbsp;&nbsp;编号："+value.id+"</div>"+
								   "<div class='classDetail'>"+
								   "<div class='left' style='width:60px;'><span>培训内容：</span></div><div style='float:right;width:610px;'>"+value.content+"...<a href='viewClass.jsp?id="+value.id+"'>[详细内容]</a></div></div>"+
								   "<div class='clear'></div>"+
								   "</div>";
					});

					$('#coursePagesNX').html(pages);
					$('#courseCurrPageNX').html(page);
				}
				//alert(valueStr);
				if(valueStr == ""){
					valueStr = "<div class='notice'>暂时没有任何课程信息</div>";
					$('#coursePagesDivNX').css('display','none');
				}else
					$('#coursePagesDivNX').css('display','block');
				$('#classesNX').html(valueStr);
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
					loadPXClass(pages);
				else
					loadPXClass(currPage+1);
			},
			'seePre':function(){
				var currPage = parseInt($('#courseCurrPage').html());
				//alert(currPage);
				if(currPage-1 > 0)
					loadPXClass(currPage-1);
				else
					loadPXClass(1);
			},
			'seeFirst':function(){
				loadPXClass(1);
			},
			'seeLast':function(){
				var pages = $('#coursePages').html();
				loadPXClass(pages);
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
				loadPXClass(jumpTo);
			}
		};
	var pagerNX = {
			'test':function(){
				alert('1');
			},
			'seeNext':function(){
				var currPage = parseInt($('#courseCurrPageNX').html());
				var pages = parseInt($('#coursePagesNX').html());
				if(currPage +1 >= pages)
					loadNXClass(pages);
				else
					loadNXClass(currPage+1);
			},
			'seePre':function(){
				var currPage = parseInt($('#courseCurrPageNX').html());
				//alert(currPage);
				if(currPage-1 > 0)
					loadNXClass(currPage-1);
				else
					loadNXClass(1);
			},
			'seeFirst':function(){
				loadNXClass(1);
			},
			'seeLast':function(){
				var pages = $('#coursePagesNX').html();
				loadNXClass(pages);
			},
			'jump':function(){
				if($('#jumpNX').val() == ''){
					alert('请输入页码！');
					return false;
				}
				var jumpTo = parseInt($('#jumpNX').val());
				var allPages = parseInt($('#coursePagesNX').html());
				if(jumpTo <=0 || jumpTo> allPages){
					alert('页码范围不正确！');
					return false;
				}
				loadNXClass(jumpTo);
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
		<li>讲师课程</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<input type='hidden' id="teacherID" value='<%=teacherID%>'/>
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart" id="leftPart">
		<div class="resultPart">
			<h2>讲师介绍</h2>
			<div class="resultContent">
			<div class="teacherList" style="border:none">
			<ul>
			<li id="pic"><img src='images/824.jpg'></li>
			<li>
				<div style="width:550px;padding-top:10px;">
					<table>
					<tr><td colspan='2' width="250px"><h3 class='th3' id="name"></h3></td><td width="60px">邀请费用:</td><td align="left"><span id="money"></span></td></tr>
					<tr><td width="60px">擅长领域:</td><td align="left"><span id="expectIn"></span></td><td width="60px">联系方式:</td><td align="left"><span id="tel">13640713242</span></td></tr>
					<tr><td valign="top">个人简介:</td><td align="left" colspan="3"  valign="top" style="line-height:18px"><span id="teacherDesc"></span></td></tr>
					</table>
				</div>
			</li>
			</ul>
			<div class='clear'></div>
			</div>
			</div>
		</div>
		<br>
		<div class="resultPart">
			<h2>培训课程</h2>
			<div class="resultContent">
					<div id="classes">
		<!--课程介绍 start-->
			<div  class="classDesc" style="width:680px">
				<h3>企业培训体系设计</h3>
				<div class="classInfor">培训时间：2013-0-20&nbsp;&nbsp;培训天数：2天&nbsp;&nbsp;培训地点：深圳&nbsp;&nbsp;培训费用：￥3500&nbsp;&nbsp;编号：1234</div>
				<div class="classDetail">
					<div class="left" style="width:60px;"><span>培训内容：</span></div><div style="float:right;width:610px;">使参训人员了解企业架构与IT战略规划全套流程与方法，通过案例学习相关架构工具Togaf9.0，认识到架构方法在信息化规划中的重要性，了解企业架构中的核心理念与实践方法，掌握业务架构、应用架构、技术架构...<a href="#">[详细内容]</a></div></div>
					<div class="clear"></div>
			</div>

			<div  class="classDesc" style="width:680px">
				<h3>企业培训体系设计</h3>
				<div class="classInfor">培训时间：2013-0-20&nbsp;&nbsp;培训天数：2天&nbsp;&nbsp;培训地点：深圳&nbsp;&nbsp;培训费用：￥3500&nbsp;&nbsp;编号：1234</div>
				<div class="classDetail">
					<div class="left" style="width:60px;"><span>培训内容：</span></div><div style="float:right;width:610px;">使参训人员了解企业架构与IT战略规划全套流程与方法，通过案例学习相关架构工具Togaf9.0，认识到架构方法在信息化规划中的重要性，了解企业架构中的核心理念与实践方法，掌握业务架构、应用架构、技术架构...<a href="#">[详细内容]</a></div></div>
					<div class="clear"></div>
			</div>
			<!--课程介绍 end-->
			</div>
			
			<div class="resultFoot" id="coursePagesDiv" style='padding-top:20px'>
						<a href="javascript:void(0)" onclick="javascript:pager.seeFirst();">第一页</a>			
						<a href="javascript:void(0)" onclick="javascript:pager.seePre();">上一页</a>				
						<a href="javascript:void(0)" onclick="javascript:pager.seeNext();">下一页</a>
						<a href="javascript:void(0)" onclick="javascript:pager.seeLast();">最后一页</a>
						&nbsp;&nbsp;跳转至<input id="jump"/>页&nbsp;<button style="height:22px;" onclick="javascript:pager.jump();">跳转</button>,当前是第<span id="courseCurrPage"></span>页,共<span id="coursePages">60</span>页
					</div>
			<div class="clear"></div>
			</div>
		</div>
		<br>
		<div class="resultPart">
			<h2>内训课程</h2>
			<div class="resultContent">
				<div id="classesNX">
		<!--课程介绍 start-->
			<div  class="classDesc" style="width:680px">
				<h3>企业培训体系设计</h3>
				<div class="classInfor">培训费用：面议&nbsp;&nbsp;编号：1234</div>
				<div class="classDetail">
					<div class="left" style="width:60px;"><span>培训内容：</span></div><div style="float:right;width:610px;">使参训人员了解企业架构与IT战略规划全套流程与方法，通过案例学习相关架构工具Togaf9.0，认识到架构方法在信息化规划中的重要性，了解企业架构中的核心理念与实践方法，掌握业务架构、应用架构、技术架构...<a href="#">[详细内容]</a></div></div>
					<div class="clear"></div>
			</div>

			<div  class="classDesc" style="width:680px">
				<h3>企业培训体系设计</h3>
				<div class="classInfor">培训费用：面议&nbsp;&nbsp;编号：1234</div>
				<div class="classDetail">
					<div class="left" style="width:60px;"><span>培训内容：</span></div><div style="float:right;width:610px;">使参训人员了解企业架构与IT战略规划全套流程与方法，通过案例学习相关架构工具Togaf9.0，认识到架构方法在信息化规划中的重要性，了解企业架构中的核心理念与实践方法，掌握业务架构、应用架构、技术架构...<a href="#">[详细内容]</a></div></div>
					<div class="clear"></div>
			</div>
			<!--课程介绍 end-->
			</div>
			
			<div class="resultFoot" id="coursePagesNXDiv" style='padding-top:20px'>
						<a href="javascript:void(0)" onclick="javascript:pagerNX.seeFirst();">第一页</a>			
						<a href="javascript:void(0)" onclick="javascript:pagerNX.seePre();">上一页</a>				
						<a href="javascript:void(0)" onclick="javascript:pagerNX.seeNext();">下一页</a>
						<a href="javascript:void(0)" onclick="javascript:pagerNX.seeLast();">最后一页</a>
						&nbsp;&nbsp;跳转至<input id="jumpNX"/>页&nbsp;<button style="height:22px;" onclick="javascript:pagerNX.jump();">跳转</button>,当前是第<span id="courseCurrPageNX"></span>页,共<span id="coursePagesNX">60</span>页
					</div>
			<div class="clear"></div>
			</div>
		</div>
		
		
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