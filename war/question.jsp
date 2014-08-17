<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = request.getParameter("id");
	String username = request.getSession().getAttribute("clientUserName")==null?null:request.getSession().getAttribute("clientUserName").toString();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>南北培训网</title>
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
		
		//加载热门文章
		loadHotArticle();
		//加载推荐文章
		loadRecommandArticle();

		loadAnswers();
	});
	

	function loadAnswers(){
		$.ajax({
			url:encodeURI("struts/Question_viewAnswers?id=")+<%=id%>,
			success:function(data){
				var best_answer_header = "<div class='best-answer'><div class='header-pic'></div>" +
				"<div class='header-label'><span><h2>最佳答案</h2></span></div><div class='content'>";
				var normal_answer_header = "<div><div class='clear'></div><div class='content'>";
				var part2 = "</div><div class='footer'><div class='float-attr' id=answerBy'>";
				var part3 = "</div><div class='float-attr' id='answerDate'>";
				var part4 = "</div></div></div><div class='clear'></div>";

				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					valueStr += (value.isBest?best_answer_header:normal_answer_header) + value.content + part2 + value.answeredBy + part3 + value.answerdDate + part4;
				});
				$('#answers').html(valueStr);
			}
		})
	}


	function answerIt(){
		var user =  "<%=username%>";
		if(user!= "null"&&user!=""){
			if($('#newAnswer').val()==null || $('#newAnswer').val() == ""){
				alert("回答不能为空！");
			}
			var answer = $('#newAnswer').val();
			var tmp = document.createElement("DIV");
		   	tmp.innerHTML = answer;
		   	tmp = tmp.textContent || tmp.innerText || "";
			answer = answer.replace("<script>","").replace("<//script>","");
			$.ajax({
				url:encodeURI("struts/Question_answerIt?id="+<%=id%> + "&myAnswer=" + tmp),
				success:function(data){
					$('#newAnswer').val("");
					loadAnswers();
				}
			});
		}else{
			alert("请先登录！");
		}
	}

	function loadHotArticle(){
		$.ajax({
			url:encodeURI("struts/ViewArticle_getHotArticle"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					var color = "red";
					if(n>2)
						color = "blue";
					valueStr += "<li class='line'><a href='viewArticle.jsp?id="+value.id+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text tooLong w150'>"+value.title+"</span><span class='count'>"+value.hot+"</span></a><div class='clear'></div></li>";
				});
				$('#hotArticle').html(valueStr);
			}
		})
	}
	
	function loadRecommandArticle(){
		$.ajax({
			url:encodeURI("struts/ViewArticle_getRecommandArticle"),
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					var color = "red";
					if(n>2)
						color = "blue";
					valueStr += "<li class='line'><a href='viewArticle.jsp?id="+value.id+"'><span class='"+color+"'>"+(n+1)+"</span><span class='text tooLong w160'>"+value.title+"</span></a><div class='clear'></div></li>";
				});
				$('#recommandArticle').html(valueStr);
			}
		})
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
		<s:property value="inputStream"/>
			<div ><span id="title"><h1><s:property value="%{question.title}" /></h1></span>
			<div class="classNum" id="questionId"><s:property value="%{question.questionId}" /></div></div>
			<div class="detail">

			<div class="classLeftPart" id="courseInfo">
			<div class="time" id="askedBy">提问人：<s:property value="%{question.askedBy}" /></div>
			<div class="time" id="askDate">时间：<s:property value="%{question.askDate}" /></div>
			<div class="time" id="keyWords">
				<span>关键词：</span>
				<s:iterator value="%{question.questionKeywords}" status="xxx">
				  	<s:url var="myURL" value="seeKey.jsp">
						<s:param name="key"><s:property value="keyword"/></s:param>
					</s:url>
				  	<s:a href="%{myURL}"><s:property value="keyword"/></s:a>
				</s:iterator>
			</div>
			<div class="time" id="series">
				<span>专题：</span>
				<s:iterator value="%{question.questionSubjects}" status="xxx">
				  	<s:url var="myURL" value="seeKey.jsp">
						<s:param name="key"><s:property value="subject"/></s:param>
					</s:url>
				  	<s:a href="%{myURL}"><s:property value="subject"/></s:a>
				</s:iterator>
			</div>
			</div>
			
			<div class="clear"></div>
			</div>
			<div class="clear"></div>
			<div id="questionContent" class="qcontent">
					<p id="questionContent"><s:property value="%{question.content}" /></p>
			</div>
			<div class="clear"></div>
		</div>

		<div class="wgt-answers">
			<form id="newAnswer-fm" method="post">
				<textarea id="newAnswer" name="newAnwser" style="height:160px;width:700px;"></textarea>
				<div class="clear"></div>
				<button type="button" onclick="answerIt()" style="padding-top: 10px; padding-bottom: 10px; margin-top: 10px; margin-bottom: 60px;">回答问题</button>
			</form>
		</div>
		<div class="clear"></div>

		<div id="answers" class="wgt-answers">
			<s:if test="%{bestAnswer}!=null">
		  		<div class="best-answer">
					<div class="header-pic">
					</div>
					<div class="header-label">
					<span><h2>最佳答案</h2></span>
					</div>
					<div class="content">
						<p><s:property value="%{bestAnswer.content}" /></p>
					</div>
					<div class="footer">
						<div class="float-attr" id="answerBy">回答者：John Dou</div>
						<div class="float-attr" id="answerDate">时间：2014-04-12 15:35:32</div>
					</div>
				</div>		
		  	</s:if>
			
			<div class="clear"></div>
			
			<s:iterator value="%{answerList}" status="xxx">
			  	<div>
					<div class="clear"></div>
					<div class="content">
						<p><p><s:property value="%{#xxx.content}" /></p></p>
					</div>
					<div class="footer">
						<div class="float-attr" id="answerBy">
							回答者：<s:property value="%{#xxx.answerBy}"/>
						</div>
						<div class="float-attr" id="answerDate">
							时间：<s:property value="%{#xxx.answerDate}"/>
						</div>
					</div>
				</div>
			</s:iterator>
			
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
	</div>
	<!--左边部分课程信息 end-->
	
	<!--右边部分信息 start-->
	<div class="rightInPart">
			<div class="rightTeacher">
				<h5  class="first">热门文章</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:195px;"/>
					<div class="clear" style="height:5px;"></div>
					<ul class="list7" id="hotArticle">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="red">2</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="red">3</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>					
					</ul>	
					<div class="clear"></div>
				</div>
				<h5>推荐文章</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:195px;"/>
					<div class="clear" style="height:5px;"></div>
					<ul class="list7" id="recommandArticle">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span></a><div class="clear"></div></li>
						<li class="line"><a><span class="red">2</span><span class="text">人力资源 </span></a><div class="clear"></div></li>
						<li class="line"><a><span class="red">3</span><span class="text">人力资源 </span></a><div class="clear"></div></li>				
					</ul>
				<div class="clear"></div>
				</div>
			</div>
			<div style="height:30px">&nbsp;</div>
	</div>
	<!--右边部分信息 end-->
	
</div>

<div class="clear"></div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>