<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = request.getParameter("id");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看课程</title>
<link type="text/css" href="css/face.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<script src="js/easyui/jquery-1.8.0.min.js"></script>
<script src="js/easyui/jquery.easyui.min.js"></script>
</head>
<body>
<jsp:include page="head.jsp" flush="true"/>
<script>
	$(function(){
		$.ajax({
			url:"struts/ViewClass_ViewClass?id="+<%=id%>,
			success:function(data){
				var jsonObject = eval('('+data+')');
				$('#titile').html(jsonObject.title);
				$('#courseId').html("课程编号："+jsonObject.classNum);
				$('#blockContent').html(jsonObject.bloclContent);
				$('#classContent').html(jsonObject.content);
				$('#teacher').html("<span>培训师：</span>"+jsonObject.teacher);
				$('#price').html("<span>课程费用：</span>"+jsonObject.price);
				if(jsonObject.isInner == '0'){
					$('#inAttend').css('display','block');
					$('#outAttend').css('display','none');
				}
				else{
					$('#inAttend').css('display','none');
					$('#outAttend').css('display','block');
				}
				
				//路径
				var path = "<ul><li>当前位置:&nbsp;</li><li><a href='index.jsp'>首页</a></li><li class='bread'>&gt;&gt;</li>";
				if(jsonObject.isInner == '0')
					path += "<li><a href='#'>企业培训</a></li>";
				else
					path += "<li><a href='#'>企业内训</a></li>";
				path += "<li class='bread'>&gt;&gt;</li><li><a href='xx.jsp?id="+jsonObject.categoryID+"'>"+jsonObject.categoryName+"</a></li><li class='bread'>&gt;&gt;</li>";
				path += "<li>"+jsonObject.title+"</li></ul><div class='clear'></div>";
				$('#path').html(path);
				
				//添加时间 地点
				var places = jsonObject.time;
				var placeStr="<span>上课地点：</span>";
				var timeStr = "<span>举办时间：</span>";
			
				$.each(places,function(n,value){
					timeStr += value.from+"至"+value.to;
					placeStr += value.city;
					if(n<places.length-1){
						timeStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
						placeStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
					}
				});
				$('#place').html(placeStr);
				$('#time').html(timeStr);
				
				//添加培训对象
				var object = jsonObject.object;
				var objectStr = "<span>培训对象：</span>";
				for(var i=0;i<object.length;i++){
					objectStr += "<a href='xx.jsp?id="+object[i].id+"'>"+object[i].name+"</a>";
					if(i<object.length-1)
						objectStr += ",";
				}
				$('#object').html(objectStr);
				
				//添加适用行业
				var indestory = jsonObject.indestory;
				var indestoryStr = "<span>适用行业：</span>";
				for(var i=0;i<indestory.length;i++){
					indestoryStr += "<a href='xx.jsp?id="+indestory[i].id+"'>"+indestory[i].name+"</a>";
					if(i<indestory.length-1)
						indestoryStr += ",";
				}
				$('#indestory').html(indestoryStr);
				
				//添加适用专业
				var major = jsonObject.major;
				var majorStr = "<span>适用专业：</span>";
				for(var i=0;i<major.length;i++){
					majorStr += "<a href='xx.jsp?id="+major[i].id+"'>"+major[i].name+"</a>";
					if(i<major.length-1)
						majorStr += ",";
				}
				$('#major').html(majorStr);
				
				//添加关键词
				var keyWords = jsonObject.keyWords;
				var keyWordsStr = "<span>关键词：</span>";
				for(var i=0;i<keyWords.length;i++){
					keyWordsStr += "<a href='xx.jsp?id="+keyWords[i].id+"'>"+keyWords[i].name+"</a>";
					if(i<keyWords.length-1)
						keyWordsStr += ",";
				}
				$('#keyWords').html(keyWordsStr);
				
				//添加专题
				var series = jsonObject.series;
				var seriesStr = "<span>专题：</span>";
				for(var i=0;i<series.length;i++){
					seriesStr += "<a href='xx.jsp?id="+series[i].id+"'>"+series[i].name+"</a>";
					if(i<series.length-1)
						seriesStr += ",";
				}
				$('#series').html(seriesStr);
			}
		});
	});
