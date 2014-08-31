<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = request.getParameter("id");
	Calendar c=Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	int nextYear = year + 1;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看课程</title>
</head>
<body>
<jsp:include page="head.jsp" flush="true"/>
<script>
	var arrangeOpts = [];
	$(function(){
		//加载课程信息
		$.ajax({
			url:"struts/ViewClass_ViewClass?id="+<%=id%>,
			success:function(data){
				var jsonObject = eval('('+data+')');
				$('#title').html("<h1>"+jsonObject.title+"</h1>");
				$('#courseId').html("课程编号："+jsonObject.classNum);
				$('#blockContent').html(jsonObject.bloclContent);
				$('#classContent').html(jsonObject.content);
				$('#teacher').html("<span>培训师：</span>"+jsonObject.teacher);
				var price = jsonObject.price;
				if(jsonObject.isInner == '0'){
					$('#inAttend').css('display','none');
					$('#outAttend').css('display','block');
					$('#time').css('display','block');
					$('#place').css('display','block');
				}
				else{
					$('#inAttend').css('display','block');
					$('#outAttend').css('display','none');
					$('#time').css('display','none');
					$('#place').css('display','none');
					price = "面议";
				}
				if(price == '0')
					price = "面议";
				$('#price').html("<span>课程费用：</span>"+price);
				
				//路径
				var path = "<ul><li>当前位置:&nbsp;</li><li><a href='index.jsp'>首页</a></li><li class='bread'>&gt;&gt;</li>";
				if(jsonObject.isInner == '0')
					path += "<li><a href='#'>企业培训</a></li>";
				else
					path += "<li><a href='#'>企业内训</a></li>";
				path += "<li class='bread'>&gt;&gt;</li><li><a href='seeKey.jsp?key="+jsonObject.categoryID+"'>"+jsonObject.categoryName+"</a></li><li class='bread'>&gt;&gt;</li>";
				path += "<li>"+jsonObject.title+"</li></ul><div class='clear'></div>";
				$('#courseName').val(jsonObject.title);
				$('#path').html(path);
				
				//添加时间 地点
				var places = jsonObject.time;
				var placeStr="<span>上课地点：</span>";
				var timeStr = "<span>举办时间：</span>";
			
				$.each(places,function(n,value){
					timeStr += value.from+"至"+value.to;
					placeStr += value.city;
					if(n==0){
						arrangeOpts.push({
						    key:   value.from+"至"+value.to+"在"+value.city,
						    value: value.from+"至"+value.to+"在"+value.city,
							selected : true
						});
					}else{
						arrangeOpts.push({
						    key:   value.from+"至"+value.to+"在"+value.city,
						    value: value.from+"至"+value.to+"在"+value.city
						});
					}
					//arrangeOpts.push(value.from+"至"+value.to+"在"+value.city);
					if(n<places.length-1){
						timeStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
						placeStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
					}
				});
				$('#arrange').combobox('loadData', arrangeOpts);
				$('#place').html(placeStr);
				$('#time').html(timeStr);
				//console.log("arranges  = "+arrangeOpts);
				
				//添加培训对象
				var object = jsonObject.object;
				var objectStr = "<span>培训对象：</span>";
				for(var i=0;i<object.length;i++){
					objectStr += "<a href='seeKey.jsp?key="+object[i].name+"'>"+object[i].name+"</a>";
					if(i<object.length-1)
						objectStr += ",";
				}
				$('#object').html(objectStr+"<br>");
				
				//添加适用行业
				var indestory = jsonObject.indestory;
				var indestoryStr = "<span>适用行业：</span>";
				for(var i=0;i<indestory.length;i++){
					indestoryStr += "<a href='seeKey.jsp?key="+indestory[i].name+"'>"+indestory[i].name+"</a>";
					if(i<indestory.length-1)
						indestoryStr += ",";
				}
				$('#indestory').html(indestoryStr+"<br>");
				
				//添加适用专业
				var major = jsonObject.major;
				var majorStr = "<span>适用专业：</span>";
				for(var i=0;i<major.length;i++){
					majorStr += "<a href='seeKey.jsp?key="+major[i].name+"'>"+major[i].name+"</a>";
					if(i<major.length-1)
						majorStr += ",";
				}
				$('#major').html(majorStr+"<br>");
				
				//添加关键词
				var queryKeyWords = "";
				var keyWords = jsonObject.keyWords;
				var keyWordsStr = "<span>关键词：</span>";
				for(var i=0;i<keyWords.length;i++){
					keyWordsStr += "<a href='seeKey.jsp?key="+keyWords[i].name+"'>"+keyWords[i].name+"</a>";
					queryKeyWords += keyWords[i].name+'';
					if(i<keyWords.length-1)
						keyWordsStr += ",";
				}
				$('#keyWords').html(keyWordsStr+"<br>");
				loadRelatedKeyWords(queryKeyWords);
				
				//添加专题
				var querySubjects = "";
				var series = jsonObject.series;
				var seriesStr = "<span>专题：</span>";
				for(var i=0;i<series.length;i++){
					seriesStr += "<a href='seeKey.jsp?key="+series[i].name+"'>"+series[i].name+"</a>";
					querySubjects += series[i].name+'';
					if(i<series.length-1)
						seriesStr += ",";
				}
				loadRelatedSubjects(querySubjects);
				$('#series').html(seriesStr+"<br>");

				
			}
		});
		
		//03.加载热门课程
		getHotCourse();
		//04.加载内训课程
		getNXCourse();
		//05.加载内训视频
		getVedioCourse();
		//06.加载相关讲师
		getTeacher();
		//07.加载相关文章
		loadHotArticle();
		//08.加载相关问答
		loadQuestion();
		//09.加载培训下载
		getHotDownLoads();
		//10.相关培训机构
		loadPXOrg();
		//11.相关客户群
		loadCustomer();
		//12.相关评价
		loadComments();
		//13.相关培训计划、内训计划
		seePartTab('plan',1,1);
		//14.相关培训现场、内训现场
		seePartTab('place',1,1);

	});
	
	//01.加载相关关键词
	function loadRelatedKeyWords(condition){
		$.ajax({
			url:encodeURI('struts/ViewClass_getRelatedKeyWords?condition='+condition),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr +="<li><a href='seeKey.jsp?key="+value.keyword+"'>"+value.keyword+"</a></li>";
				});
				$('#relatedKeywords').html(valueStr);
			}
		})
	}
	//02.加载相关专题
	function loadRelatedSubjects(condition){
		$.ajax({
			url:encodeURI('struts/ViewClass_getRelatedSubjects?condition='+condition),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href='#'>"+value.subject+"</a></li>";
				});
				$('#relatedSubjects').html(valueStr);
			}
		})
	}
	//03.加载培训课程
	function getHotCourse(){
		$.ajax({
			url:encodeURI("struts/Main_getHotCourseWithNoTime?rows=5"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr += "<li style='width:210px;text-align:left;'><a class='left tooLong w230' href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></li>";
				});
				$('#hotCourse').html(valueStr);
			}
		});
	}
	//04.加载内训课程
	function getNXCourse(){
		$.ajax({
			url:encodeURI("struts/HotCourse_getClassiscNXCourse?rows=5&page=1"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr += "<li style='width:210px;text-align:left;'><a class='left tooLong w230' href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></li>";
				});
				$('#NXCourse').html(valueStr);
			}
		});
	}
	//05.加载内训视频
	function getVedioCourse(){
		$.ajax({
			url:"struts/Main_getVedioNX?flag=2",
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					if(n<=5)
						valueStr += "<li style='width:210px;text-align:left;'><a class='left tooLong w230' href='viewClass.jsp?id="+value.courseId+"'>"+value.title+"</a></li>";
				});
				if(valueStr == "")
					valueStr = "<div class='notice'>暂时没有内训视频</div>";
				$('#NXVideo').html(valueStr);
			}
		});
	}
	//06.加载讲师
	function getTeacher(){
		$.ajax({
			url:"struts/Main_getTeachers?page=1&rows=6&flag=1",
			success:function(data){
				//alert(data);
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr +="<li><a href='teacherClass.jsp?id="+value.teacherId+"'>"+value.realName+"</a></li>";
				});
				if(valueStr == "")
					valueStr ="<div class='notice'>暂时没有讲师信息</div>";
				$('#teacherPart').html(valueStr);
			}
		});
	}
	//07.加载文章
	function loadHotArticle(){
		$.ajax({
			url:encodeURI("struts/ViewArticle_getHotArticle"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					if(n<6)
						valueStr += "<li style='width:210px;text-align:left;'><a class='left tooLong w230' href='viewArticle.jsp?id="+value.id+"'>"+value.title+"</a></li>";
				});
				if(valueStr =="")
					valueStr = "<div class='notice'>暂时没有文章信息</div>";
				$('#hotArticle').html(valueStr);
			}
		})
	}
	//08.加载问答
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
	//09.加载下载
	function getHotDownLoads(){
		$.ajax({
			url:encodeURI("struts/Main_getDownLoads?flag="+2),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					if(n<5)
						valueStr +="<li  style='width:200px;text-align:left;'><a class='left' href='seeDownLoadsDetail.jsp?id="+value.downloadId+"'><span class='text tooLong left' style='width:200px;display:block'>"+value.title+"</span></a><div class='clear'></div></li>";

				});
				if(valueStr == ""){
					valueStr = "<div class='notice'>没有下载记录</div>";
				}
				$('#hotDownloads').html(valueStr);
			}
		})
	}
	//10.加载培训机构
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
	//11.加载客户群
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
	//12.加载相关评价
	function loadComments(){
		$.ajax({
			url: 'struts/ViewDic_getMoreDicItems?codeName=25&rows=5&page=1',
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr += "<li><a class='left tooLong w200'>"+value.showName+"</a></li>";
				});
	
				if(valueStr == "")
					valueStr ="<div class='notice'>暂时没有评价信息</div>";
				
				$('#comments').html(valueStr);
			}
			
		});
	}
	//13.加载培训计划、内训计划	 //14.加载培训现场、内训现场
	function loadTabDate(pre,flag,part){
		if(pre == 'plan'){//加载培训计划、内训计划
			$.ajax({
				url:encodeURI('struts/TrainPlan_getPlanCourse?flag='+flag+'&rows=5&page=1'),
				success: function(data){
					//alert(data);
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject,function(n,value){
						if(n<5)
							valueStr += "<li class='line'><a class='left tooLong w200' href='viewClass.jsp?id="+value.courseId+"'>"+value.title+"</a></li>";
					});
					if(valueStr == "" || valueStr == "暂无课程信息")
						valueStr = "<div class='notice'>没有最新的培训计划</div>";
					$('#'+pre+part).html(valueStr);
				}		
			})
		}else{//加载培训现场、内训现场
			$.ajax({
				url:"struts/LiveScene_queryLiveSceneTopList?flag="+flag,
				success:function(data){
					//alert(data);
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					
					$.each(jsonObject,function(n,value){
						if(n < 6)
							valueStr +="<li class='line'><a  class='left tooLong w200' href='viewLiveScene.jsp?id="+value.id+"&flag="+flag+"'>"+value.name+"</a></li>";
					});	
					if(valueStr == ""){
						valueStr = "<div class='notice'>没有最新的现场信息</div>";
					}
					$('#'+pre+part).html(valueStr);
				}
			});
		}
	}

	//切换Tab页
	function seePartTab(pre,flag,part){
		var count = 2;
		var cssOn = "tabOn half";
		var cssOff = "tabOff half";

		for(var i=1;i<=count;i++){
			if(i == flag){
				$('#'+pre+part+i).attr('class',cssOn);
				loadTabDate(pre,flag,part);
			}else
				$('#'+pre+part+i).attr('class',cssOff);
		}	
	}
	
	
	function submitNeed(){
		if($('#contact').val() == ''){
			alert('联系人不能为空!');
			return false;
		}
		if($('#telephone').val() == ''){
			alert('固定电话不能为空!');
			return false;
		}
		if($('#compName').val() == ''){
			alert('单位名称不能为空!');
			return false;
		}
		if($('#headCount').val() == ''){
			alert('人数不能为空!');
			return false;
		}

		var apply =  {
				confirmed:$('#confirm').combobox('getValue'),
				headCount:$('#headCount').val(),
				applicantCompany:$('#compName').val(),
				telephone:$('#telephone').val(),
				cellphone:$('#celphone').val(),
				email:$('#email').val(),
				contact:$('#contact').val(),
				fax:$('#fax').val(),
				followed:false,
				department:$('#department').val(),
				qq:$('#qq').val(),
				participants:$('#participants').val(),
				remarks:$('#remark').val(),
				applyCourseId:<%= id%>
				};
		$.ajax('struts/Application_submitApplication?objectName=apply', {
							      type:'POST',
						          data: apply,
								  success: function(data){
										alert(data);
								  }
							 });
	}
	function clearForm(){
		$('#needForm').form("clear");
	}
	function objToString (name,obj) {
	    var str = '';
	    for (var p in obj) {
	        if (obj.hasOwnProperty(p)) {
	            str += name + '.' + p + ':' + obj[p] + '\n';
	        }
	    }
	    return str;
	}
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
			<div ><span id="title"></span>
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
			<!-- 
				<div class="intro">推荐理由</div>
					<p id="blockContent"></p> -->
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
		<Form id="needForm">
		<input type="hidden" id="courseName" >
		<table cellspacing="0" cellpadding="0" class="need" align="center" style="font-size:12px">
			<thead><h2>报名/咨询表</h2></thead>
		<tr>
			<td colspan="2" valign="top" >
				<select id="confirm" name="confirm" class="easyui-combobox" data-options=" panelHeight:'50',
						strict:true" style="panelHeight:30px;">
		    		<option value="false">先咨询</option>
		    		<option value="true">确认报名</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>我单位共计<input id="headCount" name="headCount">人<em style="color:red">*</em>
			</td>
			<td>参加<input id="arrange" name="arrange" class="easyui-combobox" data-options="valueField: 'key',textField: 'value',strict:true,editable:false" style="width:200px;">举办的课程
			</td>
		</tr>
		<tr>
			<td>单位名称:&nbsp;<input id="compName" name="compName"/><em style="color:red">*</em></td>
			<td>&nbsp;&nbsp;联系人:&nbsp;<input id="contact" name="contact"/><em style="color:red">*</em></td>
		</tr>
		<tr>
			<td>联系电话:&nbsp;<input id="telephone" name="telephone"/><em style="color:red">*</em></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;传真:&nbsp;<input id="fax" name="fax"/></td>
		</tr>
		<tr>
			<td>移动电话:&nbsp;<input id="celphone" name="celphone"/></td>
			<td>电子邮箱:&nbsp;<input id="email" name="email"/></td>
		</tr>
		<tr>
			<td>任职部门:&nbsp;<input id="department" name="department"/></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;QQ:&nbsp;<input id="qq" name="qq"/></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:12px;">参与人信息，姓名，职位，联系电话等，方便我们提前安排（非必填）:</td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:12px;">如：王自如 测评家 13800138000，罗永浩 企业家 13800138000</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><textarea id="participants" name="participants"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" valign="bottom" style="height:12px;">备注(如是否需要帮忙订酒店，什么时候到达等。):</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><textarea id="remark" name="remark"></textarea></td>
		</tr>
		<tr>
			<td align="center" style="padding-top:30px;padding-bottom:30px" colspan="2">
				<a class="normalButton" onclick="javascript:submitNeed()" href="javascript:void(0)">确定报名</a>
				<a class="normalButton" onclick="javascript:clearForm()" href="javascript:void(0)">重新填写</a>
			</td>
		</tr>
		</table></form>
	</div>
	<!--报名表 end-->
	</div>
	<!--左边部分课程信息 end-->
	
	<!--右边部分信息 start-->
	<div class="rightInPart">
			<div class="rightTeacher">
				<h5  class="first">相关关键词</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;">
					<div class="clear" style="height:10px;"></div>
				<ul class="list8" id="relatedKeywords"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
				<h5 >相关专题</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;">
					<div class="clear" style="height:10px;"></div>
				<ul class="list8" id="relatedSubjects"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
			</div>
	
		<!--内训 end-->
		<!--地点 start-->
		<!-- <div class="head">开课地点</div>
		<div class="bg h45" style="border-bottom:1px solid #ebebeb">
			<ul class="list2 city">
				<li><a href="seePlace.jsp?city=北京">北京</a></li>
				<li><a href="seePlace.jsp?city=上海">上海</a></li>
				<li><a href="seePlace.jsp?city=深圳">深圳</a></li>
				<li><a href="seePlace.jsp?city=广州">广州</a></li>
				<li><a href="seePlace.jsp?city=杭州">杭州</a></li>
				<li><a href="seePlace.jsp?city=东莞">东莞</a></li>
				<li><a href="seePlace.jsp?city=苏州">苏州</a></li>
				<li><a href="seePlace.jsp?city=全国">全国</a></li>
			</ul>
			<div class="clear"></div>
		</div> -->
		<!--地点 end-->
		<!--热门培训 培训计划 培训下载 start-->
		
		<!--培训计划 培训下载 end-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
			<h5  class="first">相关培训课程</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9" id="hotCourse">
					<!--  <li><a>2013年4月培训计划</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5  class="first">相关内训课程</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9" id="NXCourse">
					<!--  <li><a>2013年4月培训计划</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关内训视频</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9" id="NXVideo">
					<!--  <li><a>2013年4月培训计划</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关讲师</h5>
			<div class="bg" style="padding:10px 0px 10px 12px;border:none;height:auto;">
				<ul class="teacher" id="teacherPart">
					<!--<li><a href="#">刘强</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关文章</h5>
			<div class="bg" style="padding:10px 0px 10px 12px;border:none;height:auto;">
				<ul class="list9" id="hotArticle">
					<!--<li><a href="#">刘强</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关问答</h5>
			<div class="inQuesiton">	
					<dl id="questions">
						<!--<dd><a href="#">如何解除劳动合同?</a></dd>-->
					</dl>
			</div>
			<h5 >培训下载</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto;">
				<ul class="list9" id="hotDownloads">
					<!-- <li><a>经典资料：行政管理怎样做...</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
			<h5>相关培训机构</h5>
			<ul class="list7" style="padding-top:10px;padding-left:15px;" id="PXOrgs">
				<!--  <li class="line"><a><span class="red">1</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="red">2</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">3</span><span class="text">三人行教育培训机构</span></a></li>
				<li class="line"><a><span class="blue">4</span><span class="text">众行机构</span></a></li>
				<li class="line"><a><span class="blue">5</span><span class="text">众行机构</span></a></li>-->
			</ul>
			<div class="clear"></div>
			<h5>相关客户群</h5>
			<dl class="bestCustomer leftPart left" style="width:200px;" id="customer">
				<!-- <dd><a href="#">华夏基金</a></dd>-->
			</dl>
			<div class="clear"></div>
			<h5>相关评价</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9" id="comments">
					<!--  <li><a>2013年4月培训计划</a></li>-->
				</ul>
				<div class="clear"></div>
			</div>
		</div>
		
		<div style="height:10px; display:block"></div>
		 <div class="sortList">
			<div class="head">
						<div class="tabOn half" id="plan11"><a href='javascript:void(0)' onclick="javascript:seePartTab('plan',1,1)">培训计划</a></div>
						<div class="tabOff half" id="plan12"><a href='javascript:void(0)' onclick="javascript:seePartTab('plan',2,1)">内训计划</a></div>
						<div class="clear"></div>
					</div>
					<div class="bg h315" style="padding:0px 15px 4px 15px;">
						<ul class="list7" style="padding-top:10px" id="plan1">
							<!--<li class="line"><a>企业资本运作与投融资顾问</a></li>  -->
						</ul>
						<div class="clear"></div>
					</div>
		</div>
		<div style="height:10px; display:block"></div>
		 <div class="sortList">
			<div class="head">
						<div class="tabOn half" id="place11"><a  href='javascript:void(0)' onclick="javascript:seePartTab('place',1,1)">培训现场</a></div>
						<div class="tabOff half" id="place12"><a  href='javascript:void(0)' onclick="javascript:seePartTab('place',2,1)">内训现场</a></div>
						<div class="clear"></div>
					</div>
					<div class="bg h315" style="padding:0px 15px 4px 15px;">
						<ul class="list7" style="padding-top:10px" id="place1">
							<!--<li class="line"><a>企业资本运作与投融资顾问</a></li>  -->
						</ul>
						<div class="clear"></div>
					</div>
		</div>
		<div style="height:10px; display:block"></div>
	</div>
	<!--右边部分信息 end-->
	
</div>

<div class="clear"></div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>