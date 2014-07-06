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
		getCity();
	})
	//加载下载列表，按照时间顺序
	function getCity(){

		$.ajax({
			url:"struts/Dictionary_queryCity",
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";	
				//alert(data);

				$.each(jsonObject,function(n,value){
					valueStr +="<tr>"+
							   "<td class='province'>"+value.p+"</td><td class='cityTd'><ul>";
					var citys = value.c;
					$.each(citys,function(n,value){
						valueStr +="<li><a href='seeKey.jsp?key="+value+"'>"+value+"</a></li>";
					});
					valueStr += "</ul></td><tr>";
				});

				if(valueStr == ""){
					valueStr = "<div class='notice'>没有设置城市字典</div>";
				}
				//alert(valueStr);
				$('#cityTable').html(valueStr);
			}
		});
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
		<li>城市字典</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->

<!--主体部分二 start-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px">
	<div class="leftInPart">
		<style>
			.cityWrapper{border:1px solid #d0e2d4;width:960px;padding:20px 0 20px 0}
			.cityTable{width:100%;height:100%;font-size:12px;color:#010101}
			.cityTable .province{width:100px;text-align:right;font-weight:bold;vertical-align:top;line-height:23px}
			.cityTable .cityTd{padding-left:15px;vertical-align:top}
			.cityTable ul{list-style:none;text-decoration:none}
			.cityTable ul li{float:left;padding-right:5px}
			.cityTable ul li a{ text-decoration:none;color:#010101;line-height:23px}
			.cityTable ul li a:hover{color:red}
		</style>
		<!--最新的下载 start-->
		<div class="resultPart">
			<div class="cityWrapper">
				<table class="cityTable" id="cityTable">
				</table>
				
			</div>
			<div class="clear" style="height:10px">&nbsp;</div>
		</div>
		<!--消费者相关企业培训 end-->	
		
	</div>
	
	
	</div>
</div>
<!--主体部分二 end-->

<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>