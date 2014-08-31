//js file for index.jsp

function searchTabs(tabObj, obj) 
{
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for (i = 0; i < tabList.length; i++) 
	{
		if (tabList[i].id == obj.id) 
		{
			document.getElementById(tabObj + "_Title" + i).className = "on";
		}else{
			document.getElementById(tabObj + "_Title" + i).className = "off";
		}
	}
	if(obj.id == "searchTab_Title1"){
		setTeacherTip();
		$('#search_type').val('pxs');
	}else if(obj.id == "searchTab_Title2"){
		$('#search_type').val('qynx');
	}else if(obj.id == "searchTab_Title3"){
		$('#search_type').val('pxs');
	}else if(obj.id == "searchTab_Title4"){
		$('#search_type').val('xz');
	}else if(obj.id == "searchTab_Title5"){
		$('#search_type').val('wk');
	}else if(obj.id == "searchTab_Title6"){
		setOrgTip();
		$('#search_type').val('jg');
	}else if(obj.id == "searchTab_Title7"){
		$('#search_type').val('wd');
	}else if(obj.id == "searchTab_Title8"){
		$('#search_type').val('khpj');
	}else if(obj.id == "searchTab_Title9"){
		$('#search_type').val('khq');
	}else if(obj.id == "searchTab_Title0"){
		setKeyWordTips();
		$('#search_type').val('qypx');
	}else{
		setKeyWordTips();
		$('#search_type').val('qypx');
	}
	$("#searchWord").autocomplete("option", "minLength", 1);
} 

function changePlanTabs(tabObj, obj)
{
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for (i = 0; i < tabList.length; i++) 
	{
		if (tabList[i].id == obj.id) 
			{
				document.getElementById(tabObj + "_tab" + i + "_a").className = "on";
			}
		else 
			{
				document.getElementById(tabObj + "_tab" + i + "_a").className = "off";
			}
	}
}


//阻止默认行为
function my_stop(oEvent){
	if(oEvent.preventDefault){
		oEvent.preventDefault();
	}else{
		oEvent.returnValue=false;
		return false;
	}
}

function fnt_top_search2(oEvent)
{
	if(oEvent.keyCode==13){
		my_stop(oEvent); 
		fnt_top_search(document.getElementById('search_type').value);
	}
}

//头部搜索
function fnt_top_search(search_type)
{
	var txt_search=document.getElementById("searchWord").value;

	if("请输入关键字,如: 员工 管理" == $("#searchWord").val()){
		return;
	}
	//if(txt_search.value.indexOf("请输入") != -1) txt_search.value = "";
	var my_href="";
	switch(search_type)
	{
		case "qypx":
		{
			//企业培训
			my_href="searchCourse.jsp?key="+$("#searchWord").val();
		}break;
		case "pxs":
		{
			//培训师
			my_href="searchTeacher.jsp?key="+$("#searchWord").val();
		}break;
		case "pxjh":
		{
			//培训计划
			my_href="trainPlan.jsp?key="+$("#searchWord").val();
		}break;
		case "qynx":
		{
			//企业内训
			my_href="searchInnerCourse.jsp?key="+$("#searchWord").val();
		}break;
		case "nxs":
		{
			//内训师 TODO
			my_href="searchCourse.jsp?key="+$("#searchWord").val();
		}break;

		case "nxsp":
		{
			//内训视频 TODO
			my_href="searchInnerVideoCourse.jsp?key="+$("#searchWord").val();
		}break;
		case "xz":
		{
			//下载
			my_href="searchDownload.jsp?key="+$("#searchWord").val();
		}break;
		case "wk":
		{
			//文库
			my_href="searchArticle.jsp?key="+$("#searchWord").val();
		}break;
		case "jg":
		{
			//机构
			my_href="searchOrganisation.jsp?key="+$("#searchWord").val();
		}break;
		case "wd":
		{
			//问答
			my_href="searchQuestion.jsp?key="+$("#searchWord").val();
		}break;
		case "khpj":
		{
			//客户评价 TODO
			my_href="searchCourse.jsp?key="+$("#searchWord").val();
		}break;
		case "khq":
		{
			//客户群 TODO
			my_href="searchCourse.jsp?key="+$("#searchWord").val();
		}break;
	}
	window.location.href= my_href;
	return false;
}


function setTeacherTip(){
	var func = function(request, response) {
		$.ajax({
			url: "struts/Search_queryTeacherTip",
			delay: 500,
			dataType:'json',
			timeout: 5000,
			data: {
				featureClass: "P",
				style: "full",
				maxRows: 12,
				wt:"json",
				q:$("#searchWord").val(),
				name_startsWith: request.term
			},
			success: function(data) {
				response($.map(data, function(item) {
					return {
						label: item.keyword,
						value: item.keyword
					};
				}));
			}
		});
	};
	var xxxx = function(request, response) {
		alert('sdfsdfasdgerg');
	};
	$("#searchWord").autocomplete( "option", "source", xxxx );
	$("#searchWord").autocomplete( "option", "source", func );
}

function setOrgTip(){
	var func = function(request, response) {
		$.ajax({
			url: "struts/Search_queryOrgTip",
			delay: 500,
			dataType:'json',
			timeout: 5000,
			data: {
				featureClass: "P",
				style: "full",
				maxRows: 12,
				wt:"json",
				q:$("#searchWord").val(),
				name_startsWith: request.term
			},
			success: function(data) {
				response($.map(data, function(item) {
					return {
						label: item.keyword,
						value: item.keyword
					};
				}));
			}
		});
	};
	$("#searchWord").autocomplete( "option", "source", func );
}

function setKeyWordTips(){
	var func = function(request, response) {
		$.ajax({
			url: "struts/Search_queryKeywordsByKeyword",
			delay: 500,
			dataType:'json',
			timeout: 5000,
			data: {
				featureClass: "P",
				style: "full",
				maxRows: 12,
				wt:"json",
				q:$("#searchWord").val(),
				name_startsWith: request.term
			},
			success: function(data) {
				response($.map(data, function(item) {
					return {
						label: item.keyword,
						value: item.keyword
					};
				}));
			}
		});
	};
	$("#searchWord").autocomplete( "option", "source", func );
}

function sourceFunc(myurl){
	$.ajax({
		url: myurl,
		delay: 500,
		dataType:'json',
		timeout: 5000,
		data: {
			featureClass: "P",
			style: "full",
			maxRows: 12,
			wt:"json",
			q:$("#searchWord").val(),
			name_startsWith: request.term
		},
		success: function(data) {
			response($.map(data, function(item) {
				return {
					label: item.keyword,
					value: item.keyword
				};
			}));
		}
	});
}