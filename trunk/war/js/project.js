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