</script>
<!--当前路径 start-->
<div class="mainContent path" id="path">
	<div class="clear"></div>
</div>
<!--当前路径 end-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px;">
	
	<!--左边部分课程信息 start-->
	<div class="leftInPart">
		<div class="classDetail" >
			<div ><h1 id="title">成为卓越领导、123</h1>
			<div class="classNum" id="courseId">课程编号：12345</div></div>
			<div class="detail">
			<div class="classLeftPart" id="courseInfo">
			<div class="time" id="time"><span>举办时间：</span><a href="#">2013-5-10 至 2013-5-15</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">2013-6-10 至 2013-6-19</a></div>
			<div class="time" id="place"><span>上课地点：</span><a href="#">广州</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">北京</a></div>
			<div class="time" id="price"><span>课程费用：</span>2800元/位; 7980元/3位; 13300元/5位;(包含上课所有中午餐,茶水和培训教材)</div>
			<div class="time" id="teacher"><span>培训师：</span>李老师</div>
			<div class="time" id="object"><span>培训对象：</span><a href="#">总经理</a>、<a href="#">CEO</a>、<a href="#">高级管理人员</a></div>
			<div class="time" id="indestory"><span>适用行业：</span><a href="#">电力行业</a>、<a href="#">生产行业</a></div>
			<div class="time" id="major"><span>适用专业：</span><a href="#">工商管理</a>、<a href="#">行政管理</a>、<a href="#">人力资源</a></div>
			<div class="time" id="keyWords"><span>关键词：</span><a href="#">管理</a>、<a href="#">团队建设</a></div>
			<div class="time" id="series"><span>专题：</span><a href="#">企业管理</a></div>
			</div>
			<div class="classRightPart">
				<dd><a href="#">打印课程提纲</a></dd>
				<dd><a href="#">打印报名表格</a></dd>
				<dd><a href="#">先加入收藏夹</a></dd>
				<dd><a href="#">引入内训申请</a></dd>
				<dd><a href="#">先发送至邮箱</a></dd>
				<dd><a href="#">保存电脑桌面</a></dd>
				<dd><a href="#">下载课程提纲</a></dd>
				</div>
			<div class="clear"></div>
			</div>
			<div class="clear"></div>
			<div id="courseContent">
				<div class="intro">推荐理由</div>
					<p id="blockContent"></p>
				<div class="intro">课程内容</div>
					<p id="classContent"></p>
			</div>
	</div>
	<div class="clear"></div>
	<!--报名表 start-->
	<div class="attend" id="inAttend">
		<h2>报名/咨询</h2>
		<div style="height:15px; display:block" class="clear"></div>
		<div ><h3>企业培训:</h3><span>020-61908283</span><span>020-39948135</span></div>
		<div class="clear"></div>
	</div>
	
	<div class="attendTable" id="outAttend">
		<table>
			<thead><h2>报名/咨询表</h2></thead>
			<tr>
				<td width="140px" align="right">单位名称：</td>
				<td width="240px" align="left"><input  type="text"/></td>
				<td width="70px"  align="right">联系人：</td>
				<td align="left"><input  type="text"/><font style="color:red">&nbsp;*</font></td>
			</tr>
			<tr>
				<td align="right">联系电话：</td>
				<td align="left"><input  type="text"/><font style="color:red">&nbsp;*</font></td>
				<td align="right">传真：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td align="right">移动电话：</td>
				<td align="left"><input  type="text"/></td>
				<td  align="right">电子邮箱：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td align="right">任职部门：</td>
				<td align="left"><input  type="text"/></td>
				<td align="right">MSN：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td align="right">企业类型：</td>
				<td align="left"><input  type="text"/></td>
				<td  align="right">业务范围：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td align="right">开始时间：</td>
				<td  align="left"><input  type="text"/></td>
				<td  align="right">结束时间：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td  align="right">财务预算：</td>
				<td align="left"><input  type="text"/></td>
				<td align="right">教学语种：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
			<td  align="right">参训对象简单描述：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">学员基础简单说明：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">企业简介：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">具体那个环节出问题：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">培训内容说明：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">预期目标：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td align="right">备注：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td colspan="2"  align="left" style="padding-left:140px;"><input type="radio" class="status" name="group1" checked="checked"/><label>确认报名</label><input type="radio" class="status" name="group1" /><label>正在申请中</label></td>
			
			</tr>
			<tr style="height:70px"><td colspan="4" align="center"><input class="btn"  type="button" value="确定报名"/>&nbsp;<input class="btn"  type="button" value="重新填写"/></td></tr>
		</table>
	</div>
	<!--报名表 end-->
	</div>
	<!--左边部分课程信息 end-->
	
	<!--右边部分信息 start-->
	<div class="rightInPart">
			<div class="rightTeacher">
				<h5  class="first">相关关键词</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;"/>
					<div class="clear" style="height:10px;"></div>
				<ul class="list8"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
				<h5 >相关专题</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;"/>
					<div class="clear" style="height:10px;"></div>
				<ul class="list8"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
			</div>
	<!--月份 start-->
		<div style="display:block;height:10px"></div>
		<div class="head">2012年企业培训计划</div>
		<div class="bg p5 h40">
			<ul class="list2">
				<li><a href="#">01月</a></li>
				<li><a href="#">02月</a></li>
				<li><a href="#">03月</a></li>
				<li><a href="#">04月</a></li>
				<li><a href="#">05月</a></li>
				<li><a href="#">06月</a></li>
				<li><a href="#">07月</a></li>
				<li ><a href="#">08月</a></li>
				<li><a href="#">09月</a></li>
				<li><a href="#">10月</a></li>
				<li><a href="#">11月</a></li>
				<li><a href="#">12月</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<!--月份 end-->
		
		<!--内训 start-->
		<div class="head">2013年企业培训计划</div>
		<div class="bg p5 h40" >
				<ul class="list2">
					<li><a href="#">01月</a></li>
					<li><a href="#">02月</a></li>
					<li><a href="#">03月</a></li>
					<li><a href="#">04月</a></li>
					<li><a href="#">05月</a></li>
					<li><a href="#">06月</a></li>
					<li><a href="#">07月</a></li>
					<li ><a href="#">08月</a></li>
					<li><a href="#">09月</a></li>
					<li><a href="#">10月</a></li>
					<li><a href="#">11月</a></li>
					<li><a href="#">12月</a></li>
				</ul>
			<div class="clear"></div>
		</div>
		<!--内训 end-->
		<!--地点 start-->
		<div class="head">开课地点</div>
		<div class="bg h45" style="border-bottom:1px solid #ebebeb">
			<ul class="list2 city">
				<li><a href="#">北京</a></li>
				<li><a href="#">上海</a></li>
				<li><a href="#">深圳</a></li>
				<li><a href="#">广州</a></li>
				<li><a href="#">杭州</a></li>
				<li><a href="#">东莞</a></li>
				<li><a href="#">苏州</a></li>
				<li><a href="#">全国</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<!--地点 end-->
		<!--热门培训 培训计划 培训下载 start-->
		<div style="height:10px; display:block"></div>
		<div class="sortList">
			<div class="head">
						<div class="tabOn half">热门培训</div>
						<div class="tabOff half">热门排行</div>
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
		<!--培训计划 培训下载 end-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
			<h5  class="first">培训计划</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9">
					<li><a>2013年4月培训计划</a></li>
					<li><a>2013年5月培训计划</a></li>
					<li><a>2013年6月培训计划</a></li>
					<li><a>2013年7月培训计划</a></li>
					<li><a>2013年8月培训计划</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<h5 >培训下载</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto;">
				<ul class="list9">
					<li><a>经典资料：行政管理怎样做...</a></li>
					<li><a>发邮件的礼仪</a></li>
					<li><a>教你如何与人交流</a></li>
					<li><a>攻心说话术</a></li>
					<li><a>与人相处的黄金法则</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<h5>培训老师</h5>
			<div class="bg" style="padding:10px 0px 10px 12px;border:none;height:auto;">
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
			
			<h5>典型客户</h5>
			<dl class="bestCustomer leftPart left" style="width:110px;">
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
				<dd><a href="#">阿里巴巴</a></dd>
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
			</dl>
			<dl class="bestCustomer rightPart right" style="width:110px;">
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
				<dd><a href="#">阿里巴巴</a></dd>
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
			</dl>
			<div class="clear"></div>
		</div>
		
	</div>
	<!--右边部分信息 end-->
	
</div>

<div class="clear"></div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>