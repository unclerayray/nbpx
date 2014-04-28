<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>南北培训网</title>
<link type="text/css" href="css/search.css" rel="stylesheet" />
<link type="text/css" href="css/face.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<script src="js/easyui/jquery-1.8.0.min.js"></script>
<script src="js/easyui/jquery.easyui.min.js"></script>
<script src="js/myjs/index.js"></script>
<script src="ui/jquery.ui.core.js"></script>
<script src="ui/jquery.ui.widget.js"></script>
<script src="ui/jquery.ui.position.js"></script>
<script src="ui/jquery.ui.menu.js"></script>
<script src="ui/jquery.ui.autocomplete.js"></script>
</head>
<body>
<jsp:include page="head.jsp" flush="true"/>

<!--醒目地区start-->
<!-- <div class="mainContent area">
	<ul>
		<li><a href="#">北京培训</a></li>
		<li><a href="#">上海培训</a></li>
		<li><a href="#">杭州培训</a></li>
		<li><a href="#">苏州培训</a></li>
		<li><a href="#">深圳培训</a></li>
		<li><a href="#">广州培训</a></li>
		<li><a href="#">东莞培训</a></li>
		<li><a href="#">全国培训</a></li>
		<li><a href="#">海外培训</a></li>
	</ul>
	<div class="clear"></div>
</div>
 -->
<!--flash start-->
<div class="mainContent flash" style="padding-top:5px;">
	<img  src="images/adv1.gif" width="960" height="60px"/>
</div>
<!--flash end -->

<!--搜索start-->
<div class="mainContent search">
	<div class="rightContent">
		<input type="hidden" value="qypx" id="search_type" NAME="search_type">
		<div  id="searchTab"  class="searchType">
			<ul>
				<li id="searchTab_Title0" class="on" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='qypx';"><a href='javascript:void(0)' >企业培训</a></li>
				<li id="searchTab_Title1" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='pxs';"><a href='javascript:void(0)'>培训师</a></li>
				<li id="searchTab_Title2" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='pxjh';"><a href='javascript:void(0)'>培训计划</a></li>
				<li id="searchTab_Title3" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='qynx';"><a href='javascript:void(0)'>企业内训</a></li>
				<li id="searchTab_Title4" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='nxs';"><a href='javascript:void(0)'>内训师</a></li>
				<li id="searchTab_Title5" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='nxsp';"><a href='javascript:void(0)'>内训视频</a></li>
				<li id="searchTab_Title6" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='xz';"><a href='javascript:void(0)'>下载</a></li>
				<li id="searchTab_Title7" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='wk';"><a href='javascript:void(0)'>文库</a></li>
				<li id="searchTab_Title8" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='jg';"><a href='javascript:void(0)'>机构</a></li>
				<li id="searchTab_Title9" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='wd';"><a href='javascript:void(0)'>问答</a></li>
				<li id="searchTab_Title10" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='khpj'"><a href='javascript:void(0)'>客户评价</a></li>
				<li id="searchTab_Title11" onclick="searchTabs('searchTab',this);document.getElementById('search_type').value='khq';"><a href='javascript:void(0)'>客户群</a></li>
			</ul>
		</div>
	</div>
	<div class="clear"></div>
	<div class="searchInput"><input id="key" value="请输入关键字,如: 员工 管理" onfocus="if (this.value=='请输入关键字,如: 员工 管理'){this.value='';}" 
	onblur="if (this.value==''){this.value='请输入关键字,如: 员工 管理';}" onkeydown="fnt_top_search2(event);" />
	<button class="searchButton"  onclick="fnt_top_search(document.getElementById('search_type').value);">搜&nbsp;索</button></div>
</div>
<!--搜索end-->

<!--按子母检索 start-->
<div class="quickFind">
	<div class="title">热门搜索:</div>
	<div class="condition">
		<ul>
			<li><a href="#">清华大学</a></li>
			<li><a href="#">岗位分析</a></li>
			<li><a href="#">股权激励</a></li>
			<li><a href="#">沟通</a></li>
			<li><a href="#">工商管理</a></li>
		</ul>
	</div>
	<div  class="clear"></div>
</div>
<!--关键字 start-->
<div class="mainContent keyWord">
	<div class="item" id="topkey1">
		<div class="title"><a href="keyWordMore.jsp?type=1">财务管理</a></div>
		<div class="content">
			<ul id="topkey_c1">
			</ul>
		</div>	
	</div>
	<div class="clear"></div>
	<div class="item" id="topkey2">
		<div class="title"><a href="keyWordMore.jsp?type=2">人力资源</a></div>
		<div class="content">
			<ul id="topkey_c2">
			</ul>
		</div>
		
	</div>
	<div class="clear"></div>
	<div class="item" id="topkey3">
	<div class="title"><a href="keyWordMore.jsp?type=3">生产管理</a></div>
		<div class="content">
			<ul id="topkey_c3">
			</ul>
		</div>
		<div class="clear"></div>
	</div>
	<div class="item" id="topkey4">
		<div class="title"><a href="keyWordMore.jsp?type=4">战略管理</a></div>
		<div class="content">
			<ul id="topkey_c4">
			</ul>
		</div>
	</div>
	<div class="clear"></div>
	<div class="item" id="topkey5">
		<div class="title"><a href="keyWordMore.jsp?type=5">项目管理</a></div>
		<div class="content">
			<ul id="topkey_c5">
			</ul>
		</div>
	</div>
	<div class="clear"></div>
	<div class="item" id="topkey6">
		<div class="title"><a href="keyWordMore.jsp?type=6">职业技能</a></div>
		<div class="content">
			<ul id="topkey_c6">
			</ul>
	</div>
	<div class="clear"></div>
	<div class="item" id="topkey7">
		<div class="title"><a href="keyWordMore.jsp?type=7">研修班人&nbsp;&nbsp;</a></div>
		<div class="content">
			<ul id="topkey_c7">
			</ul>
		</div>
	</div>
	<div class="clear"></div>
	<div class="item" id="topkey8">
		<div class="title"><a href="keyWordMore.jsp?type=8">采购仓储</a></div>
		<div class="content">
			<ul id="topkey_c8">
			</ul>
			
		</div>
	</div>
	<div class="clear"></div>
