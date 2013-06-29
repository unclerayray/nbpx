// JavaScript Document
function autoHeight(){
		var iframe = document.getElementById('contentFrame');
		if(iframe.contentDocument != null)
		 	iframe.height= iframe.contentDocument.body.scrollHeight;
		else
			alert(iframe.contentWindow.documentElement);

}