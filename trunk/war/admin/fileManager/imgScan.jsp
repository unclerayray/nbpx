<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.codec.binary.*" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>图片管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="js/prototype.js"></script>
	<script type="text/javascript" src="js/scriptaculous.js?load=effects,builder"></script>
	<script type="text/javascript" src="js/lightbox.js"></script>
	<script type="text/javascript" src="swfupload/swfupload.js"></script>
	<script type="text/javascript" src="js/swfupload.queue.js"></script>
	<script type="text/javascript" src="js/fileprogress.js"></script>
	<script type="text/javascript" src="js/handlers.js"></script>
	
	
	<link rel="stylesheet" href="css/lightbox.css" type="text/css" media="screen" />
	<link href="css/default.css" rel="stylesheet" type="text/css" />

	<style>
	.con{
		width:100px;
		height:116px;
		float:left;
		margin:5px;
		border:solid black 1px;
	}
	.thum{
		width:100px;
		height:100px;
	}
	.con span{
		width:100px;
		height:16px;
	}
	.con span img{
		margin-left:12px;
		cursor: pointer;
	}
	img{
		border: 0px;
	}
	.uploadDIV{
		clear:both;
		width: 100%;
		height:150px;
		background-color: red;
	}
	</style>
	
  <script type="text/javascript">
  function del(str){
  	if(confirm("确认要删除吗?")){
  		window.location.href = "imgScan.jsp?delete=1&name="+str;
  	}
  }
  var upload;
  window.onload = function() {
	upload = new SWFUpload({
	// 处理文件上传的url
	upload_url: "${pageContext.request.contextPath}/admin/fileManager/imgScan.jsp?upload=1",	// 路径写全，否则Firefox下会出现404错误。修改处二：处理文件上传的url路径，注意还要写全部

	// 上传文件限制设置
	file_size_limit : "10240",	// 10MB
	file_types : "*.jpg;*.gif;*.png",
	file_types_description : "Image Files",
	file_upload_limit : "10",
	file_queue_limit : "5",

	// 事件处理设置（所有的自定义处理方法都在handler.js文件里）
	file_dialog_start_handler : fileDialogStart,
	file_queued_handler : fileQueued,
	file_queue_error_handler : fileQueueError,
	file_dialog_complete_handler : fileDialogComplete,
	upload_start_handler : uploadStart,
	upload_progress_handler : uploadProgress,
	upload_error_handler : uploadError,
	upload_success_handler : uploadSuccess,
	upload_complete_handler : uploadComplete,

	// 按钮设置
	button_image_url : "swfupload/xpbutton.png",	// 按钮图标
	button_placeholder_id : "spanButtonPlaceholder",
	button_width: 61,
	button_height: 22,
				
	// swf设置
	flash_url : "swfupload/swfupload.swf",
				

	custom_settings : {
		progressTarget : "fsUploadProgress",
		cancelButtonId : "btnCancel"
	},
				
				// Debug 设置
		debug: false
	});
  }
  </script>

  </head>
  <%
  String deleteSign = request.getParameter("delete");
  String uploadSign = request.getParameter("upload");
  String rootPath = request.getParameter("rootPath");
  String path = request.getParameter("path");
  if(rootPath == null) rootPath = "";
  	rootPath = rootPath.trim();
  if(rootPath.equals("")){
	rootPath = application.getRealPath("/admin/fileManager/examples");//修改处一：指定服务器固定文件
  }

  if(path == null) {
	path = rootPath;
  }else{
	path = new String(Base64.decodeBase64(path.getBytes()));
  }
  %>
  <%
  //删除操作
  if(null != deleteSign && !"".equals(deleteSign)){
	  String name = request.getParameter("name");
	  File deleteFile = new File(path+"\\"+name);
	  if(!deleteFile.delete()){
		  System.out.println("删除失败！");
	  }
  }
  //上传操作
  if(null != uploadSign && !"".equals(uploadSign)){
	  FileItemFactory factory = new DiskFileItemFactory();
	  ServletFileUpload upload = new ServletFileUpload(factory);
	  //upload.setHeaderEncoding("UTF-8");
	  try{
		  List items = upload.parseRequest(request);
		  if(null != items){
			  Iterator itr = items.iterator();
			  while(itr.hasNext()){
				  FileItem item = (FileItem)itr.next();
				  if(item.isFormField()){
					  continue;
				  }else{
					  SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddkkmmss");//以当前精确到秒的日期为上传的文件的文件名
					  File savedFile = new File(path,sdf.format(new Date()));
					  item.write(savedFile);
				  }
			  }
		  }
	  }catch(Exception e){
		  e.printStackTrace();
	  }
  }
  File file = new File(path);
  File[] entry = file.listFiles();
  %>
  <body>
  <%
  if(null != entry){
  for(int i = 0;i < entry.length;++i){
	  String fileName = entry[i].getName();
  %>
    <div class="con">
    <img class="thum" alt="<%=fileName%>" src="examples/<%=fileName%>"/>
    <span>
    <img alt="选择" src="images/accept.png"/>
    <a href="examples/<%=fileName%>" rel="lightbox" title="<%=fileName%>"><img alt="查看" src="images/zoom.png"/></a>
    <img alt="删除" src="images/delete.png" onclick="del('<%=fileName%>')"/>
    </span>
    </div>
  <%}} %>
  <div style="clear: both"></div><!-- 填充div，解决Firefox层重叠的问题 -->
  <div class="fieldset flash" id="fsUploadProgress">
  	<span class="legend">上传状态监视</span>
  </div>
  <div style="padding-left: 5px;">
  	<span id="spanButtonPlaceholder"></span>
  	<input id="btnCancel" type="button" value="取消" onclick="cancelQueue(upload);" disabled="disabled" style="margin-left: 2px; height: 22px; font-size: 8pt;" />
  </div>
  </body>
</html>
