/*
MySQL Data Transfer
Source Host: localhost
Source Database: nbpx
Target Host: localhost
Target Database: nbpx
Date: 2013/7/24 0:16:48
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
-- Table structure for courseindustry
-- ----------------------------
DROP TABLE IF EXISTS `courseindustry`;
CREATE TABLE `courseindustry` (
  `courseIndustryID` int(11) NOT NULL auto_increment,
  `courseID` int(11) default NULL,
  `industryCode` varchar(20) default NULL,
  `industry` varchar(100) default NULL,
  PRIMARY KEY  (`courseIndustryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for courseinfo
-- ----------------------------
DROP TABLE IF EXISTS `courseinfo`;
CREATE TABLE `courseinfo` (
  `courseInfoId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `courseId` int(11) default NULL COMMENT '课程名',
  `startDate` date default NULL COMMENT '开始时间',
  `endDate` date default NULL COMMENT '结束时间',
  `city` varchar(20) default NULL COMMENT '开课城市',
  PRIMARY KEY  (`courseInfoId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='开课时间地点安排表; InnoDB free: 3072 kB';

-- ----------------------------
-- Table structure for coursekeywords
-- ----------------------------
DROP TABLE IF EXISTS `coursekeywords`;
CREATE TABLE `coursekeywords` (
  `courseKeywordId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `keywordId` int(11) default NULL COMMENT '对应keywords表中的ID',
  `courseId` int(11) default NULL COMMENT '课程ID',
  `keyword` varchar(100) default '' COMMENT '关键字',
  PRIMARY KEY  (`courseKeywordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程关键词表';

-- ----------------------------
-- Table structure for coursemajor
-- ----------------------------
DROP TABLE IF EXISTS `coursemajor`;
CREATE TABLE `coursemajor` (
  `courseMajorId` int(11) NOT NULL auto_increment COMMENT '主键',
  `courseId` int(11) default NULL COMMENT '课程',
  `major` varchar(100) default NULL COMMENT '专业',
  `majorCode` varchar(20) default NULL,
  PRIMARY KEY  (`courseMajorId`)
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
  `category` varchar(20) default NULL COMMENT '课程类别',
  `isInner` tinyint(1) default '0' COMMENT '是否为内训课程',
  `price` double(10,0) unsigned zerofill default NULL,
  `content` mediumtext COMMENT '课程内容',
  `blockedContent` mediumtext COMMENT '屏蔽内容',
  `videoUrl` varchar(60) default NULL COMMENT '视频地址',
  `hits` int(11) unsigned zerofill default '00000000200' COMMENT '点击数',
  `createdBy` int(11) default NULL,
  `creationDate` date default NULL,
  `lastUpdatedBy` int(11) default NULL,
  `lastUpdateDate` date default NULL,
  `recommanded` tinyint(4) unsigned zerofill default '0000' COMMENT '是否推荐',
  `state` tinyint(1) default '0' COMMENT '审核标志（1为通过，0为未审核通过）',
  `classic` tinyint(1) unsigned zerofill default '0' COMMENT '是否经典',
  PRIMARY KEY  (`courseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程表';

-- ----------------------------
-- Table structure for coursetarget
-- ----------------------------
DROP TABLE IF EXISTS `coursetarget`;
CREATE TABLE `coursetarget` (
  `courseTargetTd` int(11) NOT NULL auto_increment COMMENT '主键id',
  `courseId` int(11) default NULL COMMENT '课程id',
  `target` varchar(100) default NULL COMMENT '培训对象(字典项)',
  `targetCode` varchar(20) default NULL,
  PRIMARY KEY  (`courseTargetTd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='培训课程对象表';

-- ----------------------------
-- Table structure for keywords
-- ----------------------------
DROP TABLE IF EXISTS `keywords`;
CREATE TABLE `keywords` (
  `keyId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `keyword` varchar(100) default NULL COMMENT '关键词',
  `flag` tinyint(1) default '0' COMMENT '是否有效',
  `type` int(11) default NULL COMMENT '关键词种类',
  `categoryId` int(11) default NULL COMMENT '种类ID',
  `batchNum` int(11) default NULL COMMENT '批次号',
  PRIMARY KEY  (`keyId`),
  UNIQUE KEY `UniqueKeywordName` (`keyword`)
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
-- Table structure for ranks
-- ----------------------------
DROP TABLE IF EXISTS `ranks`;
CREATE TABLE `ranks` (
  `rankOrder` int(11) default NULL,
  `rankId` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`rankId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `userId` int(11) default NULL COMMENT '用户名',
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
INSERT INTO `courseindustry` VALUES ('1', '10', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('2', '10', '008_01', '发电行业');
INSERT INTO `courseinfo` VALUES ('4', '4', '2013-07-09', '2013-07-01', '007_02');
INSERT INTO `courseinfo` VALUES ('5', '4', '2013-07-09', '2013-07-31', '007_01');
INSERT INTO `courseinfo` VALUES ('7', '4', '2013-07-24', '2013-07-04', '007_03');
INSERT INTO `courseinfo` VALUES ('8', '19', '2013-07-08', '2013-07-23', '007_03');
INSERT INTO `courseinfo` VALUES ('9', '20', '2013-07-16', '2013-07-25', '007_01');
INSERT INTO `courseinfo` VALUES ('10', '19', '2013-07-09', '2013-07-24', '007_02');
INSERT INTO `courseinfo` VALUES ('12', '18', '2013-07-02', '2013-08-02', '007_03');
INSERT INTO `courseinfo` VALUES ('13', '11', '2013-07-02', '2013-07-31', '007_03');
INSERT INTO `coursekeywords` VALUES ('1', '1', '10', '中华');
INSERT INTO `coursekeywords` VALUES ('2', '2', '10', '建设');
INSERT INTO `coursekeywords` VALUES ('3', '3', '10', '国家');
INSERT INTO `coursekeywords` VALUES ('49', '76', '1', '的');
INSERT INTO `coursekeywords` VALUES ('50', '77', '1', '进行');
INSERT INTO `coursekeywords` VALUES ('51', '78', '1', '怎样');
INSERT INTO `coursekeywords` VALUES ('52', '74', '1', '企业管理');
INSERT INTO `coursekeywords` VALUES ('53', '75', '1', '有效');
INSERT INTO `coursemajor` VALUES ('1', '10', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('2', '10', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('31', '1', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('32', '1', '软件工程', '009_02');
INSERT INTO `courses` VALUES ('1', '怎样有效的进行企业管理', 'ZYYX_001', '1', '003_01', null, '0000003453', null, null, null, null, null, null, null, null, '0001', '1', null);
INSERT INTO `courses` VALUES ('2', '哈哈哈', 'QQYUDO', '3', '003_03', null, null, '<p><span style=\"background-color:rgb(250, 250, 250); color:rgb(66, 48, 9); font-family:arial,helvetica,sans-serif; font-size:14px\">【看中国：世界最大单体建筑成都开业】英国卫报关注了6月28日开业的&quot;世界最大单体建筑&quot;-成都新世界环球中心。里面酒店、购物中心、电影院等设施一应俱全，还有人造海洋、海滩。卫报网友对这座建筑进行热议，有赞扬，有想去的，有怕挤的，还有觉得热闹的。观点就是如此纷繁。详见：</span><a href=\"http://t.cn/zQ2qL24\" style=\"text-decoration: none; color: rgb(108, 99, 81); font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(250, 250, 250);\" target=\"_blank\" title=\"http://news.sina.com.cn/w/gc/2013-07-10/2021159.shtml\">http://t.cn/zQ2qL24</a></p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('4', '哈哈哈sfdvgsd', 'QQYUDOs', '4', '003_01', null, null, '<p>saveCoursesfbhsdfhdhtrhvcsdgsdg</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('9', '爱我中华，建设我们的国家', 'grecgs', '4', '003_03', null, null, '<p>五十六个民族&nbsp; 五十六之花</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('10', '爱我中华，建设我们的国家是的方式的', '干涉fgs', '2', '003_03', null, '0000234234', '<p>内容不能为空哈&nbsp;&nbsp; 普通样式 字体&nbsp; 大小</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><em><strong>哈哈哈</strong></em></p>\r\n', null, null, null, null, null, null, null, null, '1', null);
INSERT INTO `courses` VALUES ('11', '耨和个哦我俄军哦我俄军', '改3gewrt', '2', '003_01', null, '0000003453', '<p>上电股份为各位</p>\r\n', null, null, null, null, null, null, null, null, '1', null);
INSERT INTO `courses` VALUES ('12', '刚我热管', '非郭德纲', '1', '003_03', null, null, '<p>丰盛的刚是</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('13', '能够i无任何刚', 'ngowerhg', '4', '003_03', null, null, '<p>个人工</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('14', 'i狗狗哦该', '干涉u币', '3', '003_03', null, null, '<p>结果欧冠哦好吧来接你</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('15', '哦你胡poker平', '刚你我和', '2', '003_03', null, '0000345345', '<p>哥和天然 差别差别呃呃</p>\r\n\r\n<p>v型风格<textarea name=\"撒的发刚\"></textarea></p>\r\n', null, null, null, null, null, null, null, null, '1', null);
INSERT INTO `courses` VALUES ('16', '刚认为该', '地方好', '3', '003_03', null, null, '<p>工程让他华瑞通 本才v不错</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('17', '哦你胡poker平', '十多个', '3', '003_03', null, null, '', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('18', '的呃呃地方改写成', '地方个', '1', '003_03', null, '0000000987', null, null, null, null, null, null, null, null, null, '1', null);
INSERT INTO `courses` VALUES ('19', '哦你胡poker平', '撒旦法', '2', '003_03', null, '0000000234', '<p>被呃xcvs gfsr gth dth j yj</p>\r\n', null, null, null, null, null, null, null, null, '1', null);
INSERT INTO `courses` VALUES ('20', '哈哈哈撒旦法', '地方好 通电后一', '4', '003_03', null, null, '<p>阿什顿飞</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('21', '被她法国湖人', 'oihj', '4', '003_01', null, null, '<p>而嘎登飞</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('22', '111', '1123', '4', '003_03', null, null, '<p>放顶顶顶顶顶顶顶顶顶顶</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('23', '4623425324', '2342354', '4', '003_03', null, null, '<p>撒旦法后天更好</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('24', '尔特让他', '\\(^o^)/~56 ', '3', '003_03', null, null, '<p>嘎登是</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('25', '如何4不6 345', '沃尔沃', '2', '003_03', null, null, '<p>方便太古汇ethernet让他好</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('26', '多个', '的人格234', '2', '003_03', null, null, '<p>而豆腐干</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('27', '不同意能否和', '撒旦法是的方式的 ', '4', '003_03', null, null, '<p>撒旦法</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('28', '风格化', '方解放军', '3', '003_03', null, null, '<p>高考回家</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('29', '你让他4673434', '是的467568465', '4', '003_03', null, null, '<p>的放噶 是个外人</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('30', '十多个人呃ethernet', '34545是梵蒂冈', '4', '003_01', null, null, '<p>阿什顿飞</p>\r\n', null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `courses` VALUES ('31', '', '', '', '', null, null, '', null, null, null, null, null, null, null, null, '1', null);
INSERT INTO `coursetarget` VALUES ('1', '10', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('2', '10', '财务人员', '010_02');
INSERT INTO `coursetarget` VALUES ('10', '1', '企业老总', '010_01');
INSERT INTO `keywords` VALUES ('1', '中华', '0', null, null, null);
INSERT INTO `keywords` VALUES ('2', '建设', '0', null, null, null);
INSERT INTO `keywords` VALUES ('3', '国家', '0', null, null, null);
INSERT INTO `keywords` VALUES ('74', '企业管理', null, null, null, null);
INSERT INTO `keywords` VALUES ('75', '有效', null, null, null, null);
INSERT INTO `keywords` VALUES ('76', '的', null, null, null, null);
INSERT INTO `keywords` VALUES ('77', '进行', null, null, null, null);
INSERT INTO `keywords` VALUES ('78', '怎样', null, null, null, null);
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
INSERT INTO `sys_dictionary` VALUES ('41', '998', '005', 'bak', null, null, null, null, '1', 'asdfsadgfgrwe');
INSERT INTO `sys_dictionary` VALUES ('42', '998', '007', '城市', null, null, null, null, '1', '开课城市之类的');
INSERT INTO `sys_dictionary` VALUES ('45', '007', '007_01', '广州', null, null, null, null, '1', '');
INSERT INTO `sys_dictionary` VALUES ('46', '007', '007_02', '深圳', null, null, null, null, '1', '');
INSERT INTO `sys_dictionary` VALUES ('47', '007', '007_03', '北京', null, null, null, null, '1', '');
INSERT INTO `sys_dictionary` VALUES ('48', '998', '008', '行业', null, null, null, null, '1', '行业字典类');
INSERT INTO `sys_dictionary` VALUES ('49', '998', '009', '专业', null, null, null, null, '1', '专业字典类');
INSERT INTO `sys_dictionary` VALUES ('50', '008', '008_01', '发电行业', null, null, null, null, '1', '发电行业');
INSERT INTO `sys_dictionary` VALUES ('51', '008', '008_02', '通信行业', null, null, null, null, '1', '通信行业');
INSERT INTO `sys_dictionary` VALUES ('52', '009', '009_01', '电子工程', null, null, null, null, '1', '电子工程');
INSERT INTO `sys_dictionary` VALUES ('53', '009', '009_02', '软件工程', null, null, null, null, '1', '软件工程');
INSERT INTO `sys_dictionary` VALUES ('54', '998', '010', '培训对象', null, null, null, null, '1', '哈哈哈');
INSERT INTO `sys_dictionary` VALUES ('55', '010', '010_01', '企业老总', null, null, null, null, '1', '企业老总');
INSERT INTO `sys_dictionary` VALUES ('56', '010', '010_02', '财务人员', null, null, null, null, '1', '财务人员');
INSERT INTO `teacher_info` VALUES ('1', '3', '邓卫华', '2013-06-20', '人力资源', '1000', '800', '8960', '13640713241', '13640713241', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '人力资源，内部培训等');
INSERT INTO `teacher_info` VALUES ('2', '13', '雷理超', '1988-12-06', '', '1000', '1000', '', '020-89608900', '', '123445', '123456');
INSERT INTO `teacher_info` VALUES ('3', null, '路人甲', '2013-06-20', '人力资源', '1231', '234234', '1234123', '13450461343', '13454335433', '税费改革', '个人');
INSERT INTO `teacher_info` VALUES ('4', null, '路人艺', '2013-06-20', '人力资源', '1231', '234234', '1234123', '13450461343', '13454335433', '税费改革', '个人');
INSERT INTO `teacher_info` VALUES ('5', null, '路人修行', '2013-06-20', '人力资源', '1231', '234234', '1234123', '13450461343', '13454335433', '税费改革', '个人');
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
