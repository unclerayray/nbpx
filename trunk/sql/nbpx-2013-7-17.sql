/*
MySQL Data Transfer
Source Host: localhost
Source Database: nbpx
Target Host: localhost
Target Database: nbpx
Date: 2013/7/17 21:12:53
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for answers
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `answerId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `answeredBy` int(11) default NULL COMMENT '回答用户ID',
  `answerdDate` date default NULL COMMENT '回答时间',
  `isBest` tinyint(1) default '0' COMMENT '是否最佳答案',
  `content` tinyint(4) default NULL COMMENT '回答内容',
  PRIMARY KEY  (`answerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for applications
-- ----------------------------
DROP TABLE IF EXISTS `applications`;
CREATE TABLE `applications` (
  `applyId` int(11) NOT NULL auto_increment COMMENT '报名表主键ID',
  `applicant` int(11) default NULL COMMENT '申请人ID',
  `applicatCompId` int(11) default NULL COMMENT '申请企业的ID，如非注册用户，可为空',
  `applicantCompany` varchar(20) default NULL COMMENT '申请企业名（如无单位可为空）',
  `applyCourseId` int(11) default NULL COMMENT '申请课程ID',
  `headCount` int(11) default '1' COMMENT '参加人数',
  `contact` varchar(20) default '' COMMENT '联系人',
  `cellphone` int(20) default NULL COMMENT '联系人移动电话',
  `telephone` int(20) default NULL COMMENT '座机',
  `email` varchar(20) default NULL,
  `fax` int(20) default NULL,
  `department` varchar(40) default NULL,
  `remarks` varchar(256) default '备注',
  `state` varchar(11) default NULL COMMENT '报名状态',
  `stateInfo` varchar(200) default NULL COMMENT '跟进情况',
  `attribute1` varchar(20) default NULL,
  `attribute2` varchar(20) default NULL,
  `attribute3` varchar(20) default NULL,
  `attribute4` varchar(20) default NULL,
  PRIMARY KEY  (`applyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程申请表';

-- ----------------------------
-- Table structure for articlekeywords
-- ----------------------------
DROP TABLE IF EXISTS `articlekeywords`;
CREATE TABLE `articlekeywords` (
  `artKeywordId` int(11) NOT NULL COMMENT '主键ID',
  `keywordId` int(11) default NULL COMMENT '对应keywords表中的ID',
  `articleId` int(11) default NULL,
  PRIMARY KEY  (`artKeywordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章关键词表';

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `articleID` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `articleTitle` varchar(40) default NULL COMMENT '标题',
  `content` mediumtext COMMENT '内容',
  `author` varchar(20) default NULL COMMENT '作者',
  `creationDate` date default NULL COMMENT '创建日期',
  `categoryId` int(11) default NULL COMMENT '种类ID',
  `hits` int(11) default '200' COMMENT '点击量',
  `state` tinyint(1) default '0' COMMENT '审核状态',
  `recommended` tinyint(1) default NULL COMMENT '推荐',
  PRIMARY KEY  (`articleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章与新闻表; InnoDB free: 1050624 kB';

-- ----------------------------
-- Table structure for companyinfo
-- ----------------------------
DROP TABLE IF EXISTS `companyinfo`;
CREATE TABLE `companyinfo` (
  `compInfoId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `userId` int(11) NOT NULL COMMENT '对应users表中的主键ID',
  `contact` varchar(20) default NULL COMMENT '联系人',
  `company` varchar(20) default NULL COMMENT '企业名称',
  `telephone` varchar(16) default NULL COMMENT '固定电话',
  `cellphone` varchar(16) default NULL COMMENT '移动电话',
  `fax` varchar(16) default NULL COMMENT '传真',
  `department` varchar(20) default '' COMMENT '职任部门',
  PRIMARY KEY  (`compInfoId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业信息表';

-- ----------------------------
-- Table structure for courseinfo
-- ----------------------------
DROP TABLE IF EXISTS `courseinfo`;
CREATE TABLE `courseinfo` (
  `coursePeriodId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `courseId` int(11) default NULL COMMENT '课程名',
  `startDate` date default NULL COMMENT '开始时间',
  `endDate` date default NULL COMMENT '结束时间',
  `city` varchar(20) default NULL COMMENT '开课城市',
  PRIMARY KEY  (`coursePeriodId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='开课时间地点表';

-- ----------------------------
-- Table structure for coursekeywords
-- ----------------------------
DROP TABLE IF EXISTS `coursekeywords`;
CREATE TABLE `coursekeywords` (
  `courseKeywordId` int(11) NOT NULL COMMENT '主键ID',
  `keywordId` int(11) default NULL COMMENT '对应keywords表中的ID',
  `courseId` int(11) default NULL COMMENT '课程ID',
  PRIMARY KEY  (`courseKeywordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程关键词表';

-- ----------------------------
-- Table structure for coursemajor
-- ----------------------------
DROP TABLE IF EXISTS `coursemajor`;
CREATE TABLE `coursemajor` (
  `courseMajorId` int(11) default NULL COMMENT '主键',
  `courseId` int(11) default NULL COMMENT '课程',
  `major` varchar(20) default NULL COMMENT '专业'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程专业表';

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `courseId` int(11) NOT NULL auto_increment COMMENT '课程表主键ID',
  `title` varchar(200) default NULL COMMENT '课程标题',
  `courseCode` varchar(20) default NULL COMMENT '课程编号',
  `teacherId` varchar(11) default NULL,
  `teacherName` varchar(20) default NULL,
  `category` varchar(20) default NULL COMMENT '课程类别',
  `isInner` tinyint(1) default '0' COMMENT '是否为内训课程',
  `content` mediumtext COMMENT '课程内容',
  `blockedContent` mediumtext COMMENT '屏蔽内容',
  `videoUrl` varchar(60) default NULL COMMENT '视频地址',
  `hits` int(11) default '200' COMMENT '点击数',
  `createdBy` int(11) default NULL,
  `creationDate` date default NULL,
  `lastUpdatedBy` int(11) default NULL,
  `lastUpdateDate` date default NULL,
  `state` tinyint(1) default '0' COMMENT '审核标志（1为通过，0为未审核通过）',
  PRIMARY KEY  (`courseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程表';

-- ----------------------------
-- Table structure for coursetarget
-- ----------------------------
DROP TABLE IF EXISTS `coursetarget`;
CREATE TABLE `coursetarget` (
  `courseTargetTd` int(11) NOT NULL auto_increment COMMENT '主键id',
  `courseId` int(11) default NULL COMMENT '课程id',
  `target` varchar(20) default NULL COMMENT '培训对象(字典项)',
  PRIMARY KEY  (`courseTargetTd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='培训课程对象表';

-- ----------------------------
-- Table structure for keywords
-- ----------------------------
DROP TABLE IF EXISTS `keywords`;
CREATE TABLE `keywords` (
  `keyId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `keyword` varchar(10) default NULL COMMENT '关键词',
  `flag` tinyint(1) default '0' COMMENT '是否有效',
  `type` int(11) default NULL COMMENT '关键词种类',
  `categoryId` int(11) default NULL COMMENT '种类ID',
  PRIMARY KEY  (`keyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `logId` int(11) NOT NULL auto_increment COMMENT 'log表主键',
  `logContents` varchar(80) default NULL COMMENT 'log内容',
  `logDate` date default NULL COMMENT 'log时间',
  `logedBy` int(11) default NULL COMMENT 'log产生人',
  PRIMARY KEY  (`logId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orginfo
-- ----------------------------
DROP TABLE IF EXISTS `orginfo`;
CREATE TABLE `orginfo` (
  `orgId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `userId` int(11) NOT NULL COMMENT '对应users表中的主键ID',
  `orgName` varchar(20) default NULL COMMENT '机构名称',
  `address` varchar(50) default NULL COMMENT '地址',
  `postCode` int(6) default NULL COMMENT '邮编',
  `contact` varchar(8) default NULL COMMENT '联系人',
  `cellphone` varchar(16) default NULL COMMENT '移动电话',
  `telephone` varchar(16) default NULL COMMENT '联系电话',
  `fax` varchar(16) default NULL COMMENT '传真',
  `website` varchar(30) default NULL COMMENT '网址',
  `category` varchar(30) default '' COMMENT '培训类别（多选）',
  `introduction` varchar(300) default '' COMMENT '简介',
  PRIMARY KEY  (`orgId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构信息表';

-- ----------------------------
-- Table structure for questions
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `questionId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `title` varchar(50) default '' COMMENT '标题',
  `content` tinytext COMMENT '内容',
  `isClosed` tinyint(1) default '0' COMMENT '关闭标志',
  `askDate` date default NULL COMMENT '提问时间',
  `askedBy` varchar(11) default NULL COMMENT '提问人',
  PRIMARY KEY  (`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题表';

-- ----------------------------
-- Table structure for requirements
-- ----------------------------
DROP TABLE IF EXISTS `requirements`;
CREATE TABLE `requirements` (
  `requirementId` int(10) unsigned NOT NULL auto_increment COMMENT '需求主键ID',
  `userId` int(11) NOT NULL COMMENT '用户ID，可为空',
  `requiredCourse` varchar(20) collate utf8_bin NOT NULL COMMENT '需要的课程名称',
  `headCount` int(11) default NULL COMMENT '预计参加人数',
  `validDays` int(3) default NULL COMMENT '有效天数',
  `startTime` datetime NOT NULL COMMENT '开始时间',
  `endTime` datetime NOT NULL COMMENT '结束时间',
  `city` varchar(20) collate utf8_bin NOT NULL default '' COMMENT '所在城市',
  `contact` varchar(20) collate utf8_bin NOT NULL default '' COMMENT '联系人',
  `telephone` int(18) default NULL,
  `cellphone` int(18) default NULL,
  `comp_name` varchar(30) collate utf8_bin NOT NULL COMMENT '所在公司',
  `description` tinytext collate utf8_bin NOT NULL COMMENT '求需描述',
  `reply` tinytext collate utf8_bin COMMENT '回复',
  `hasReplied` tinyint(1) unsigned NOT NULL default '0' COMMENT '回复标志',
  PRIMARY KEY  (`requirementId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='需求表';

-- ----------------------------
-- Table structure for series
-- ----------------------------
DROP TABLE IF EXISTS `series`;
CREATE TABLE `series` (
  `serieId` int(11) default NULL COMMENT '主键id',
  `serieName` varchar(20) default NULL COMMENT '专题名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='专题表';

-- ----------------------------
-- Table structure for statistics
-- ----------------------------
DROP TABLE IF EXISTS `statistics`;
CREATE TABLE `statistics` (
  `statisticsId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `type` varchar(11) NOT NULL default '' COMMENT '统计类别',
  `order` int(11) default NULL COMMENT '顺序',
  `year` int(4) default NULL COMMENT '统计年份',
  `month` int(2) default NULL COMMENT '统计月份',
  `statDate` date default NULL COMMENT '统计日期',
  `keyword` int(11) default NULL COMMENT '关键词',
  PRIMARY KEY  (`statisticsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionary`;
CREATE TABLE `sys_dictionary` (
  `dicId` int(11) NOT NULL auto_increment COMMENT '字典项ID',
  `dicType` char(3) default NULL COMMENT '类型',
  `codeName` varchar(20) default NULL COMMENT '代码名称',
  `showName` varchar(100) default NULL COMMENT '显示名称',
  `orderNum` int(11) default NULL COMMENT '排列顺序',
  `attribute1` varchar(20) default NULL COMMENT '备用1',
  `attribute2` varchar(20) default NULL COMMENT '备用2',
  `attribute3` varchar(20) default NULL COMMENT '备用3',
  `flag` tinyint(1) default '1' COMMENT '有效标识',
  `discription` varchar(100) default NULL COMMENT '字典描述',
  PRIMARY KEY  (`dicId`),
  UNIQUE KEY `dumpPropConst` (`dicType`,`codeName`,`showName`),
  KEY `dicType_index` (`dicType`),
  KEY `code_index` (`codeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Table structure for sys_dictionary_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionary_relation`;
CREATE TABLE `sys_dictionary_relation` (
  `relationId` int(11) NOT NULL COMMENT '主键',
  `dicType` varchar(20) collate utf8_bin default NULL COMMENT '字典类型',
  `dicCode` varchar(20) collate utf8_bin default NULL COMMENT '字典编码',
  `pid` int(11) default NULL COMMENT '父字典编码',
  `orderNum` int(3) default NULL COMMENT '顺序号',
  `description` varchar(50) collate utf8_bin default NULL COMMENT '关联描述',
  PRIMARY KEY  (`relationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for teacher_info
-- ----------------------------
DROP TABLE IF EXISTS `teacher_info`;
CREATE TABLE `teacher_info` (
  `teacherId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `userId` int(11) NOT NULL COMMENT '用户名',
  `realName` varchar(20) default NULL COMMENT '真实姓名',
  `birthday` date default NULL COMMENT '出生日期',
  `majorCatgory` varchar(11) default NULL COMMENT '主讲类别',
  `externalPayment` double default NULL COMMENT '对外课酬',
  `internalPayment` double default NULL COMMENT '协议课酬',
  `fax` varchar(16) default NULL COMMENT '传真',
  `telephone` varchar(16) default NULL COMMENT '座机',
  `cellphone` varchar(16) default NULL COMMENT '移动电话',
  `introduction` text COMMENT '个人简介',
  `expertIn` text COMMENT '擅长项目',
  PRIMARY KEY  (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='讲师信息表';

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(20) NOT NULL COMMENT '用户密码',
  `city` varchar(11) NOT NULL default '' COMMENT '所在城市',
  `email` varchar(20) NOT NULL COMMENT '邮箱',
  `userType` varchar(20) NOT NULL COMMENT '用户类别',
  `state` tinyint(1) NOT NULL default '0' COMMENT '激活状态',
  `registerDate` date NOT NULL COMMENT '注册日期',
  PRIMARY KEY  (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `articles` VALUES ('1', null, '????????????????????????????????????????', '宋祖英', '2013-05-07', '1', '200', '0', null);
INSERT INTO `companyinfo` VALUES ('1', '1', '邓卫华', '科技公司', '8960111', '13640713241', '88218960', '开发部');
INSERT INTO `courses` VALUES ('1', '怎样有效的进行企业管理', 'ZYYX_001', '1', '邓卫华', '003_01', '0', '富士康因克扣工资和加班费被曝光，这个被为“血汗工厂”的公司失去的肯定远远不止“中国出口冠军”的头衔；华为员工胡新宇因长期加班致死，让华为的社会形象一落千丈；无锡红星工具有限公司因员工索要加班费而致破产……<br>在劳动合同法即将实施的背景下，工资、工时及加班费成为劳资管理领域最热门、最敏感的话题。随着建设“和谐社会”进程的加快，政府不断提高劳动保护标准，导致企业用工成本的提高。于是，通过加班的方式延长工时，减少员工人数，成了众多企业采取的应对策略。越来越多的劳动者则对加班感到不满，由于加班费而引发的劳动争议呈逐年上升之势。同时，员工将正常工时下能完成的任务拖到加班时来做，导致加班费用大大增加，企业苦不堪言。如何合法设计工资、工时、控制加班管理风险成了众多企业头痛的一个问题。 <br><br>主要内容：<br>1、企业拖欠、克扣工资、加班费的巨大法律风险<br>2、工资、工时、休假及加班费的基本法律规定和法律要点<br>3、薪酬设计与实施中对法律的技术性处理和利用<br>4、薪酬设计中同工同酬的正确理解与风险控制<br>5、计件制、综合计算工时制、不定时工时制之区别与正确运用<br>6、企业高管、保安、门卫等特殊岗位人员加班费管理实务<br>7、加班加点的工资计算口径与工资支付中的风险规避<br>8、加班费的追索时效、举证责任与企业如何应对加班费投诉、诉讼<br>9、考勤的重要法律意义及企业考勤管理中普遍存在的若干问题<br>10、企业合法控制加班管理风险及加班费成本的六大法宝 <br>11、如何完善企业加班管理制度及制订技巧实战训练<br>12、典型案例分析、现场疑难解答、经验交流与精彩互动<br><br>讲师简介：<br>　　魏浩征，劳动法首席顾问，《员工关系》总编，美国认证协会注册国际高级人力资源专家，北京中关村IT协会劳动关系首席顾问。<br>　　作为国内顶尖的劳动法与员工关系管理专家，魏浩征老师在企业规章制度管理、劳动合同管理、商业秘密保护、员工违纪处理、企业裁员、用工成本控制、改制重组、劳动争议预防及应对等方面具有独特的才能和丰富的经验，为新闻出版署、奇瑞汽车、蒙牛乳业、联想集团、中国兵器工业集团、中国银行、中国五矿集团、华润集团、易初莲花、拜耳、橡果国际、AO史密斯、大金空调、DMG等近百家知名企业机构提供劳动关系风险管理咨询、培训及顾问服务。<br>　　魏浩征老师的课程具有极强的穿透力、杀伤力和改造力，近年来，他先后在在全国各地主讲超过300场劳动关系管理公开课及内训课程，受训学员数万名', '　　魏浩征老师的课程具有极强的穿透力、杀伤力和改造力，近年来，他先后在在全国各地主讲超过300场劳动关系管理公开课及内训课程，受训学员数万名', null, '200', null, null, null, null, '1');
INSERT INTO `courses` VALUES ('2', '哈哈哈', 'QQYUDO', null, '你要', '003_03', null, '<p><span style=\"background-color:rgb(250, 250, 250); color:rgb(66, 48, 9); font-family:arial,helvetica,sans-serif; font-size:14px\">【看中国：世界最大单体建筑成都开业】英国卫报关注了6月28日开业的&quot;世界最大单体建筑&quot;-成都新世界环球中心。里面酒店、购物中心、电影院等设施一应俱全，还有人造海洋、海滩。卫报网友对这座建筑进行热议，有赞扬，有想去的，有怕挤的，还有觉得热闹的。观点就是如此纷繁。详见：</span><a href=\"http://t.cn/zQ2qL24\" style=\"text-decoration: none; color: rgb(108, 99, 81); font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(250, 250, 250);\" target=\"_blank\" title=\"http://news.sina.com.cn/w/gc/2013-07-10/2021159.shtml\">http://t.cn/zQ2qL24</a></p>\r\n', null, null, null, null, null, null, null, '1');
INSERT INTO `orginfo` VALUES ('1', '2', '人人培训', '天河东路', '51000123', '邓生啊阿斯蒂芬', '13640713241', '8960', '8960', 'www.baidu.com', '内训培训', '我们是个好机构，专门培养各种人才我去阿的发放');
INSERT INTO `sys_dictionary` VALUES ('1', '001', '001_01', '企业', null, null, null, null, '1', '用户类别字典');
INSERT INTO `sys_dictionary` VALUES ('2', '001', '001_02', '教师', null, null, null, null, '1', '用户类别字典');
INSERT INTO `sys_dictionary` VALUES ('3', '001', '001_03', '机构', null, null, null, null, '1', '用户类别字典');
INSERT INTO `sys_dictionary` VALUES ('4', '998', '001', '用户种类', null, null, null, null, '1', '顶级节点');
INSERT INTO `sys_dictionary` VALUES ('6', '002', '002_001', '人力', null, null, null, null, '1', '测试字典功能');
INSERT INTO `sys_dictionary` VALUES ('7', '002', '002_002', '资源', null, null, null, null, '1', '再次测试');
INSERT INTO `sys_dictionary` VALUES ('8', '002', '002_003', '薪资', null, null, null, null, '1', 'sdgergwerg');
INSERT INTO `sys_dictionary` VALUES ('9', '002', '002_004', '报酬', null, null, null, null, '1', 'asdf');
INSERT INTO `sys_dictionary` VALUES ('10', '002', '002_005', '资讯', null, null, null, null, '1', '34545');
INSERT INTO `sys_dictionary` VALUES ('11', '002', '002_006', '计算机', null, null, null, null, '1', 'dfsgsdf');
INSERT INTO `sys_dictionary` VALUES ('12', '002', '002_007', '科学', null, null, null, null, '1', 'ewr');
INSERT INTO `sys_dictionary` VALUES ('13', '002', '002_008', '救灾', null, null, null, null, '1', 'aag');
INSERT INTO `sys_dictionary` VALUES ('14', '001', '001_04', '地震', null, null, null, null, '1', '测试字典功能');
INSERT INTO `sys_dictionary` VALUES ('15', '001', '001_05', '科普', null, null, null, null, '1', '测试字典功能');
INSERT INTO `sys_dictionary` VALUES ('24', '998', '002', '文章分类', null, null, null, null, '1', '顶级节点 实得分');
INSERT INTO `sys_dictionary` VALUES ('30', '998', '006', '专题分类', null, null, null, null, '1', '给我个');
INSERT INTO `sys_dictionary` VALUES ('31', '006', '006_01', '人力资源', null, null, null, null, '1', '二哥');
INSERT INTO `sys_dictionary` VALUES ('32', '998', '003', '课程分类', null, null, null, null, '1', '课程分类顶级节点');
INSERT INTO `sys_dictionary` VALUES ('33', '003', '003_01', '人力资源', null, null, null, null, '1', '人力资源相关课程');
INSERT INTO `sys_dictionary` VALUES ('35', '998', '004', '测试分类', null, null, null, null, '1', '个人股');
INSERT INTO `sys_dictionary` VALUES ('36', '003', '003_03', '企业管理', null, null, null, null, '1', '企业管理相关的课程');
INSERT INTO `sys_dictionary` VALUES ('39', '998', null, null, null, null, null, null, null, null);
INSERT INTO `teacher_info` VALUES ('1', '3', '邓卫华', '2013-06-20', '人力资源', '1000', '800', '8960', '13640713241', '13640713241', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '人力资源，内部培训等');
INSERT INTO `teacher_info` VALUES ('2', '13', '雷理超', '1988-12-06', '', '1000', '1000', '', '020-89608900', '', '123445', '123456');
INSERT INTO `users` VALUES ('1', 'Roger', '123456', '', '234@qq.com', '001_01', '0', '2013-06-06');
INSERT INTO `users` VALUES ('2', 'Ray', '123456', '', '123@qq.com', '001_01', '1', '2013-06-06');
INSERT INTO `users` VALUES ('3', 'Alonzo', '5555', '', '5555@qq.com', '001_01', '1', '2013-06-06');
INSERT INTO `users` VALUES ('4', 'syadmin', '12', '', '23@qq.com', '001_01', '1', '2013-06-06');
INSERT INTO `users` VALUES ('5', 'syadmin', 'asgwergwreg', '', '23@qq.com', '001_01', '0', '2013-06-06');
INSERT INTO `users` VALUES ('7', 'syadmin65uyg', '1234534', '', '23@qq.com', '001_01', '1', '2013-06-06');
INSERT INTO `users` VALUES ('8', 'someone', '1275', '', '23@qq.com', '001_03', '1', '2013-06-06');
INSERT INTO `users` VALUES ('9', 'hjfiouf', '1275', '', '23@qq.com', '001_02', '0', '2013-06-06');
INSERT INTO `users` VALUES ('10', 'henry', '123', '', '24@qq.com', '001_03', '0', '2013-06-06');
INSERT INTO `users` VALUES ('11', 'syadmirger', '1275', '', '23@qq.com', '001_03', '0', '2013-06-06');
INSERT INTO `users` VALUES ('12', 'edward', '1275', '', '23@qq.com', '001_01', '1', '2013-06-06');
INSERT INTO `users` VALUES ('13', '4444', '123456', '', '', '001_02', '0', '2013-06-30');