</div>
<div class="clear"></div>
<!--关键字 end-->
<script>
	$(function(){
		//加载提示
		loadTip();
		//加载地区
		loadCityCourse(1);
		//加载企业培训
		loadTop(1);
		//加载培训课程
		for(var i=1;i<=8;i++)
			seePartTab('a',1,i);
		//加载内训课程
		for(var i=1;i<=8;i++)
			seePartTab('b',1,i);
		//加载关键词u
		for(var i=1;i<=3;i++)
			seePartTab('k',1,i);
		//加载专题
		for(var i=1;i<=2;i++)
			seePartTab('s',1,i);
		//加载文章
		var tabCount = 4;
		for(var i=1;i<=8;i++){
			if(i == 2)
				tabCount =3;
			loadPartDateForArticle(tabCount,1,i,"");
		}
			//seePartTab('c',1,i);
		//加载培训下载
		seePartTab('d',1,1);
		//加载企业培训机构
		seePartTab("org",1,1);
		
		//008 009 010 011 加载关键词
		seePartTab('dic',1,1);
		
		//加载顶部关键词
		for(var i=1;i<=8;i++)
			loadTopKey(i);
		//加载题目字典
		loadDics('020',8,'timu_dic');
		//加载培训机构字典
		loadDics('004',11,'jigou_dic');
		//加载客户评价
		loadDics("25",10,"customSay")
	});	
	

	function loadTip(){
		var search_type = document.getElementById('search_type').value;
		var searchUrl = '';
		if(search_type=='qypx'){
			searchUrl = 'struts/Search_queryKeywordsByKeyword';
		}else if(search_type=='pxs'){
			searchUrl = 'struts/Search_queryTeacherTip';
		}else if(search_type=='khpj'){
			//how to tip?
		}else if(search_type=='khq'){
			//how to tip?
		}else if(search_type=='jg'){
			//how to tip?
		}else if(search_type=='nxs'){
			//shouldn't have those
		}else{
			searchUrl = 'struts/Search_queryKeywordsByKeyword';
		}
		$( "#key" ).autocomplete({
			minLength: 1,
			source: function(request, response) {
				$.ajax({
					url: searchUrl,
					delay: 500,
					dataType:'json',
					timeout: 5000,
					data: {
						featureClass: "P",
						style: "full",
						maxRows: 12,
						wt:"json",
						q:$("#key").val(),
						name_startsWith: request.term
					},
					success: function(data) {
						response($.map(data, function(item) {
							return {
								label: item.keyword,
								value: item.keyword
							}
						}));
					}
				});
			}
		});
	}
	function loadDics(type,rows,id){
		$.ajax({
			url: 'struts/ViewDic_getMoreDicItems?codeName='+type+'&rows='+rows+'&page=1',
			success:function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject.rows,function(n,value){
					if(id == 'timu_dic')
						valueStr += "<li><a href=\"seeKey.jsp?key="+value.showName+"\">"+value.showName+"</a></li>";
					if(id == 'jigou_dic')
						valueStr += "<li><a class='left tooLong w230' href=\"seeKey.jsp?key="+value.showName+"\">"+value.showName+"</a></li>";	
					if(id == 'customSay')
						valueStr += "<li><a class='left tooLong w200'>"+value.showName+"</a></li>";
				});
	
				if(valueStr == "")
					valueStr ="<div class='notice'>暂时没有字典信息</div>";
				
				$('#'+id).html(valueStr);
			}
			
		});
	}
	
	function loadTopKey(type){
		var urlStr = 'struts/Main_getTopKeyWord?category='+type;
		$.ajax({
			url:encodeURI(urlStr),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr += "<li><a href=\"seeKey.jsp?key="+value.name+"\">"+value.name+"</a></li>";
					if(n<jsonObject.length-1)
						valueStr += "<li>|</li>";	
				});
				if(valueStr == ''){
					valueStr = "<div class='notice' style='font-size:12px'>暂时没有推荐的关键词</div>";
					//$('#topkey'+type).css('display','none');
				}else
					valueStr += "<li><a href='keyWordMore.jsp?type="+type+"'><img src='images/more.gif'/></a></li>";
	
				$('#topkey_c'+type).html(valueStr);
			}		
		})
	}
	function loadTopKey(type){
		var urlStr = 'struts/Main_getTopKeyWord?category='+type;
		$.ajax({
			url:encodeURI(urlStr),
			success: function(data){
				var jsonObject = eval('('+data+')');
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr += "<li><a href=\"seeKey.jsp?key="+value.name+"\">"+value.name+"</a></li>";
					if(n<jsonObject.length-1)
						valueStr += "<li>|</li>";	
				});
				if(valueStr == ''){
					valueStr = '暂时没有推荐的关键词';
					//$('#topkey'+type).css('display','none');
				}else
					valueStr += "<li><a href='keyWordMore.jsp?type="+type+"'><img src='images/more.gif'/></a></li>";
	
				$('#topkey_c'+type).html(valueStr);
			}		
		})
	}
	function changeCity(flag){
		for(var i=1;i<=5;i++){
			if(i == flag){
				$('#c'+i).attr('class','tabOn');
				loadCityCourse(flag);
			}
			else
				$('#c'+i).attr('class','tabOff');
		}
	}
	function changeTab(flag){
		for(var i=1;i<=3;i++){
			if(i == flag){
				$('#f'+i).attr('class','tabOn three2');
				loadTop(flag);
			}else
				$('#f'+i).attr('class','tabOff three2');
		}	
	}
	function loadTop(flag){
		$.ajax({
			url:encodeURI('struts/Main_getTopCourse?flag='+flag),
			success: function(data){
				var jsonObject = eval("("+data+")");
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					if(n == 0)
						valueStr += "<div class='item first'>";
					else
						valueStr += "<div class='item'>";	
					valueStr += "<div class='title'><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></div>"+
								"<div class='infor'><span class='teacher'>["+value.teacher+"]</span><span class='date'>"+value.date+
								"</span><span class='city'>"+value.city+"</span></div></div>";
				})
				if(valueStr == "")
						valueStr = "<div class='notice'>没有最新的培训</div>";
				$('#topCourse').html(valueStr);
			}		
		})
	}
	
	function seePartTab(pre,flag,part){
		var count = 0;
		var cssOn = "tabOn";
		var cssOff = "tabOff";
		if(pre == 'a')
			count = 4;
		if(pre == 'b')
			count = 4;
		if(pre == 'c')
			count = 2;
		if(pre == 'dic')//产品字典等
			count = 4;
		if(pre == 'k'){//flag为1代表是培训关键词，2代表内训关键词，3代表文章关键词
			if(part  == 1){
				count = 2;
				cssOn = "tabOn half";
				cssOff = "tabOff half";
			}else{
				count = 3;
				cssOn = "tabOn three";
				cssOff = "tabOff three";
			}
		}

		if(pre == 's' || pre == 't'){//专题
			count = 3;
			cssOn = "tabOn three";
			cssOff = "tabOff three";
		}
		if(pre == 'd' || pre == 'org')//培训下载和企业机构
			count = 3;
			
		for(var i=1;i<=count;i++){
			if(i == flag){
				$('#'+pre+part+i).attr('class',cssOn);
				loadPartDate(pre,flag,part);
			}else
				$('#'+pre+part+i).attr('class',cssOff);
		}	
	}
	
	//专门为文章部分显示用的函数
	function loadPartDateForArticle(count,flag,part,key){
		var cssOn = "tabOn";
		var cssOff = "tabOff";
		for(var i=1;i<=count;i++){
			if(i == flag){
				$('#c'+part+i).attr('class',cssOn);
				//加载文章信息
				$.ajax({
					url:encodeURI('struts/Main_getArticle?flag='+flag+'&type='+part+"&key="+key),
					success: function(data){
						var jsonObject = eval('('+data+')');
						var valueStr = "";
						$.each(jsonObject,function(n,value){
							valueStr += "<li><a href='viewArticle.jsp?id="+value.articleId+"'>"+value.articleTitle+"</a></li>";
						});
						if(valueStr == "")
							valueStr = "<div class='notice'>没有最新的文章</div>";
						$("#cn"+part).html(valueStr);
					}		
				});
			}else
				$('#c'+part+i).attr('class',cssOff);
		}	
	}
	
	//加载tab页
	function loadPartDate(pre,flag,part){
		if(pre == 'a'){//获取培训的内容
			$.ajax({
				url:encodeURI('struts/Main_getPeiXun?flag='+flag+'&type='+part),
				success: function(data){
					//alert(data);
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject,function(n,value){
						valueStr += "<li><a href='viewClass.jsp?id="+value.courseId+"'>"+value.title+"</a></li>";
					});
					if(valueStr == "" || valueStr == "暂无课程信息")
						valueStr = "<div class='notice'>没有最新的培训</div>";
					$('#'+pre+part).html(valueStr);
				}		
			})
		}
		if(pre == 'b'){//加载内训的内容
			$.ajax({
				url:encodeURI('struts/Main_getNeiXun?flag='+flag+'&type='+part),
				success: function(data){
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject,function(n,value){
						if(n == 0){
							$('#'+pre+part+"P").html("<img src=\""+value.img+"\" />");
							$('#'+pre+part+"T").html(value.title);
							$('#'+pre+part+"C").html(value.content+"...<span>[<a href='viewClass.jsp?id="+value.id+"'>详细</a>]</span>");
						}else
							valueStr += "<li><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a></li>";
					});
					if(valueStr == "")
						valueStr = "<div class='notice'>没有最新的内训</div>";
					$('#'+pre+part).html(valueStr);
				}		
			})
		}
		if(pre == 'c'){//加载文章内容
			$.ajax({
				url:encodeURI('struts/Main_getArticle?flag='+flag+'&type='+part),
				success: function(data){
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject,function(n,value){
						valueStr += "<li><a href='viewArticle.jsp?id="+value.articleId+"'>"+value.articleTitle+"</a></li>";
					});
					if(valueStr == "")
						valueStr = "<div class='notice'>没有最新的文章</div>";
					$('#'+pre+"n"+part).html(valueStr);
				}		
			})
		}
		
		if(pre == 't'){//推荐、本月最热、本周最热
			var returnValue = "[]";
			if(flag == '1'){//课程推荐
				
			}else{//本周最热、本月最热
				var time = 1;//一周
				if(flag == '2')
					time = 2;//一个月
				//alert(time);
				$.ajax({
					url:encodeURI("struts/Main_getTimeTopCourse?flag="+time),
					success:function(data){
						//alert(data);
						returnValue = data;
					}
				});
			}
		
			var jsonObject = eval('('+returnValue+')');
			var valueStr = "";
			$.each(jsonObject,function(n,value){
				valueStr += "<li><a class='left' href='viewClass.jsp?id="+value.id+"'>"+value.name+"</a></li>";
			});
			$('#'+pre+part).html(valueStr);
			
		}
		if(pre == 's'){//获取专题，flag 1代表培训专题，2代表内训关键词
			var urlStr;var sortType;
			if(part == '1')//培训
				urlStr = "struts/Main_getSubjects?isInner=0";
			else//内训
				urlStr = "struts/Main_getSubjects?isInner=1";
			if(flag == '1')
				sortType = "2";
			else if(flag == '2')
				sortType = "3";
			else
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
							valueStr += "<li class='line'><a href='#'><span class=\""+color+"\">"+(n+1)+"</span><span class='text tooLong w150'>"+value.name+"</span><span class='count'></span></a><div class='clear'></div></li>";
						else
							valueStr += "<li class='line'><a href='#'><span class=\""+color+"\">"+(n+1)+"</span><span class='text tooLong w150'>"+value.name+"</span><span class='count'>"+value.count+"</span></a><div class='clear'></div></li>";
					});
					$('#'+pre+part).html(valueStr);
				}
			});
			
		}
		if(pre == 'k'){//获取关键词 flag 1代表是培训关键词，2代表内训关键词，3代表文章关键词
			var urlStr;var sortType;
			if(part == '1'){//培训关键词	
				if(flag == '1')
					sortType = '3';//热搜
				else
					sortType = '1';//点击率排行
				urlStr = 'struts/Main_getKeywords?isInner=0';
			}else if(part == '2'){//内训关键词
				if(flag == '1')
					sortType = '3';
				else if(flag == '2')
					sortType = '2';
				else
					sortType = '1';
				urlStr = 'struts/Main_getKeywords?isInner=1';
			}else{//文章关键词
				if(flag == '1')
					sortType = '3';
				else if(flag == '2')
					sortType = '1';
				else
					sortType = '2';
				urlStr = "";
			}
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
			
					$('#'+pre+part).html(valueStr);
				}		
			})
		}
		if(pre == 'dic'){
			var type = "008";
			if(flag == 2)
				type="009";
			if(flag == 3)
				type = "010";
			if(flag == 4)
				type = "011";
			$.ajax({
				url: 'struts/ViewDic_getMoreDicItems?codeName='+type+'&rows=90&page=1',
				success:function(data){
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject.rows,function(n,value){
						valueStr += "<li><a href=\"seeKey.jsp?key="+value.showName+"\">"+value.showName+"</a></li>";
					});
		
					if(valueStr == "")
						valueStr ="<div class='notice'>暂时没有字典信息</div>";
					
					$('#'+pre+part).html(valueStr);
				}
				
			});
		}
		if(pre == 'd'){
			$.ajax({
				url:"struts/Main_getDownLoads?flag="+flag,
				success:function(data){
					//alert(data);
					var jsonObject = eval('('+data+')');
					var valueStr = "";
					$.each(jsonObject.rows,function(n,value){
						valueStr += "<li><a href='struts/Download_downLoadFile?id="+value.id+"'>"+value.title+"</a></li>";
					});
					$('#'+pre+part).html(valueStr);
				}
			});
		}
	}
	function loadCityCourse(flag){
		$.ajax({
			url:encodeURI('struts/Main_getCourseByCity?flag='+flag),
			success: function(data){
				var jsonObject = eval("("+data+")");			
				var valueStr = "";
				$.each(jsonObject,function(n,value){
					valueStr += "<li><a href='viewClass.jsp?id="+value.id+"'>"+value.title+"</a><div>"+value.date+"/<span class='money'>￥</span>"+value.price+"</div></li>";
				});
				if(valueStr == "")
					valueStr = "<div class='notice'>没有最新的培训</div>";
				$('#cityList').html(valueStr);
			}		
		})
	}
