<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="css/face.css" rel="stylesheet" />
<script src="js/easyui/jquery-1.8.0.min.js"></script>
<script src="js/gallery/gallery.min.js"></script>
<link type="text/css" href="css/gallery.css" rel="stylesheet" />
<title>内训现场照片</title>
<style>
img {
	border: 0px
}
</style>
</head>
</head>

<body>
	<jsp:include page="head.jsp" flush="true" />
	<!--当前路径 start-->
	<div class="mainContent path">
		<ul>
			<li>当前位置:&nbsp;</li>
			<li><a href="main.html" target="_self">首页</a></li>
			<li class="bread">&gt;&gt;</li>
			<li>内训现场照片</li>
		</ul>
		<div class="clear"></div>
	</div>
	<!--当前路径 end-->


	<!--主体部分二 start-->
	<div class="mainContent partTwo"
		style="margin-top: 0px; padding-top: 0px">
			<div class="dengxaing-keleyi-com">

				<a title="2013-8-21"
					href="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-8-21_w.jpg">
					<img width="133" height="75"
					src="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-8-21_s.jpg">
				</a> <a title="2013-9-13"
					href="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-13_w.jpg">
					<img width="133" height="75"
					src="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-13_s.jpg">
				</a> <a title="2013-9-15"
					href="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-15_w.jpg">
					<img width="133" height="75"
					src="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-15_s.jpg">
				</a> <a title="2013-9-16"
					href="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-16_w.jpg">
					<img width="133" height="75"
					src="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-16_s.jpg">
				</a> <a title="2013-9-17"
					href="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-17_w.jpg">
					<img width="133" height="75"
					src="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-17_s.jpg">
				</a> <a title="2013-9-23"
					href="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-23_w.jpg">
					<img width="133" height="75"
					src="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-9-23_s.jpg">
				</a> <a title="2013-10-2"
					href="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-10-2_w.jpg">
					<img width="133" height="75"
					src="http://keleyi.com/keleyi/phtml/jqtexiao/3/images/keleyi-com-2013-10-2_s.jpg">
				</a>
			</div>
			<div class="clear"></div>

		<!--右边部分 end-->
		<div class="clear"></div>
	</div>
	<!--主体部分二 end-->
	<jsp:include page="foot.jsp" flush="true" />
	<script type="text/jscript">
							$(document).ready(function() {

								$('.dengxaing-ke' + 'leyi-com').magnificPopup({
									delegate: 'a',
									type: 'image',
									tLoading: 'Loading image #%curr%...',
									mainClass: 'mfp-img-mobile',
									gallery: {
										enabled: true,
										navigateByImgClick: true,
										preload: [0,1] // Will preload 0 - before current, and 1 after the current image
									},
									image: {
										tError: '<a href="%url%">The image #%curr%</a> could not be loaded.',
										titleSrc: function(item) {
											return item.el.attr('title') + '<small>by Keleyi</small>';
										}
									}
								});


							});

							</script>
</body>
</html>
