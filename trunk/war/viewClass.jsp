<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看课程</title>
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
		$.ajax({
			url:"struts/ViewClass_ViewClass",
			success:function(data){
				var jsonObject = eval('('+data+')');
				$('#titile').html(jsonObject.title);
				$('#courseId').html(jsonObject.classNum);
				$('#blockContent').html(jsonObject.bloclContent);
			}
		});
		
	});
</script>
<!--当前路径 start-->0
<div class="mainContent path">
	<ul>
		<li>当前位置:&nbsp;</li>
		<li><a href="main.html" target="_self">首页</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><a href="#">企业培训</a></li>
		<li class="bread">&gt;&gt;</li>
		<li><a href="#">人力资源课程</a></li>
		<li class="bread">&gt;&gt;</li>
		<li>成为卓越领导、构建高绩效团队</li>
	</ul>
	<div class="clear"></div>
</div>
<!--当前路径 end-->
<div class="mainContent partTwo" style="margin-top:0px;padding-top:0px;">
	
	<!--左边部分课程信息 start-->
	<div class="leftInPart">
		<div class="classDetail" >
			<div ><h1 id="title">成为卓越领导、构建高绩效团队</h1>
			<div class="classNum" id="courseId">课程编号：12345</div></div>
			<div class="detail">
			<div class="classLeftPart" id="courseInfo">
			<div class="time"><span>举办时间：</span><a href="#">2013-5-10 至 2013-5-15</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">2013-6-10 至 2013-6-19</a></div>
			<div class="time"><span>上课地点：</span><a href="#">广州</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">北京</a></div>
			<div class="time"><span>课程费用：</span>2800元/位; 7980元/3位; 13300元/5位;(包含上课所有中午餐,茶水和培训教材)</div>
			<div class="time"><span>培训师：</span>李老师</div>
			<div class="time"><span>培训对象：</span><a href="#">总经理</a>、<a href="#">CEO</a>、<a href="#">高级管理人员</a></div>
			<div class="time"><span>适用行业：</span><a href="#">电力行业</a>、<a href="#">生产行业</a></div>
			<div class="time"><span>适用专业：</span><a href="#">工商管理</a>、<a href="#">行政管理</a>、<a href="#">人力资源</a></div>
			<div class="time"><span>关键词：</span><a href="#">管理</a>、<a href="#">团队建设</a></div>
			<div class="time"><span>专题：</span><a href="#">企业管理</a></div>
			</div>
			<div class="classRightPart">
				<dd><a href="#">打印课程提纲</a></dd>
				<dd><a href="#">打印报名表格</a></dd>
				<dd><a href="#">先加入收藏夹</a></dd>
				<dd><a href="#">引入内训申请</a></dd>
				<dd><a href="#">先发送至邮箱</a></dd>
				<dd><a href="#">保存电脑桌面</a></dd>
				<dd><a href="#">下载课程提纲</a></dd>
				</div>
			<div class="clear"></div>
			</div>
			<div class="clear"></div>
			<div id="courseContent">
			<div class="intro">推荐理由</div>
			<p id="blockContent">
				高绩效团队课程旨在帮助学员对照新、旧工作模式及其结果来看清自身的“行为短板”，激发学员主动改变的动机；理解、掌握“团队工作模式”的过程和行为要领，并结合自身的经验运用于实际工作中；了解在团队中实施“团队工作模式”的阻力与解决策略，使得他们愿意带领团队尝试改变。 
			</p>
			<div class="intro">课程内容</div>
			<p >
目前中国已经成为全球电子制造业的中心,随着电子产品的高密化、环保化、低利润化、高质量要求,电子制造企业的生存越来越艰难,只有在保证产品功能的情况下提高产品质量、降低产品成本,才能在竞争激烈的市场中争得一席之地。对电子产品质量影响最大的莫过于工艺缺陷,是否有能力准确地定位、分析、解决电子制造工艺缺陷成为提高电子产品质量的关键,本课程总结讲师多年的工作经验和实例,并综合业界最新的成果拟制而成,是业内少见的系统讲解工艺缺陷分析诊断与解决方案的精品课程。</p>
<div class="intro">课程特点</div>
<p>
本课程以电子组装焊接(软钎焊)基本原理和可焊性基础讲解为出发点,通过实例来系统深入地讲解电子组装工艺(SMT和波峰焊)工艺过程的数十种典型工艺缺陷的机理和解决方案,通过该课程的学习可以掌握电子组装工艺典型缺陷的分析 定位与解决.在第二天的专项工艺缺陷的诊断分析中,将针对组装工艺的新问题和难点问题:无铅焊接 BGA焊接 QFN/MLF焊接问题进行讲解,介绍无铅焊接过程独特的工艺缺陷的分析与解决,介绍面阵列器件(BGA)10大类工艺缺陷的分析解决,介绍QFN/MLF器件工艺缺陷的分析和解决方案介绍.通过本课程的学习,学员能够基本掌握电子组装焊接(软钎焊)的基本原理和可焊性测量判断方法,能够系统准确地定位分析解决电子组装过程典型工艺缺陷,有效提高公司产品的设计水平与质量水平,提高产品在市场的竞争力.</p>
<div class="intro">课程大纲</div>
<p>
第一天课程:
<h2>一、电子组装工艺技术介绍</h2>
<h3>从THT到SMT工艺的驱动</h3>
<h3>SMT工艺的发展趋势及面临的挑战</h3>