</script>
<!--主体 部分一 start-->

<div class="mainContent partOne">
	<div class="left">
		<!--城市 start-->
		<div class="firstHead">
			<div class="tabOn" id="c1"><a href="javascript:void(0)" onclick="javascript:changeCity(1)">北京</a></div>
			<div class="tabOff" id="c2"><a href="javascript:void(0)" onclick="javascript:changeCity(2)">上海</a></div>
			<div class="tabOff" id="c3" ><a href="javascript:void(0)" onclick="javascript:changeCity(3)">深圳</a></div>
			<div class="tabOff" id="c4"><a href="javascript:void(0)" onclick="javascript:changeCity(4)">广州</a></div>
			<div class="tabOff" id="c5"><a href="javascript:void(0)" onclick="javascript:changeCity(5)">苏州</a></div>
			<div class="more"><a href="#">更多</a></div>
			<div class="clear"></div>
		</div>
		<div class="bg" style="background:none;border-bottom:1px solid #ddeae0;height:210px">
			<ul class="list1" id="cityList">
				<li><a href="#">销售精英2天一夜疯狂训练</a><div>04-12/<span class="money">￥</span>1800</div></li>
				<li><a href="#">销售精英2天一夜疯狂训练</a><div>04-12/<span class="money">￥</span>1800</div></li>
				<li><a href="#">销售精英2天一夜疯狂训练</a><div>04-12/<span class="money">￥</span>1800</div></li>
				<li><a href="#">销售精英2天一夜疯狂训练</a><div>04-12/<span class="money">￥</span>1800</div></li>
				<li><a href="#">销售精英2天一夜疯狂训练</a><div>04-12/<span class="money">￥</span>1800</div></li>
				<li><a href="#">销售精英2天一夜疯狂训练</a><div>04-12/<span class="money">￥</span>1800</div></li>
				<li><a href="#">销售精英2天一夜疯狂训练</a><div>04-12/<span class="money">￥</span>1800</div></li>
				<li><a href="#">销售精英2天一夜疯狂训练</a><div>04-12/<span class="money">￥</span>1800</div></li>
			</ul>
		</div>
		<!--城市 end-->
		<div style="padding:10px 0px"> 
				<img  src="images/leftAdv.jpg" width="310" height="110"/>
		</div>
		
		<!--月份 start-->
		<div class="head">2012年企业培训计划</div>
		<div class="bg p5">
			<ul class="list2">
				<li><a href="#">01月</a><span>|</span></li>
				<li><a href="#">02月</a><span>|</span></li>
				<li><a href="#">03月</a><span>|</span></li>
				<li><a href="#">04月</a><span>|</span></li>
				<li><a href="#">05月</a><span>|</span></li>
				<li><a href="#">06月</a><span>&nbsp;</span></li>
				<li><a href="#">07月</a><span>|</span></li>
				<li ><a href="#">08月</a><span>|</span></li>
				<li><a href="#">09月</a><span>|</span></li>
				<li><a href="#">10月</a><span>|</span></li>
				<li><a href="#">11月</a><span>|</span></li>
				<li><a href="#">12月</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<!--月份 end-->
		
		<!--内训 start-->
		<div class="head">2013年企业培训计划</div>
			<div class="bg p5" style="border-bottom:1px solid #ebebeb">
			<ul class="list2">
				<li><a href="#">01月</a><span>|</span></li>
				<li><a href="#">02月</a><span>|</span></li>
				<li><a href="#">03月</a><span>|</span></li>
				<li><a href="#">04月</a><span>|</span></li>
				<li><a href="#">05月</a><span>|</span></li>
				<li><a href="#">06月</a><span>&nbsp;</span></li>
				<li><a href="#">07月</a><span>|</span></li>
				<li><a href="#">08月</a><span>|</span></li>
				<li><a href="#">09月</a><span>|</span></li>
				<li><a href="#">10月</a><span>|</span></li>
				<li><a href="#">11月</a><span>|</span></li>
				<li><a href="#">12月</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<!--内训 end-->
		<div style="height:10px; display:block"></div>
		<!--最新消息 start-->
			<div class="fisrtHead news"  style="border:1px solid #ddeae0; border-bottom:0px;">
				<div class="tabOn">题目字典</div>
				<div class="clear"></div>
			</div>
			<div class="bg" style="height:177px;background:none;border-bottom:1px solid #ddeae0;padding-left:30px">
					<ul class="list4" id="timu_dic">
					</ul>
			</div>
		<!--最新消息 end-->
		
	</div>
	<div class="right">
		<div class="head">
			<div class="tabOn three2" id="f1"><a href='javascript:void(0)' onclick="javascript:changeTab(1)">企业培训(solr)</a></div>
			<div class="tabOff three2" id="f2"><a href='javascript:void(0)' onclick="javascript:changeTab(2)">企业管理(solr)</a></div>
			<div class="tabOff three2" id="f3"><a href='javascript:void(0)' onclick="javascript:changeTab(3)">热门培训(点击率+推荐)</a></div>
		</div>
		<div class="bg" id="topCourse" style='height:750px;'>
			<div class="item first">
				<div class="title"><a href="#">成功的产品经理高级实务</a></div>
				<div class="infor"><span class="teacher">[张守春]</span><span class="date">2013-04-12</span><span class="city">广州</span></div>
			</div>
			<div class="clear"></div>
		</div>
		
		<!-- <div style="padding-top:10px;">
			<img  src="images/partOne1.jpg" class="left"  style="width:377px;height:60px"/>
			<img  src="images/partOne2.jpg" class="right"  style="width:250px;height:60px"/>
		</div> -->
	</div>
</div>
<!-- 主体部分二 end-->
<!--flash start-->
<div class="clear"></div>
<div class="mainContent flash" style="padding-top:10px;">
	<img  src="images/flash2.jpg" width="960"/>
</div>
<!--flash end -->

