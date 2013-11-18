/*
MySQL Data Transfer
Source Host: localhost
Source Database: nbpx
Target Host: localhost
Target Database: nbpx
Date: 2013/11/18 22:59:12
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for answers
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `answerId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `answeredBy` varchar(11) default NULL COMMENT '回答用户ID',
  `answerdDate` date default NULL COMMENT '回答时间',
  `isBest` tinyint(1) default '0' COMMENT '是否最佳答案',
  `content` mediumtext COMMENT '回答内容',
  `questionId` int(11) default NULL COMMENT '对应问题',
  PRIMARY KEY  (`answerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='回答表';

-- ----------------------------
-- Table structure for applications
-- ----------------------------
DROP TABLE IF EXISTS `applications`;
CREATE TABLE `applications` (
  `applyId` int(11) NOT NULL auto_increment COMMENT '报名表主键ID',
  `applicant` int(11) default NULL COMMENT '申请人ID',
  `applicantCompany` varchar(20) default NULL COMMENT '申请企业名（如无单位可为空）',
  `applyCourseId` varchar(11) default NULL COMMENT '申请课程ID',
  `headCount` int(11) default '1' COMMENT '参加人数',
  `contact` varchar(20) default '' COMMENT '联系人',
  `cellphone` int(20) default NULL COMMENT '联系人移动电话',
  `telephone` int(20) default NULL COMMENT '座机',
  `email` varchar(20) default NULL,
  `fax` int(20) default NULL,
  `department` varchar(40) default NULL COMMENT '部门',
  `remarks` varchar(256) default NULL COMMENT '备注',
  `confirmed` tinyint(1) default NULL COMMENT '报名状态(是否已确认)',
  `stateInfo` varchar(200) default NULL COMMENT '跟进情况',
  `createDate` datetime default NULL,
  PRIMARY KEY  (`applyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程申请表';

-- ----------------------------
-- Table structure for articlekeywords
-- ----------------------------
DROP TABLE IF EXISTS `articlekeywords`;
CREATE TABLE `articlekeywords` (
  `articleKeywordId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `keywordId` int(11) default NULL COMMENT '对应keywords表中的ID',
  `articleId` int(11) default NULL COMMENT '文章ID',
  `keyword` varchar(100) default '' COMMENT '关键字',
  PRIMARY KEY  (`articleKeywordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章关键词表';

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `articleId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `articleTitle` varchar(40) default NULL COMMENT '标题',
  `content` mediumtext COMMENT '内容',
  `author` varchar(20) default NULL COMMENT '作者',
  `creationDate` datetime default NULL COMMENT '创建日期',
  `lastUpdateDate` datetime default NULL,
  `category` varchar(20) default NULL COMMENT '种类ID',
  `hits` int(11) default '200' COMMENT '点击量',
  `state` tinyint(1) default '0' COMMENT '审核状态',
  `recommanded` tinyint(1) default NULL COMMENT '推荐',
  PRIMARY KEY  (`articleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章; InnoDB free: 1050624 kB';

-- ----------------------------
-- Table structure for articlesubjects
-- ----------------------------
DROP TABLE IF EXISTS `articlesubjects`;
CREATE TABLE `articlesubjects` (
  `articleSubjectId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `articleId` int(11) default NULL COMMENT 'article表外键',
  `subjectId` varchar(20) default '' COMMENT '专题Id',
  `subject` varchar(50) default NULL COMMENT '专题',
  PRIMARY KEY  (`articleSubjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for courseproduct
-- ----------------------------
DROP TABLE IF EXISTS `courseproduct`;
CREATE TABLE `courseproduct` (
  `courseProductId` int(11) NOT NULL auto_increment COMMENT '主键',
  `courseId` int(11) default NULL COMMENT '课程',
  `product` varchar(100) default NULL COMMENT '产品',
  `productCode` varchar(20) default NULL COMMENT '产品字典编码',
  PRIMARY KEY  (`courseProductId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程产品表';

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `courseId` int(11) NOT NULL auto_increment COMMENT '课程表主键ID',
  `title` varchar(200) default NULL COMMENT '课程标题',
  `shortName` varchar(50) default NULL COMMENT '课程专题（别名）',
  `teacherId` varchar(11) default NULL,
  `category` varchar(20) default NULL COMMENT '课程类别',
  `isInner` tinyint(1) default '0' COMMENT '是否为内训课程',
  `price` double(10,0) unsigned zerofill default NULL,
  `content` mediumtext COMMENT '课程内容',
  `blockedContent` mediumtext COMMENT '屏蔽内容',
  `hasVideo` tinyint(1) default '0' COMMENT '视频地址',
  `hits` int(11) unsigned zerofill default '00000000200' COMMENT '点击数',
  `createdBy` int(11) default NULL,
  `creationDate` datetime default NULL,
  `lastUpdatedBy` int(11) default NULL,
  `lastUpdateDate` datetime default NULL,
  `recommanded` tinyint(1) unsigned zerofill default '0' COMMENT '是否推荐',
  `state` tinyint(1) default '0' COMMENT '审核标志（1为通过，0为未审核通过）',
  `classic` tinyint(1) unsigned zerofill default '0' COMMENT '是否经典',
  PRIMARY KEY  (`courseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程表';

-- ----------------------------
-- Table structure for coursesubjects
-- ----------------------------
DROP TABLE IF EXISTS `coursesubjects`;
CREATE TABLE `coursesubjects` (
  `courseSubjectId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `courseId` int(11) default NULL COMMENT 'course表外键',
  `subjectId` varchar(20) default '' COMMENT '专题Id',
  `subject` varchar(50) default NULL COMMENT '专题',
  PRIMARY KEY  (`courseSubjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for coursetarget
-- ----------------------------
DROP TABLE IF EXISTS `coursetarget`;
CREATE TABLE `coursetarget` (
  `courseTargetId` int(11) NOT NULL auto_increment COMMENT '主键id',
  `courseId` int(11) default NULL COMMENT '课程id',
  `target` varchar(100) default NULL COMMENT '培训对象(字典项)',
  `targetCode` varchar(20) default NULL,
  PRIMARY KEY  (`courseTargetId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='培训课程对象表';

-- ----------------------------
-- Table structure for downloads
-- ----------------------------
DROP TABLE IF EXISTS `downloads`;
CREATE TABLE `downloads` (
  `downloadId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `filepath` varchar(50) NOT NULL COMMENT '存放路径（直接带文件名）',
  `filetype` varchar(5) NOT NULL COMMENT '文件类型(ppt,word,pdf等)',
  `description` varchar(500) default NULL COMMENT '说明说明',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `uploadDate` datetime NOT NULL COMMENT '上传时间',
  `downloadCnt` int(11) NOT NULL default '200' COMMENT '下载次数',
  `hits` int(11) NOT NULL default '200' COMMENT '查看次数',
  PRIMARY KEY  (`downloadId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `itemid` varchar(20) default NULL,
  `productid` varchar(20) default NULL,
  `listprice` varchar(20) default NULL,
  `unitcost` varchar(20) default NULL,
  `attr1` varchar(20) default NULL,
  `status` tinyint(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for keywords
-- ----------------------------
DROP TABLE IF EXISTS `keywords`;
CREATE TABLE `keywords` (
  `keyId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `keyword` varchar(100) default NULL COMMENT '关键词',
  `flag` tinyint(1) default '0' COMMENT '是否有效(预留字段，暂时没用)',
  `type` int(11) default NULL COMMENT '关键词种类',
  `category` varchar(20) default NULL COMMENT '种类ID',
  `hits` int(20) default '500' COMMENT '点击量',
  `searchCnt` int(20) default '500' COMMENT '搜索次数',
  `recommanded` tinyint(1) default NULL COMMENT '是否推荐',
  `recommandDate` datetime default NULL COMMENT '推荐日期',
  `indexed` tinyint(1) default '0' COMMENT '是否已经在solr索引',
  PRIMARY KEY  (`keyId`),
  UNIQUE KEY `UniqueKeywordName` (`category`,`keyword`)
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
  `content` mediumtext COMMENT '内容',
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
  `startTime` date NOT NULL COMMENT '开始时间',
  `endTime` date NOT NULL COMMENT '结束时间',
  `city` varchar(20) collate utf8_bin NOT NULL default '' COMMENT '所在城市',
  `contact` varchar(20) collate utf8_bin NOT NULL default '' COMMENT '联系人',
  `telephone` int(18) default NULL,
  `cellphone` int(18) default NULL,
  `comp_name` varchar(30) collate utf8_bin NOT NULL COMMENT '所在公司',
  `description` tinytext collate utf8_bin NOT NULL COMMENT '求需描述',
  `reply` tinytext collate utf8_bin COMMENT '回复',
  `hasReplied` tinyint(1) unsigned NOT NULL default '0' COMMENT '回复标志',
  `createDate` datetime default NULL COMMENT '创建时间',
  `email` varchar(20) collate utf8_bin default NULL,
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
-- Table structure for subjects
-- ----------------------------
DROP TABLE IF EXISTS `subjects`;
CREATE TABLE `subjects` (
  `subjectId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `subject` varchar(100) default NULL COMMENT '专题',
  `flag` tinyint(1) default '0' COMMENT '是否有效(预留字段，暂时没用)',
  `type` int(11) default NULL COMMENT '专题种类',
  `category` varchar(20) default NULL COMMENT '种类ID',
  `hits` int(20) default '500' COMMENT '点击量',
  `searchCnt` int(20) default '500' COMMENT '搜索次数',
  `recommanded` tinyint(1) default NULL COMMENT '是否推荐',
  `recommandDate` datetime default NULL COMMENT '推荐日期',
  PRIMARY KEY  (`subjectId`),
  UNIQUE KEY `UniqueKeywordName` (`category`,`subject`)
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
INSERT INTO `answers` VALUES ('1', '1', '2013-11-18', null, 'I don\'t know man, you tell me单反的', '1');
INSERT INTO `answers` VALUES ('2', '2', '2013-11-12', null, 'oh good one  呵呵', '1');
INSERT INTO `answers` VALUES ('3', '雷理超', '2013-11-11', '0', '撒旦法个豆腐干的', '2');
INSERT INTO `answers` VALUES ('4', '沃尔', null, null, '炯强', null);
INSERT INTO `answers` VALUES ('5', '沃尔', null, null, '凤飞飞', null);
INSERT INTO `answers` VALUES ('6', '沃尔', null, null, '多少分', '1');
INSERT INTO `applications` VALUES ('1', '1', '科技公司', '10001', '123', '胡平凡', '1380013800', '85583222', '23@yd.com', '12342111', '开发部', '很多人要参加的', '1', '好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会', '2013-11-13 16:01:23');
INSERT INTO `articlekeywords` VALUES ('1', '258', null, '犯规');
INSERT INTO `articlekeywords` VALUES ('2', '256', null, '打手');
INSERT INTO `articlekeywords` VALUES ('3', '257', null, '个人');
INSERT INTO `articlekeywords` VALUES ('4', '259', null, '中国');
INSERT INTO `articlekeywords` VALUES ('5', '259', '4', '中国');
INSERT INTO `articlekeywords` VALUES ('6', '259', '3', '中国');
INSERT INTO `articlekeywords` VALUES ('7', '259', '2', '中国');
INSERT INTO `articlekeywords` VALUES ('8', '260', null, '印象');
INSERT INTO `articlekeywords` VALUES ('9', '261', null, '南京');
INSERT INTO `articlekeywords` VALUES ('10', '259', '5', '中国');
INSERT INTO `articlekeywords` VALUES ('11', '262', null, '关门');
INSERT INTO `articlekeywords` VALUES ('12', '263', null, '关键');
INSERT INTO `articlekeywords` VALUES ('13', '266', null, '政府');
INSERT INTO `articlekeywords` VALUES ('14', '264', null, '部门');
INSERT INTO `articlekeywords` VALUES ('15', '265', null, '美国联邦');
INSERT INTO `articlekeywords` VALUES ('16', '267', null, '试飞');
INSERT INTO `articlekeywords` VALUES ('17', '267', null, '试飞');
INSERT INTO `articlekeywords` VALUES ('18', '267', null, '试飞');
INSERT INTO `articlekeywords` VALUES ('19', '267', null, '试飞');
INSERT INTO `articlekeywords` VALUES ('27', '258', '10009', '犯规');
INSERT INTO `articlekeywords` VALUES ('28', '256', '10009', '打手');
INSERT INTO `articlekeywords` VALUES ('29', '257', '10009', '个人');
INSERT INTO `articlekeywords` VALUES ('65', '292', '10008', '石家庄');
INSERT INTO `articlekeywords` VALUES ('66', '293', '10008', '晴转多云');
INSERT INTO `articlekeywords` VALUES ('67', '294', '10008', '天气很好');
INSERT INTO `articlekeywords` VALUES ('112', '307', '10016', '天气预报');
INSERT INTO `articlekeywords` VALUES ('113', '306', '10016', '企业培训');
INSERT INTO `articlekeywords` VALUES ('114', '296', '10016', '如此');
INSERT INTO `articlekeywords` VALUES ('115', '297', '10016', '世界');
INSERT INTO `articlekeywords` VALUES ('116', '309', '10014', '提前完成');
INSERT INTO `articlekeywords` VALUES ('117', '308', '10014', '我要');
INSERT INTO `articlekeywords` VALUES ('140', '283', '10015', '测试');
INSERT INTO `articlekeywords` VALUES ('141', '282', '10015', '插入');
INSERT INTO `articlekeywords` VALUES ('142', '281', '10015', '文章');
INSERT INTO `articlekeywords` VALUES ('143', '270', '10011', '科比咯');
INSERT INTO `articlekeywords` VALUES ('144', '310', '10013', '还在');
INSERT INTO `articlekeywords` VALUES ('145', '270', '10013', '科比咯');
INSERT INTO `articlekeywords` VALUES ('146', '258', '10010', '犯规');
INSERT INTO `articlekeywords` VALUES ('147', '256', '10010', '打手');
INSERT INTO `articlekeywords` VALUES ('148', '257', '10010', '个人');
INSERT INTO `articles` VALUES ('10008', '石家庄晴转多云，天气很好', '<p><span style=\"background-color:rgb(255, 255, 255); color:rgb(0, 0, 0); font-family:georgia,times new roman,times,serif; font-size:15px\"><strong>10月8日，维克托・科瓦茨<a href=\"http://www.baidu.com\" target=\"_blank\">试飞</a>的最后一跃。当天下午，正在张家界参加第二届世界翼装飞行世锦赛的匈牙利选手维克托・科瓦茨在<a href=\"http://www.baidu.com\" target=\"_blank\">试飞</a>过程中不幸坠落悬崖，张家界当即dsf<br />\r\n<br />\r\n组织了近200名公安、武警、消防官兵等搜救人员进行全力搜救。经过近24个小时的连续搜救，于9日清晨8时57分，在峡谷中找到了维克多，并已确认遇难身亡。</strong></span><span style=\"background-color:rgb(255, 255, 255); color:rgb(0, 0, 0); font-family:georgia,times new roman,times,serif; font-size:15px\"> </span></p>\r\n', '普京', '2013-10-13 00:00:00', '2013-10-21 22:58:08', '003_02', '500', '1', '1');
INSERT INTO `articles` VALUES ('10009', '个人打手犯规的是', '<p>是个</p>\r\n', '奥巴马', '2013-10-13 00:00:00', '2013-10-13 00:00:00', '003_02', '500', '1', null);
INSERT INTO `articles` VALUES ('10010', '个人打手犯规的是没有', '<p>是个风格化I love to stay latefff</p>\r\n', '奥巴马', '2013-10-13 00:00:00', '2013-11-07 22:18:06', '003_02', '500', '1', null);
INSERT INTO `articles` VALUES ('10011', '科比布莱恩特', '<p>科比的狗还在等他传球首飞是sdfsdf</p>\r\n', 'Jim Buss', '2013-10-13 00:00:00', '2013-11-07 22:17:44', '003_01', '500', '1', null);
INSERT INTO `articles` VALUES ('10013', '科比布莱恩特的3', '<p>科比的狗<a href=\"http://www.baidu.com\" target=\"_blank\">还在</a>等他传球ffff</p>\r\n', 'Jim Buss', '2013-10-13 00:00:00', '2013-11-07 22:17:59', '003_01', '500', '1', null);
INSERT INTO `articles` VALUES ('10014', '我要提前完成', '<p>随笔&nbsp;&nbsp;</p>\r\n\r\n<p>自己写</p>\r\n', '雷理超', '2013-10-17 19:34:57', '2013-10-21 23:37:59', '003_01', '500', '1', null);
INSERT INTO `articles` VALUES ('10015', '文章插入测试1', '<p>演示 关键词<a href=\"http://www.baidu.com\" target=\"_blank\">插入</a>&nbsp;&nbsp;&nbsp; <a href=\"http://www.baidu.com\" target=\"_blank\">文章</a>&nbsp;&nbsp; 第一次<a href=\"http://www.baidu.com\" target=\"_blank\">测试</a></p>\r\n\r\n<p>heng?</p>\r\n', '雷理超', '2013-10-17 19:36:19', '2013-11-07 22:05:04', '003_01', '500', '1', null);
INSERT INTO `articles` VALUES ('10016', '这世界如此美妙，天气预报，企业培训', '<p><a href=\"http://www.baidu.com\" target=\"_blank\">文章</a>新建，<a href=\"http://www.baidu.com\" target=\"_blank\">测试</a>第二次，<a href=\"http://www.baidu.com\" target=\"_blank\">发布</a>资讯，<a href=\"http://www.baidu.com\" target=\"_blank\">手写</a>关键词</p>\r\n', '雷理超', '2013-10-17 19:44:01', '2013-10-21 23:28:13', '003_02', '500', '1', null);
INSERT INTO `articlesubjects` VALUES ('1', null, '34', '人');
INSERT INTO `articlesubjects` VALUES ('2', null, '35', '犯规');
INSERT INTO `articlesubjects` VALUES ('3', null, '34', '人');
INSERT INTO `articlesubjects` VALUES ('4', null, '35', '犯规');
INSERT INTO `articlesubjects` VALUES ('5', '4', '34', '人');
INSERT INTO `articlesubjects` VALUES ('6', '4', '35', '犯规');
INSERT INTO `articlesubjects` VALUES ('7', '3', '34', '人');
INSERT INTO `articlesubjects` VALUES ('8', '3', '35', '犯规');
INSERT INTO `articlesubjects` VALUES ('9', '2', '34', '人');
INSERT INTO `articlesubjects` VALUES ('10', '2', '35', '犯规');
INSERT INTO `articlesubjects` VALUES ('11', null, '36', '旅游什么的');
INSERT INTO `articlesubjects` VALUES ('12', '5', '37', '旅游什么的');
INSERT INTO `articlesubjects` VALUES ('13', null, '38', '资本主义垮台');
INSERT INTO `articlesubjects` VALUES ('14', null, '39', '意外');
INSERT INTO `articlesubjects` VALUES ('15', null, '39', '意外');
INSERT INTO `articlesubjects` VALUES ('16', null, '39', '意外');
INSERT INTO `articlesubjects` VALUES ('17', null, '39', '意外');
INSERT INTO `articlesubjects` VALUES ('26', '10009', '37', '旅游什么的');
INSERT INTO `articlesubjects` VALUES ('50', '10008', '34', '人');
INSERT INTO `articlesubjects` VALUES ('51', '10008', '35', '犯规');
INSERT INTO `articlesubjects` VALUES ('61', '10016', '45', '发布资讯');
INSERT INTO `articlesubjects` VALUES ('62', '10014', '43', '中文文章');
INSERT INTO `articlesubjects` VALUES ('77', '10015', '44', 'take1');
INSERT INTO `articlesubjects` VALUES ('78', '10011', '40', '是的');
INSERT INTO `articlesubjects` VALUES ('79', '10013', '40', '是的');
INSERT INTO `articlesubjects` VALUES ('80', '10013', '46', '还在');
INSERT INTO `articlesubjects` VALUES ('81', '10010', '37', '旅游什么的');
INSERT INTO `companyinfo` VALUES ('1', '1', '邓卫华', '科技公司', '8960111', '13640713241', '88218960', '开发部');
INSERT INTO `courseindustry` VALUES ('5', '1', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('6', '12', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('9', '10', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('10', '10', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('11', '9', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('12', '4', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('13', '33', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('14', '10002', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('19', '10034', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('20', '10034', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('43', '10001', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('44', '10001', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('51', '10009', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('56', '10035', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('57', '10026', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('72', '10036', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('73', '10036', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('82', '10010', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('89', '10018', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('90', '10018', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('91', '10033', '008_01', '发电行业');
INSERT INTO `courseinfo` VALUES ('9', '20', '2013-07-16', '2013-07-25', '007_01');
INSERT INTO `courseinfo` VALUES ('10', '33', '2013-07-02', '2013-07-10', '007_04');
INSERT INTO `courseinfo` VALUES ('11', '33', '2013-07-25', '2013-07-26', '007_01');
INSERT INTO `courseinfo` VALUES ('12', '18', '2013-07-10', '2013-07-19', '007_02');
INSERT INTO `courseinfo` VALUES ('13', '10010', '2013-08-05', '2013-08-06', '007_03');
INSERT INTO `courseinfo` VALUES ('16', '10019', '2013-07-30', '2013-08-21', '007_03');
INSERT INTO `courseinfo` VALUES ('17', '10019', '2013-07-30', '2013-08-21', '007_03');
INSERT INTO `courseinfo` VALUES ('19', '10025', '2013-08-06', '2013-08-23', '007_02');
INSERT INTO `courseinfo` VALUES ('22', '10017', '2013-08-06', '2013-08-22', '007_03');
INSERT INTO `courseinfo` VALUES ('25', '10016', '2013-08-01', '2013-08-09', '007_03');
INSERT INTO `courseinfo` VALUES ('27', '10013', '2013-08-01', '2013-08-22', '007_04');
INSERT INTO `courseinfo` VALUES ('30', '10034', '2013-08-07', '2013-08-15', '007_03');
INSERT INTO `courseinfo` VALUES ('31', '10034', '2013-08-07', '2013-08-22', '007_04');
INSERT INTO `courseinfo` VALUES ('32', '10014', '2013-08-06', '2013-08-23', '007_02');
INSERT INTO `courseinfo` VALUES ('35', '10001', '2013-08-06', '2013-08-06', '007_03');
INSERT INTO `courseinfo` VALUES ('36', '10001', '2013-07-31', '2013-08-07', '007_02');
INSERT INTO `courseinfo` VALUES ('37', '10018', '2013-08-29', '2013-09-05', '007_03');
INSERT INTO `courseinfo` VALUES ('38', '10018', '2013-09-07', '2013-09-07', '007_04');
INSERT INTO `courseinfo` VALUES ('39', '10018', '2013-08-28', '2013-08-30', '007_01');
INSERT INTO `courseinfo` VALUES ('40', '10035', '2013-09-05', '2013-08-30', '007_02');
INSERT INTO `courseinfo` VALUES ('41', '10035', '2013-09-05', '2013-09-07', '007_03');
INSERT INTO `courseinfo` VALUES ('42', '10018', '2013-09-25', '2013-10-03', '007_02');
INSERT INTO `courseinfo` VALUES ('43', '10036', '2013-09-06', '2013-09-07', '007_02');
INSERT INTO `coursekeywords` VALUES ('26', '79', '32', '');
INSERT INTO `coursekeywords` VALUES ('41', '77', '1', '进行');
INSERT INTO `coursekeywords` VALUES ('42', '78', '1', '怎样');
INSERT INTO `coursekeywords` VALUES ('43', '74', '1', '企业管理');
INSERT INTO `coursekeywords` VALUES ('44', '75', '1', '有效');
INSERT INTO `coursekeywords` VALUES ('45', '85', '12', '管理');
INSERT INTO `coursekeywords` VALUES ('46', '84', '12', '供应商');
INSERT INTO `coursekeywords` VALUES ('47', '81', '12', '采购');
INSERT INTO `coursekeywords` VALUES ('48', '80', '12', '评估');
INSERT INTO `coursekeywords` VALUES ('49', '83', '12', '优化');
INSERT INTO `coursekeywords` VALUES ('50', '82', '12', '流程');
INSERT INTO `coursekeywords` VALUES ('51', '87', '18', '抱怨');
INSERT INTO `coursekeywords` VALUES ('52', '86', '18', '客户');
INSERT INTO `coursekeywords` VALUES ('53', '93', '18', '技巧');
INSERT INTO `coursekeywords` VALUES ('54', '92', '18', '服务');
INSERT INTO `coursekeywords` VALUES ('55', '89', '18', '投诉');
INSERT INTO `coursekeywords` VALUES ('56', '88', '18', '处理');
INSERT INTO `coursekeywords` VALUES ('57', '91', '18', '优质');
INSERT INTO `coursekeywords` VALUES ('58', '90', '18', '提升');
INSERT INTO `coursekeywords` VALUES ('64', '98', '10', '最新');
INSERT INTO `coursekeywords` VALUES ('65', '96', '10', '企业');
INSERT INTO `coursekeywords` VALUES ('66', '97', '10', '筹划');
INSERT INTO `coursekeywords` VALUES ('67', '95', '10', '纳税');
INSERT INTO `coursekeywords` VALUES ('68', '94', '10', '税收优惠政策');
INSERT INTO `coursekeywords` VALUES ('83', '96', '19', '企业');
INSERT INTO `coursekeywords` VALUES ('84', '97', '19', '筹划');
INSERT INTO `coursekeywords` VALUES ('85', '92', '19', '服务');
INSERT INTO `coursekeywords` VALUES ('86', '108', '19', '销售');
INSERT INTO `coursekeywords` VALUES ('87', '109', '19', '活动');
INSERT INTO `coursekeywords` VALUES ('88', '107', '19', '税务');
INSERT INTO `coursekeywords` VALUES ('115', '119', '31', '实施');
INSERT INTO `coursekeywords` VALUES ('116', '118', '31', '健康');
INSERT INTO `coursekeywords` VALUES ('117', '96', '31', '企业');
INSERT INTO `coursekeywords` VALUES ('118', '107', '31', '税务');
INSERT INTO `coursekeywords` VALUES ('119', '121', '31', '方法');
INSERT INTO `coursekeywords` VALUES ('120', '120', '31', '检查');
INSERT INTO `coursekeywords` VALUES ('121', '105', '31', '与');
INSERT INTO `coursekeywords` VALUES ('127', '1', '9', '中华');
INSERT INTO `coursekeywords` VALUES ('128', '2', '9', '建设');
INSERT INTO `coursekeywords` VALUES ('129', '3', '9', '国家');
INSERT INTO `coursekeywords` VALUES ('130', '123', '9', '我们');
INSERT INTO `coursekeywords` VALUES ('131', '122', '9', '爱');
INSERT INTO `coursekeywords` VALUES ('146', '125', '28', '化');
INSERT INTO `coursekeywords` VALUES ('147', '124', '28', '风格');
INSERT INTO `coursekeywords` VALUES ('148', '127', '4', 'sfdvgsd');
INSERT INTO `coursekeywords` VALUES ('149', '128', '4', '哈');
INSERT INTO `coursekeywords` VALUES ('150', '126', '4', '哈哈');
INSERT INTO `coursekeywords` VALUES ('170', '102', '11', '制度');
INSERT INTO `coursekeywords` VALUES ('171', '103', '11', '内部');
INSERT INTO `coursekeywords` VALUES ('172', '100', '11', '控制');
INSERT INTO `coursekeywords` VALUES ('173', '101', '11', '如何');
INSERT INTO `coursekeywords` VALUES ('174', '99', '11', '建立');
INSERT INTO `coursekeywords` VALUES ('175', '75', '11', '有效');
INSERT INTO `coursekeywords` VALUES ('195', '119', '2', '实施');
INSERT INTO `coursekeywords` VALUES ('196', '118', '2', '健康');
INSERT INTO `coursekeywords` VALUES ('197', '96', '2', '企业');
INSERT INTO `coursekeywords` VALUES ('198', '129', '2', '环境');
INSERT INTO `coursekeywords` VALUES ('199', '107', '2', '税务');
INSERT INTO `coursekeywords` VALUES ('200', '121', '2', '方法');
INSERT INTO `coursekeywords` VALUES ('201', '120', '2', '检查');
INSERT INTO `coursekeywords` VALUES ('202', '131', '33', '高效');
INSERT INTO `coursekeywords` VALUES ('203', '130', '33', '领导力');
INSERT INTO `coursekeywords` VALUES ('204', '85', '25', '管理');
INSERT INTO `coursekeywords` VALUES ('205', '113', '25', '经济');
INSERT INTO `coursekeywords` VALUES ('206', '112', '25', '财税');
INSERT INTO `coursekeywords` VALUES ('207', '110', '25', '风险');
INSERT INTO `coursekeywords` VALUES ('208', '111', '25', '合同');
INSERT INTO `coursekeywords` VALUES ('209', '96', '15', '企业');
INSERT INTO `coursekeywords` VALUES ('210', '93', '15', '技巧');
INSERT INTO `coursekeywords` VALUES ('211', '106', '15', '机关');
INSERT INTO `coursekeywords` VALUES ('212', '107', '15', '税务');
INSERT INTO `coursekeywords` VALUES ('213', '104', '15', '打交道');
INSERT INTO `coursekeywords` VALUES ('214', '85', '26', '管理');
INSERT INTO `coursekeywords` VALUES ('215', '117', '26', '企业所得税');
INSERT INTO `coursekeywords` VALUES ('216', '116', '26', '税前');
INSERT INTO `coursekeywords` VALUES ('217', '98', '26', '最新');
INSERT INTO `coursekeywords` VALUES ('218', '114', '26', '扣除');
INSERT INTO `coursekeywords` VALUES ('219', '119', '10002', '实施');
INSERT INTO `coursekeywords` VALUES ('220', '118', '10002', '健康');
INSERT INTO `coursekeywords` VALUES ('221', '107', '10002', '税务');
INSERT INTO `coursekeywords` VALUES ('222', '192', '10002', '企业');
INSERT INTO `coursekeywords` VALUES ('223', '121', '10002', '方法');
INSERT INTO `coursekeywords` VALUES ('224', '120', '10002', '检查');
INSERT INTO `coursekeywords` VALUES ('269', '201', '10019', '筹划');
INSERT INTO `coursekeywords` VALUES ('270', '199', '10019', '服务');
INSERT INTO `coursekeywords` VALUES ('271', '108', '10019', '销售');
INSERT INTO `coursekeywords` VALUES ('272', '109', '10019', '活动');
INSERT INTO `coursekeywords` VALUES ('273', '107', '10019', '税务');
INSERT INTO `coursekeywords` VALUES ('274', '192', '10019', '企业');
INSERT INTO `coursekeywords` VALUES ('304', '207', '10014', '管理');
INSERT INTO `coursekeywords` VALUES ('305', '216', '10014', '技能');
INSERT INTO `coursekeywords` VALUES ('306', '197', '10014', '提升');
INSERT INTO `coursekeywords` VALUES ('307', '213', '10014', '干部');
INSERT INTO `coursekeywords` VALUES ('308', '214', '10014', '综合');
INSERT INTO `coursekeywords` VALUES ('309', '215', '10014', '部门经理');
INSERT INTO `coursekeywords` VALUES ('374', '212', '10034', '高绩效');
INSERT INTO `coursekeywords` VALUES ('375', '208', '10034', '领导');
INSERT INTO `coursekeywords` VALUES ('376', '209', '10034', '构建');
INSERT INTO `coursekeywords` VALUES ('377', '210', '10034', '卓越');
INSERT INTO `coursekeywords` VALUES ('378', '211', '10034', '团队');
INSERT INTO `coursekeywords` VALUES ('443', '207', '10025', '管理');
INSERT INTO `coursekeywords` VALUES ('444', '113', '10025', '经济');
INSERT INTO `coursekeywords` VALUES ('445', '112', '10025', '财税');
INSERT INTO `coursekeywords` VALUES ('446', '110', '10025', '风险');
INSERT INTO `coursekeywords` VALUES ('447', '111', '10025', '合同');
INSERT INTO `coursekeywords` VALUES ('520', '220', '10001', '即使');
INSERT INTO `coursekeywords` VALUES ('521', '217', '10001', '如果');
INSERT INTO `coursekeywords` VALUES ('522', '218', '10001', '那么');
INSERT INTO `coursekeywords` VALUES ('523', '219', '10001', '及时');
INSERT INTO `coursekeywords` VALUES ('524', '77', '10001', '进行');
INSERT INTO `coursekeywords` VALUES ('555', '235', '10009', '中华');
INSERT INTO `coursekeywords` VALUES ('556', '234', '10009', '建设');
INSERT INTO `coursekeywords` VALUES ('557', '233', '10009', '国家');
INSERT INTO `coursekeywords` VALUES ('558', '123', '10009', '我们');
INSERT INTO `coursekeywords` VALUES ('581', '85', '10035', '管理');
INSERT INTO `coursekeywords` VALUES ('582', '244', '10035', '深圳');
INSERT INTO `coursekeywords` VALUES ('583', '245', '10035', '电子');
INSERT INTO `coursekeywords` VALUES ('584', '242', '10035', '标杆');
INSERT INTO `coursekeywords` VALUES ('585', '243', '10035', '创新');
INSERT INTO `coursekeywords` VALUES ('586', '240', '10035', '之旅');
INSERT INTO `coursekeywords` VALUES ('587', '241', '10035', '学习');
INSERT INTO `coursekeywords` VALUES ('593', '239', '10026', '最新');
INSERT INTO `coursekeywords` VALUES ('594', '117', '10026', '企业所得税');
INSERT INTO `coursekeywords` VALUES ('595', '207', '10026', '管理');
INSERT INTO `coursekeywords` VALUES ('596', '116', '10026', '税前');
INSERT INTO `coursekeywords` VALUES ('597', '114', '10026', '扣除');
INSERT INTO `coursekeywords` VALUES ('598', '246', '10026', '办法');
INSERT INTO `coursekeywords` VALUES ('652', '252', '10036', '100');
INSERT INTO `coursekeywords` VALUES ('653', '250', '10036', '性能');
INSERT INTO `coursekeywords` VALUES ('654', '251', '10036', '一行');
INSERT INTO `coursekeywords` VALUES ('655', '248', '10036', '修改');
INSERT INTO `coursekeywords` VALUES ('656', '249', '10036', '代码');
INSERT INTO `coursekeywords` VALUES ('657', '247', '10036', 'sql');
INSERT INTO `coursekeywords` VALUES ('658', '90', '10036', '提升');
INSERT INTO `coursekeywords` VALUES ('671', '96', '10031', '企业');
INSERT INTO `coursekeywords` VALUES ('672', '232', '10031', '税务');
INSERT INTO `coursekeywords` VALUES ('673', '231', '10031', '方法');
INSERT INTO `coursekeywords` VALUES ('674', '230', '10031', '检查');
INSERT INTO `coursekeywords` VALUES ('675', '229', '10031', '实施');
INSERT INTO `coursekeywords` VALUES ('676', '228', '10031', '健康');
INSERT INTO `coursekeywords` VALUES ('716', '239', '10010', '最新');
INSERT INTO `coursekeywords` VALUES ('717', '238', '10010', '及其');
INSERT INTO `coursekeywords` VALUES ('718', '237', '10010', '税收优惠政策');
INSERT INTO `coursekeywords` VALUES ('719', '236', '10010', '纳税');
INSERT INTO `coursekeywords` VALUES ('720', '201', '10010', '筹划');
INSERT INTO `coursekeywords` VALUES ('721', '192', '10010', '企业');
INSERT INTO `coursekeywords` VALUES ('722', '124', '10028', '风格');
INSERT INTO `coursekeywords` VALUES ('723', '223', '10004', '哈哈');
INSERT INTO `coursekeywords` VALUES ('724', '224', '10004', '什么');
INSERT INTO `coursekeywords` VALUES ('751', '205', '10012', '优化');
INSERT INTO `coursekeywords` VALUES ('752', '204', '10012', '供应商');
INSERT INTO `coursekeywords` VALUES ('753', '207', '10012', '管理');
INSERT INTO `coursekeywords` VALUES ('754', '206', '10012', '流程');
INSERT INTO `coursekeywords` VALUES ('755', '203', '10012', '采购');
INSERT INTO `coursekeywords` VALUES ('756', '202', '10012', '评估');
INSERT INTO `coursekeywords` VALUES ('757', '200', '10018', '技巧');
INSERT INTO `coursekeywords` VALUES ('758', '197', '10018', '提升');
INSERT INTO `coursekeywords` VALUES ('759', '196', '10018', '投诉');
INSERT INTO `coursekeywords` VALUES ('760', '199', '10018', '服务');
INSERT INTO `coursekeywords` VALUES ('761', '198', '10018', '优质');
INSERT INTO `coursekeywords` VALUES ('762', '193', '10018', '客户');
INSERT INTO `coursekeywords` VALUES ('763', '195', '10018', '处理');
INSERT INTO `coursekeywords` VALUES ('764', '194', '10018', '抱怨');
INSERT INTO `coursekeywords` VALUES ('765', '221', '10033', '领导力');
INSERT INTO `coursekeywords` VALUES ('766', '222', '10033', '高效');
INSERT INTO `coursemajor` VALUES ('15', '1', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('16', '1', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('17', '12', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('20', '10', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('21', '10', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('22', '9', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('23', '9', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('24', '4', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('25', '33', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('26', '10002', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('31', '10019', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('36', '10014', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('37', '10014', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('40', '10034', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('41', '10034', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('61', '10001', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('67', '10009', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('68', '10009', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('71', '10035', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('72', '10026', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('80', '10036', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('85', '10031', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('86', '10031', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('93', '10010', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('100', '10012', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('101', '10012', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('102', '10018', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('103', '10033', '电子工程', '009_01');
INSERT INTO `courseproduct` VALUES ('23', '10001', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('24', '10001', '日用品', '011_02');
INSERT INTO `courseproduct` VALUES ('29', '10009', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('32', '10035', '日用品', '011_02');
INSERT INTO `courseproduct` VALUES ('35', '10026', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('36', '10026', '日用品', '011_02');
INSERT INTO `courseproduct` VALUES ('44', '10036', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('47', '10031', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('52', '10010', '日用品', '011_02');
INSERT INTO `courseproduct` VALUES ('55', '10018', '软件产品', '011_01');
INSERT INTO `courses` VALUES ('10001', '怎样有效的进行企业管理', '怎样有效的', '2', '003_01', '1', '0000005000', '<p style=\"text-align:left\"><a name=\"N1006B\"><strong>简介</strong></a></p>\r\n\r\n<p style=\"text-align:left\"><a href=\"http://www.baidu.com\">如果</a>您听说过 <a href=\"http://www.baidu.com\">Node</a>，或者阅读过一些文章，宣称 Node 是多么多么的棒，<a href=\"http://www.baidu.com\">那么</a>您可能会想：&ldquo;Node 究竟是什么东西？&rdquo; 即便是在参阅 Node 的主页之后，您甚至可能<em>还是</em> 不明白 Node 为何物？Node 肯定不适合每个程序员，但它可能是某些程序员一直苦苦追寻的东西。</p>\r\n\r\n<p style=\"text-align:left\">为 试图解释什么是 Node.js，本文将简要介绍一些背景信息：它要解决的问题，它如何工作，如何运行一个简单应用程序，最后，Node 在什么情况下是一个好的解决方案。本文不涉及如何编写一个复杂的 Node 应用程序，也不是一份全面的 Node 教程。阅读本文应该有助于您决定是否应该继续学习 Node，以便将其用于您的业务。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1007B\"><strong>Node 旨在解决什么问题？</strong></a></p>\r\n\r\n<p style=\"text-align:left\">Node 公开宣称的目标是 &ldquo;旨在提供一种简单的构建可伸缩网络程序的方法&rdquo;。当前的服务器程序有什么问题？我们来做个数学题。在 Java&trade; 和 PHP 这类语言中，每个连接都会生成一个新线程，每个新线程可能需要 2 MB 的配套内存。在一个拥有 8 GB RAM 的系统上，理论上最大的并发连接数量是 4,000 个用户。随着您的客户群的增长，<a href=\"http://www.baidu.com\">如果</a>希望您的 Web 应用程序支持更多用户，<a href=\"http://www.baidu.com\">那么</a>，您必须添加更多服务器。当然，这会增加服务器成本、流量成本和人工成本等成本。除这些成本上升外，还有一个潜在技术问题，即 用户可能针对每个请求使用不同的服务器，因此，任何共享资源都必须在所有服务器之间共享。鉴于上述所有原因，整个 Web 应用程序架构（包括流量、处理器速度和内存速度）中的瓶颈是：服务器能够处理的并发连接的最大数量。<img alt=\"\" src=\"http://www.baidu.com/img/bdlogo.gif\" /></p>\r\n\r\n<p style=\"text-align:left\">Node 解决这个问题的方法是：更改连接到服务器的方式。每个连接发射一个在 Node 引擎的进程中运行的事件，而不是为每个连接生成一个新的 OS 线程（并为其分配一些配套内存）。Node 声称它绝不会死锁，因为它根本不允许使用锁，它不会直接阻塞 I/O 调用。Node 还宣称，运行它的服务器能支持数万个并发连接。</p>\r\n\r\n<p style=\"text-align:left\">现在您有了一个能处理数万个并发连接的程 序，<a href=\"http://www.baidu.com\">那么</a>您能通过 Node 实际构建什么呢？<a href=\"http://www.baidu.com\">如果</a>您有一个 Web 应用程序需要处理这么多连接，那将是一件很 &ldquo;恐怖&rdquo; 的事！那是一种 &ldquo;<a href=\"http://www.baidu.com\">如果</a>您有这个问题，<a href=\"http://www.baidu.com\">那么</a>它根本不是问题&rdquo; 的问题。在回答上面的问题之前，我们先看看 Node 的工作原理以及它的设计运行方式。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1008D\"><strong>Node 肯定不是什么？</strong></a></p>\r\n\r\n<p style=\"text-align:left\">没错，Node 是一个服务器程序。但是，基础 Node 产品肯定<em>不</em> 像 Apache 或 Tomcat。本质上，那些服务器 &ldquo;安装就绪型&rdquo; 服 务器产品，支持立即部署应用程序。通过这些产品，您可以在一分钟内启动并运行一个服务器。Node 肯定不是这种产品。Apache 能通过添加一个 PHP 模块来允许开发人员创建动态 Web 页，添加一个 SSL 模块来实现安全连接，与此类似，Node 也有模块概念，允许向 Node 内核添加模块。实际上，可供选择的用于 Node 的模块有数百个之多，社区在创建、发布和更新模块方面非常活跃，一天甚至可以处理数十个模块。本文后面将讨论 Node 的整个模块部分。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1009A\"><strong>Node 如何工作？</strong></a></p>\r\n\r\n<p style=\"text-align:left\">Node 本身运行 V8 JavaScript。等等，服务器上的 JavaScript？没错，您没有看错。对于只在客户机上使用 JavaScript 的程序员而言，服务器端 JavaScript 可能是一个新概念，但这个概念本身并非遥不可及，因此为何不能在服务器上使用客户机上使用的编程语言？</p>\r\n\r\n<p style=\"text-align:left\">什 么是 V8？V8 JavaScript 引擎是 Google 用于其 Chrome 浏览器的底层 JavaScript 引擎。很少有人考虑 JavaScript 在客户机上实际做了些什么？实际上，JavaScript 引擎负责解释并执行代码。Google 使用 V8 创建了一个用 C++ 编写的超快解释器，该解释器拥有另一个独特特征；您可以下载该引擎并将其嵌入<em>任何</em> 应用程序。V8 JavaScript 引擎并不仅限于在一个浏览器中运行。因此，Node 实际上会使用 Google 编写的 V8 JavaScript 引擎，并将其重建为可在服务器上使用。太完美了！既然已经有一个不错的解决方案可用，为何还要创建一种新语言呢？</p>\r\n\r\n<p style=\"text-align:left\">&nbsp;</p>\r\n\r\n<p style=\"text-align:left\"><object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0\" height=\"200\" hspace=\"10\" vspace=\"10\" width=\"300\"><param name=\"quality\" value=\"high\" /><param name=\"movie\" value=\"http://player.youku.com/player.php/Type/Folder/Fid/19577274/Ob/1/sid/XNTk2ODg3OTY0/v.swf\" /><embed height=\"200\" hspace=\"10\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" quality=\"high\" src=\"http://player.youku.com/player.php/Type/Folder/Fid/19577274/Ob/1/sid/XNTk2ODg3OTY0/v.swf\" type=\"application/x-shockwave-flash\" vspace=\"10\" width=\"300\"></embed></object></p>\r\n', null, '1', '00000000206', null, '2013-07-24 00:00:00', null, '2013-08-18 00:06:05', '1', '1', '1');
INSERT INTO `courses` VALUES ('10002', '企业税务健康检查方法与实施', '企业税务健', '3', '003_02', null, '0000005000', '<p><span style=\"background-color:rgb(250, 250, 250); color:rgb(66, 48, 9); font-family:arial,helvetica,sans-serif; font-size:14px\">【看中国：世界最大单体建筑成都开业】英国卫报关注了6月28日开业的&quot;世界最大单体建筑&quot;-成都新世界环球中心。里面酒店、购物中心、电影院等设施一应俱全，还有人造海洋、海滩。卫报网友对这座建筑进行热议，有赞扬，有想去的，有怕挤的，还有觉得热闹的。观点就是如此纷繁。详见：</span><a href=\"http://t.cn/zQ2qL24\" style=\"text-decoration: none; color: rgb(108, 99, 81); font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(250, 250, 250);\" target=\"_blank\" title=\"http://news.sina.com.cn/w/gc/2013-07-10/2021159.shtml\">http://t.cn/zQ2qL24</a></p>\r\n', null, null, '00000000202', null, '2013-07-24 00:00:00', null, '2013-08-01 23:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10004', '哈哈哈sfdvgsd', '哈哈哈sf', '3', '003_01', '1', '0000005000', '<p>saveCoursesfbhsdfhdhtrhvcsdgsdg</p>\r\n', null, null, '00000000203', null, '2013-07-24 00:00:00', null, '2013-10-13 21:57:41', '1', '1', '1');
INSERT INTO `courses` VALUES ('10009', '爱我中华，建设我们的国家', '爱我中华，', '4', '003_02', null, '0000005000', '<p>五十六个民族&nbsp; 五十六之花</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-08-18 16:21:36', '1', '1', '1');
INSERT INTO `courses` VALUES ('10010', '最新企业税收优惠政策及其纳税筹划', '最新企业税', '2', '003_02', null, '0000050002', '<div class=\"content\"><strong>培训收益</strong><br />\r\n充分有效利用<a href=\"http://www.baidu.com\">税收优惠政策</a>是降低<a href=\"http://www.baidu.com\">企业</a>税务成本的基本方法之一。<a href=\"http://www.baidu.com\">企业</a>在运用<a href=\"http://www.baidu.com\">税收优惠政策</a>中常见的误区包括：自2008年新<a href=\"http://www.baidu.com\">企业</a>所得法出台、2009年增值税、营业税条例修订以来，<a href=\"http://www.baidu.com\">税收优惠政策</a>大幅调整，对新政策比较陌生；只关注大的优惠政策，忽略小的优惠政策；缺乏针对享受优惠政策的有效税收<a href=\"http://www.baidu.com\">筹划</a>手段；申请税收优惠常常受阻于程序和资料的准备。&nbsp;&nbsp;&nbsp;<br />\r\n本培训课程总结归纳各项现行有效<a href=\"http://www.baidu.com\">税收优惠政策</a>，以及享受这些优惠政策的配套<a href=\"http://www.baidu.com\">筹划</a>手段，并分析了<a href=\"http://www.baidu.com\">企业</a>利用<a href=\"http://www.baidu.com\">税收优惠政策</a>失败原因<a href=\"http://www.baidu.com\">及其</a>改进方法。<br />\r\n&nbsp;<br />\r\n<strong>培训提纲</strong>\r\n<ul>\r\n	<li><strong>我国实施税收优惠的常见方式</strong></li>\r\n</ul>\r\n加速折旧、直接减免、先征后退、先征后返、即征即退、减计收入、减免所得、减按税率等举例介绍。\r\n\r\n<ul>\r\n	<li><strong>运用<a href=\"http://www.baidu.com\">税收优惠政策</a>的税务<a href=\"http://www.baidu.com\">筹划</a>技巧</strong></li>\r\n	<li>事前享受优惠规划</li>\r\n	<li>事中合理享受规划</li>\r\n	<li>事后补救享受规划</li>\r\n	<li>放弃优惠享受规划\r\n	<ul>\r\n		<li><strong>增值税<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>进项税额优惠<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li><a href=\"http://www.baidu.com\">纳税</a>时点延后<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>增营结合利用<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>销售已使用固定资产合理<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>资产重组优惠<a href=\"http://www.baidu.com\">筹划</a>\r\n	<ul>\r\n		<li><strong>营业税<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>特殊混合销售行为<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>分别核算<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li><a href=\"http://www.baidu.com\">纳税</a>主体分割<a href=\"http://www.baidu.com\">筹划</a>\r\n	<ul>\r\n		<li><strong><a href=\"http://www.baidu.com\">企业</a>所得税<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>小型微利<a href=\"http://www.baidu.com\">企业</a>税收优惠</li>\r\n	<li>非居民<a href=\"http://www.baidu.com\">企业</a>税收优惠</li>\r\n	<li>高新技术<a href=\"http://www.baidu.com\">企业</a>税收优惠</li>\r\n	<li>研发费、残疾人工资加计扣除优惠</li>\r\n	<li>创投<a href=\"http://www.baidu.com\">企业</a>税收优惠</li>\r\n	<li>四项免税收入税收优惠</li>\r\n	<li>不征税收入税收优惠</li>\r\n	<li>应计未计应扣未扣多交税处理</li>\r\n	<li>过渡期税收优惠</li>\r\n	<li>债务重组税收优惠</li>\r\n	<li>资本交易税收优惠\r\n	<ul>\r\n		<li><strong>个人所得税<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>工资薪金合理<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>保险与补充保险合理<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>利股红合理<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>其他税目合理<a href=\"http://www.baidu.com\">筹划</a>\r\n	<ul>\r\n		<li><strong>小税种<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>房产税城镇土地使用税优惠</li>\r\n	<li>契税印花税优惠\r\n	<ul>\r\n		<li><strong><a href=\"http://www.baidu.com\">企业</a>税收优惠的征管程序规定</strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>备案制优惠管理</li>\r\n	<li>审批制优惠管理</li>\r\n	<li>非居民优惠管理\r\n	<ul>\r\n		<li><strong><a href=\"http://www.baidu.com\">企业</a>享受税收优惠失败案例分析</strong></li>\r\n	</ul>\r\n	</li>\r\n</ul>\r\n&nbsp;<br />\r\n<strong>主讲嘉宾：王老师</strong><br />\r\n理道授权<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/index.php\" target=\"_blank\">讲师</a>，国家税务总局网站答疑专家，现供职于江苏地税稽查局，近20年税务管理经验，业务熟练、理解独到，授课以实战为主攻，以实用为目标，以实惠为理念，以实效为境界。<br />\r\n&nbsp;<br />\r\n<strong>培训形式</strong>：讲授与学员参与多种形式相结合，案例分析和情景模拟相结合</div>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-10-13 21:50:07', '1', '1', '1');
INSERT INTO `courses` VALUES ('10011', '如何建立有效的内部控制制度', '如何建立有', '2', '003_01', '1', '0000005000', '<p>我给大家讲一下<a href=\"http://www.baidu.com\">如何</a><a href=\"http://www.baidu.com\">建立</a><a href=\"http://www.baidu.com\">有效</a>的<a href=\"http://www.baidu.com\">内部</a><a href=\"http://www.baidu.com\">控制</a><a href=\"http://www.baidu.com\">制度</a></p>\r\n\r\n<p>blablabla</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-08-17 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10012', '采购流程优化及供应商评估与管理 ', '采购流程优', '2', '003_02', null, '0000005000', '<p>丰盛的刚是</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-10-13 22:15:18', '1', '1', '1');
INSERT INTO `courses` VALUES ('10013', '能够i无任何刚', '能够i无任', '4', '003_02', null, '0000005000', '<p>个人工</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:34:23', '1', '1', '1');
INSERT INTO `courses` VALUES ('10014', '部门经理、管理干部综合管理技能提升 ', 'i狗狗哦该', '3', '003_02', null, '0000005000', '<p>结果欧冠哦好吧来接你</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-08-05 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10015', '企业与税务机关打交道的技巧', '企业与税务', '2', '003_02', '1', '0000005000', '<p>哥和天然 差别差别呃呃</p>\r\n\r\n<p>v型风格</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-08-17 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10016', '刚认为该', '刚认为该', '3', '003_02', null, '0000005000', '<p>工程让他华瑞通 本才v不错</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10017', '哦你胡poker平', '哦你胡po', '3', '003_02', null, '0000005000', '', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10018', '优质客户服务与客户投诉、抱怨处理技巧提升', '优质客户服', '1', '003_02', null, '0000008000', '<p><strong>培训收益</strong><br />\r\n很多财务人员都会犯愁：我的专业水平很好，可我写的财务报告怎么总是觉得不尽人意呢？报告演示的时候总是别别扭扭！本课程专门针对财务人员开发，特邀经验丰富的财务管理<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/index.php\" target=\"_blank\">讲师</a>，传授如何<a href=\"http://www.baidu.com\">提升</a>财务报告演示的技能。已经参训学员的评价：大开眼界！！！！<br />\r\n<br />\r\n<strong>培训提纲</strong><br />\r\n一、威力简报<br />\r\n&nbsp;</p>\r\n\r\n<ul>\r\n	<li>简报的问题所在</li>\r\n	<li>说服：从（起点）通往（终点）之路</li>\r\n	<li>豁然开朗</li>\r\n	<li>找错对象的危机</li>\r\n</ul>\r\n\r\n<p>&nbsp;<br />\r\n二、要有创意：脑力激荡的艺术</p>\r\n\r\n<ul>\r\n	<li>做好脑力激荡管理：架构表</li>\r\n	<li>脑力激荡：让垃圾资料开花结果</li>\r\n	<li>先专注，再流畅</li>\r\n	<li>结构</li>\r\n	<li>该选哪招（结构流）</li>\r\n	<li>选择结构流的价值</li>\r\n	<li>四个关键性问题</li>\r\n</ul>\r\n\r\n<p>&nbsp;<br />\r\n三、抓住听众<br />\r\n1、七种经典的开场白<br />\r\n2、复合式开场白<br />\r\n3、与（终点）连结<br />\r\n4、告诉听众你的计划<br />\r\n5、九十妙开场<br />\r\n6、赢得难缠的听众<br />\r\n&nbsp;<br />\r\n四、用视觉沟通<br />\r\n1、图表的功能<br />\r\n2、以简报者为焦点<br />\r\n3、少即是多<br />\r\n4、认知心理学<br />\r\n5、图表设计元素<br />\r\n&nbsp;<br />\r\n五、让文字说话</p>\r\n\r\n<ul>\r\n	<li>条列重点VS完整句子</li>\r\n	<li>自动换行</li>\r\n	<li>打造有效的条例重点式简报</li>\r\n	<li>用（对句法）减少眼球扫视</li>\r\n	<li>使用效果</li>\r\n	<li>小标层次</li>\r\n	<li>视觉风格</li>\r\n</ul>\r\n\r\n<p>&nbsp;<br />\r\n六、让数字发挥作用<br />\r\n1、数据图表的力量<br />\r\n2、柱状图<br />\r\n3、圆饼图<br />\r\n4、数据图表的版面格式<br />\r\n5、曲棍球棒曲线<br />\r\n6、很难捉摸吗？没错，但是&hellip;&hellip;<br />\r\n&nbsp;<br />\r\n七、量身定作简报内容</p>\r\n\r\n<ul>\r\n	<li>量身定作力量大</li>\r\n	<li>收集客制化简报的材料</li>\r\n	<li>活用外部串场话</li>\r\n	<li>有始有终</li>\r\n	<li>练习、练习、再练习</li>\r\n	<li>随时随地加以运用</li>\r\n</ul>\r\n\r\n<p>&nbsp;<br />\r\n<strong>培训<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/index.php\" target=\"_blank\">讲师</a>：</strong><strong>李</strong><strong>老师</strong><br />\r\n理道授权讲师。纽西兰威克图大学管理学博士，纽西兰奥克兰大学财管硕士。李老师是北京大学、清华大学、英国威尔斯大学EMBA特聘教授。具有扎实的财务管理功底，同时擅管理类培训，包括：领导力<a href=\"http://www.baidu.com\">提升</a>、MTP、内部讲师培训、沟通<a href=\"http://www.baidu.com\">技巧</a>、团队与激励、压力与情绪管理、非财务主管财务管理课程。<a class=\"keylink\" href=\"http://www.qgpx.com/neixun/\" target=\"_blank\">内训</a>企业包括麦当劳、百事可乐、广东移动、花旗银行、荷兰银行、第一银行、深圳华强集团、深圳福田汽车站、深圳福田酒店等企业。李老师授课幽默风趣，案例生动，能针对财务群体的特点讲解，深受企业欢迎。</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-10-13 22:43:06', '1', '1', '1');
INSERT INTO `courses` VALUES ('10019', '企业销售（服务）活动税务筹划', '企业销售', '2', '003_02', null, '0000008022', '<p>被呃xcvs gfsr gth dth j yj</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-08-17 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10020', '哈哈哈撒旦法', '哈哈哈撒旦', '4', '003_02', null, '0000008000', '<p>阿什顿飞</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10021', '被她法国湖人', '被她法国湖', '4', '003_01', null, '0000008000', '<p>而嘎登飞</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10022', '111', '111', '4', '003_02', null, '0000008000', '<p>放顶顶顶顶顶顶顶顶顶顶</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10023', '4623425324', '46234', '4', '003_02', null, '0000008000', '<p>撒旦法后天更好</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10024', '尔特让他', '尔特让他', '3', '003_02', null, '0000008000', '<p>嘎登是</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10025', '经济合同的财税风险管理', '经济合同的', '2', '003_02', null, '0000008000', '<p><a href=\"http://www.baidu.com\">财税</a><a href=\"http://www.baidu.com\">风险</a><a href=\"http://www.baidu.com\">管理</a> 之类的课程</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-08-17 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10026', '最新企业所得税税前扣除管理办法', '最新企业所', '2', '003_02', null, '0000008000', '<p>而豆腐干</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-08-18 20:45:31', '1', '1', '1');
INSERT INTO `courses` VALUES ('10027', '不同意能否和', '不同意能否', '4', '003_02', null, '0000008000', '<p>撒旦法</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10028', '风格化', '风格化', '3', '003_02', null, '0000008000', '<p>高考<span style=\"color:#FF0000\"><strong>回家</strong></span></p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-10-13 21:56:09', '1', '1', '1');
INSERT INTO `courses` VALUES ('10029', '你让他4673434', '你让他46', '4', '003_02', null, '0000008000', '<p>的放噶 是个外人</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10030', '十多个人呃ethernet', '十多个人呃', '4', '003_01', null, '0000008000', '<p>阿什顿飞</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10031', '企业税务健康检查方法与实施', '企业税务健', '4', '003_01', null, '0000008000', '<div class=\"WB_text\" style=\"font-size: 14px; line-height: 23px; padding: 4px 0px; color: rgb(66, 48, 9); font-family: Arial, Helvetica, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(250, 250, 250);\">【羽毛一开始是用来飞的吗？】鸟是会飞的恐龙，在它们还不会飞的时候就拥有羽毛222了。然而原始羽毛显然不是为了飞才演化出来的，但这样的结构却为飞行提供了可能性。像这样，在演化过程中性状的作是用发生改变的现象，被称为&ldquo;预适应&rdquo;。一个新研究对预适应的机制进行了阐述：<a href=\"http://t.cn/zQVmLT7\" style=\"text-decoration: none; color: rgb(108, 99, 81);\" target=\"_blank\" title=\"http://www.guokr.com/article/437222/\">http://t.cn/zQVmLT7</a></div>\r\n\r\n<div class=\"WB_media_expand SW_fun2 S_line1 S_bg1\" style=\"background-color: rgb(242, 242, 242); border: 1px solid rgb(224, 219, 209); padding: 10px 20px; margin: 5px 0px 15px; border-top-left-radius: 3px; border-top-right-radius: 3px; border-bottom-right-radius: 3px; border-bottom-left-radius: 3px; color: rgb(66, 48, 9); font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 13px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">\r\n<p>收起<em>|</em>查看大图<em>|</em>向左转<em>|</em>向右转</p>\r\n\r\n<div class=\"smallcursor\" style=\"cursor: url(http://img.t.sinajs.cn/t5/style/images/common/small.cur), auto !important; text-align: center;\"><img src=\"http://ww1.sinaimg.cn/bmiddle/6e53d84fjw1e6xq8y7kqnj20t50l6gn7.jpg\" style=\"border:0px; cursor:url(http://img.t.sinajs.cn/t5/style/images/common/small.cur), auto !important; width:440px\" /></div>\r\n</div>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-10-13 17:29:12', '1', '1', '1');
INSERT INTO `courses` VALUES ('10032', '我去', '我去', '4', '003_01', null, '0000008000', '<p style=\"text-align:left\"><a name=\"N1006B\"><strong>简介</strong></a></p>\r\n\r\n<p style=\"text-align:left\">如果您听说过 Node，或者阅读过一些文章，宣称 Node 是多么多么的棒，那么您可能会想：&ldquo;Node 究竟是什么东西？&rdquo; 即便是在参阅 Node 的主页之后，您甚至可能<em>还是</em> 不明白 Node 为何物？Node 肯定不适合每个程序员，但它可能是某些程序员一直苦苦追寻的东西。</p>\r\n\r\n<p style=\"text-align:left\">为试图解释什么是 Node.js，本文将简要介绍一些背景信息：它要解决的问题，它如何工作，如何运行一个简单应用程序，最后，Node 在什么情况下是一个好的解决方案。本文不涉及如何编写一个复杂的 Node 应用程序，也不是一份全面的 Node 教程。阅读本文应该有助于您决定是否应该继续学习 Node，以便将其用于您的业务。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1007B\"><strong>Node 旨在解决什么问题？</strong></a></p>\r\n\r\n<p style=\"text-align:left\">Node 公开宣称的目标是 &ldquo;旨在提供一种简单的构建可伸缩网络程序的方法&rdquo;。当前的服务器程序有什么问题？我们来做个数学题。在 Java&trade; 和 PHP 这类语言中，每个连接都会生成一个新线程，每个新线程可能需要 2 MB 的配套内存。在一个拥有 8 GB RAM 的系统上，理论上最大的并发连接数量是 4,000 个用户。随着您的客户群的增长，如果希望您的 Web 应用程序支持更多用户，那么，您必须添加更多服务器。当然，这会增加服务器成本、流量成本和人工成本等成本。除这些成本上升外，还有一个潜在技术问题，即用户可能针对每个请求使用不同的服务器，因此，任何共享资源都必须在所有服务器之间共享。鉴于上述所有原因，整个 Web 应用程序架构（包括流量、处理器速度和内存速度）中的瓶颈是：服务器能够处理的并发连接的最大数量。</p>\r\n\r\n<p style=\"text-align:left\">Node 解决这个问题的方法是：更改连接到服务器的方式。每个连接发射一个在 Node 引擎的进程中运行的事件，而不是为每个连接生成一个新的 OS 线程（并为其分配一些配套内存）。Node 声称它绝不会死锁，因为它根本不允许使用锁，它不会直接阻塞 I/O 调用。Node 还宣称，运行它的服务器能支持数万个并发连接。</p>\r\n\r\n<p style=\"text-align:left\">现在您有了一个能处理数万个并发连接的程序，那么您能通过 Node 实际构建什么呢？如果您有一个 Web 应用程序需要处理这么多连接，那将是一件很 &ldquo;恐怖&rdquo; 的事！那是一种 &ldquo;如果您有这个问题，那么它根本不是问题&rdquo; 的问题。在回答上面的问题之前，我们先看看 Node 的工作原理以及它的设计运行方式。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1008D\"><strong>Node 肯定不是什么？</strong></a></p>\r\n\r\n<p style=\"text-align:left\">没错，Node 是一个服务器程序。但是，基础 Node 产品肯定<em>不</em> 像 Apache 或 Tomcat。本质上，那些服务器 &ldquo;安装就绪型&rdquo; 服 务器产品，支持立即部署应用程序。通过这些产品，您可以在一分钟内启动并运行一个服务器。Node 肯定不是这种产品。Apache 能通过添加一个 PHP 模块来允许开发人员创建动态 Web 页，添加一个 SSL 模块来实现安全连接，与此类似，Node 也有模块概念，允许向 Node 内核添加模块。实际上，可供选择的用于 Node 的模块有数百个之多，社区在创建、发布和更新模块方面非常活跃，一天甚至可以处理数十个模块。本文后面将讨论 Node 的整个模块部分。</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-07-24 00:00:00', '1', null, '1');
INSERT INTO `courses` VALUES ('10033', '高效的领导力', '高效的领导', '2', '003_01', null, '0000006000', '<p>样式&nbsp; 普通&nbsp;</p>\r\n\r\n<p>课程内容</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>目的</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>大纲</p>\r\n', null, null, '00000000200', null, '2013-07-24 00:00:00', null, '2013-10-13 22:44:35', null, '1', null);
INSERT INTO `courses` VALUES ('10034', '成为卓越领导、构建高绩效团队', null, '2', '003_01', null, '0000100045', '<div id=\"courseContent\">\r\n<div class=\"intro\">推荐理由</div>\r\n\r\n<p><a href=\"http://www.baidu.com\">高绩效</a><a href=\"http://www.baidu.com\">团队</a>课程旨在帮助学员对照新、旧工作模式及其结果来看清自身的&ldquo;行为短板&rdquo;，激发学员主动改变的动机；理解、掌握&ldquo;<a href=\"http://www.baidu.com\">团队</a>工作模式&rdquo;的过程和行为要 领，并结合自身的经验运用于实际工作中；了解在<a href=\"http://www.baidu.com\">团队</a>中实施&ldquo;<a href=\"http://www.baidu.com\">团队</a>工作模式&rdquo;的阻力与解决策略，使得他们愿意带领<a href=\"http://www.baidu.com\">团队</a>尝试改变。</p>\r\n\r\n<div class=\"intro\">课程内容</div>\r\n\r\n<p>目前中国已经成为全球电子制造业的中心,随着电子产品的高密化、环保化、低利润化、高质量要求,电子制造企业的生存越来越艰难,只有在保证产品功能的情况 下提高产品质量、降低产品成本,才能在竞争激烈的市场中争得一席之地。对电子产品质量影响最大的莫过于工艺缺陷,是否有能力准确地定位、分析、解决电子制 造工艺缺陷成为提高电子产品质量的关键,本课程总结讲师多年的工作经验和实例,并综合业界最新的成果拟制而成,是业内少见的系统讲解工艺缺陷分析诊断与解 决方案的精品课程。</p>\r\n\r\n<p><img alt=\"\" src=\"http://www.baidu.com/img/bdlogo.gif\" style=\"height:129px; width:270px\" /></p>\r\n\r\n<div class=\"intro\">课程特点</div>\r\n\r\n<p>本课程以电子组装焊接(软钎焊)基本原理和可焊性基础讲解为出发点,通过实例来系统深入地讲解电子组装工艺(SMT和波峰焊)工艺过程的数十种典型工艺缺 陷的机理和解决方案,通过该课程的学习可以掌握电子组装工艺典型缺陷的分析 定位与解决.在第二天的专项工艺缺陷的诊断分析中,将针对组装工艺的新问题和难点问题:无铅焊接 BGA焊接 QFN/MLF焊接问题进行讲解,介绍无铅焊接过程独特的工艺缺陷的分析与解决,介绍面阵列器件(BGA)10大类工艺缺陷的分析解决,介绍QFN /MLF器件工艺缺陷的分析和解决方案介绍.通过本课程的学习,学员能够基本掌握电子组装焊接(软钎焊)的基本原理和可焊性测量判断方法,能够系统准确地 定位分析解决电子组装过程典型工艺缺陷,有效提高公司产品的设计水平与质量水平,提高产品在市场的竞争力.</p>\r\n\r\n<div class=\"intro\">课程大纲</div>\r\n\r\n<p>第一天课程:</p>\r\n\r\n<h2>一、电子组装工艺技术介绍</h2>\r\n\r\n<h3>从THT到SMT工艺的驱动</h3>\r\n\r\n<h3>SMT工艺的发展趋势及面临的挑战</h3>\r\n\r\n<h2>二、电子组装焊接(软钎焊)原理及可焊性基础</h2>\r\n\r\n<h3>焊接方法分类</h3>\r\n\r\n<h3>电子组装焊接(软钎焊)的机理和优越性</h3>\r\n\r\n<h3>形成良好软钎焊的条件</h3>\r\n\r\n<h3>润湿 扩散 金属间化合物在焊接中的作用</h3>\r\n\r\n<h3>良好焊点与不良焊点举例</h3>\r\n\r\n<h2>三、SMT工艺缺陷的诊断分析与解决</h2>\r\n\r\n<h3>印刷工艺缺陷分析与解决:</h3>\r\n\r\n<h3>焊膏脱模不良</h3>\r\n\r\n<h3>焊膏印刷厚度问题</h3>\r\n\r\n<h3>焊膏塌陷</h3>\r\n\r\n<h3>布局不当引起印锡问题等</h3>\r\n\r\n<h3>回流焊接工艺缺陷分析诊断与解决方案:</h3>\r\n\r\n<h3>冷焊</h3>\r\n\r\n<h3>立碑</h3>\r\n\r\n<h3>连锡</h3>\r\n\r\n<h3>偏位</h3>\r\n\r\n<h3>芯吸(灯芯现象)</h3>\r\n\r\n<h3>开路</h3>\r\n\r\n<h3>焊点空洞</h3>\r\n\r\n<h3>锡珠</h3>\r\n\r\n<h3>不润湿</h3>\r\n\r\n<h3>半润湿</h3>\r\n\r\n<h3>退润湿</h3>\r\n\r\n<h3>焊料飞溅等</h3>\r\n\r\n<h3>回流焊接典型缺陷案例介绍</h3>\r\n\r\n<p>第二天课程(专项工艺缺陷的分析与诊断):</p>\r\n\r\n<h2>四、无铅焊接工艺缺陷的诊断分析与解决无铅焊接典型工艺缺陷分析诊断与解决:</h2>\r\n\r\n<h3>PCB分层与变形</h3>\r\n\r\n<h3>BAG/CSP曲翘变形导致连锡、开路</h3>\r\n\r\n<h3>无铅焊料润湿性差、扩散性差导致波峰焊的连锡缺陷</h3>\r\n\r\n<h3>黑焊盘Black pads</h3>\r\n\r\n<h3>焊盘脱离</h3>\r\n\r\n<h3>润湿不良;</h3>\r\n\r\n<h3>锡须Tin whisker;</h3>\r\n\r\n<h3>热损伤Thermadamage;</h3>\r\n\r\n<h3>导电阳极细丝Conductive anodic filament;</h3>\r\n\r\n<h3>无铅焊接典型工艺缺陷实例分析.</h3>\r\n\r\n<h2>五、面阵列类器件(BGA)十类典型工艺缺陷的诊断分析与解决</h2>\r\n\r\n<h3>BGA典型工艺缺陷的分析诊断与解决方案:</h3>\r\n\r\n<h3>空洞</h3>\r\n\r\n<h3>连锡</h3>\r\n\r\n<h3>虚焊</h3>\r\n\r\n<h3>锡珠</h3>\r\n\r\n<h3>爆米花现象</h3>\r\n\r\n<h3>润湿不良</h3>\r\n\r\n<h3>焊球高度不均</h3>\r\n\r\n<h3>自对中不良</h3>\r\n\r\n<h3>焊点不饱满</h3>\r\n\r\n<h3>焊料膜等.</h3>\r\n\r\n<h3>BGA工艺缺陷实例分析.</h3>\r\n\r\n<h2>六、QFN/MLF器件工艺缺陷的分析诊断与解决</h2>\r\n\r\n<h3>QFN/MLF器件封装设计上的考虑</h3>\r\n\r\n<h3>PCB设计指南</h3>\r\n\r\n<h3>钢网设计指南</h3>\r\n\r\n<h3>印刷工艺控制</h3>\r\n\r\n<h3>QFN/MLF器件潜在工艺缺陷的分析与解决</h3>\r\n\r\n<h3>典型工艺缺陷实例分析.</h3>\r\n\r\n<h2>七、讨论</h2>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"intro\">讲师介绍：王毅博士</div>\r\n\r\n<p>工学博士，曾任职华为技术有限公司，8年以上大型企业研发及生产实践经验。主持建立华为公司SMT工艺可靠性技术研究平台，参与建设华为公司SMT 工艺平台四大规范体系，擅长电子产品可制造性设计DFM 、SMT工艺可靠性设计DFR等DFx设计平台的建立与应用，在电子产品可制造性设计、SMT组装工艺缺陷机理分析与解决、失效分析、工艺可靠性等领域有 深入研究与丰富的实践应用经验。获省部级科技进步一等奖一次，包括在《CHINES SCIENCE BULLETINE》等国际一流刊物发表学术论文30多篇，包括《BGA空洞形成的机理及对焊点可靠性的影响》、《微型片式元件焊接过程立碑工艺缺陷的分 析与解决》、《QFN器件组装工艺缺陷的分析与解决》、《CCGA器件的可靠性返修》等SMT专业技术文章多篇。</p>\r\n\r\n<p>培训和咨询过的知名企业： 艾默生网络能源、南京熊猫爱立信、深圳市高新技术行业协会、日立汽车部件、霍尼韦尔安防（中国）有限公司、西蒙克拉电子(苏州)、上海大唐移动、中兴通 讯、Optel通讯、厦门华侨电子、海尔、美的集团、格力电器、创维集团、康佳集团、联想集团、比亚迪、同洲电子、同维电子、TCL、大族激光、迈瑞生物 医疗、富士康、英业达、炬力、固高科技、飞通光电、 步步高、万利达、宇龙、好易通、科立讯、金立、海康威视公司、长沙威胜集团、佛山伊戈尔集团、航盛电子、嘉兆电子科技（珠海）、斯比泰电子、中达电子、苏 州万旭光电、山东省东营科英激光电子、南京汉业电子实业有限公司、深圳安科讯、电子十所、西安东风仪表厂、中海油服、北京人民电器厂。</p>\r\n</div>\r\n', null, null, '00000000500', null, '2013-08-05 00:00:00', null, '2013-08-06 00:00:00', '1', '1', '1');
INSERT INTO `courses` VALUES ('10035', '创新管理·深圳电子标杆学习之旅', null, '1', '003_01', null, '0000234234', '<p><strong>【<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>概述】</strong><br />\r\n&nbsp;&nbsp;&nbsp; 随着<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>经济时代的来临、市场的日益全球化和网络的广泛运用，<strong><a href=\"http://www.qgpx.com/neixun/qiyejingying/biaoganguanli/\">标杆学习</a></strong>越 来越成为企业实施流程再造、持续改善及建立核心竞争优势的关键<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>方法。据统计，全球500强企业中超过90%的企业应用了<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>法，如施乐、三星、 IBM等全球行业领袖。那些通过<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>取得系统突破的企业，其投资回报率都在普通公司的五倍以上。为此，华制国际秉持&ldquo;用世界级智慧推动中国经济腾飞， 让中国企业在全球更受尊敬！&rdquo;的使命，将行之有效的&ldquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>&rdquo;和&ldquo;行动<a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>&rdquo;相结合，推出了&ldquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>全球行&rdquo;系列产品。<br />\r\n　　　<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>全球行概念<br />\r\n　　<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>全球行是将<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>与行动<a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>相结合，以中国企业经营<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>中的实际问题为载体，以全球领先企业相同或相似主题的最佳实践为<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a>，并以此为基准 与本企业进行比较、分析、判断，对本企业的问题进行处理，从而使自己企业得到不断改进，赶超一流公司，创造优秀业绩的良性循环过程。<br />\r\n　　　<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>全球行方法<br />\r\n<br />\r\n<strong>【课程背景】&nbsp;</strong>&nbsp;<br />\r\n　　<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>是中国第一个经济特区，经过短短32年的发展，从一个仅有两三万人的小渔村发展为拥有1400万人口、经济繁荣、功能完备、环境优美的新兴现代化大都市，以举世瞩目的&ldquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>速度&rdquo;，创造了世界工业化、城市化、现代化史上的奇迹。<br />\r\n　　创造奇迹的不仅仅是这座城市，还有众多<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>本土企业。华为书写了从两万到千亿的创业传奇，中兴位列国内发明专利申请量第一，腾讯改变了中国数以亿计网 民的沟通方式和生活习惯，创维、康佳依靠<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>跨界白色家电领域，变身家电业巨鳄。他们的诞生、强大直至成为行业强有力的领导者，除了依托特区优越的创业环 境及政策环境，更重要的是企业高瞻远瞩的战略眼光、先进的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>模式以及持续<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>的能力。<br />\r\n　　在全球经济下滑的大背景下，中国经济面临严峻考验，着力转变发展方式、努力提升<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>能力成为众多中国企业应对危机的共同选择。而华为、中兴、腾讯等一 大批<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>企业用实践证明：只有不断优化企业<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>模式、提升自主<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>能力，才能紧跟时代脚步，在激烈的竞争中把握先机、赢得市场。<br />\r\n　　鉴于此，华制国际倾力打造《<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>&middot;<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a><a href=\"http://www.baidu.com\"  target=\"_blank\">电子</a><a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a><a href=\"http://www.baidu.com\"  target=\"_blank\">之旅</a>》，前往<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>高新技术产业园区，参观华为、中兴两家中国卓越企业，领略国际领先企业的风采，近距离<a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>其<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>模式、<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>思维与发展战略，总结其做到全球卓越的本质原因，为企业的<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>探寻路径。<br />\r\n<br />\r\n<strong>【课程特色及受益】</strong></p>\r\n\r\n<p>个性化主题研修&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 了解<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>高新技术企业飞速发展的原因，<a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>华为的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>模式，系统梳理<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>对企业发展的影响及意义，探寻企业<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的实施路径<br />\r\n实战型专家授课&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 具有丰富理论经验和多年企业<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>经验的实战型专家进行授课，讲述企业真实案例，分享实际<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>经验<br />\r\n<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a>企业现场参观&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 走进<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>高新技术产业园区，近距离参观中兴、华为等<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>型<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a>企业，感受企业<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>氛围，现场了解<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a>企业的运营模式<br />\r\n企业高管互动交流&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 深入业内领先的<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a>企业实地考察，与企业高管交流企业的<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>模式，<a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a><a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a><a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_0_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">企业战略</a>思维及<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a><a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>手段<br />\r\n学员总结分享心得&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 分享经验，碰撞智慧，分析自身企业在发展<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>中所遇的问题，讨论<a href=\"http://www.baidu.com\"  target=\"_blank\">标杆</a>企业的先进的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>理念、<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>模式以及<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>路径对于自身企业的启示</p>\r\n\r\n<p><strong>【学员对象】</strong><br />\r\n　　企业董事长/总裁/总经理、副总裁/副总经理、总监/部门经理等中高层<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>者<br />\r\n<br />\r\n<strong>【行程安排】</strong></p>\r\n\r\n<p>日期&nbsp;城市&nbsp;日程安排<br />\r\n&nbsp;&nbsp;时间&nbsp;内容<br />\r\n&nbsp;<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>&nbsp;下午&nbsp;报到/<a href=\"http://www.baidu.com\"  target=\"_blank\">学习</a>资料发放/酒店入住安排&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />\r\n&nbsp;&nbsp;晚上&nbsp;晚餐</p>\r\n\r\n<p>第一天<br />\r\n&nbsp;<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>&nbsp;08:30-09:00&nbsp;开讲仪式：行程介绍、注意事项说明<br />\r\n&nbsp;&nbsp;09:00-12:00&nbsp;主题培训一：《华为<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>》上<br />\r\n&nbsp;&nbsp;12:00-14:00&nbsp;合影&amp;午餐&amp;休息<br />\r\n&nbsp;&nbsp;14:00-17:00&nbsp;主题培训一：《华为<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>》下<br />\r\n&nbsp;&nbsp;17:30-18:30&nbsp;晚餐<br />\r\n<br />\r\n第二天&nbsp;</p>\r\n\r\n<p>&nbsp;<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>&nbsp;08:30-09:30&nbsp;乘车前往<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>华为技术<br />\r\n&nbsp;&nbsp;09:30-11:30&nbsp;参观一：<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>华为技术<br />\r\n参观内容：华为产品展厅/<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_10_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">企业文化</a>展厅/华为大学主培楼/高培楼/ 华为百草园（单身公寓）<br />\r\n&nbsp;&nbsp;11:30-13:00&nbsp;午餐、休息<br />\r\n&nbsp;&nbsp;13:00-17:30&nbsp;主题培训二：《中兴基于客户价值的<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>》<br />\r\n&nbsp;&nbsp;17:30-18:30&nbsp;晚餐<br />\r\n&nbsp;&nbsp;18:30-20:30&nbsp;学员发表<br />\r\n主题：<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>对企业的启发</p>\r\n\r\n<p>第三天&nbsp;<br />\r\n<br />\r\n<a href=\"http://www.baidu.com\"  target=\"_blank\">深圳</a>&nbsp;08:30-09:30&nbsp;乘车前往中兴通讯<br />\r\n&nbsp;&nbsp;09:30-11:30&nbsp;参观二：中兴通讯<br />\r\n参观流程：中兴通讯总部研发大楼/中兴产品与设备展厅/中兴生产车间/中兴历史文化博物馆<br />\r\n&nbsp;&nbsp;11:30-14:00&nbsp;午餐&amp;休息<br />\r\n&nbsp;&nbsp;14:00-17:00&nbsp;主题培训三：《中兴流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>体系》<br />\r\n&nbsp;&nbsp;17:00-17:30&nbsp;结业仪式、课程结束</p>\r\n\r\n<p>《华为<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>》<br />\r\n　一、流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的原则<br />\r\n　 1.加快反应速度<br />\r\n　2.提高<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>效率<br />\r\n　二、华为的流程变革<br />\r\n　 1.变革<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>体系<br />\r\n　 2.变革<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>运作机制<br />\r\n　 3.变革历程与相关经验<br />\r\n　三、流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的操作手法&nbsp;　 1.梳理作业流程<br />\r\n　 2.精简冗余程序<br />\r\n　 3.合并同类环节<br />\r\n　 4.合理排序<br />\r\n　四、华为的研发流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a><br />\r\n　 1.预研：专利转为商品的必经之路&nbsp;&nbsp;<br />\r\n　 2.IPD：集成产品开发&nbsp;&nbsp;<br />\r\n　 3.&ldquo;专利地图&rdquo;<br />\r\n《中兴基于客户价值的<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>》<br />\r\n一、中兴以客户为主的<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_10_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">企业文化</a><br />\r\n　1.互相尊重，忠于中兴事业<br />\r\n　2.精诚服务，凝聚顾客身上<br />\r\n　3.拼搏<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>，集成中兴名牌<br />\r\n　4.科学<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>，提高企业效益<br />\r\n二、中兴基于客户价值的&ldquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>服务&rdquo;产品<br />\r\n　1.<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>服务支撑&nbsp;　2.故障<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>服务<br />\r\n　3.性能<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>与优化服务<br />\r\n　4.配置<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>服务<br />\r\n　5.业务<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>服务<br />\r\n　6.预防性维护服务<br />\r\n三、中兴的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>机制及体系<br />\r\n四、中兴的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>模式的<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>及发展<br />\r\n《中兴流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>体系》<br />\r\n一、流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的原则<br />\r\n　加快反应速度 / 提高<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>效率<br />\r\n二、流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的一般手法<br />\r\n三、中兴的流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>划分<br />\r\n　1.运行监控<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>&nbsp;&nbsp;&nbsp; 2.持续优化<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a><br />\r\n　3.审计<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.文件<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a><br />\r\n　四、流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a><a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><br />\r\n&nbsp;　1.<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>的必要性<br />\r\n　2.流程<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>的步骤<br />\r\n　　目标流程的选定&rarr;现状调查、设定目标<br />\r\n　&rarr;改进措施的确定和实施&rarr;巩固和标准化<br />\r\n　3.常见的<a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a>组织方式<br />\r\n　QC小组/6Sigma团队/<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_14_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">项目管理</a>/8D<br />\r\n4.中兴的流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a><a href=\"http://www.baidu.com\"  target=\"_blank\">创新</a><br />\r\n<br />\r\n<strong>【核心师资】</strong><br />\r\n1. 刘老师<br />\r\n&nbsp;&nbsp;&nbsp; 具有10余年国际、国内知名高科技企业研发实践和研发<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>经验，先后在IBM、华为担任过系统工程师、项目经理、开发部经理、事业部总经理等职位，主持了某著名高科技企业电信业务软件平台的开发，具有非常丰富的产品开发<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>和<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_14_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">项目管理</a>专业知识及实践经验。国内最早一批（2000年）美国项目<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>协会认证专家PMP。<br />\r\n2. 张老师<br />\r\n&nbsp; 经历了从质量专家到资深质量经理人的转换，体验了从国有企业到外资企业再到合资企业的文化差异。长期从事质量<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>工作，具有丰富的服务性、制造性企业质量 <a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>及实务经验，尤其在流程<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>领域上的研究受到国内外人士的推崇。10年工厂审核、咨询和培训的经验使师老师对各行业的制造过程和产品特征有深入的了 解，多年来担任质量<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>及现场改进领域的嘉宾，并成功辅导了十几家跨领域企业的质量改善项目。</p>\r\n', null, null, '00000000500', null, '2013-08-18 18:22:39', null, '2013-08-18 18:22:39', null, '1', null);
INSERT INTO `courses` VALUES ('10036', '修改一行SQL代码，性能提升了100倍', null, '2', '003_01', null, '0000086000', '<p>在PostgreSQL中<a href=\"http://www.baidu.com\" target=\"_blank\">修改</a>了<a href=\"http://www.baidu.com\" target=\"_blank\">一行</a>不明显的<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>，把（ANY(ARRAY[...]) 改成 ANY(VALUES(...))），结果查询时间从20s变为0.2s。最初我们学习使用<a href=\"http://www.postgresql.org/docs/9.1/static/sql-explain.html\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\">EXPLAN ANALYZE</a>来优化<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>，到后来，<a href=\"http://www.postgresql.org/list/pgsql-performance/\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\">Postgres社区</a>也成为我们学习<a href=\"http://www.baidu.com\" target=\"_blank\">提升</a>的一个好帮手，付出总会有回报，我们产品的<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a>也因此得到了极大的<a href=\"http://www.baidu.com\" target=\"_blank\">提升</a>。</p>\r\n\r\n<p><strong>事出有因</strong></p>\r\n\r\n<p>我们所开发的产品是<a href=\"http://www.datadoghq.com/\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\">Datadog</a>， 这是专门为那些编写和运营大规模应用的团队、IT运营商提供监控服务的一个平台，帮助他们把海量的数据转化为切实可行的计划、操作方案。在这周早些时候， 我们的许多数据库所面临的一个<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a>问题是在一个较小的表上进行大量的key查询。这些查询中的99.9%都是高效灵活的。在极少数实例中，有些数量的<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a> 指标tag查询是费时的，这些查询需要花费20s时间。这也就意味着用户需要在浏览器面前花费这么长的时间来等待图形编辑器做出响应。即使是0.1%，这 样的用户体验也显然糟透了，对此，我们进行了监测，探究为何速度会这么慢。</p>\r\n\r\n<p><strong>查询与计划</strong></p>\r\n\r\n<p>结果令人震惊，罪魁祸首竟然是下面这个简单的查询：</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n\r\n<ol start=\"1\">\r\n	<li>SELECT&nbsp;c.key,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c.x_key,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c.tags,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;x.name&nbsp;&nbsp;</li>\r\n	<li>&nbsp;FROM&nbsp;context&nbsp;c&nbsp;&nbsp;</li>\r\n	<li>&nbsp;JOIN&nbsp;x&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;ON&nbsp;c.x_key&nbsp;=&nbsp;x.key&nbsp;&nbsp;</li>\r\n	<li>WHERE&nbsp;c.key&nbsp;=&nbsp;ANY&nbsp;(ARRAY[15368196,&nbsp;--&nbsp;11,000&nbsp;other&nbsp;keys&nbsp;--)])&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;AND&nbsp;c.x_key&nbsp;=&nbsp;1&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;AND&nbsp;c.tags&nbsp;@&gt;&nbsp;ARRAY[E&#39;blah&#39;];&nbsp;&nbsp;</li>\r\n</ol>\r\n</div>\r\n\r\n<p>X表拥有 上千行数据，C表拥有1500万行数据，这两个表的&ldquo;key&rdquo;列都带有适当的索引主键。简单地说，它就是一个简单的主键查询。但有趣地是，随着key列中 记录的增加，例如在1<a href=\"http://www.baidu.com\" target=\"_blank\">100</a>0行时，我们通过添加EXPLAIN (ANALYZE, BUFFERS)前缀来查看key列的值是否与数组中的值匹配：</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n</div>\r\n\r\n<p>这次查询共花费22s，我们可以通过下图对这22s进行很直观的了解，其中大部分时间花费在Postgres和OS之间，而磁盘I/O则花费非常少的时间。</p>\r\n\r\n<p style=\"text-align:center\"><img alt=\"\" src=\"http://dl2.iteye.com/upload/attachment/0088/6876/39007ce3-4097-38fe-9998-b86de8f00f50.jpg\" /></p>\r\n\r\n<p>在最低水平，这些查询看起来就像是这些CPU利用率的峰值。在这里主要是想证实一个关键点：数据库不会等待磁盘去读取数据，而是做排序、散列和行比较这些事。</p>\r\n\r\n<p>通过Postgres获取与峰值最接近的行数。</p>\r\n\r\n<p style=\"text-align:center\"><img alt=\"\" src=\"http://dl2.iteye.com/upload/attachment/0088/6878/fcaba5f9-b7f9-3e4f-ac70-749698af550b.jpg\" /></p>\r\n\r\n<p>显然，我们的查询在大多数情况下都有条不紊的执行着。</p>\r\n\r\n<p><strong>Postgres的<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a>问题：位图堆扫描</strong>&nbsp;</p>\r\n\r\n<p>rows_fetched度量与下面的部分计划是一致的：&nbsp;</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n</div>\r\n\r\n<p style=\"text-align:left\">Postgres使用位图堆扫描（&nbsp;<a href=\"http://www.postgresql.org/message-id/12553.1135634231@sss.pgh.pa.us\" style=\"font-size: 12px; cursor: pointer; color: #0066cc;\" target=\"_blank\">Bitmap Heap Scan</a>） 来读取C表数据。当关键字的数量较少时，它可以在内存中非常高效地使用索引构建位图。如果位图太大，查询优化器会改变其查找数据的方式。在我们这个案例 中，需要检查大量的关键字，所以它使用了非常相似的方法来检查候选行并且单独检查与x_key和tag相匹配的每<a href=\"http://www.baidu.com\" target=\"_blank\">一行</a>。而所有的这些&ldquo;在内存中加载&rdquo;和 &ldquo;检查每<a href=\"http://www.baidu.com\" target=\"_blank\">一行</a>&rdquo;都需要花费大量的时间。</p>\r\n\r\n<p style=\"text-align:left\">幸 运的是，我们的表有30%都是装载在RAM中，所以在从磁盘上检查行的时候，它不会表现的太糟糕。但在<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a>上，它仍然存在非常明显的影响。查询过于简单， 这是一个非常简单的key查找，所以没有显而易见的数据库或应用重构，它很难找到一些简单的方式来解决这个问题。最后，我们使用<span style=\"font-size:14px\"><a href=\"http://www.postgresql.org/message-id/200209271205.49756.josh@agliodbs.com\" style=\"font-size: 12px; cursor: pointer; color: #0066cc;\" target=\"_blank\">PGSQL-Performance邮件</a></span>向社区寻求帮助。&nbsp;</p>\r\n\r\n<p><strong>解决方案</strong></p>\r\n\r\n<p>开源帮了我们，经验丰富的且<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>贡献量非常多的<a href=\"http://en.wikipedia.org/wiki/Tom_Lane_%28computer_scientist%29\" style=\"cursor: pointer; color: #0066cc;\">Tom Lane</a>让我们试试这个：</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n\r\n<ol start=\"1\">\r\n	<li>SELECT&nbsp;c.key,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c.x_key,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c.tags,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;x.name&nbsp;&nbsp;</li>\r\n	<li>&nbsp;FROM&nbsp;context&nbsp;c&nbsp;&nbsp;</li>\r\n	<li>&nbsp;JOIN&nbsp;x&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;ON&nbsp;c.x_key&nbsp;=&nbsp;x.key&nbsp;&nbsp;</li>\r\n	<li>WHERE&nbsp;c.key&nbsp;=&nbsp;ANY&nbsp;(VALUES&nbsp;(15368196),&nbsp;--&nbsp;11,000&nbsp;other&nbsp;keys&nbsp;--)&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;AND&nbsp;c.x_key&nbsp;=&nbsp;1&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;AND&nbsp;c.tags&nbsp;@&gt;&nbsp;ARRAY[E&#39;blah&#39;];&nbsp;&nbsp;</li>\r\n</ol>\r\n</div>\r\n\r\n<p>你能发现有啥不同之处吗？把ARRAY换成了VALUES。</p>\r\n\r\n<p>我们使用ARRAY[...]列举出所有的关键字来进行查询，但却欺骗了查询优化器。Values(...)让优化器充分使用关键字索引。仅仅是<a href=\"http://www.baidu.com\" target=\"_blank\">一行</a><a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>的改变，并且没有产生任何语义的改变。</p>\r\n\r\n<p>下面是新查询语句的写法，差别就在于第三和第十四行。</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n</div>\r\n\r\n<p style=\"text-align:left\"><strong>产品里新的查询</strong></p>\r\n\r\n<p>部署后的<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>：</p>\r\n\r\n<p><a href=\"http://cms.csdnimg.cn/article/201308/27/521c4cd925f9e.jpg\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\"><img alt=\"\" src=\"http://cms.csdnimg.cn/article/201308/27/521c4cd925f9e.jpg\" style=\"border-style:none; height:67px; vertical-align:middle; width:608.9117647058823px\" /></a></p>\r\n\r\n<p>数据库看起来更美观</p>\r\n\r\n<p style=\"text-align:center\"><a href=\"http://cms.csdnimg.cn/article/201308/27/521c4d43ab729.jpg\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\"><img alt=\"\" src=\"http://cms.csdnimg.cn/article/201308/27/521c4d43ab729.jpg\" style=\"border-style:none; vertical-align:middle\" />&nbsp;</a></p>\r\n\r\n<p style=\"text-align:center\"><a href=\"http://cms.csdnimg.cn/article/201308/27/521c4d93a92ef.jpg\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\"><img alt=\"\" src=\"http://cms.csdnimg.cn/article/201308/27/521c4d93a92ef.jpg\" style=\"border-style:none; vertical-align:middle\" /></a></p>\r\n\r\n<p>Postgres慢查询将一去不复返了。但有谁愿意因为这个0.1%的倒霉蛋再去折磨呢？我们使用Datadog来验证<a href=\"http://www.baidu.com\" target=\"_blank\">修改</a>是否正确，它能够做出即时验证。如果你想查看Postgres查询速度的各种影响，&nbsp;<a href=\"https://www.datadoghq.com/signup/\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\">不妨试试Datadog</a>吧。</p>\r\n', null, null, '00000000500', null, '2013-08-31 16:06:13', null, '2013-10-12 11:26:08', null, '1', null);
INSERT INTO `coursesubjects` VALUES ('11', '10014', '7', '综合');
INSERT INTO `coursesubjects` VALUES ('12', '10014', '8', '部门经理');
INSERT INTO `coursesubjects` VALUES ('43', '10034', '1', '企业管理');
INSERT INTO `coursesubjects` VALUES ('44', '10034', '2', '企业发展');
INSERT INTO `coursesubjects` VALUES ('71', '10025', '11', '财税风险管理');
INSERT INTO `coursesubjects` VALUES ('92', '10001', '1', '企业管理');
INSERT INTO `coursesubjects` VALUES ('93', '10001', '2', '企业发展');
INSERT INTO `coursesubjects` VALUES ('98', '10009', '20', '五十六个民族是一家');
INSERT INTO `coursesubjects` VALUES ('103', '10035', '26', '深圳电子标杆学习之旅');
INSERT INTO `coursesubjects` VALUES ('105', '10026', '27', '企业所得税税前扣除管理办法');
INSERT INTO `coursesubjects` VALUES ('122', '10036', '29', '性能提升');
INSERT INTO `coursesubjects` VALUES ('123', '10036', '28', '修改代码');
INSERT INTO `coursesubjects` VALUES ('126', '10031', '19', '企业税务健康检查');
INSERT INTO `coursesubjects` VALUES ('135', '10010', '25', '企业在运用税收优惠政策中常见的误');
INSERT INTO `coursesubjects` VALUES ('136', '10010', '24', '最新企业税收优惠政策及其纳税筹划');
INSERT INTO `coursesubjects` VALUES ('137', '10028', '5', '企业管理');
INSERT INTO `coursesubjects` VALUES ('138', '10028', '6', '企业发展');
INSERT INTO `coursesubjects` VALUES ('139', '10004', '42', '什么意思啊');
INSERT INTO `coursesubjects` VALUES ('146', '10012', '3', '采购');
INSERT INTO `coursesubjects` VALUES ('147', '10012', '4', '供应商');
INSERT INTO `coursesubjects` VALUES ('148', '10018', '18', '抱怨处理技巧提升');
INSERT INTO `coursesubjects` VALUES ('149', '10033', '9', '领导力高效');
INSERT INTO `coursetarget` VALUES ('9', '1', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('10', '12', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('11', '12', '财务人员', '010_02');
INSERT INTO `coursetarget` VALUES ('14', '10', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('15', '10', '财务人员', '010_02');
INSERT INTO `coursetarget` VALUES ('16', '4', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('17', '4', '财务人员', '010_02');
INSERT INTO `coursetarget` VALUES ('21', '2', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('22', '2', '财务人员', '010_02');
INSERT INTO `coursetarget` VALUES ('23', '2', '机构', '001_03');
INSERT INTO `coursetarget` VALUES ('24', '33', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('25', '33', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('26', '33', '机构', '001_03');
INSERT INTO `coursetarget` VALUES ('27', '10002', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('28', '10002', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('39', '10019', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('40', '10019', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('46', '10014', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('47', '10014', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('77', '10034', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('126', '10001', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('127', '10001', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('134', '10009', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('135', '10009', '秘书', '010_03');
INSERT INTO `coursetarget` VALUES ('140', '10035', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('141', '10026', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('142', '10026', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('152', '10036', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('163', '10010', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('174', '10012', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('175', '10012', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('176', '10018', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('177', '10018', '秘书', '010_03');
INSERT INTO `coursetarget` VALUES ('178', '10033', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('179', '10033', '财务从业人员', '010_02');
INSERT INTO `downloads` VALUES ('1', '小米3发布会', 'C:\\Users\\Roger\\Desktop\\小米3发布会.ppt', 'ppt', '小米发布会上的ppt，雷军说。小米3 是最好的安卓机', '雷军', '2013-11-20 22:29:29', '200', '200');
INSERT INTO `item` VALUES ('fsdags', 'sadf', 'fg', 'sdf', null, null);
INSERT INTO `item` VALUES ('sdf', 'grwe', 'sdf', 'werf', 'sadf', null);
INSERT INTO `item` VALUES ('sdf', 'grwe', 'sdf', 'werf', 'sadf', null);
INSERT INTO `item` VALUES ('sdf', 'grwe', 'sdf', 'werf', 'sadf', null);
INSERT INTO `item` VALUES ('sdf', 'grwe', 'sdf', 'werf', 'sadf', null);
INSERT INTO `keywords` VALUES ('1', '中华', '1', null, '003_01', '1', '835', '1', '2013-08-07 15:43:35', '1');
INSERT INTO `keywords` VALUES ('2', '建设', '1', null, '003_01', '2', '498', '1', '2013-08-07 15:43:35', '0');
INSERT INTO `keywords` VALUES ('3', '国家', '1', null, '003_01', '3', '671', '1', '2013-08-18 15:46:51', '0');
INSERT INTO `keywords` VALUES ('74', '企业管理', '1', null, '003_01', '74', '426', '1', '2013-08-01 16:31:49', '0');
INSERT INTO `keywords` VALUES ('75', '有效', '1', null, '003_01', '75', '425', '1', '2013-07-28 20:59:23', '0');
INSERT INTO `keywords` VALUES ('76', '的', '1', null, '003_01', '76', '424', '1', '2013-08-01 15:24:36', '0');
INSERT INTO `keywords` VALUES ('77', '进行', '1', null, '003_01', '77', '423', '1', '2013-07-28 20:57:54', '0');
INSERT INTO `keywords` VALUES ('78', '怎样', '1', null, '003_01', '78', '422', '1', '2013-07-28 20:57:36', '0');
INSERT INTO `keywords` VALUES ('79', '', '1', null, '003_01', '79', '421', '1', '2013-08-18 15:46:51', '0');
INSERT INTO `keywords` VALUES ('80', '评估', '1', null, '003_01', '80', '420', '1', '2013-07-28 20:59:23', '0');
INSERT INTO `keywords` VALUES ('81', '采购', '1', null, '003_01', '81', '419', '1', '2013-07-28 20:57:54', '0');
INSERT INTO `keywords` VALUES ('82', '流程', '1', null, '003_01', '82', '218', '1', '2013-08-18 15:46:51', '0');
INSERT INTO `keywords` VALUES ('83', '优化', '1', null, '003_01', '83', '417', '1', '2013-07-28 20:55:52', '0');
INSERT INTO `keywords` VALUES ('84', '供应商', '1', null, '003_01', '84', '416', '1', '2013-07-28 20:59:23', '0');
INSERT INTO `keywords` VALUES ('85', '管理', '1', null, '003_01', '85', '415', '1', '2013-07-28 20:56:04', '0');
INSERT INTO `keywords` VALUES ('86', '客户', '1', null, '003_01', '86', '414', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('87', '抱怨', '1', null, '003_01', '87', '413', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('88', '处理', '1', null, '003_01', '88', '412', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('89', '投诉', '1', null, '003_01', '89', '411', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('90', '提升', '1', null, '003_01', '90', '410', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('91', '优质', '1', null, '003_01', '91', '409', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('92', '服务', '1', null, '003_01', '92', '408', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('93', '技巧', '1', null, '003_01', '93', '407', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('94', '税收优惠政策', '1', null, '003_01', '94', '406', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('95', '纳税', '1', null, '003_01', '95', '405', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('96', '企业', '1', null, '003_01', '96', '404', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('97', '筹划', '1', null, '003_01', '97', '403', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('98', '最新', '1', null, '003_01', '98', '402', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('99', '建立', '1', null, '003_01', '99', '401', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('100', '控制', '1', null, '003_01', '100', '400', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('101', '如何', '1', null, '003_02', '101', '399', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('102', '制度', '1', null, '003_02', '102', '398', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('103', '内部', '1', null, '003_02', '103', '397', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('104', '打交道', '1', null, '003_02', '104', '396', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('105', '与', '1', null, '003_02', '105', '395', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('106', '机关', '1', null, '003_02', '106', '394', '1', '2013-07-28 20:56:04', '0');
INSERT INTO `keywords` VALUES ('107', '税务', '1', null, '003_02', '107', '393', '1', '2013-07-28 20:56:04', '0');
INSERT INTO `keywords` VALUES ('108', '销售', '1', null, '003_02', '108', '392', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('109', '活动', '1', null, '003_02', '109', '391', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('110', '风险', '1', null, '003_02', '110', '390', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('111', '合同', '1', null, '003_02', '111', '389', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('112', '财税', '1', null, '003_02', '112', '388', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('113', '经济', '1', null, '003_02', '113', '387', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('114', '扣除', '1', null, '003_02', '114', '386', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('115', '办', '1', null, '003_02', '115', '385', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('116', '税前', '1', null, '003_02', '116', '384', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('117', '企业所得税', '1', null, '003_02', '117', '383', '1', '2013-07-28 20:56:04', '0');
INSERT INTO `keywords` VALUES ('118', '健康', '1', null, '003_02', '118', '382', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('119', '实施', '1', null, '003_02', '119', '381', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('120', '检查', '1', null, '003_02', '120', '380', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('121', '方法', '1', null, '003_02', '121', '379', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('122', '爱', '1', null, '003_02', '122', '378', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('123', '我们', '1', null, '003_02', '123', '377', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('124', '风格', '1', null, '003_02', '124', '376', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('125', '化', '1', null, '003_02', '125', '375', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('126', '哈哈', '1', null, '003_02', '126', '374', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('127', 'sfdvgsd', '1', null, '003_02', '127', '373', '1', '2013-07-27 14:16:01', '0');
INSERT INTO `keywords` VALUES ('128', '哈', '1', null, '003_02', '128', '372', '1', '2013-07-28 20:56:39', '0');
INSERT INTO `keywords` VALUES ('129', '环境', '1', null, '003_02', '129', '371', '1', '2013-07-28 20:56:39', '0');
INSERT INTO `keywords` VALUES ('130', '领导力', '1', null, '003_02', '130', '370', '1', '2013-07-28 20:56:39', '0');
INSERT INTO `keywords` VALUES ('131', '高效', '1', null, '003_02', '131', '369', '1', '2013-07-28 20:56:39', '0');
INSERT INTO `keywords` VALUES ('190', '税款', '1', null, '003_02', '500', '500', '1', '2013-08-01 16:24:42', '0');
INSERT INTO `keywords` VALUES ('191', '嘻嘻', '1', null, '003_02', '500', '500', '1', '2013-08-07 15:43:55', '0');
INSERT INTO `keywords` VALUES ('192', '企业', null, null, '003_02', '500', '500', '1', '2013-08-07 15:43:50', '0');
INSERT INTO `keywords` VALUES ('193', '客户', null, null, '003_02', '500', '500', '1', '2013-08-07 15:43:50', '0');
INSERT INTO `keywords` VALUES ('194', '抱怨', null, null, '003_02', '500', '500', '1', '2013-08-18 15:46:51', '0');
INSERT INTO `keywords` VALUES ('195', '处理', null, null, '003_02', '500', '500', '1', '2013-08-07 15:43:49', '0');
INSERT INTO `keywords` VALUES ('196', '投诉', null, null, '003_02', '500', '500', '1', '2013-08-07 15:43:49', '0');
INSERT INTO `keywords` VALUES ('197', '提升', null, null, '003_02', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('198', '优质', null, null, '003_02', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('199', '服务', null, null, '003_02', '500', '500', '1', '2013-08-07 15:43:55', '0');
INSERT INTO `keywords` VALUES ('200', '技巧', null, null, '003_02', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('201', '筹划', null, null, '003_02', '500', '500', '1', '2013-08-07 15:43:55', '0');
INSERT INTO `keywords` VALUES ('202', '评估', null, null, '003_02', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('203', '采购', null, null, '003_02', '500', '500', '1', '2013-08-07 15:43:55', '0');
INSERT INTO `keywords` VALUES ('204', '供应商', null, null, '003_02', '500', '500', '1', '2013-08-18 15:46:22', '0');
INSERT INTO `keywords` VALUES ('205', '优化', null, null, '003_02', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('206', '流程', null, null, '003_02', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('207', '管理', null, null, '003_02', '500', '500', '1', '2013-08-07 15:43:49', '0');
INSERT INTO `keywords` VALUES ('208', '领导', null, null, '003_01', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('209', '构建', null, null, '003_01', '500', '500', '1', '2013-08-07 15:43:50', '0');
INSERT INTO `keywords` VALUES ('210', '卓越', null, null, '003_01', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('211', '团队', null, null, '003_01', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('212', '高绩效', null, null, '003_01', '500', '500', '1', '2013-08-18 15:46:22', '0');
INSERT INTO `keywords` VALUES ('213', '干部', null, null, '003_02', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('214', '综合', null, null, '003_02', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('215', '部门经理', null, null, '003_02', '500', '500', '1', '2013-08-07 15:43:55', '0');
INSERT INTO `keywords` VALUES ('216', '技能', null, null, '003_02', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('217', '如果', null, null, '003_01', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('218', '那么', null, null, '003_01', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('219', '及时', null, null, '003_01', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('220', '即使', null, null, '003_01', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('221', '领导力', null, null, '003_01', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('222', '高效', null, null, '003_01', '500', '500', '1', '2013-08-07 15:44:10', '0');
INSERT INTO `keywords` VALUES ('223', '哈哈', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('224', '什么', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('225', '如何', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('226', '制度', null, null, '003_01', '500', '500', '1', '2013-08-18 15:46:37', '1');
INSERT INTO `keywords` VALUES ('227', '内部', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('228', '健康', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('229', '实施', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('230', '检查', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('231', '方法', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('232', '税务', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('233', '国家', null, null, '003_02', '500', '500', '1', '2013-08-18 16:22:55', '1');
INSERT INTO `keywords` VALUES ('234', '建设', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('235', '中华', null, null, '003_02', '500', '500', '1', '2013-08-18 16:22:55', '1');
INSERT INTO `keywords` VALUES ('236', '纳税', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('237', '税收优惠政策', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('238', '及其', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('239', '最新', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('240', '之旅', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('241', '学习', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('242', '标杆', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('243', '创新', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('244', '深圳', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('245', '电子', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('246', '办法', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('247', 'sql', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('248', '修改', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('249', '代码', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('250', '性能', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('251', '一行', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('252', '100', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('253', '打手', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('254', '个人', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('255', '犯规', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('256', '打手', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('257', '个人', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('258', '犯规', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('259', '中国', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('260', '印象', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('261', '南京', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('262', '关门', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('263', '关键', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('264', '部门', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('265', '美国联邦', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('266', '政府', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('267', '试飞', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('268', '试飞', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('269', '是的', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('270', '科比咯', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('271', '今天', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('272', '星期一', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('273', '是的dd', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('274', '领导哥们', '1', null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('275', '领导胜利', '1', null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('276', '领导无产阶级', '1', null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('277', '领导未来', '1', null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('278', '领导部门', '1', null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('279', '打中', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('280', '随便', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('281', '文章', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('282', '插入', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('283', '测试', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('284', '进程', '1', null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('285', '软件', '1', null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('286', '工程', '1', null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('287', '企业资讯', '1', null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('288', '文章', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('289', '测试', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('290', '发布', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('291', '手写', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('292', '石家庄', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('293', '晴转多云', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('294', '天气很好', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('295', '美妙', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('296', '如此', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('297', '世界', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('298', '如此美妙', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('299', '丢失', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('300', '茅十八', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('301', '法克鱿', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('302', '报文丢失', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('303', '报想丢失', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('304', '报想丢', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('305', '发资讯', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('306', '企业培训', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('307', '天气预报', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('308', '我要', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('309', '提前完成', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('310', '还在', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `orginfo` VALUES ('1', '2', '人人培训', '天河东路', '51000123', '邓生啊阿斯蒂芬', '13640713241', '8960', '8960', 'www.baidu.com', '内训培训', '我们是个好机构，专门培养各种人才我去阿的发放');
INSERT INTO `questions` VALUES ('1', '天气预报怎么生成的', '天天看天气预报，天气预报是怎么产生的呢', null, '2013-11-12', '1');
INSERT INTO `questions` VALUES ('2', '公积金问题', '我的公积金基数', null, null, '雷理超');
INSERT INTO `requirements` VALUES ('1', '1', '怎样创建中国共产党', '12', '2', '2013-11-06', '2013-11-22', '广州', '毛泽东', '110', '119', '中华人民共和国', 0xE4B88AE8AFBEE4B88AE8AFBE, 0xE4BA8BE5AE9EE4B88A, '0', '2013-11-06 23:16:34', '763658583@qq.com');
INSERT INTO `requirements` VALUES ('2', '1', '怎样创建中国共产党', '12', '2', '2013-11-06', '2013-11-22', '广州', '毛泽东', '110', '119', '中华人民共和国', 0xE4B88AE8AFBEE4B88AE8AFBE, '', '1', '2013-11-06 23:16:34', '763658583@qq.com');
INSERT INTO `subjects` VALUES ('1', '企业管理', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('2', '企业发展', null, null, '003_01', '500', '500', '1', '2013-08-18 16:03:19');
INSERT INTO `subjects` VALUES ('3', '采购', null, null, '003_02', '500', '500', '1', '2013-08-18 16:03:19');
INSERT INTO `subjects` VALUES ('4', '供应商', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('5', '企业管理', null, null, '003_02', '500', '500', '1', '2013-08-18 16:03:19');
INSERT INTO `subjects` VALUES ('6', '企业发展', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('7', '综合', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('8', '部门经理', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('9', '领导力高效', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('10', '什么意思啊？', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('11', '财税风险管理', null, null, '003_02', '500', '500', '1', '2013-08-18 16:26:04');
INSERT INTO `subjects` VALUES ('18', '抱怨处理技巧提升', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('19', '企业税务健康检查', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('20', '五十六个民族是一家', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('21', '我们为什么要走社会主义道路', '1', null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('22', '社会怎么了', '1', null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('23', '资本主义不好吗', '1', null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('24', '最新企业税收优惠政策及其纳税筹划', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('25', '企业在运用税收优惠政策中常见的误', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('26', '深圳电子标杆学习之旅', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('27', '企业所得税税前扣除管理办法', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('28', '修改代码', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('29', '性能提升', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('34', '人', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('35', '犯规', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('36', '旅游什么的', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('37', '旅游什么的', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('38', '资本主义垮台', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('39', '意外', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('40', '是的', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('41', '星期一', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('42', '什么意思啊', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('43', '中文文章', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('44', 'take1', null, null, '003_01', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('45', '发布资讯', null, null, '003_02', '500', '500', null, null);
INSERT INTO `subjects` VALUES ('46', '还在', null, null, '003_01', '500', '500', null, null);
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
INSERT INTO `sys_dictionary` VALUES ('36', '003', '003_02', '企业管理', null, null, null, null, '1', '企业管理相关的课程');
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
INSERT INTO `sys_dictionary` VALUES ('56', '010', '010_02', '财务从业人员', null, null, null, null, '1', '财务从业人员');
INSERT INTO `sys_dictionary` VALUES ('57', '010', '010_03', '秘书', null, null, null, null, '1', '');
INSERT INTO `sys_dictionary` VALUES ('58', '007', '007_04', '成都', null, null, null, null, '1', '成都');
INSERT INTO `sys_dictionary` VALUES ('59', '998', '011', '产品', null, null, null, null, '1', '产品类别');
INSERT INTO `sys_dictionary` VALUES ('60', '011', '011_01', '软件产品', null, null, null, null, '1', '软件产品');
INSERT INTO `sys_dictionary` VALUES ('61', '011', '011_02', '日用品', null, null, null, null, '1', '日用品');
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
