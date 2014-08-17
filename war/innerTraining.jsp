<%@ page language="java" contentType="text/html; charset=utf-8" import="java.util.*"
    pageEncoding="utf-8"%>
   <%
   int currYear = 2013;
   int nextYear = currYear+1;
   
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link type="text/css" href="css/face.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="js/nav/goodnav.css">

<script src="js/easyui/jquery-1.8.0.min.js"></script>
<script src="js/easyui/jquery.easyui.min.js"></script>
<script src="js/nav/jquery.litenav.js"></script>
<style>
	h6{
		padding:0px;margin:0px;line-height:30px
	}
	
</style>
<title>企业内训</title>
</head>
<script>
	$(function(){
		//加载行业，专业等数据
		for(var i=1;i<=4;i++)
			seePartTab('a',1,i);
		//加载高端课程
		for(var i=1;i<=6;i++)
			seePartTab('b',1,i);
		//加载经典课程
		loadClassicCourse();
		//加载热门课程
		loadHotCourse();
		//加载课程种类
		for(var i=1;i<=4;i++)
			loadCourseType(i);
		//加载相关关键词
		loadKeyWords();
		//加载相关专题
		loadSubjects();
		//加载问题
		loadQuestion();
		//加载讲师
		loadTeachers();
		//加载培训机构
		loadPXOrg();
		//加载热门文章
		loadHotArticle();
		//加载推荐文章
		loadRecommandArticle();
		loadCustomer();
	});
	//加载典型客户
	function loadCustomer(){
		$.ajax({
				url: 'struts/ViewDic_getMoreDicItems?codeName=005&rows=7&page=1',
				success:function(data){
					//alert(data);
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject.rows,function(n,value){
						valueStr += "<dd><a class='left tooLong w230' href=\"seeKey.jsp?key="+value.showName+"\">"+value.showName+"</a></dd>";
					});
		
					if(valueStr == "")
						valueStr ="<div class='notice'>暂时没有客户信息</div>";

					$('#customer').html(valueStr);
				}
		});
	}
	//加载热门文章
	function loadHotArticle(){
		$.ajax({
			url:encodeURI("struts/ViewArticle_getHotArticle"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					if(n<6){
						if(n%2 ==0)
							valueStr += "<li><a href='viewArticle?id="+value.id+"' class='text tooLong w150'>"+value.title+"</a></li>";
						else
							valueStr += "<li class='noMargin'><a href='viewArticle?id="+value.id+"' class='text tooLong w150'>"+value.title+"</a></li>";
					}
				});
				$('#hotArticle').html(valueStr);
			}
		})
	}
	//加载推荐文章
	function loadRecommandArticle(){
		$.ajax({
			url:encodeURI("struts/ViewArticle_getRecommandArticle"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var topStr = "";
				$.each(jsonObject,function(n,value){
					if(n ==0){
						topStr += "<div class='inNews'>"+
								  "<h2><a href='viewArticle?id="+value.id+"' class='text tooLong w150'>"+value.title+"</a></h2>"+
								  "<p>"+value.content+"...</p>"+
								  "</div>";
		
					}
					if(n == 1){
						topStr += "<div class='inNews none'>"+
								  "<h2><a href='viewArticle?id="+value.id+"' class='text tooLong w150'>"+value.title+"</a></h2>"+
								  "<p>"+value.content+"...</p>"+
								  "</div>";
		
					}
					if(n<8 && n>=2){
						if(n%2 ==0)
							valueStr += "<li><a href='viewArticle?id="+value.id+"' class='text tooLong w150'>"+value.title+"</a></li>";
						else
							valueStr += "<li class='noMargin'><a href='viewArticle?id="+value.id+"' class='text tooLong w150'>"+value.title+"</a></li>";
					}
				});
				$('#topArticle').html(topStr);
				$('#recommondArticel').html(valueStr);
			}
		})
	}
	
	//加载培训机构
	function loadPXOrg(){
		$.ajax({
			url:"struts/OrgInfo_getOrgList?page=1&rows=5",
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr = "";

				var rows = jsonObject.rows;
				$.each(rows,function(n,value){
					if(n<2)
						valueStr += "<li class='line'><a  href='orgView.jsp?id="+value.orgId+"'><span class='red'>"+(n+1)+"</span><span class='text'>"+value.orgName+"</span></a></li>";
					else
						valueStr += "<li class='line'><a href='orgView.jsp?id="+value.orgId+"'><span class='blue'>"+(n+1)+"</span><span class='text'>"+value.orgName+"</span></a></li>";

				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>暂时没有机构信息</div>";
				}
				
				$('#PXOrgs').html(valueStr);
			}
		});
	}
	//加载讲师信息
	function loadTeachers(){
		$.ajax({
			url:"struts/Main_getTeachers?page=1&rows=5&flag="+flag,
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr += "<div class='teacherListP'>"+
								"<h6><a href='teacherClass.jsp?type="+flag+"&id="+value.teacherId+"'>"+value.realName+"</a></h6>"+
								"<div class='listDesc'><span>擅长领域:</span><span class='tooLong' style='display:block;width:170px;float:right;'>"+(value.expertIn == undefined?"暂无介绍":value.expertIn)+"</span></div>"+
								"</div>";
				});
				if(valueStr == "")
					valueStr ="<div class='notice'>暂时没有讲师信息</div>";
				$('#teacherPart').html(valueStr);
			}
		});
	}
	
	//加载问题
	function loadQuestion(){
		var urlStr = 'struts/Wenda_queryQuestions?rows=6&page=1';
		
		$.ajax({
			url:encodeURI(urlStr),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var lines = jsonObject.rows;
				var total = jsonObject.total;
				var valueStr = "";
				$.each(lines,function(n,value){
					if(n<6)
						valueStr += "<dd><a class='tooLong' style='width:200px;display:block' href='viewQuestion.jsp?id="+value.questionId+"'>"+value.title+"</a></dd>";
				});
				if(valueStr == '')
					valueStr = "<div class='notice'>暂时还没有问答</div>";
				$('#questions').html(valueStr);
			}		
		})
	}
	//加载典型客户
	function loadCustomer(){
		$.ajax({
				url: 'struts/ViewDic_getMoreDicItems?codeName=005&rows=7&page=1',
				success:function(data){
					//alert(data);
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject.rows,function(n,value){
						valueStr += "<dd><a class='left tooLong w230' href=\"seeKey.jsp?key="+value.showName+"\">"+value.showName+"</a></dd>";
					});
		
					if(valueStr == "")
						valueStr ="<div class='notice'>暂时没有客户信息</div>";

					$('#customer').html(valueStr);
				}
		});
	}
	function loadKeyWords(){
		$.ajax({
			url:"struts/Train_getNXRelatedKeyWords",
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href='#'>"+value.keyword+"</a></li>";
				});
				$('#relatedKeywords').html(valueStr);
			}
		})
	}
	
	function loadSubjects(){
		$.ajax({
			url:"struts/Train_getNXRelatedSubjects",
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr1 = "";
				var valueStr2 = "";
				$.each(jsonObject.rows,function(n,value){
					var subject = value.subject;
					if(subject.length > 5)
						subject = subject.substring(0,5)+"...";
					if(n<=9)
						valueStr1 +="<dd><a href='#'>"+subject+"</a></dd>";
					else
						valueStr2 +="<dd><a href='#'>"+subject+"</a></dd>";
				});
				$('#relatedSubjects1').html(valueStr1);
				$('#relatedSubjects2').html(valueStr2);
			}
		})
	}
	
	function loadClassicCourse(){
		$.ajax({
			url:"struts/Train_getClassicNXCourse",
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr +="<li><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></li>";
				});
				if(valueStr == '')
					valueStr = "<div class='notice'>暂无课程数据</div>";
				$('#classiscCourse').html(valueStr);
			}
		});
	}
	
	function loadHotCourse(){
		$.ajax({
			url:"struts/Train_getNXHotCourse",
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				var color = "red";
				$.each(jsonObject,function(n,value){
					if(n>2)
						color="blue";
					valueStr +="<li><span class='"+color+"'>"+(n+1)+"</span><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></li>";
				});
				if(valueStr == '')
					valueStr = "<div class='notice'>暂无课程数据</div>";
				$('#hotCourse').html(valueStr);
			}
		});
	}
	
	function loadCourseType(flag){
		$.ajax({
			url:"struts/Train_getCourseType?flag="+flag,
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr +="<li><a href='#'>"+value.name+"</a></li>";
				});
				if(valueStr == '')
					valueStr = "<div class='notice'>暂无数据</div>";
				$('#type'+flag).html(valueStr);
			}
		});	
	}
	
	function seePartTab(pre,flag,part){
		var count = 0;
		var cssOn = "tabOn";
		var cssOff = "tabOff";
		if(pre == 'a')
			count = 5;
		if(pre == 'b')
			count = 3;
		for(var i=1;i<=count;i++){
			if(i == flag){
				$('#'+pre+part+i).attr('class',cssOn);
				loadPartData(pre,flag,part);
			}else
				$('#'+pre+part+i).attr('class',cssOff);
		}	
	}
	function loadPartData(pre,flag,part){
		if(pre == 'a'){//加载行业培训等	
			$.ajax({
				url:"struts/Train_getNXTypeCourse?catogery="+flag+"&flag="+part,
				success:function(data){
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject,function(n,value){
						valueStr +="<li><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></li>";
					});
					if(valueStr == '')
						valueStr = "<div class='notice'>暂无课程数据</div>";
					$('#'+pre+part).html(valueStr);
				}
			});
		}
		if(pre == 'b'){
			if(flag == '1'){//加载高端课程
				$.ajax({
					url:"struts/Train_getNXCourseByPrice?catogery="+part,
					success:function(data){
						var jsonObject = eval('('+data+')');
						var valueStr = "";
						$.each(jsonObject,function(n,value){
							valueStr +="<li><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></li>";
						});
						if(valueStr == '')
							valueStr = "<div class='notice'>暂无课程数据</div>";
						$('#'+pre+part).html(valueStr);
					}
				});
			}else if(flag == '2'){//加载学员推荐
				
			}else{//加载推荐老师
				$.ajax({
					url:"struts/Train_getNXTeachers?catogery="+part,
					success:function(data){
						var jsonObject = eval('('+data+')');
						var valueStr = "";
						$.each(jsonObject,function(n,value){
							valueStr +="<li><a href='#'>"+value.name+"&nbsp;[擅长:"+value.best+"]</a></li>";
						});
						if(valueStr == '')
							valueStr = "<div class='notice'>暂无推荐老师数据</div>";
						$('#'+pre+part).html(valueStr);
					}
				});
			}
		}
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
		<li>企业内训</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
	<div class="top">
				<!-- 代码 开始 -->
	    <div id="hotpic">
	        <div id="NewsPic">
	            <a target="_blank" href="#" style="visibility: visible; display: block;">
	                <img src="images/peixunFlash.jpg" class="Picture"  title="第1张图片的说明文字" /></a>
	            <a style="visibility: hidden; display: none;" target="_blank" href="#">
	                <img class="Picture" src="images/peixunFlash.jpg"  title="第2张图片的说明文字" /></a>
	             <a style="visibility: hidden; display: none;" target="_blank" href="#">
	                <img class="Picture" src="images/peixunFlash.jpg" title="第2张图片的说明文字" /></a>
	            <div class="Nav">
	            	<span class="Normal">3</span>
	                <span class="Normal">2</span>
	                <span class="Cur">1</span>
	            </div>
	        </div>

	    </div>
	    <script type="text/javascript">
	        $('#hotpic').liteNav(1000);
	    </script>
	    <!-- 代码 结束 -->
		<!--  <img  src="images/peixunFlash.jpg"  style="width:290px;height:200px;padding:0px" class="left"/>-->
		<div id="topArticle">
		<div class="inNews">
			<h2>职场EQ与情绪管理培训</h2>
			<p>本课程详细介绍企业常用公文的写作特点、写作规范和技巧，学习快速搭建公文结构的方法，通过典型案例本课程详细介绍企业常用公文的写作特点、写作规范和技巧，学习快速搭建公文结构的方法，通过典型案例...</p>
		</div>
		<div class="inNews none">
			<h2>职场EQ与情绪管理培训</h2>
			<p>本课程详细介绍企业常用公文的写作特点、写作规范和技巧，学习快速搭建公文结构的方法，通过典型案例...</p>
		</div>  
		</div>
	<div class="clear"></div>
	<div class="classtic left">
		<h2 class="first">经典培训<span class="more"><a href="#">更多</a></span></h2>
		<ul id="classiscCourse">
			<li><a href="#">定向引爆式大客户销售</a></li>
		</ul>
		<div class="clear"></div>
		<h2>热门课程<span class="more"><a href="#">更多</a></span></h2>
		<ul class="hot" id="hotCourse">
			<!--  <li><span class="red">1</span><a href="#">定向引爆式大客户销售</a></li>
			<li><span class="red">2</span><a href="#">企业应收账款管理及信用风险控制...</a></li>
			<li><span class="red">3</span><a href="#">成功的产品经理—产品经理核心管...</a></li>
			<li><span class="blue">4</span><a href="#">心理学：洞察人心（性）之道</a></li>
			<li><span class="blue">5</span><a href="#">产品需求分析与需求管理</a></li>
			<li><span class="blue">6</span><a href="#">研发质量管理培训</a></li>
			<li><span class="blue">7</span><a href="#">产品需求分析与需求管理</a></li>-->
		</ul>
		<div class="clear"></div>
	</div>
	
	<div class="lastedArticle right">
			<h2>热门文章<span class="more"><a href="allArticles.jsp">更多</a></span></h2>
		<ul id="hotArticle">
			<!--  <li><a href="#">定向引爆式大客户销售</a></li>
			<li class="noMargin"><a href="#">企业应收账款管理及信用风险控制...</a></li>
			<li><a href="#">成功的产品经理—产品经理核心管...</a></li>
			<li class="noMargin"><a href="#">心理学：洞察人心（性）之道</a></li>
			<li><a href="#">产品需求分析与需求管理</a></li>
			<li class="noMargin"><a href="#">研发质量管理培训</a></li>
			<li><a href="#">“大卖场”终端的销售与管理</a></li>
			<li class="noMargin"><a href="#">企业应收账款管理及信用风险控制...</a></li>-->
		</ul>
		<div class="clear"></div>
			<h2>推荐文章<span class="more"><a href="allArticles.jsp">更多</a></span></h2>
		<ul id="recommondArticel">
			<!-- <li><a href="#">定向引爆式大客户销售</a></li>
			<li class="noMargin"><a href="#">企业应收账款管理及信用风险控制...</a></li>
			<li><a href="#">成功的产品经理—产品经理核心管...</a></li>
			<li class="noMargin"><a href="#">心理学：洞察人心（性）之道</a></li>
			<li><a href="#">产品需求分析与需求管理</a></li>
			<li class="noMargin"><a href="#">研发质量管理培训</a></li>
			<li><a href="#">“大卖场”终端的销售与管理</a></li>
			<li class="noMargin"><a href="#">企业应收账款管理及信用风险控制...</a></li> -->
		</ul>
		<div class="clear"></div>
	</div>
	
	</div>
	<!--广告 start-->
	<img  src="images/peixunAd.jpg"  style="width:700px; height:60px;float:left"/>
	<!--广告 end-->
	<ul>
		<li class="noneStyle">
			<div class="part left" >
				<div class="head">
					<div class="title left" >行业内训</div>
					<div class="tabOn" id="a11"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',1,1)">财务</a></div>
					<div class="tabOff" id="a12"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',2,1)">物流</a></div>
					<div class="tabOff" id="a13"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',3,1)">人力</a></div>
					<div class="tabOff" id="a14"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',4,1)">生产</a></div>
					<div class="tabOff" id="a15"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',5,1)">营销</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a1">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
			</div>
		</li>
		<li class="noneStyle" >
			<div class="part left">
				<div class="head">
					<div class="title left" >专业内训</div>
					<div class="tabOn" id="a21"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',1,2)">财务</a></div>
					<div class="tabOff" id="a22"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',2,2)">物流</a></div>
					<div class="tabOff" id="a23"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',3,2)">人力</a></div>
					<div class="tabOff" id="a24"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',4,2)">生产</a></div>
					<div class="tabOff" id="a25"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',5,2)">营销</a></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a2">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
					
				</div>
			</div>
		</li>
		
	<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="title left" >职位内训</div>
					<div class="tabOn" id="a31"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',1,3)">财务</a></div>
					<div class="tabOff" id="a32"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',2,3)">物流</a></div>
					<div class="tabOff" id="a33"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',3,3)">人力</a></div>
					<div class="tabOff" id="a34"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',4,3)">生产</a></div>
					<div class="tabOff" id="a35"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',5,3)">营销</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245" >
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a3">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
	</div>
	</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="title left" >产品内训</div>
					<div class="tabOn" id="a41"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',1,4)">财务</a></div>
					<div class="tabOff" id="a42"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',2,4)">物流</a></div>
					<div class="tabOff" id="a43"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',3,4)">人力</a></div>
					<div class="tabOff" id="a44"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',4,4)">生产</a></div>
					<div class="tabOff" id="a45"><a href="javascript:void(0)" onclick="javascript:seePartTab('a',5,4)">营销</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a4">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
			</div>
		</li>
		</ul>
		<img  src="images/peixunAd.jpg"  style="width:700px; height:60px;float:left"/>
		<ul>
			<li class="noneStyle">
				<div class="part left">
					<div class="head">
						<div class="tabOn" id="b11"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',1,1)">财务管理高端课程</a></div>	
						<div class="tabOff" id="b12"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',2,1)">学员推荐</a></div>
						<div class="tabOff" id="b13"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',3,1)">内训师推荐</a></div>
						<div class="clear"></div>
					</div>
					<div class="bg h245">
						<div style="padding-left:25px;padding-top:10px">
							<ul class="list4" id="b1">
								<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							</ul>
						</div>
					</div>
					<!--<img  src="images/class2.jpg" />-->
				</div>
			</li>
		<li class="noneStyle">
		<div class="part left">
					<div class="head">
						<div class="tabOn" id="b21"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',1,2)">物流供应链高端课程</a></div>
						<div class="tabOff" id="b22"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',2,2)">学员推荐</a></div>
						<div class="tabOff" id="b23"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',3,2)">内训师推荐</a></div>
						<div class="clear"></div>
					</div>
					<div class="bg h245">
						<div style="padding-left:25px;padding-top:10px">
							<ul class="list4" id="b2">
								<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							</ul>
						</div>
					</div>
					<!--<img  src="images/class5.jpg" />-->
		</div>
		</li>
		<li class="noneStyle">
				<div class="part left">
					<div class="head">
						<div class="tabOn" id="b31"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',1,3)">人力资源高端课程</a></div>	
						<div class="tabOff" id="b32"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',2,3)">学员推荐</a></div>
						<div class="tabOff" id="b33"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',3,3)">内训师推荐</a></div>
						<div class="clear"></div>
					</div>
					<div class="bg h245" >
						<div style="padding-left:25px;padding-top:10px">
							<ul class="list4" id="b3">
								<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							</ul>
						</div>
					</div>
					<!--<img  src="images/class2.jpg" />-->
				</div>
			</li>
		<li class="noneStyle">
		<div class="part left">
					<div class="head">
						<div class="tabOn" id="b41"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',1,4)">生产管理高端课程</a></div>
						<div class="tabOff" id="b42"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',2,4)">学员推荐</a></div>
						<div class="tabOff" id="b43"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',3,4)">内训师推荐</a></div>
						<div class="clear"></div>
					</div>
					<div class="bg h245" >
						<div style="padding-left:25px;padding-top:10px">
							<ul class="list4" id="b4">
								<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							</ul>
						</div>
					</div>
					<!--<img  src="images/class5.jpg" />-->
		</div>
		</li>
		<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="b51"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',1,5)">营销客服高端课程</a></div>	
					<div class="tabOff" id="b52"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',2,5)">学员推荐</a></div>
					<div class="tabOff" id="b53"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',3,5)">内训师推荐</a></div>
					<div class="clear" ></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="b5">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
				<img  src="images/class2.jpg" />
			</div>
		</li>
	<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn" id="b61"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',1,6)">综合战略高端课程</a></div>
					<div class="tabOff" id="b62"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',2,6)">学员推荐</a></div>
					<div class="tabOff" id="b63"><a href="javascript:void(0)" onclick="javascript:seePartTab('b',3,6)">内训师推荐</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="b6">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
				<img  src="images/class5.jpg" />
	</div>
	</li>
	</ul>
	</div>
	<!--右边部分 start-->
	<div class="rightInPart">
		<!--培训关键词 start-->
		<div class="rightTeacher">
				<h5  class="first">企业内训相关关键词</h5>
				<div class="bg h315" style="padding:0px 15px 4px 15px;border:none"/>
					<div class="clear" style="height:10px;"></div>
					<ul class="list8" id="relatedKeywords" >
						<li><a href="#">EMBA</a></li>
						<li><a href="#">KPI</a></li>
						<li><a href="#">财务管理</a></li>
						<li><a href="#">差异化</a></li>
						<li><a href="#">产品研发</a></li>
						<li><a href="#">产品质量</a></li>
						<li><a href="#">成本控制</a></li>
						<li><a href="#">消费者</a></li>
						<li><a href="#">领导力</a></li>
						<li><a href="#">品牌定位</a></li>
						<li><a href="#">企业文化</a></li>
						<li><a href="#">渠道</a></li>
						<li><a href="#">产品定位</a></li>
						<li><a href="#">服务</a></li>
						<li><a href="#">竞争优势</a></li>
						<li><a href="#">营销</a></li>
						<li><a href="#">影响力</a></li>
						<li><a href="#">招商</a></li>
						<li><a href="#">EMBA</a></li>
						<li><a href="#">KPI</a></li>
						<li><a href="#">财务管理</a></li>
						<li><a href="#">差异化</a></li>
						<li><a href="#">产品研发</a></li>
						<li><a href="#">产品质量</a></li>
						<li><a href="#">成本控制</a></li>
						<li><a href="#">消费者</a></li>
						<li><a href="#">领导力</a></li>
						<li><a href="#">品牌定位</a></li>
						<li><a href="#">企业文化</a></li>
						<li><a href="#">渠道</a></li>
						<li><a href="#">产品定位</a></li>
						<li><a href="#">服务</a></li>
						<li><a href="#">竞争优势</a></li>
						<li><a href="#">营销</a></li>
						<li><a href="#">影响力</a></li>
						<li><a href="#">招商</a></li>
						<li><a href="#">产品质量</a></li>
						<li><a href="#">成本控制</a></li>
						<li><a href="#">消费者</a></li>
						<li><a href="#">领导力</a></li>
						<li><a href="#">品牌定位</a></li>
					</ul>
				</div>
			</div>
		<!--培训关键词 end-->
		
		<!--培训专题start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
				<h5  class="first">企业内训相关专题</h5>
				<div class="bg h315" style="padding:0px 0px 4px 0px;border:none"/>
					<div class="clear" style="height:0px"></div>
					<dl class="bestCustomer leftPart left" style="width:110px;" id="relatedSubjects1">
						<dd><a href="#">市场营销培训</a></dd>
						<dd><a href="#">企业培训</a></dd>
						<dd><a href="#">企业培训计划</a></dd>
						<dd><a href="#">大客户管理</a></dd>
						<dd><a href="#">客户服务</a></dd>
						<dd><a href="#">投诉处理流程</a></dd>
						<dd><a href="#">团队培训</a></dd>
						<dd><a href="#">客户服务</a></dd>
						<dd><a href="#">投诉处理流程</a></dd>
						<dd><a href="#">团队培训</a></dd>
						<dd><a href="#">客户服务</a></dd>
						<dd><a href="#">投诉处理流程</a></dd>
					</dl>
					<dl class="bestCustomer rightPart right" style="width:130px;" id="relatedSubjects2">
						<dd><a href="#">绩效考核</a></dd>
						<dd><a href="#">新社会保险法</a></dd>
						<dd><a href="#">员工关系管理</a></dd>
						<dd><a href="#">风险管理</a></dd>
						<dd><a href="#">目标管理</a></dd>
						<dd><a href="#">商务考察</a></dd>
						<dd><a href="#">经理人培训</a></dd>
						<dd><a href="#">绩效考核</a></dd>
						<dd><a href="#">新社会保险法</a></dd>
						<dd><a href="#">员工关系管理</a></dd>
						<dd><a href="#">风险管理</a></dd>
						<dd><a href="#">目标管理</a></dd>
					</dl>
				</div>
		</div>
		<!--培训专题end-->
		

		<!--专业培训/行业培训/产品培训 start-->
		<div style="height:10px; display:block"></div>
		<div class="trainKind" style="padding:5px 0px 8px 15px;border:1px solid #ddeae0;">
			<h4>专业内训</h4>
			<ul id="type1">
				<li><a href="#">软件工程</a></li>
			</ul>
			<div class="clear"></div>
			<h4>行业内训</h4>
			<ul id="type2">
				<li><a href="#">化工</a></li>
			</ul>
			<div class="clear"></div>
			<h4>产品内训</h4>
			<ul id="type3">
				<li><a href="#">手机</a></li>
			</ul>
			<div class="clear"></div>
			<h4>职位内训</h4>
			<ul id="type4">
				<li><a href="#">HR经理</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<!--专业培训/行业培训/产品培训 end-->
		

		<!--企业培训师 start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher" >
			<h5 class=" first">企业培训师</h5>
			<div style="padding-left:15px;padding-bottom:10px" id="teacherPart">
			<!--  <img  src="images/824.jpg" style="height:50px;width:40px" class="left"/>
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
			</dl>-->
			<div class="clear"></div>
			</div>
			<h5>培训机构</h5>
			<ul class="list7" style="padding-top:10px;padding-left:15px;" id="PXOrgs">
				<li class="line"><a><span class="red">1</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="red">2</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">3</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="blue">4</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">5</span><span class="text">众行机构</span></a></li>
			</ul>
			<div class="clear"></div>
			<div style="height:10px;display:block"></div>
			<h5>典型客户</h5>
			<dl class="bestCustomer leftPart left" style="width:200px;" id="customer">
				<!--  <dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
				<dd><a href="#">阿里巴巴</a></dd>
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>-->
			</dl>
			<div class="clear"></div>
		</div>
		<!--企业培训师 end-->
		
		<!--企业培训动态 start-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
				<h5  class="first">培训动态</h5>
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
				<h5>培训问答</h5>
				<div class="inQuesiton">	
					<dl id="questions">
						<!--  <dd><a href="#">如何解除劳动合同?</a></dd>
						<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
						<dd><a href="#">如何分配股权?</a></dd>
						<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
						<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>
						<dd><a href="#">如何设计企业薪酬绩效考核制度?</a></dd>-->
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