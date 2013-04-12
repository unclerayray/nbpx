/*
MySQL Data Transfer
Source Host: localhost
Source Database: nbpx
Target Host: localhost
Target Database: nbpx
Date: 2013-4-8 21:48:38
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for answers
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `answerID` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `answerby` int(11) default NULL COMMENT '回答用户ID',
  `answerDate` date default NULL COMMENT '回答时间',
  `isBest` tinyint(1) default '0' COMMENT '是否最佳答案',
  `content` tinyint(4) default NULL COMMENT '回答内容',
  PRIMARY KEY  (`answerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for application
-- ----------------------------
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application` (
  `applyID` int(11) NOT NULL auto_increment COMMENT '报名表主键ID',
  `applicant` int(11) default NULL COMMENT '申请人ID',
  `applicatCompId` int(11) default NULL COMMENT '申请企业的ID，如非注册用户，可为空',
  `applicantCompany` varchar(20) default '' COMMENT '申请企业名（如无单位可为空）',
  `applyCourse` int(11) default NULL COMMENT '申请课程ID',
  `headcount` int(11) default '1' COMMENT '参加人数',
  `contact` varchar(20) default '' COMMENT '联系人',
  `cellphone` int(20) default NULL,
  `telephone` int(20) default NULL,
  `email` varchar(20) default NULL,
  `fax` int(20) default NULL,
  `department` varchar(40) default NULL,
  `remarks` varchar(256) default '备注',
  `state` varchar(11) default NULL COMMENT '报名状态',
  `stateInfo` varchar(200) default NULL COMMENT '跟进情况',
  PRIMARY KEY  (`applyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程申请表';

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `articleID` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `content` mediumtext COMMENT '文章内容',
  `author` varchar(20) default NULL COMMENT '文章作者',
  `creation_date` date default NULL COMMENT '创建时间',
  `categoryID` int(11) default NULL COMMENT '文章类别',
  `hits` int(11) default '200' COMMENT '点击数',
  PRIMARY KEY  (`articleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章与新闻表; InnoDB free: 1050624 kB';

-- ----------------------------
-- Table structure for companyinfo
-- ----------------------------
DROP TABLE IF EXISTS `companyinfo`;
CREATE TABLE `companyinfo` (
  `compinfoID` int(11) NOT NULL auto_increment COMMENT '键主ID',
  `userId` int(11) NOT NULL COMMENT '对应users表中的主键ID',
  `contact` varchar(20) default NULL COMMENT '联系人',
  `city` varchar(20) default NULL COMMENT '所在城市',
  `company` varchar(20) default NULL COMMENT '企业名称',
  `telephone` int(16) default NULL COMMENT '固定电话',
  `cellphone` int(16) default NULL COMMENT '移动电话',
  `fax` int(16) default NULL,
  `department` varchar(20) default '' COMMENT '职任部门',
  PRIMARY KEY  (`compinfoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业信息表';

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `courseID` int(11) NOT NULL auto_increment COMMENT '课程表主键ID',
  `courceCity` int(11) default NULL COMMENT '课程城市',
  `teacherID` int(11) default NULL,
  `teacherName` varchar(20) default '',
  `startDate` date default NULL COMMENT '课程开始时间',
  `endDate` date default NULL COMMENT '课程结束时间',
  `category` int(11) default NULL COMMENT '课程类别',
  `isCource` tinyint(1) default '1' COMMENT '是否为普通公开课程',
  `isInner` tinyint(1) default '0' COMMENT '是否为内训课程',
  `content` mediumtext COMMENT '课程内容',
  `blockedContent` tinytext COMMENT '屏蔽内容',
  `hits` int(11) default '200' COMMENT '点击数',
  `created_by` int(11) default NULL,
  `creation_date` date default NULL,
  `last_updated_by` int(11) default NULL,
  `last_update_date` date default NULL,
  PRIMARY KEY  (`courseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程表';

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `dicID` int(11) NOT NULL,
  `dicCode` int(11) default NULL,
  `dicName` varchar(20) default NULL,
  `dicDisc` varchar(30) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Table structure for keywords
-- ----------------------------
DROP TABLE IF EXISTS `keywords`;
CREATE TABLE `keywords` (
  `keyID` int(11) NOT NULL,
  `keyword` varchar(10) default '' COMMENT '键词关',
  `flag` tinyint(1) default '0' COMMENT '是否有效',
  `type` int(11) default NULL COMMENT '关键词类别',
  PRIMARY KEY  (`keyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `logID` int(11) NOT NULL auto_increment COMMENT 'log表主键',
  `logContents` varchar(80) default '' COMMENT 'log内容',
  `logDate` date default NULL COMMENT 'log时间',
  `logedBy` int(11) default NULL COMMENT 'log产生人',
  PRIMARY KEY  (`logID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orginfo
-- ----------------------------
DROP TABLE IF EXISTS `orginfo`;
CREATE TABLE `orginfo` (
  `orgId` int(11) NOT NULL auto_increment COMMENT '键主ID',
  `userID` int(11) NOT NULL COMMENT '对应users表中的主键ID',
  `orgName` varchar(20) default NULL COMMENT '机构名称',
  `address` varchar(50) default NULL COMMENT '地址',
  `postcode` int(6) default NULL COMMENT '邮编',
  `contact` varchar(8) default NULL COMMENT '联系人',
  `cellphone` int(18) default NULL COMMENT '移动电话',
  `telephone` int(18) default NULL COMMENT '联系电话',
  `fax` int(18) default NULL COMMENT '真传',
  `city` varchar(20) default '' COMMENT '在城市所',
  `website` varchar(30) default '' COMMENT '址网',
  `category` varchar(30) default '' COMMENT '培训类别（多选）',
  `introduction` varchar(300) default '' COMMENT '简介',
  PRIMARY KEY  (`orgId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构信息表; InnoDB free: 1050624 kB';

-- ----------------------------
-- Table structure for questions
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `quesID` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `title` varchar(50) default '' COMMENT '标题',
  `content` tinytext COMMENT '内容',
  `isclosed` tinyint(1) default '0' COMMENT '关闭标志',
  `askDate` date default NULL COMMENT '提问时间',
  `askBy` varchar(11) default '' COMMENT '提问人',
  PRIMARY KEY  (`quesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for requirements
-- ----------------------------
DROP TABLE IF EXISTS `requirements`;
CREATE TABLE `requirements` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '需求主键ID',
  `userId` int(11) NOT NULL COMMENT '用户ID，可为空',
  `requiredCource` varchar(20) collate utf8_bin NOT NULL default '' COMMENT '需要的课程名称',
  `headcount` int(11) default NULL COMMENT '预计参加人数',
  `validDays` int(3) default NULL COMMENT '有效天数',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `city` varchar(20) collate utf8_bin NOT NULL default '' COMMENT '所在城市',
  `contact` varchar(20) collate utf8_bin NOT NULL default '' COMMENT '联系人',
  `telephone` int(18) default NULL,
  `cellphone` int(18) default NULL,
  `compName` varchar(30) collate utf8_bin NOT NULL default '' COMMENT '所在公司',
  `description` tinytext collate utf8_bin NOT NULL COMMENT '求需描述',
  `reply` tinytext collate utf8_bin COMMENT '回复',
  `isreplied` tinyint(1) unsigned NOT NULL default '0' COMMENT '回复标志',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for statistics
-- ----------------------------
DROP TABLE IF EXISTS `statistics`;
CREATE TABLE `statistics` (
  `statisticsID` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `type` varchar(11) NOT NULL default '' COMMENT '统计类别',
  `order` int(11) default NULL COMMENT '顺序',
  `year` int(4) default NULL COMMENT '统计年份',
  `month` int(2) default NULL COMMENT '统计月份',
  `statdate` date default NULL COMMENT '统计日期',
  `keyword` int(11) default NULL COMMENT '关键词',
  PRIMARY KEY  (`statisticsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionary`;
CREATE TABLE `sys_dictionary` (
  `dicId` int(11) NOT NULL COMMENT '字典项ID',
  `dicType` char(3) default NULL COMMENT '类型',
  `codeName` varchar(20) default NULL COMMENT '代码名称',
  `showName` varchar(100) default NULL COMMENT '显示名称',
  `orderNum` int(11) default NULL COMMENT '排列顺序',
  `attribute1` varchar(20) default NULL COMMENT '备用1',
  `attribute2` varchar(20) default NULL COMMENT '备用2',
  `attribute3` varchar(20) default NULL COMMENT '备用3',
  `flag` int(11) default NULL COMMENT '有效标识',
  `discription` varchar(100) default NULL COMMENT '字典描述',
  PRIMARY KEY  (`dicId`)
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
-- Table structure for teacherinfo
-- ----------------------------
DROP TABLE IF EXISTS `teacherinfo`;
CREATE TABLE `teacherinfo` (
  `teacherID` int(11) NOT NULL COMMENT '主键ID',
  `userID` int(11) NOT NULL COMMENT '用户名',
  `realName` varchar(20) default '' COMMENT '真实姓名',
  `birthday` date default NULL COMMENT '出生日期',
  `city` varchar(20) default '' COMMENT '工作所在城市',
  `major_catgory` varchar(11) default '' COMMENT '主讲类别',
  `external_payment` double default NULL COMMENT '对外课酬',
  `internal_payment` double default NULL COMMENT '协议课酬',
  `fax` int(16) default NULL COMMENT '传真',
  `telephone` varchar(20) default '' COMMENT '座机',
  `cellphone` varchar(20) default '' COMMENT '移动电话',
  `introduction` tinytext COMMENT '个人简介',
  `expert_in` tinytext COMMENT '擅长项目',
  PRIMARY KEY  (`teacherID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='讲师信息表';

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` int(11) NOT NULL COMMENT '用户密码',
  `email` varchar(20) NOT NULL COMMENT '邮箱',
  `userType` int(1) NOT NULL COMMENT '用户类别，1为企业用户，2为讲师，3为机构',
  PRIMARY KEY  (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records 
-- ----------------------------
