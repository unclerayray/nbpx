
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
						valueStr +="<li  style='width:200px;text-align:left;'><a class='left' href='struts/seeDownLoadsDetail.jsp?id="+value.downloadId+"'><span class='text tooLong left' style='width:200px;display:block'>"+value.title+"</span></a><div class='clear'></div></li>";

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