<!-- 专业、职位、等 start -->
<style>
	.typeUl,.keyUl{text-decoration:none;list-style:none}
	.typeUl li{float:left;list-style:none;padding:3px 20px;background:red}
	.keyUl{float:left;margin-right:5px;}
	.keyUl li{padding:5px 3px;margin:0px}
	.keyUl li a{color:#2D4545;text-decoration:none;font-size:12px}
	.keyUl li a:hover{color:red}
</style>
<div class="mainContent partTwo" style='padding-top:10px;'>
				<div class="head" style='width:100%;background:url(images/longBg.png) -2px -1px no-repeat;'>
				<div class="tabOn" id="dic11"><a href='javascript:void(0)' onclick="javascript:seePartTab('dic',1,1)">行业培训</a></div>
				<div class="tabOff" id="dic12"><a href='javascript:void(0)' onclick="javascript:seePartTab('dic',2,1)">专业培训</a></div>
				<div class="tabOff" id="dic13"><a href='javascript:void(0)' onclick="javascript:seePartTab('dic',3,1)">职位培训</a></div>
				<div class="tabOff" id="dic14"><a href='javascript:void(0)' onclick="javascript:seePartTab('dic',4,1)">产品培训</a></div>
				<div class="clear"></div>
				</div>
	<div style="height:285px;padding:10px;border:1px solid #D0E2D4;border-top:none">
		<ul class="keyUl" id="dic1">
					<li><a href="#">软件工程师</a></li>
			</ul>
	</div>
</div>
<!-- 专业、职位、等 end -->

<!--主体部分二 start-->
<div class="mainContent partTwo">
	<ul>
		<li class="noneStyle">
			<div class="part left">
				<div class="head">
				<div class="tabOn" id="a11"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',1,1)">财务管理</a></div>
				<div class="tabOff" id="a12"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',2,1)">经典培训</a></div>
				<div class="tabOff" id="a13"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',3,1)">排行</a></div>
				<div class="tabOff" id="a14"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',4,1)">推荐</a></div>
				<div class="more"><a href="viewCourseType.jsp?isInner=0&type=1">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a1">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
				<img  src="images/class1.jpg"   style="padding-top:10px;"/>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="a21"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',1,2)">采购供应链仓储</a></div>
					<div class="tabOff" id="a22"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',2,2)">经典培训</a></div>
					<div class="tabOff" id="a23"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',3,2)">排行</a></div>
					<div class="tabOff" id="a24"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',4,2)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=0&type=2">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a2">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
					
				</div>
				<img  src="images/class3.jpg"  />
			</div>
		</li>
		<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn half" id="k11"><a href='javascript:void(0)' onclick="javascript:seePartTab('k',1,1)">关键词热搜</a></div>
					<div class="tabOff half" id="k12"><a href='javascript:void(0)' onclick="javascript:seePartTab('k',2,1)">关键词排行</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 15px;"/>
					<ul class="list7" style="padding-top:10px" id="k1">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
		
		</li>
	<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn" id="a31"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',1,3)">人力资源管理</a></div>
					<div class="tabOff" id="a32"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',2,3)">经典培训</a></div>
					<div class="tabOff" id="a33"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',3,3)">排行</a></div>
					<div class="tabOff" id="a34"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',4,3)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=0&type=3">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245" >
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a3">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
				<img  src="images/class4.jpg" />
	</div>
	</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="a41"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',1,4)">生产管理</a></div>
					<div class="tabOff" id="a42"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',2,4)">经典培训</a></div>
					<div class="tabOff" id="a43"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',3,4)">排行</a></div>
					<div class="tabOff" id="a44"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',3,4)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=0&type=4">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a4">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
				<img  src="images/class6.jpg" />
			</div>
		</li>
		<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" id="s11"><a href='javascript:void(0)' onclick="javascript:seePartTab('s',1,1)">专题推荐</a></div>
					<div class="tabOff three" id="s12"><a href='javascript:void(0)' onclick="javascript:seePartTab('s',2,1)">专题热搜</a></div>
					<div class="tabOff three" id="s13"><a href='javascript:void(0)' onclick="javascript:seePartTab('s',3,1)">专题排行</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 15px;">
					<ul class="list7" style="padding-top:10px" id="s1">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
		
		</li>
		<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="a51"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',1,5)">市场营销</a></div>
					<div class="tabOff" id="a52"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',2,5)">经典培训</a></div>
					<div class="tabOff" id="a53"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',3,5)">排行</a></div>
					<div class="tabOff" id="a54"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',4,5)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=0&type=5">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a5">
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
					<div class="tabOn" id="a61"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',1,6)">战略管理</a></div>
					<div class="tabOff" id="a62"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',2,6)">经典培训</a></div>
					<div class="tabOff" id="a63"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',3,6)">排行</a></div>
					<div class="tabOff" id="a64"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',4,6)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=0&type=6">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a6">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
				<img  src="images/class5.jpg" />
	</div>
	</li>
	<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" >培训类别</div>
					<div class="tabOff three">内训类别</div>
					<div class="tabOff three">排行</div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 0px 0px 25px;">
					<ul class="list5" style="padding-top:10px;width:230px;">
						<li><a class="left">战略管理</a><span>&nbsp;</span><a class="left">人力资源管理</a></li>
						<li><a class="left">生产管理</a><span>&nbsp;</span><a class="left">市场营销</a></li>
						<li><a class="left">财务管理</a><span>&nbsp;</span><a class="left">客户服务</a></li>
						<li><a class="left">采购物流</a><span>&nbsp;</span><a class="left">职业技能</a></li>
						<li><a class="left">质量管理</a><span>&nbsp;</span><a class="left">项目管理</a></li>
						<li><a class="left">团队建设</a><span>&nbsp;</span><a class="left">MBA总裁研修班</a></li>
						<li><a class="left">行政管理</a><span>&nbsp;</span><a class="left">领导力</a></li>
						<li><a class="left">战略管理</a><span>&nbsp;</span><a class="left">人力资源管理</a></li>
						<li><a class="left">生产管理</a><span>&nbsp;</span><a class="left">市场营销</a></li>
						<li><a class="left">财务管理</a><span>&nbsp;</span><a class="left">客户服务</a></li>
						<li><a class="left">生产管理</a><span>&nbsp;</span><a class="left">市场营销</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
	</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="a71"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',1,7)">项目管理</a></div>
					<div class="tabOff" id="a72"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',2,7)">经典培训</a></div>
					<div class="tabOff" id="a73"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',3,7)">排行</a></div>
					<div class="tabOff" id="a74"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',4,7)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=0&type=7">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a5">
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
					<div class="tabOn" id="a81"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',1,8)">职业技能</a></div>
					<div class="tabOff" id="a82"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',2,8)">经典培训</a></div>
					<div class="tabOff" id="a83"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',3,8)">排行</a></div>
					<div class="tabOff" id="a84"><a href='javascript:void(0)' onclick="javascript:seePartTab('a',4,8)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=0&type=8">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4" id="a6">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
				<img  src="images/class5.jpg" />
	</div>
	</li>
	<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" >客户评价</div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 0px 0px 25px;">
					<ul class="list5" style="padding-top:10px;width:230px;" id="customSay">
					</ul>
					<div class="clear"></div>
				</div>
			</div>
	</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="title left">研修班</div>
					<div class="tabOn">北大</div>
					<div class="tabOff">清华</div>
					<div class="tabOff">交大</div>
					<div class="tabOff">复大</div>
					<div class="tabOff">中大</div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4">
							<li><a href="#">北京大学私富有研修班</a></li>
							<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
							<li><a href="#">应收账款控制与催收及信用管理实务</a></li>
							<li><a href="#">企业资本运作与投融资顾问班</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
							<li><a href="#">应收账款控制与催收及信用管理实务</a></li>
							<li><a href="#">企业资本运作与投融资顾问班</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">企业资本运作与投融资顾问班</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
			</div>
		</li>
	<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn">工商管理</div>
					<div class="tabOff">金融投资</div>
					<div class="tabOff">总裁战略</div>
					<div class="tabOff">房地产班</div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4">
							<li><a href="#">北京大学私富有研修班</a></li>
							<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
							<li><a href="#">应收账款控制与催收及信用管理实务</a></li>
							<li><a href="#">企业资本运作与投融资顾问班</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
							<li><a href="#">应收账款控制与催收及信用管理实务</a></li>
							<li><a href="#">企业资本运作与投融资顾问班</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">企业资本运作与投融资顾问班</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
	</div>
	</li>
	<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" id="t11"><a href='javascript:void(0)' onclick="javascript:seePartTab('t',1,1)">培训推荐</a></div>
					<div class="tabOff three" id="t12"><a href='javascript:void(0)' onclick="javascript:seePartTab('t',2,1)">本月最热</a></div>
					<div class="tabOff three" id="t13"><a href='javascript:void(0)' onclick="javascript:seePartTab('t',3,1)">本周最热</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg" style="padding:0px 0px 0px 15px;">
					<ul class="list5" style="padding-top:10px;width:230px;" id="t1">
						<li><a class="left">生产管理技能提升</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
		
		</li>
	</ul>
	<div class="clear"></div>
</div>
<!--主体部分二 end-->

<!--主体部分三 start-->
<!--flash start-->

<div class="mainContent flash" >
	<img  src="images/flash2.jpg" width="960"/>
</div>
<div style='height:10px'></div>
<style>
.item_box {
	border: 1px solid #D0E2D4;
	width:960px;
}
.item_title {
	height: 32px;
	line-height: 32px;
	background: #F8F8F8;
	font-size: 14px;
	color: #1D2736;
	border-top: 1px solid #FFF;
	padding: 0 15px;
	position: relative;
	text-align:left;
	_zoom: 1;
	font-weight: bold;
	background:url(images/longBg.png) -2px -1px no-repeat;
}
.item_body {
	padding: 0px 20px 10px 20px;
}
 .item_wallpaper {
	_zoom: 1;
	width: 920px;
	overflow: hidden;
}
 .item_body ul {
	width: 960px;
	margin-top: -1px;
	margin-left: -10px;
}
 .item_body li {
	float: left;
	width: 274px;
	border-top: 1px solid #EEE;
	border-right: 1px solid #EEE;
	padding: 0px 20px 10px 20px;
	line-height: 22px;
	height: 120px;
	overflow: hidden;
}
.item_body li dl {
	display: block;
	text-align:left;
}
.item_body dt {
font-size: 14px;
color: #555;
font-weight: bold;
padding-bottom: 2px;
	text-align:left;
}
.item_body dd {
	height: 88px;
	overflow: hidden;
	padding-left:10px;
	margin:0px
}
.item_body dd .pic_text {
	float: right;
	line-height: 18px;
	width: 80px;
	height: 80px;
	margin-top: 5px;
	overflow: hidden;
}
.item_body dd .pic_text .pic {
	height: 80px;
}
.item_body dd a {
	float: left;
	white-space: nowrap;
	padding-right: 13px;
	font-size:12px;
	padding-left:0px;
}
.clearfix:{background:blue}
</style>
<!-- 新增培训导航 start -->
<div class="item_box mainContent">
		<div class="item_title" >职位导航</div>
		<div class="item_body">
			<div class="item_wallpaper">
				<ul class="clearfix">
					<li>
						<dl>
							<dt>销售/客服/技术支持</dt>
							<dd class="clearfix">
								<div class="pic_text">
									<div class="pic"><a href="/activities/sales/index.xhtml" title="销售类岗位招聘专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="销售类岗位招聘专场"></a></div>
								</div>								
								<a  href='#' target="_blank">sales</a>
								<a href='#' target="_blank">销售代表</a>
								<a href='#' target="_blank">业务员</a>
								<a href='#' target="_blank">客户经理</a>
								<a href='#' target="_blank">电话销售</a>
								<a href='#' target="_blank">网络销售</a>
								<a href='#' target="_blank">销售管理</a>
								<a  href='#' target="_blank">销售经理</a>
								<a href='#' target="_blank">销售主管</a>
								<a href='#' target="_blank">销售工程师</a>
								<a href='#' target="_blank">销售总监</a>
								<a href='#' target="_blank">销售助理</a>
								<a href='#'  target="_blank">客服</a>
								<a href='#' target="_blank">客服经理</a>
							</dd>
						</dl>
					</li>
					<li> 
						<dl>
							<dt>人事/行政/文职/高级管理</dt>
							<dd class="clearfix">
								<div class="pic_text">
									<div class="pic"><a href="/activities/hr.xhtml" title="人事行政类岗位招聘专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="人事行政类岗位招聘专场"></a></div>
								</div>							
								<a >HR</a>
								<a>人事专员</a>
								<a href='#' target="_blank">行政专员</a>
								<a href='#' target="_blank">招聘</a>
								<a href='#' target="_blank">培训</a>
								<a href='#' target="_blank">薪酬</a>
								<a href='#' target="_blank">员工关系</a>								
								<a href='#' target="_blank">绩效</a>
								<a href='#' target="_blank">企业文化</a>
								<a href='#' target="_blank">人力资源总监</a>
								<a href='#'  target="_blank">人事经理</a>
								<a href='#'  target="_blank">总务</a>
								<a href='#' target="_blank">文员</a>
								<a href='#' target="_blank">秘书</a>
								<a href='#' target="_blank">助理</a>
								<a href='#' target="_blank">档案管理</a>
								<a href='#' target="_blank">总监</a>
								<a href='#' target="_blank">部门经理</a>
								<a href='#' target="_blank">项目经理</a>
								<a href='#' target="_blank">厂长</a>
								<a href='#' target="_blank">总裁</a>
								<a href='#' target="_blank">总经理</a>								
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>财会/金融/银行/保险</dt>
							<dd class="clearfix">
								<div class="pic_text">
									<div class="pic"><a href="#" title="财务审计类岗位招聘专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="财务审计类岗位招聘专场"></a></div>
								</div>							
								<a href="=会计" target="_blank">会计</a>
								<a href="=会计师" target="_blank">会计师</a>
								<a href="=注册会计师" target="_blank">注册会计师</a>
								<a href="=成本会计" target="_blank">成本会计</a>
								<a href="=管理会计" target="_blank">管理会计</a>
								<a href="=出纳" target="_blank">出纳</a>
								<a href="=税务" target="_blank">税务</a>								
								<a href="=财务管理" target="_blank">财务管理</a>
								<a href="=财务总监" target="_blank">财务总监</a>
								<a href="=财务经理" target="_blank">财务经理</a>
								<a href="=会计主管" target="_blank">会计主管</a>
								<a href="=审计" target="_blank">审计</a>
								<a href="=稽核" target="_blank">稽核</a>
								<a href="=保险" target="_blank">保险</a>
								<a href="=理财" target="_blank">理财</a>
								<a href="=信贷" target="_blank">信贷</a>
								<a href="=证券" target="_blank">证券</a>
								<a href="=投资" target="_blank">投资</a>
							</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt>生产/加工/制造</dt>
							<dd class="clearfix">
								<a href="=IE工程师" target="_blank">IE工程师</a>
								<a href="=PE工程师" target="_blank">PE工程师</a>
								<a href="=ME工程师" target="_blank">ME工程师</a>
								<a href="=SMT工程师" target="_blank">SMT工程师</a>
								<a href="=包装工程师" target="_blank">包装工程师</a>
								<a href="=项目工程师" target="_blank">项目工程师</a>
								<a href="=模具工程师" target="_blank">模具工程师</a>								
								<a href="=生产管理" target="_blank">生产管理</a>
								<a href="=拉长" target="_blank">拉长</a>
								<a href="=车间主管" target="_blank">车间主管</a>
								<a href="=生产经理" target="_blank">生产经理</a>
								<a href="=PMC" target="_blank">PMC</a>
								<a href="=普工" target="_blank">普工</a>
								<a href="=技工" target="_blank">技工</a>
								<a href="=电工" target="_blank">电工</a>
								<a href="=车工" target="_blank">车工</a>
								<a href="=铣" target="_blank">铣</a>
								<a href="=焊" target="_blank">焊</a>
								<a href="=钳" target="_blank">钳</a>
								<a href="=钣金" target="_blank">钣金</a>
								<a href="=冲压" target="_blank">冲压</a>
								<a href="=打磨" target="_blank">打磨</a>
								<a href="=抛光" target="_blank">抛光</a>
								<a href="=装配" target="_blank">装配</a>
								<a href="=注塑" target="_blank">注塑</a>								
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>采购/贸易/物流</dt>
							<dd class="clearfix">
								<div class="pic_text">
									<div class="bx-wrapper" style="width:80px; position:relative;"><div class="bx-window" style="width:80px; height:80px; position:relative; overflow:hidden;"><dl id="pos_nav_slider" style="height: 999999px; position: relative; top: -91.7157287525381px;"><dd class="pic" style="list-style: none; height: 80px;"><a href="/activities/trade.xhtml" title="外贸类职位招聘专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="外贸类职位招聘专场"></a></dd>
										<dd class="pic bx-child" style="list-style: none; height: 80px;"><a href="/activities/purchase.xhtml" title="物流/采购类职位招聘专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="物流/采购类职位招聘专场"></a></dd>
										<dd class="pic bx-child" style="list-style: none; height: 80px;"><a href="/activities/trade.xhtml" title="外贸类职位招聘专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="外贸类职位招聘专场"></a></dd>
									<dd class="pic" style="list-style: none; height: 80px;"><a href="/activities/purchase.xhtml" title="物流/采购类职位招聘专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="物流/采购类职位招聘专场"></a></dd></dl></div><div class="bx-pager"><a href="" class="pager-link pager-1">1</a><a href="" class="pager-link pager-2 pager-active">2</a></div></div>
								</div>
								<a href="=采购" target="_blank">采购</a>
								<a href="=采购经理" target="_blank">采购经理</a>
								<a href="=采购工程师" target="_blank">采购工程师</a>
								<a href="=供应商开发" target="_blank">供应商开发</a>
								<a href="=国际贸易" target="_blank">国际贸易</a>
								<a href="=跟单" target="_blank">跟单</a>
								<a href="=报检" target="_blank">报检</a>								
								<a href="=报关" target="_blank">报关</a>
								<a href="=外销" target="_blank">外销</a>
								<a href="=船务" target="_blank">船务</a>
								<a href="=外贸业务员" target="_blank">外贸业务员</a>
								<a href="=外贸助理" target="_blank">外贸助理</a>
								<a href="=外贸专员" target="_blank">外贸专员</a>
								<a href="=外贸经理" target="_blank">外贸经理</a>
								<a href="=物流" target="_blank">物流</a>
								<a href="=调度" target="_blank">调度</a>
								<a href="=供应链" target="_blank">供应链</a>
								<a href="=配送" target="_blank">配送</a>
								<a href="=运输" target="_blank">运输</a>
								<a href="=快递" target="_blank">快递</a>
								<a href="=仓储" target="_blank">仓储</a>
								<a href="=仓管" target="_blank">仓管</a>
								<a href="=仓库主管" target="_blank">仓库主管</a>
								<a href="=仓库文员" target="_blank">仓库文员</a>							
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>质量管理/安全防护</dt>
							<dd class="clearfix">
								<div class="pic_text">
									<div class="pic"><a href="/activities/qc.xhtml" title="质量管理类职位招聘专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="质量管理类职位招聘专场"></a></div>
								</div>							
								<a href="=品检" target="_blank">品检</a>
								<a href="=QC" target="_blank">QC</a>
								<a href="=IQC" target="_blank">IQC</a>
								<a href="=FQC" target="_blank">FQC</a>
								<a href="=OQC" target="_blank">OQC</a>
								<a href="=IPQC" target="_blank">IPQC</a>
								<a href="=品管" target="_blank">品管</a>								
								<a href="=QA" target="_blank">QA</a>
								<a href="=品质管理" target="_blank">品质管理</a>
								<a href="=质量管理" target="_blank">质量管理</a>
								<a href="=品质经理" target="_blank">品质经理</a>
								<a href="=QE" target="_blank">QE</a>
								<a href="=品质工程师" target="_blank">品质工程师</a>
								<a href="=化验员" target="_blank">化验员</a>
								<a href="=检验员" target="_blank">检验员</a>
								<a href="=体系工程师" target="_blank">体系工程师</a>
								<a href="=ISO" target="_blank">ISO</a>
								<a href="=内审" target="_blank">内审</a>
								<a href="=供应商管理" target="_blank">供应商管理</a>
								<a href="=产品认证" target="_blank">产品认证</a>
								<a href="=计量" target="_blank">计量</a>
								<a href="=安全工程师" target="_blank">安全工程师</a>
								<a href="=安全主管" target="_blank">安全主管</a>
								<a href="=EHS" target="_blank">EHS</a>
							</dd>
						</dl>
					</li>
					<li>
						<dl>  
							<dt>IT/计算机/互联网/通信</dt>
							<dd class="clearfix">
								<div class="pic_text">
									<div class="pic"><a href="/activities/it.xhtml" title="IT类岗位招聘专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="IT类岗位招聘专场"></a></div>
									<!-- div class="text"><span>·</span><a href="">教务主管</a></div -->
								</div>							
								<a href="=程序员" target="_blank">程序员</a>
								<a href="=软件工程师" target="_blank">软件工程师</a>
								<a href="=java" target="_blank">java</a>
								<a href="=php" target="_blank">php</a>
								<a href="=Android" target="_blank">Android</a>
								<a href="=架构" target="_blank">架构</a>
								<a href="=IT" target="_blank">IT</a>								
								<a href="=网页设计" target="_blank">网页设计</a>
								<a href="=产品经理" target="_blank">产品经理</a>
								<a href="=产品开发" target="_blank">产品开发</a>
								<a href="=网络营销" target="_blank">网络营销</a>
								<a href="=SEO" target="_blank">SEO</a>
								<a href="=技术总监" target="_blank">技术总监</a>
								<a href="=测试工程师" target="_blank">测试工程师</a>
								<a href="=硬件工程师" target="_blank">硬件工程师</a>
								<a href="=网络管理员" target="_blank">网络管理员</a>
								<a href="=ERP" target="_blank">ERP</a>
								<a href="=电子商务" target="_blank">电子商务</a>
								<a href="=运营" target="_blank">运营</a>
								<a href="=通讯" target="_blank">通讯</a>
								<a href="=通信" target="_blank">通信</a>
								<a href="=无线" target="_blank">无线</a>
								<a href="=射频" target="_blank">射频</a>
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>电子/机械/仪器仪表</dt>
							<dd class="clearfix">
								<div class="pic_text hide">
									<div class="pic"><img src="images/sales.jpg" width="80" height="80" border="0" alt="青岛海信通信有限公司"></div>
									<div class="text"><span>·</span><a href="">校区负责人</a></div>
									<div class="text"><span>·</span><a href="">教务主管</a></div>
								</div>
								<a href="=电子工程师" target="_blank">电子工程师</a>
								<a href="=电气工程师" target="_blank">电气工程师</a>
								<a href="=电气设计" target="_blank">电气设计</a>
								<a href="=电路设计" target="_blank">电路设计</a>
								<a href="=电子测试" target="_blank">电子测试</a>
								<a href="=电气维修" target="_blank">电气维修</a>
								<a href="=数控" target="_blank">数控</a>								
								<a href="=CNC" target="_blank">CNC</a>
								<a href="=工艺工程师" target="_blank">工艺工程师</a>
								<a href="=结构工程师" target="_blank">结构工程师</a>
								<a href="=机械工程师" target="_blank">机械工程师</a>
								<a href="=机电工程师" target="_blank">机电工程师</a>
								<a href="=ME" target="_blank">ME</a>
								<a href="=制造工程师" target="_blank">制造工程师</a>
								<a href="=机械设计" target="_blank">机械设计</a>
								<a href="=夹具" target="_blank">夹具</a>
								<a href="=焊接" target="_blank">焊接</a>
								<a href="=调试" target="_blank">调试</a>
								<a href="=激光" target="_blank">激光</a>
								<a href="=可靠性测试" target="_blank">可靠性测试</a>
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>房地产/物业/建筑/园林</dt>
							<dd class="clearfix">
								<div class="pic_text hide">
									<div class="pic"><img src="images/sales.jpg" width="80" height="80" border="0" alt="青岛海信通信有限公司"></div>
									<div class="text"><span>·</span><a href="">校区负责人</a></div>
									<div class="text"><span>·</span><a href="">教务主管</a></div>
								</div>
								<a href="=房地产开发" target="_blank">房地产开发</a>
								<a href="=房地产策划" target="_blank">房地产策划</a>
								<a href="=房地产中介" target="_blank">房地产中介</a>
								<a href="=房地产销售" target="_blank">房地产销售</a>
								<a href="=置业顾问" target="_blank">置业顾问</a>
								<a href="=招标" target="_blank">招标</a>
								<a href="=报建" target="_blank">报建</a>								
								<a href="=物业" target="_blank">物业</a>
								<a href="=物业管理" target="_blank">物业管理</a>
								<a href="=招商" target="_blank">招商</a>
								<a href="=园林" target="_blank">园林</a>
								<a href="=景观" target="_blank">景观</a>
								<a href="=建筑设计" target="_blank">建筑设计</a>
								<a href="=建筑工程" target="_blank">建筑工程</a>
								<a href="=监理" target="_blank">监理</a>
								<a href="=室内设计" target="_blank">室内设计</a>
								<a href="=土建工程师" target="_blank">土建工程师</a>
								<a href="=水电工程师" target="_blank">水电工程师</a>
								<a href="=建造师" target="_blank">建造师</a>
								<a href="=造价师" target="_blank">造价师</a>
							</dd>
						</dl>
					</li>

					<li>
						<dl>
							<dt>广告/市场/传媒/设计/出版</dt>
							<dd class="clearfix">
								<div class="pic_text hide">
									<div class="pic"><img src="images/sales.jpg" width="80" height="80" border="0" alt="青岛海信通信有限公司"></div>
									<div class="text"><span>·</span><a href="">校区负责人</a></div>
									<div class="text"><span>·</span><a href="">教务主管</a></div>
								</div>
								<a href="=广告设计" target="_blank">广告设计</a>
								<a href="=美工" target="_blank">美工</a>
								<a href="=网页设计" target="_blank">网页设计</a>
								<a href="=平面设计" target="_blank">平面设计</a>
								<a href="=产品设计" target="_blank">产品设计</a>
								<a href="=包装设计" target="_blank">包装设计</a>
								<a href="=工业设计" target="_blank">工业设计</a>								
								<a href="=设计总监" target="_blank">设计总监</a>
								<a href="=文案" target="_blank">文案</a>
								<a href="=文案策划" target="_blank">文案策划</a>
								<a href="=编辑" target="_blank">编辑</a>
								<a href="=摄影" target="_blank">摄影</a>
								<a href="=数据分析" target="_blank">数据分析</a>
								<a href="=企划" target="_blank">企划</a>
								<a href="=公关" target="_blank">公关</a>
								<a href="=市场营销" target="_blank">市场营销</a>
								<a href="=市场总监" target="_blank">市场总监</a>
								<a href="=品牌推广" target="_blank">品牌推广</a>
								<a href="=业务拓展" target="_blank">业务拓展</a>
								<a href="=市场拓展" target="_blank">市场拓展</a>
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>服装纺织/皮革/鞋帽/化工</dt>
							<dd class="clearfix">
								<div class="pic_text">
									<div class="pic"><a href="/activities/clothing.xhtml" title="服装纺织/鞋帽/皮革职位专场" target="_blank"><img src="images/sales.jpg" width="80" height="80" border="0" alt="IT类岗位招聘专场"></a></div>
									<!-- div class="text"><span>·</span><a href="">教务主管</a></div -->
								</div>							
								<a href="=服装设计" target="_blank">服装设计</a>
								<a href="=服装跟单" target="_blank">服装跟单</a>
								<a href="=面料" target="_blank">面料</a>
								<a href="=辅料" target="_blank">辅料</a>
								<a href="=皮革" target="_blank">皮革</a>
								<a href="=制衣" target="_blank">制衣</a>
								<a href="=板房" target="_blank">板房</a>								
								<a href="=纸样" target="_blank">纸样</a>
								<a href="=打样" target="_blank">打样</a>
								<a href="=制版" target="_blank">制版</a>
								<a href="=裁床" target="_blank">裁床</a>
								<a href="=车板" target="_blank">车板</a>
								<a href="=放码" target="_blank">放码</a>
								<a href="=印花" target="_blank">印花</a>
								<a href="=车缝" target="_blank">车缝</a>
								<a href="=化工" target="_blank">化工</a>
								<a href="=调色" target="_blank">调色</a>
								<a href="=配色" target="_blank">配色</a>
								<a href="=涂料" target="_blank">涂料</a>
								<a href="=光学" target="_blank">光学</a>
								<a href="=环保" target="_blank">环保</a>
								<a href="=表面处理" target="_blank">表面处理</a>
								<a href="=高分子材料" target="_blank">高分子材料</a>
								<a href="=化学分析" target="_blank">化学分析</a>
								<a href="=电镀" target="_blank">电镀</a>							
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>服务业/其他</dt>
							<dd class="clearfix">
								<a href="=店员" target="_blank">前台</a>
								<a href="=店员" target="_blank">服务员</a>
								<a href="=店员" target="_blank">酒店管理</a>
								<a href="=店员" target="_blank">计调</a>
								<a href="=店员" target="_blank">美容</a>
								<a href="=店员" target="_blank">店员</a>
								<a href="=店长" target="_blank">店长</a>								
								<a href="=营业员" target="_blank">营业员</a>
								<a href="=导购" target="_blank">导购</a>
								<a href="=收银" target="_blank">收银</a>
								<a href="=理货" target="_blank">理货</a>
								<a href="=陈列" target="_blank">陈列</a>
								<a href="=保安" target="_blank">保安</a>
								<a href="=司机" target="_blank">司机</a>
								<a href="=清洁" target="_blank">清洁</a>
								<a href="=厨师" target="_blank">厨师</a>
								<a href="=后勤" target="_blank">后勤</a>
								<a href="=顾问" target="_blank">顾问</a>
								<a href="=咨询" target="_blank">咨询</a>
								<a href="=法务" target="_blank">法务</a>
								<a href="=翻译" target="_blank">翻译</a>
								<a href="=日语" target="_blank">日语</a>
								<a href="=英语" target="_blank">英语</a>
								<a href="=韩语" target="_blank">韩语</a>
								<a href="" target="_blank">教师</a>
								<a href="">培训师</a>										
							</dd>
						</dl>
					</li>
				</ul>
			</div>
		</div>
	</div>
<!-- 新增培训导航 end -->
<div style='height:10px'></div>
<div class="mainContent flash" >
	<img  src="images/flash3.jpg" width="960"/>
</div>
<!--flash end -->

<!--企业内训 start-->
<div class="mainContent partTwo blue">
	<ul>
		<li class="noneStyle">
		<div class="part left">
				<div class="head">
					<div class="tabOn" id="b11"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',1,1)">财务管理内训</a></div>
					<div class="tabOff" id="b12"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',2,1)">经典</a></div>
					<div class="tabOff" id="b13"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',3,1)">排行</a></div>
				    <div class="tabOff" id="b14"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',4,1)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=1&type=1">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div>
						<div class="left pic" id="b1P"></div>
						<div class="left content">
							<div class="title" id="b1T"></div>
							<div class="desc" id="b7C"></div>
						</div>
					</div>
					<div class="clear"></div>
					<div style="padding-left:25px">
						<ul class="list4 blue" id="b1">
							<li></li>
						</ul>
					</div>
				</div>
	</div>
	</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="b21"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',1,2)">采购供应链仓储内训</a></div>
					<div class="tabOff" id="b22"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',2,2)">经典</a></div>
					<div class="tabOff" id="b23"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',3,2)">排行</a></div>
				    <div class="tabOff" id="b24"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',4,2)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=1&type=2">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div>
						<div class="left pic" id="b2P"></div>
						<div class="left content">
							<div class="title" id="b7T"></div>
							<div class="desc" id="b7C"></div>
						</div>
					</div>
					<div class="clear"></div>
					<div style="padding-left:25px">
						<ul class="list4 blue" id="b2">
							<li></li>
						</ul>
					</div>
				</div>
			</div>
		</li>
		<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" id="k21"><a href='javascript:void(0)' onclick="javascript:seePartTab('k',1,2)">关键词热搜</a></div>
					<div class="tabOff three" id="k22"><a href='javascript:void(0)' onclick="javascript:seePartTab('k',2,2)">关键词推荐</a></div>
					<div class="tabOff three" id="k23"><a href='javascript:void(0)' onclick="javascript:seePartTab('k',3,2)">排行</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg" style="padding:0px 15px;">
					<ul class="list7" style="padding-top:10px" id="k2">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
		</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="b31"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',1,3)">人力资源管理内训</a></div>
					<div class="tabOff" id="b32"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',2,3)">经典</a></div>
					<div class="tabOff" id="b33"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',3,3)">排行</a></div>
				    <div class="tabOff" id="b34"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',4,3)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=1&type=3">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div>
						<div class="left pic" id="b3P"></div>
						<div class="left content">
							<div class="title" id="b3T"></div>
							<div class="desc" id="b3C"></div>
						</div>
					</div>
					<div class="clear"></div>
					<div style="padding-left:25px">
						<ul class="list4 blue" id="b3">
							<li></li>
						</ul>
					</div>
				</div>
			</div>
	</li>
	<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn" id="b41"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',1,4)">生产管理内训</a></div>
					<div class="tabOff" id="b42"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',2,4)">经典</a></div>
					<div class="tabOff" id="b43"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',3,4)">排行</a></div>
				    <div class="tabOff" id="b44"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',4,4)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=1&type=4">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div>
						<div class="left pic" id="b4P"></div>
						<div class="left content">
							<div class="title" id="b4T"></div>
							<div class="desc" id="b4C"></div>
						</div>
					</div>
					<div class="clear"></div>
					<div style="padding-left:25px">
						<ul class="list4 blue" id="b4">
							<li></li>
						</ul>
					</div>
				</div>
	</div>
	</li>
	
	<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" id="s21"><a href='javascript:void(0)' onclick="javascript:seePartTab('s',1,2)">专题推荐</a></div>
					<div class="tabOff three" id="s22"><a href='javascript:void(0)' onclick="javascript:seePartTab('s',2,2)">专题热搜</a></div>
					<div class="tabOff three" id="s23"><a href='javascript:void(0)' onclick="javascript:seePartTab('s',3,2)">专题排行</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg" style="padding:0px 15px;"> 
					<ul class="list7" style="padding-top:10px" id="s2">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
		
		</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="b51"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',1,5)">项目管理内训</a></div>
					<div class="tabOff" id="b52"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',2,5)">经典</a></div>
					<div class="tabOff" id="b53"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',3,5)">排行</a></div>
				    <div class="tabOff" id="b54"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',4,5)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=1&type=5">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div>
						<div class="left pic" id="b5P"></div>
						<div class="left content">
							<div class="title" id="b5T"></div>
							<div class="desc" id="b5C"></div>
						</div>
					</div>
					<div class="clear"></div>
					<div style="padding-left:25px">
						<ul class="list4 blue" id="b5">
							<li></li>
						</ul>
					</div>
				</div>
			</div>
		</li>
	<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn" id="b61"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',1,6)">职业技能内训</a></div>
					<div class="tabOff" id="b62"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',2,6)">经典</a></div>
					<div class="tabOff" id="b63"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',3,6)">排行</a></div>
				    <div class="tabOff" id="b64"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',4,6)">推荐</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=1&type=6">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div>
						<div class="left pic" id="b6P"></div>
						<div class="left content">
							<div class="title" id="b6T"></div>
							<div class="desc" id="b6C"></div>
						</div>
					</div>
					<div class="clear"></div>
					<div style="padding-left:25px">
						<ul class="list4 blue" id="b6">
							<li></li>
						</ul>
					</div>
				</div>
	</div>
	</li>	
		
	<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" >视频推荐</div>
					<div class="tabOff three">热门视频</div>
					<div class="tabOff three">视频热搜</div>
					<div class="clear"></div>
				</div>
				<div class="bg" style="padding:0px 0px 0px 15px;">
					<ul class="list5 videoList">
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
						<li><span class="video">&nbsp;</span>经营快乐的核心价值观在企业...</li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
		
		</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
				<div class="tabOn" id="b71"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',1,7)">财务管理内训</a></div>
				<div class="tabOff" id="b72"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',2,7)">最新</a></div>
				<div class="tabOff" id="b73"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',3,7)">经典</a></div>
				<div class="tabOff" id="b74"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',4,7)">排行</a></div>
				<div class="more"><a href="viewCourseType.jsp?isInner=1&type=7">更多</a></div>
				<div class="clear"></div>
			</div>
				<div class="bg">
					<div>
						<div class="left pic" id="b7P"></div>
						<div class="left content">
							<div class="title" id="b7T"></div>
							<div class="desc" id="b7C"></div>
						</div>
					</div>
					<div class="clear"></div>
					<div style="padding-left:25px">
						<ul class="list4 blue" id="b7">
							<li></li>
						</ul>
					</div>
				</div>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="b81"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',1,8)">采购供应链内训</a></div>
					<div class="tabOff" id="b82"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',2,8)">最新</a></div>
					<div class="tabOff" id="b83"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',3,8)">经典</a></div>
				    <div class="tabOff" id="b84"><a href='javascript:void(0)' onclick="javascript:seePartTab('b',4,8)">排行</a></div>
					<div class="more"><a href="viewCourseType.jsp?isInner=1&type=8">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div>
						<div class="left pic" id="b8P"></div>
						<div class="left content">
							<div class="title" id="b8T"></div>
							<div class="desc" id="b8C"></div>
						</div>
					</div>
					<div class="clear"></div>
					<div style="padding-left:25px">
						<ul class="list4 blue" id="b8">
							<li></li>
						</ul>
					</div>
				</div>
			</div>
		</li>
	<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" >企业培训师</div>
					<div class="tabOff three">企业内训师</div>
					<div class="tabOff three">名字热搜</div>
					<div class="clear"></div>
				</div>
				<div class="bg" style="padding:0px 0px 0px 15px;">
					<div style="height:10px"></div>
					<div class="teacherList">
						<h5>余世维</h5>
						<div class="listDesc"><span>擅长领域:</span>团队管理陈中老师 ——连锁、店面实战派...</div>
					</div>
										<div class="teacherList">
						<h5>余世维</h5>
						<div class="listDesc"><span>擅长领域:</span>团队管理陈中老师 ——连锁、店面实战派...</div>
					</div>
										<div class="teacherList">
						<h5>余世维</h5>
						<div class="listDesc"><span>擅长领域:</span>团队管理陈中老师 ——连锁、店面实战派...</div>
					</div>
										<div class="teacherList">
						<h5>余世维</h5>
						<div class="listDesc"><span>擅长领域:</span>团队管理陈中老师 ——连锁、店面实战派...</div>
					</div>
										<div class="teacherList">
						<h5>余世维</h5>
						<div class="listDesc"><span>擅长领域:</span>团队管理陈中老师 ——连锁、店面实战派...</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		
		</li>
	</ul>
	<div class="clear"></div>
</div>
<!--企业内训 end -->

<!--flash start-->

<div class="mainContent flash" >
	<img  src="images/flash3.jpg" width="960"/>
</div>
<!--flash end -->

<!--企业新闻 start-->
<div class="mainContent partTwo gray">
	<ul>
		<li class="noneStyle">
			<div class="part left">
				<div class="head">
				<div class="tabOn" id="c11"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,1,1,'');">财务管理</a></div>
				<div class="tabOff" id="c12"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,2,1,'内务控制')">内务控制</a></div>
				<div class="tabOff" id="c13"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,3,1,'融资')">融资</a></div>
				<div class="tabOff" id="c14"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,4,1,'税收')">税收</a></div>
				<div class="more"><a href="#">更多</a></div>
				<div class="clear"></div>
			</div>
			<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="cn1">
							<li></li>
						</ul>
					</div>
				</div>
				<img  src="images/news1.jpg"/>
			</div>
		</li>
		<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="c21"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(3,1,2,'')">采购供应链仓储</a></div>
					<div class="tabOff" id="c22"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(3,2,2,'供应商')">供应商</a></div>
					<div class="tabOff" id="c23"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(3,3,2,'采购谈判')">采购谈判</a></div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="cn2">
							<li></li>
						</ul>
					</div>
					</div>
				<img  src="images/news2.jpg"/>
			</div>
		</li>
		<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" >关键词热搜</div>
					<div class="tabOff three">关键词排行</div>
					<div class="tabOff three">关键词推荐</div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 15px;">
					<ul class="list7" style="padding-top:10px">
						<li class="line"><a><span class="red">1</span><span class="text">人力资源 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li  class="line"><a><span class="red">2</span><span class="text">员工离职 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="red">3</span><span class="text">企业内训</span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="blue">4</span><span class="text">产品研核心管理技能 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="blue">5</span><span class="text">技术人员管理技能 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="blue">6</span><span class="text">人力资源  </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="blue">7</span><span class="text">员工离职 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="blue">8</span><span class="text">产品研核心管理技能 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="blue">9</span><span class="text">技术人员管理技能</span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="blue">10</span><span class="text">员工离职 </span><span class="count">89989</span></a><div class="clear"></div></li>
						<li class="line"><a><span class="blue">11</span><span class="text">员工离职 </span><span class="count">89989</span></a><div class="clear"></div></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
		
		</li>
	<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn" id="c31"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,1,3,'')">人力资源</a></div>
					<div class="tabOff" id="c32"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,2,3,'绩效考核')">绩效考核</a></div>
					<div class="tabOff" id="c33"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,3,3,'薪酬设计')">薪酬设计</a></div>
					<div class="tabOff" id="c34"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,4,3,'招聘')">招聘</a></div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="cn3">
							<li></li>
						</ul>
					</div>
				</div>
				<img  src="images/new3.jpg"/>
	</div>
	</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="c41"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,1,4,'')">生产管理</a></div>
					<div class="tabOff" id="c42"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,2,4,'PMC')">PMC</a></div>
					<div class="tabOff" id="c43"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,3,4,'班组长')">班组长</a></div>
					<div class="tabOff" id="c44"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,4,4,'TPM')">TPM</a></div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="cn4">
							<li></li>
						</ul>
					</div>
				</div>
				<img  src="images/class5.jpg"/>
			</div>
		</li>
		<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" >文库分类</div>
					<div class="tabOff three">文库排行</div>
					<div class="tabOff three">本月排行</div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 15px;">
					<div class="docType">
						<h5>财务管理</h5>
						<ul>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
						</ul>
					</div>
					<div class="clear"></div>
					<div class="docType">
						<h5>生产管理</h5>
						<ul>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
						</ul>
					</div>
					<div class="clear"></div>
					<div class="docType">
						<h5>企业管理</h5>
						<ul>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
							<li>[税收]</li>
							<li>[预算]</li>
						</ul>
					</div>
					<div class="clear"></div>					
					<div class="docType">
						<h5>企业管理</h5>
						<ul>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
							<li>[税收]</li>
							<li>[预算]</li>
						</ul>
					</div>
					<div class="clear"></div>

				</div>
			</div>
		
		</li>
		<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn" id="c51"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,1,5,'')">市场营销</a></div>
					<div class="tabOff" id="c52"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,2,5,'销售')">销售</a></div>
					<div class="tabOff" id="c53"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,3,5,'团队')">团队</a></div>
					<div class="tabOff" id="c54"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,4,5,'市场调研')">市场调研</a></div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="cn5">
							<li></li>
						</ul>
					</div>
				</div>
				<img  src="images/new3.jpg"/>
	</div>
	</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="c61"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,1,6,'')">战略管理</a></div>
					<div class="tabOff" id="c62"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,2,6,'领导力')">领导力</a></div>
					<div class="tabOff" id="c63"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,3,6,'执行力')">执行力</a></div>
					<div class="tabOff" id="c64"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,4,6,'运营')">运营</a></div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="cn6">
							<li></li>
						</ul>
					</div>
				</div>
				<img  src="images/class5.jpg"/>
			</div>
		</li>
		<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three"  style="width:110px">培训机构字典</div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 15px;">
					<ul class="list5" style="padding-top:10px;width:230px;" id="jigou_dic">
						<li><a class="left tooLong w230">深圳市鑫阳企业管理咨询有限公司鑫阳企业管理咨询有限公司</a></li>
						<li><a class="left">上海复锐企业管理咨询有限公司</a></li>
						<li><a class="left">深圳市鑫阳企业管理咨询有限公司</a></li>
						<li><a class="left">上海复锐企业管理咨询有限公司</a></li>
						<li><a class="left">深圳市鑫阳企业管理咨询有限公司</a></li>
						<li><a class="left">上海复锐企业管理咨询有限公司</a></li>
						<li><a class="left">深圳市鑫阳企业管理咨询有限公司</a></li>
						<li><a class="left">上海复锐企业管理咨询有限公司</a></li>
						<li><a class="left">深圳市鑫阳企业管理咨询有限公司</a></li>
						<li><a class="left">上海复锐企业管理咨询有限公司</a></li>
						<li><a class="left">上海复锐企业管理咨询有限公司</a></li>
					</ul>
					<div class="clear"></div>

				</div>
			</div>
		
		</li>
			<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn" id="c71"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,1,7,'')">项目管理</a></div>
					<div class="tabOff" id="c72"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,2,7,'研发')">研发</a></div>
					<div class="tabOff" id="c73"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,3,7,'品牌')">品牌</a></div>
					<div class="tabOff" id="c74"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,4,7,'时间')">时间</a></div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="cn7">
							<li></li>
						</ul>
					</div>
				</div>
				<img  src="images/new3.jpg"/>
	</div>
	</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="c81"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,1,8,'')">职业技能</a></div>
					<div class="tabOff" id="c82"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,2,8,'秘书')">秘书</a></div>
					<div class="tabOff" id="c83"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,3,8,'认证')">认证</a></div>
					<div class="tabOff" id="c84"><a href='javascript:void(0)' onclick="javascript:loadPartDateForArticle(4,4,8,'英语')">英语</a></div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="cn8">
							<li></li>
						</ul>
					</div>
				</div>
				<img  src="images/class5.jpg"/>

			</div>
		</li>
		<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn three" >文库分类</div>
					<div class="tabOff three">文库排行</div>
					<div class="tabOff three">本月排行</div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 15px;">
					<div class="docType">
						<h5>财务管理</h5>
						<ul>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
						</ul>
					</div>
					<div class="clear"></div>
					<div class="docType">
						<h5>生产管理</h5>
						<ul>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
						</ul>
					</div>
					<div class="clear"></div>
					<div class="docType">
						<h5>企业管理</h5>
						<ul>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
							<li>[税收]</li>
							<li>[预算]</li>
						</ul>
					</div>
					<div class="clear"></div>					
					<div class="docType">
						<h5>企业管理</h5>
						<ul>
							<li>[税收]</li>
							<li>[预算]</li>
							<li>[企业内部]</li>
							<li>[成本]</li>
							<li>[融资]</li>
							<li>[税收]</li>
							<li>[预算]</li>
						</ul>
					</div>
					<div class="clear"></div>

				</div>
			</div>
		
		</li>
		<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn" id="d11"><a href='javascript:void(0)' onclick="javascript:seePartTab('d',1,1)">企业培训下载</a></div>
					<div class="tabOff" id="d12"><a href='javascript:void(0)' onclick="javascript:seePartTab('d',2,1)">热门下载</a></div>
					<div class="tabOff" id="d13"><a href='javascript:void(0)' onclick="javascript:seePartTab('d',3,1)">热门搜索</a></div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="d1">
							<li></li>
						</ul>
					</div>
				</div>
				<img  src="images/class5.jpg"/>
			</div>
		</li>
	<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn" id="org11"><a href='javascript:void(0)' onclick="javascript:seePartTab('org',1,1)">企业培训机构</a></div>
					<div class="tabOff" id="org12"><a href='javascript:void(0)' onclick="javascript:seePartTab('org',2,1)">培训机构排名</a></div>
					<div class="tabOff" id="org13"><a href='javascript:void(0)' onclick="javascript:seePartTab('org',3,1)">热门搜索</a></div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg h245">
					<div style="padding-left:25px;padding-top:10px">
						<ul class="list4 gray" id="org1">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
						</ul>
					</div>
				</div>
				<img  src="images/class5.jpg"/>
	</div>
	</li>
	<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn half" >培训在线问答</div>
					<div class="tabOff half">企业培训需求</div>
					<div class="clear"></div>
				</div>
				<div class="bg h315" style="padding:0px 10px 0px 10px;">
					<div style="height:15px"></div>
					<div class="question"><span>&nbsp;</span>&nbsp;请问如何解除劳动合同通知书</div>
					<div class="answer"><span>最佳答案:&nbsp;</span>有无劳动合同，有无社保。有无拖欠或克扣工资（劳动合同法中所说的未及时足额支付劳动报酬）。以及其他...</div>
					<div class="answerline"></div>
					<div class="question"><span>&nbsp;</span>&nbsp;请问如何解除劳动合同通知书</div>
					<div class="answer"><span>最佳答案:&nbsp;</span>有无劳动合同，有无社保。有无拖欠或克扣工资（劳动合同法中所说的未及时足额支付劳动报酬）。以及其他...</div>
					<div class="answerline"></div>
					<div class="question"><span>&nbsp;</span>&nbsp;请问如何解除劳动合同通知书</div>
					<div class="answer"><span>最佳答案:&nbsp;</span>有无劳动合同，有无社保。有无拖欠或克扣工资（劳动合同法中所说的未及时足额支付劳动报酬）。以及其他...</div>
			</div>
		
		</li>
	<li class="noneStyle">
			<div class="part left">
				<div class="head">
					<div class="tabOn">户外拓展</div>
					<div class="tabOff">企业培训拓展</div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
					<div style="padding:10px 5px 0px 5px">
						<div class="tableImg"><img  src="images/activity.jpg"/></div>
						<div class="tableImg"><img  src="images/activity.jpg"/></div>
					</div>
					<div class="clear"></div>
					<div style="padding-left:25px">
						<ul class="list4 gray">
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
							<li><a href="#">应收账款控制与催收及信用管理实务</a></li>
							<li><a href="#">企业资本运作与投融资顾问班</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
							<li><a href="#">财务人员必须掌握的28个Excel</a></li>
							<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
							<li><a href="#">应收账款控制与催收及信用管理实务</a></li>
						</ul>
					</div>
				</div>
			</div>
		</li>
	<li class="noneStyle">
	<div class="part left">
				<div class="head">
					<div class="tabOn">企业培训现场</div>
					<div class="tabOff">企业内训现场</div>
					<div class="more"><a href="#">更多</a></div>
					<div class="clear"></div>
				</div>
				<div class="bg">
						<div style="padding:10px 5px 0px 5px">
							<div class="tableImg"><img  src="images/activity.jpg"/></div>
							<div class="tableImg"><img  src="images/activity.jpg"/></div>
						</div>
						<div class="clear"></div>
						<div style="padding-left:25px">
							<ul class="list4 gray">
								<li><a href="#">财务人员必须掌握的28个Excel</a></li>
								<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
								<li><a href="#">应收账款控制与催收及信用管理实务</a></li>
								<li><a href="#">企业资本运作与投融资顾问班</a></li>
								<li><a href="#">财务人员必须掌握的28个Excel</a></li>
								<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
								<li><a href="#">财务人员必须掌握的28个Excel</a></li>
								<li><a href="#">企业经营活动中的海关事务风险及其解决路...</a></li>
								<li><a href="#">应收账款控制与催收及信用管理实务</a></li>
							</ul>
						</div>
					</div>
	</div>
	</li>
	<li class="last noneStyle">
			<div class="partLeft left">
				<div class="head">
					<div class="tabOn half" >企业培训动态</div>
					<div class="tabOff half">企业内训动态</div>
					<div class="clear"></div>
				</div>
				<div class="bg" style="padding:0px 0px 0px 15px;">
					<marquee  direction="up" scrollamount="3" behavior="scroll" class="lasted" height="320px" onmouseover="this.stop();" onMouseOut="this.start()">
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
			</div>
		
		</li>
	</ul>
	<div class="clear"></div>
</div>
<!--企业新闻 end -->


<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>