<h2>二、电子组装焊接(软钎焊)原理及可焊性基础</h2>
<h3>焊接方法分类</h3>
<h3>电子组装焊接(软钎焊)的机理和优越性</h3>
<h3>形成良好软钎焊的条件</h3>
<h3>润湿 扩散 金属间化合物在焊接中的作用</h3>
<h3>良好焊点与不良焊点举例</h3>
<h2>三、SMT工艺缺陷的诊断分析与解决</h2>
<h3>印刷工艺缺陷分析与解决:</h3>
<h3>焊膏脱模不良</h3>
<h3>焊膏印刷厚度问题</h3>
<h3>焊膏塌陷</h3>
<h3>布局不当引起印锡问题等</h3>
<h3>回流焊接工艺缺陷分析诊断与解决方案:</h3>
<h3>冷焊</h3>
<h3>立碑</h3>
<h3>连锡</h3>
<h3>偏位</h3>
<h3>芯吸(灯芯现象)</h3>
<h3>开路</h3>
<h3>焊点空洞</h3>
<h3>锡珠</h3>
<h3>不润湿</h3>
<h3>半润湿</h3>
<h3>退润湿</h3>
<h3>焊料飞溅等</h3>
<h3>回流焊接典型缺陷案例介绍</h3>
<p>第二天课程(专项工艺缺陷的分析与诊断):</p>
<h2>四、无铅焊接工艺缺陷的诊断分析与解决无铅焊接典型工艺缺陷分析诊断与解决:</h2>
<h3>PCB分层与变形</h3>
<h3>BAG/CSP曲翘变形导致连锡、开路</h3>
<h3>无铅焊料润湿性差、扩散性差导致波峰焊的连锡缺陷</h3>
<h3>黑焊盘Black pads</h3>
<h3>焊盘脱离</h3>
<h3>润湿不良;</h3>
<h3>锡须Tin whisker;</h3>
<h3>热损伤Thermadamage;</h3>
<h3>导电阳极细丝Conductive anodic filament;</h3>
<h3>无铅焊接典型工艺缺陷实例分析.</h3>
<h2>五、面阵列类器件(BGA)十类典型工艺缺陷的诊断分析与解决</h2>
<h3>BGA典型工艺缺陷的分析诊断与解决方案:</h3>
<h3>空洞</h3>
<h3>连锡</h3>
<h3>虚焊</h3>
<h3>锡珠</h3>
<h3>爆米花现象</h3>
<h3>润湿不良</h3>
<h3>焊球高度不均</h3>
<h3>自对中不良</h3>
<h3>焊点不饱满</h3>
<h3>焊料膜等.</h3>
<h3>BGA工艺缺陷实例分析.</h3>
<h2>六、QFN/MLF器件工艺缺陷的分析诊断与解决</h2>
<h3>QFN/MLF器件封装设计上的考虑</h3>
<h3>PCB设计指南</h3>
<h3>钢网设计指南</h3>
<h3>印刷工艺控制</h3>
<h3>QFN/MLF器件潜在工艺缺陷的分析与解决</h3>
<h3>典型工艺缺陷实例分析.</h3>
<h2>七、讨论</h2>
</p>
<div class="intro">讲师介绍：王毅博士</div>
<p>工学博士，曾任职华为技术有限公司，8年以上大型企业研发及生产实践经验。主持建立华为公司SMT工艺可靠性技术研究平台，参与建设华为公司SMT工艺平台四大规范体系，擅长电子产品可制造性设计DFM 、SMT工艺可靠性设计DFR等DFx设计平台的建立与应用，在电子产品可制造性设计、SMT组装工艺缺陷机理分析与解决、失效分析、工艺可靠性等领域有深入研究与丰富的实践应用经验。获省部级科技进步一等奖一次，包括在《CHINES SCIENCE BULLETINE》等国际一流刊物发表学术论文30多篇，包括《BGA空洞形成的机理及对焊点可靠性的影响》、《微型片式元件焊接过程立碑工艺缺陷的分析与解决》、《QFN器件组装工艺缺陷的分析与解决》、《CCGA器件的可靠性返修》等SMT专业技术文章多篇。</p><p>培训和咨询过的知名企业：艾默生网络能源、南京熊猫爱立信、深圳市高新技术行业协会、日立汽车部件、霍尼韦尔安防（中国）有限公司、西蒙克拉电子(苏州)、上海大唐移动、中兴通讯、Optel通讯、厦门华侨电子、海尔、美的集团、格力电器、创维集团、康佳集团、联想集团、比亚迪、同洲电子、同维电子、TCL、大族激光、迈瑞生物医疗、富士康、英业达、炬力、固高科技、飞通光电、 步步高、万利达、宇龙、好易通、科立讯、金立、海康威视公司、长沙威胜集团、佛山伊戈尔集团、航盛电子、嘉兆电子科技（珠海）、斯比泰电子、中达电子、苏州万旭光电、山东省东营科英激光电子、南京汉业电子实业有限公司、深圳安科讯、电子十所、西安东风仪表厂、中海油服、北京人民电器厂。 
			</p>
		</div>
	</div>
	<div class="clear"></div>
	<!--报名表 start-->
	<div class="attend">
		<h2>报名/咨询</h2>
		<div style="height:15px; display:block" class="clear"></div>
		<div ><h3>企业培训:</h3><span>020-61908283</span><span>020-39948135</span></div>
		<div class="clear"></div>
	</div>
	
	<div class="attendTable">
		<table>
			<thead><h2>报名/咨询表</h2></thead>
			<tr>
				<td width="140px" align="right">单位名称：</td>
				<td width="240px" align="left"><input  type="text"/></td>
				<td width="70px"  align="right">联系人：</td>
				<td align="left"><input  type="text"/><font style="color:red">&nbsp;*</font></td>
			</tr>
			<tr>
				<td align="right">联系电话：</td>
				<td align="left"><input  type="text"/><font style="color:red">&nbsp;*</font></td>
				<td align="right">传真：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td align="right">移动电话：</td>
				<td align="left"><input  type="text"/></td>
				<td  align="right">电子邮箱：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td align="right">任职部门：</td>
				<td align="left"><input  type="text"/></td>
				<td align="right">MSN：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td align="right">企业类型：</td>
				<td align="left"><input  type="text"/></td>
				<td  align="right">业务范围：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td align="right">开始时间：</td>
				<td  align="left"><input  type="text"/></td>
				<td  align="right">结束时间：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
				<td  align="right">财务预算：</td>
				<td align="left"><input  type="text"/></td>
				<td align="right">教学语种：</td>
				<td align="left"><input  type="text"/></td>
			</tr>
			<tr>
			<td  align="right">参训对象简单描述：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">学员基础简单说明：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">企业简介：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">具体那个环节出问题：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">培训内容说明：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td  align="right">预期目标：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td align="right">备注：</td>
			<td colspan="3"  align="left"><textarea rows="5" cols="57"></textarea></td>
			</tr>
			<tr>
			<td colspan="2"  align="left" style="padding-left:140px;"><input type="radio" class="status" name="group1" checked="checked"/><label>确认报名</label><input type="radio" class="status" name="group1" /><label>正在申请中</label></td>
			
			</tr>
			<tr style="height:70px"><td colspan="4" align="center"><input class="btn"  type="button" value="确定报名"/>&nbsp;<input class="btn"  type="button" value="重新填写"/></td></tr>
		</table>
	</div>
	<!--报名表 end-->
	</div>
	<!--左边部分课程信息 end-->
	
	<!--右边部分信息 start-->
	<div class="rightInPart">
			<div class="rightTeacher">
				<h5  class="first">相关关键词</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;"/>
					<div class="clear" style="height:10px;"></div>
				<ul class="list8"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
				<h5 >相关专题</h5>
				<div class="bg" style="padding:0px 15px 4px 15px;border:none;height:85px;"/>
					<div class="clear" style="height:10px;"></div>
				<ul class="list8"><li><a href="#">绩效管理</a></li><li><a href="#">团队管理</a></li><li><a href="#">团队素质</a></li><li><a href="#">团队文化建设</a></li><li><a href="#">团队执行力</a></li><li><a href="#">领导力</a></li><li><a href="#">绩效考核</a></li><li><a href="#">绩效测评</a></li></ul>
				<div class="clear"></div>
				</div>
			</div>
	<!--月份 start-->
		<div style="display:block;height:10px"></div>
		<div class="head">2012年企业培训计划</div>
		<div class="bg p5 h40">
			<ul class="list2">
				<li><a href="#">01月</a></li>
				<li><a href="#">02月</a></li>
				<li><a href="#">03月</a></li>
				<li><a href="#">04月</a></li>
				<li><a href="#">05月</a></li>
				<li><a href="#">06月</a></li>
				<li><a href="#">07月</a></li>
				<li ><a href="#">08月</a></li>
				<li><a href="#">09月</a></li>
				<li><a href="#">10月</a></li>
				<li><a href="#">11月</a></li>
				<li><a href="#">12月</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<!--月份 end-->
		
		<!--内训 start-->
		<div class="head">2013年企业培训计划</div>
		<div class="bg p5 h40" >
				<ul class="list2">
					<li><a href="#">01月</a></li>
					<li><a href="#">02月</a></li>
					<li><a href="#">03月</a></li>
					<li><a href="#">04月</a></li>
					<li><a href="#">05月</a></li>
					<li><a href="#">06月</a></li>
					<li><a href="#">07月</a></li>
					<li ><a href="#">08月</a></li>
					<li><a href="#">09月</a></li>
					<li><a href="#">10月</a></li>
					<li><a href="#">11月</a></li>
					<li><a href="#">12月</a></li>
				</ul>
			<div class="clear"></div>
		</div>
		<!--内训 end-->
		<!--地点 start-->
		<div class="head">开课地点</div>
		<div class="bg h45" style="border-bottom:1px solid #ebebeb">
			<ul class="list2 city">
				<li><a href="#">北京</a></li>
				<li><a href="#">上海</a></li>
				<li><a href="#">深圳</a></li>
				<li><a href="#">广州</a></li>
				<li><a href="#">杭州</a></li>
				<li><a href="#">东莞</a></li>
				<li><a href="#">苏州</a></li>
				<li><a href="#">全国</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<!--地点 end-->
		<!--热门培训 培训计划 培训下载 start-->
		<div style="height:10px; display:block"></div>
		<div class="sortList">
			<div class="head">
						<div class="tabOn half">热门培训</div>
						<div class="tabOff half">热门排行</div>
						<div class="clear"></div>
					</div>
					<div class="bg h315" style="padding:0px 15px 4px 15px;">
						<ul class="list7" style="padding-top:10px">
							<li class="line"><a><span class="red">1</span>企业资本运作与投融资顾问</a></li>
							<li  class="line"><a><span class="red">2</span>企业资本运作与投融资顾问</a></li>
							<li class="line"><a><span class="blue">3</span>企业资本运作与投融资顾问</a></li>
							<li class="line"><a><span class="blue">4</span>企业资本运作与投融资顾问</a></li>
							<li class="line"><a><span class="blue">5</span>企业资本运作与投融资顾问</a></li>
						</ul>
						<div class="clear"></div>
					</div>
		</div>
		<!--培训计划 培训下载 end-->
		<div style="height:10px; display:block"></div>
		<div class="rightTeacher">
			<h5  class="first">培训计划</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto">
				<ul class="list9">
					<li><a>2013年4月培训计划</a></li>
					<li><a>2013年5月培训计划</a></li>
					<li><a>2013年6月培训计划</a></li>
					<li><a>2013年7月培训计划</a></li>
					<li><a>2013年8月培训计划</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<h5 >培训下载</h5>
			<div class="bg" style="padding:10px 15px 10px 15px;border:none;height:auto;">
				<ul class="list9">
					<li><a>经典资料：行政管理怎样做...</a></li>
					<li><a>发邮件的礼仪</a></li>
					<li><a>教你如何与人交流</a></li>
					<li><a>攻心说话术</a></li>
					<li><a>与人相处的黄金法则</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<h5>培训老师</h5>
			<div class="bg" style="padding:10px 0px 10px 12px;border:none;height:auto;">
				<ul class="teacher">
					<li><a href="#">刘强</a></li>
					<li><a href="#">张三</a></li>
					<li><a href="#">刘强</a></li>
					<li><a href="#">张三</a></li>
					<li><a href="#">刘强</a></li>
					<li><a href="#">张三</a></li>
					<li><a href="#">刘强</a></li>
					<li><a href="#">张三</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			
			<h5>典型客户</h5>
			<dl class="bestCustomer leftPart left" style="width:110px;">
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
				<dd><a href="#">阿里巴巴</a></dd>
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
			</dl>
			<dl class="bestCustomer rightPart right" style="width:110px;">
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
				<dd><a href="#">阿里巴巴</a></dd>
				<dd><a href="#">华夏基金</a></dd>
				<dd><a href="#">湖南中烟</a></dd>
				<dd><a href="#">工商银行</a></dd>
			</dl>
			<div class="clear"></div>
		</div>
		
	</div>
	<!--右边部分信息 end-->
	
</div>

<div class="clear"></div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>