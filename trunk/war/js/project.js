// JavaScript Document
function autoHeight(){
		var iframe = document.getElementById('contentFrame');
		if(iframe.contentDocument != null)
		 	iframe.height= iframe.contentDocument.body.scrollHeight;
		else
			alert(iframe.contentWindow.documentElement);

}

function GetArgsFromHref(sArgName){ 
	var sHref =window.location.href;
	var args = sHref.split("?");
	var retval = "";
	if(args[0] == sHref) /*参数为空*/  
		return retval; /*无需做任何处理*/
		
	var str = args[1]; 
	args = str.split("&"); 
	for(var i = 0; i < args.length; i++ ){
		str = args[i]; 
		var arg = str.split("="); 
		if(arg.length <= 1) continue;
		if(arg[0] == sArgName)
			retval = arg[1]; 
	}
	return retval;
} 

var page = {
	'test':function(){
		alert('1');
	},
	'seeNext':function(){
		var currPage = parseInt($('#currPage').html());
		var pages = parseInt($('#pages').html());
		if(currPage +1 >= pages)
			loadCourses(pages-1);
		else
			loadCourses(currPage);
	},
	'seePre':function(){
		var currPage = parseInt($('#currPage').html());
		if(currPage-1 > 0)
			loadCourses(currPage-2);
		else
			loadCourses(0);
	},
	'seeFirst':function(){
		loadCourses(0);
	},
	'seeLast':function(){
		var pages = $('#pages').html();
		loadCourses(pages-1);
	},
	'jump':function(){
		if($('#jump').val() == ''){
			alert('请输入页码！');
			return false;
		}
		var jumpTo = parseInt($('#jump').val());
		var allPages = parseInt($('#pages').html());
		if(jumpTo <=0 || jumpTo> allPages){
			alert('页码范围不正确！');
			return false;
		}
		loadCourses(jumpTo-1);
	}
};