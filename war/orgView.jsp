<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String orgID = request.getParameter("id");
%>
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
		loadTeachers();
		//加载热门关键词
		loadHotKeyWord();
		//加载热门专题
		loadHotSubjects()
	});
	function loadTeachers(){
		$.ajax({
			url:"struts/OrgInfo_getOrgInforByID?orgID="+$('#orgID').val(),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$('#currOrg').html(jsonObject.orgName);
				$('#contact').html(jsonObject.contact);
				$('#orgName').html(jsonObject.orgName);
				$('#fax').html(jsonObject.fax);
				$('#address').html(jsonObject.address);
				$('#cel').html(jsonObject.cellphone);
				$('#tel').html(jsonObject.telephone);
				$('#code').html(jsonObject.postCode);
				$('#web').html(jsonObject.website);
				$('#desc').html(jsonObject.introduction);
				
				if(jsonObject.orgName == ""){
					valueStr = "<div class='notice'>该机构已禁用或者删除</div>";
					$('#classes').html(valueStr);
				}
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
					valueStr = "<div class='notice'>没有推荐的关键词</div>";
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
					valueStr = "<div class='notice'>没有推荐的专题</div>";
				$('#hotSubjects').html(valueStr);
			}
		});
	}

</script>
<body>
<jsp:include page="head.jsp" flush="true"/>
<input type='hidden' id="orgID" value='<%=orgID %>' />
<!--当前路径 start-->
<div class="mainContent path">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="index.jsp" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><a href="orgList.jsp" target="_self">培训机构</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><span id="currOrg"></span></li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart" id="leftPart">
		<div id="classes">
		<!--课程介绍 start-->
			<table width="100%" style="font-size:12px;color:#2D4545;"  cellspacing="0" cellpadding="0">
				<tr height="30px"><th colspan="2" align="center" style="font-size:14px"><span id="orgName">xxxx</span></th></tr>
				<!--<tr height="25px"><td width="100px" align="right">擅长领域:</td><td align="left"><span id="expectIn">xxx</span></td></tr>  -->
				<tr height="25px"><td align="right">联系人:</td><td align="left"><span id="contact">xxx</span></td></tr>
				<tr height="25px"><td align="right">移动电话:</td><td align="left"><span id="cel">xxx</span></td></tr>
				<tr height="25px"><td align="right">固定电话:</td><td align="left"><span id="tel">xxx</span></td></tr>
				<tr height="25px"><td align="right">传真号码:</td><td align="left"><span id="fax">xxx</span></td></tr>
				<tr height="25px"><td align="right">邮编:</td><td align="left"><span id="code">xxx</span></td></tr>
				<tr height="25px"><td align="right">网址:</td><td align="left"><span id="web">xxx</span></td></tr>
				<tr height="25px"><td align="right">机构地址:</td><td align="left"><span id="address">xxx</span></td></tr>
				<tr height="25px"><td align="right">机构简介:</td><td align="left"><span id="desc">xxx</span></td></tr>
			</table>
		<!--课程介绍 end-->
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