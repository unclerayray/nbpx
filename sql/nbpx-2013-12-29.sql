/*
MySQL Data Transfer
Source Host: localhost
Source Database: nbpx
Target Host: localhost
Target Database: nbpx
Date: 2013/12/29 14:21:43
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
  `isInner` tinyint(1) unsigned zerofill default '0' COMMENT '是否为内训课程',
  `price` double(10,0) unsigned zerofill default NULL,
  `content` mediumtext COMMENT '课程内容',
  `blockedContent` mediumtext COMMENT '屏蔽内容',
  `hasVideo` tinyint(1) default '0' COMMENT '视频地址',
  `hits` int(11) unsigned zerofill default '00000000200' COMMENT '点击数',
  `createdBy` varchar(20) default NULL,
  `creationDate` datetime default NULL,
  `lastUpdatedBy` varchar(20) default NULL,
  `lastUpdateDate` datetime default NULL,
  `recommanded` tinyint(1) unsigned zerofill default '0' COMMENT '是否推荐',
  `state` tinyint(1) default '0' COMMENT '审核标志（1为通过，0为未审核通过）',
  `classic` tinyint(1) unsigned zerofill default '0' COMMENT '是否经典',
  `links` varchar(100) default NULL,
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
-- Table structure for downloadkeywords
-- ----------------------------
DROP TABLE IF EXISTS `downloadkeywords`;
CREATE TABLE `downloadkeywords` (
  `downloadkeywordId` int(11) NOT NULL auto_increment,
  `keywordId` int(11) NOT NULL default '0' COMMENT '对应keywords表中的ID',
  `downloadId` int(11) NOT NULL COMMENT '下载ID',
  `keyword` varchar(100) default '' COMMENT '关键字',
  PRIMARY KEY  (`downloadkeywordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='下载关键词表';

-- ----------------------------
-- Table structure for downloads
-- ----------------------------
DROP TABLE IF EXISTS `downloads`;
CREATE TABLE `downloads` (
  `downloadId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `filepath` varchar(100) NOT NULL COMMENT '存放路径（直接带文件名）',
  `filetype` varchar(5) NOT NULL COMMENT '文件类型(ppt,word,pdf等)',
  `description` varchar(500) default NULL COMMENT '说明说明',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `uploadDate` datetime NOT NULL COMMENT '上传时间',
  `downloadCnt` int(11) NOT NULL default '200' COMMENT '下载次数',
  `hits` int(11) NOT NULL default '200' COMMENT '查看次数',
  `size` double default NULL COMMENT '大小',
  `category` varchar(20) default NULL,
  PRIMARY KEY  (`downloadId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for downloadsubjects
-- ----------------------------
DROP TABLE IF EXISTS `downloadsubjects`;
CREATE TABLE `downloadsubjects` (
  `downloadSubjectId` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `downloadId` int(11) default NULL COMMENT 'download表外键',
  `subjectId` varchar(20) default '' COMMENT '专题Id',
  `subject` varchar(50) default NULL COMMENT '专题',
  PRIMARY KEY  (`downloadSubjectId`)
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
  `indexed` tinyint(1) unsigned zerofill default '0' COMMENT '是否已经在solr索引',
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
  `userId` int(11) default NULL COMMENT '用户ID，可为空',
  `requiredCourse` varchar(20) collate utf8_bin default NULL COMMENT '需要的课程名称',
  `headCount` int(11) default NULL COMMENT '预计参加人数',
  `validDays` int(3) default NULL COMMENT '有效天数',
  `startTime` date default NULL COMMENT '开始时间',
  `endTime` date default NULL COMMENT '结束时间',
  `city` varchar(20) collate utf8_bin default NULL COMMENT '所在城市',
  `contact` varchar(20) collate utf8_bin default NULL COMMENT '联系人',
  `telephone` int(18) default NULL,
  `cellphone` int(18) default NULL,
  `comp_name` varchar(30) collate utf8_bin default NULL COMMENT '所在公司',
  `description` varchar(500) collate utf8_bin default NULL COMMENT '求需描述',
  `reply` varchar(500) collate utf8_bin default NULL COMMENT '回复',
  `hasReplied` tinyint(1) unsigned default '0' COMMENT '回复标志',
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
  `indexed` tinyint(1) unsigned zerofill default '0',
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
  `username` varchar(20) default NULL COMMENT '用户名',
  `password` varchar(20) default NULL COMMENT '用户密码',
  `city` varchar(11) default NULL COMMENT '所在城市',
  `email` varchar(20) default NULL COMMENT '邮箱',
  `userType` varchar(20) NOT NULL COMMENT '用户类别',
  `state` tinyint(1) NOT NULL default '0' COMMENT '激活状态',
  `registerDate` date NOT NULL COMMENT '注册日期',
  PRIMARY KEY  (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Procedure structure for prc_add_teachers
-- ----------------------------
DROP PROCEDURE IF EXISTS `prc_add_teachers`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_add_teachers`(IN amount int(10))
BEGIN
    DECLARE x   INT;
    SET x = 1;

    REPEAT
      INSERT INTO
        teacher_info(
          realName
         ,birthday
         ,majorCatgory
         ,externalPayment
         ,internalPayment
         ,fax
         ,telephone
         ,cellphone
         ,introduction
         ,expertIn)
      VALUES
        (
          CONCAT('讲师',x) -- realName - IN varchar(20)
         ,sysdate()
         ,'企业培训' -- majorCatgory - IN varchar(11)
         ,1222 -- externalPayment - IN double
         ,3444 -- internalPayment - IN double
         ,'23423423' -- fax - IN varchar(16)
         ,'10086' -- telephone - IN varchar(16)
         ,'13800138000' -- cellphone - IN varchar(16)
         ,'我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不' -- introduction - IN text
         ,'企业培训' -- expertIn - IN text
            );
    UNTIL x > amount
    END REPEAT;
  END;;
DELIMITER ;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `answers` VALUES ('1', 'John', '2013-11-18', '0', 'I don\'t know man, you tell me单反的', '1');
INSERT INTO `answers` VALUES ('2', 'Thomas', '2013-11-12', '1', 'oh good one  呵呵', '1');
INSERT INTO `answers` VALUES ('3', '雷理超', '2013-11-11', '1', '撒旦法个豆腐干的', '2');
INSERT INTO `answers` VALUES ('4', '沃尔', null, null, '炯强', null);
INSERT INTO `answers` VALUES ('5', '沃尔', null, null, '凤飞飞', null);
INSERT INTO `answers` VALUES ('6', 'Mery', '2013-11-19', '0', 'yeah. totally agree.  No , I don\'t think so', '1');
INSERT INTO `answers` VALUES ('7', 'John', '2013-11-19', '0', '是的飞洒的发', '2');
INSERT INTO `answers` VALUES ('9', 'Mery', '2013-11-19', '1', '撒旦法', '8');
INSERT INTO `answers` VALUES ('10', '撒旦法', '2013-11-19', null, '是大方', '8');
INSERT INTO `answers` VALUES ('11', 'John', '2013-11-20', null, '恶搞提高 hyhj6u', '11');
INSERT INTO `applications` VALUES ('1', '1', '科技公司', '10001', '123', '胡平凡', '1380013800', '85583222', '23@yd.com', '12342111', '开发部', '很多人要参加的', '1', '好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会安排的好的 会', '2013-11-13 16:01:23');
INSERT INTO `applications` VALUES ('2', '8', '开发公司', '10018', '10', '杨总', '10086', '10100', '12306@qq.com', '123123', '领导', '十个人参加', '1', 'hao d', '2013-12-09 14:16:16');
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
INSERT INTO `articlekeywords` VALUES ('116', '309', '10014', '提前完成');
INSERT INTO `articlekeywords` VALUES ('117', '308', '10014', '我要');
INSERT INTO `articlekeywords` VALUES ('143', '270', '10011', '科比咯');
INSERT INTO `articlekeywords` VALUES ('149', '310', '10013', '还在');
INSERT INTO `articlekeywords` VALUES ('150', '270', '10013', '科比咯');
INSERT INTO `articlekeywords` VALUES ('151', '283', '10015', '测试');
INSERT INTO `articlekeywords` VALUES ('152', '282', '10015', '插入');
INSERT INTO `articlekeywords` VALUES ('153', '281', '10015', '文章');
INSERT INTO `articlekeywords` VALUES ('168', '258', '10010', '犯规');
INSERT INTO `articlekeywords` VALUES ('169', '256', '10010', '打手');
INSERT INTO `articlekeywords` VALUES ('170', '257', '10010', '个人');
INSERT INTO `articlekeywords` VALUES ('171', '307', '10016', '天气预报');
INSERT INTO `articlekeywords` VALUES ('172', '306', '10016', '企业培训');
INSERT INTO `articlekeywords` VALUES ('173', '297', '10016', '世界');
INSERT INTO `articlekeywords` VALUES ('174', '298', '10016', '如此美妙');
INSERT INTO `articlekeywords` VALUES ('175', '324', '10017', '形势');
INSERT INTO `articlekeywords` VALUES ('176', '325', '10017', '贸易');
INSERT INTO `articlekeywords` VALUES ('177', '322', '10017', '世纪');
INSERT INTO `articlekeywords` VALUES ('178', '323', '10017', '21');
INSERT INTO `articles` VALUES ('10008', '石家庄晴转多云，天气很好', '<p><span style=\"background-color:rgb(255, 255, 255); color:rgb(0, 0, 0); font-family:georgia,times new roman,times,serif; font-size:15px\"><strong>10月8日，维克托・科瓦茨<a href=\"http://www.baidu.com\" target=\"_blank\">试飞</a>的最后一跃。当天下午，正在张家界参加第二届世界翼装飞行世锦赛的匈牙利选手维克托・科瓦茨在<a href=\"http://www.baidu.com\" target=\"_blank\">试飞</a>过程中不幸坠落悬崖，张家界当即dsf<br />\r\n<br />\r\n组织了近200名公安、武警、消防官兵等搜救人员进行全力搜救。经过近24个小时的连续搜救，于9日清晨8时57分，在峡谷中找到了维克多，并已确认遇难身亡。</strong></span><span style=\"background-color:rgb(255, 255, 255); color:rgb(0, 0, 0); font-family:georgia,times new roman,times,serif; font-size:15px\"> </span></p>\r\n', '普京', '2013-10-13 00:00:00', '2013-10-21 22:58:08', '003_02', '500', '1', '1');
INSERT INTO `articles` VALUES ('10009', '个人打手犯规的是', '<p>是个</p>\r\n', '奥巴马', '2013-10-13 00:00:00', '2013-10-13 00:00:00', '003_02', '500', '1', null);
INSERT INTO `articles` VALUES ('10010', '个人打手犯规的是没有', '<p>是个风格化I love to stay</p>\r\n\r\n<p>sdfsdf</p>\r\n\r\n<p>hgergergerg</p>\r\n\r\n<p>sgewgwgwertwer市发改委人格人格若干天5个恶搞</p>\r\n', '奥巴马', '2013-10-13 00:00:00', '2013-11-27 21:13:36', '003_02', '500', '1', null);
INSERT INTO `articles` VALUES ('10011', '科比布莱恩特', '<p>科比的狗还在等他传球首飞是sdfsdf</p>\r\n', 'Jim Buss', '2013-10-13 00:00:00', '2013-11-07 22:17:44', '003_01', '500', '1', null);
INSERT INTO `articles` VALUES ('10013', '科比布莱恩特的3', '<p>科比的狗<a href=\"http://www.baidu.com\" target=\"_blank\">还在</a>等他传球ffffgrege rgerg er g</p>\r\n', 'Jim Buss', '2013-10-13 00:00:00', '2013-11-26 21:34:42', '003_01', '500', '1', null);
INSERT INTO `articles` VALUES ('10014', '我要提前完成', '<p>随笔&nbsp;&nbsp;</p>\r\n\r\n<p>自己写</p>\r\n', '雷理超', '2013-10-17 19:34:57', '2013-10-21 23:37:59', '003_01', '500', '1', null);
INSERT INTO `articles` VALUES ('10015', '文章插入测试1', '<p>演示 关键词<a href=\"http://www.baidu.com\" target=\"_blank\">插入</a>&nbsp;&nbsp;&nbsp; <a href=\"http://www.baidu.com\" target=\"_blank\">文章</a>&nbsp;&nbsp; 第一次<a href=\"http://www.baidu.com\" target=\"_blank\">测试</a></p>\r\n\r\n<p>heng?gergergergreg</p>\r\n', '雷理超', '2013-10-17 19:36:19', '2013-11-26 21:34:52', '003_01', '500', '1', null);
INSERT INTO `articles` VALUES ('10016', '这世界如此美妙，天气预报，企业培训', '<p><a href=\"http://www.baidu.com\" target=\"_blank\">文章</a>新建，<a href=\"http://www.baidu.com\" target=\"_blank\">测试</a>第二次，<a href=\"http://www.baidu.com\" target=\"_blank\">发布</a>资讯，<a href=\"http://www.baidu.com\" target=\"_blank\">手写</a>关键词&nbsp;&nbsp; sdfsdf</p>\r\n', '雷理超', '2013-10-17 19:44:01', '2013-11-27 21:26:54', '003_02', '500', '1', null);
INSERT INTO `articles` VALUES ('10017', '21世纪的贸易形势', '<p>很好</p>\r\n', '谁', '2013-11-30 11:24:51', '2013-11-30 11:24:51', '003_02', '500', '1', null);
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
INSERT INTO `articlesubjects` VALUES ('62', '10014', '43', '中文文章');
INSERT INTO `articlesubjects` VALUES ('78', '10011', '40', '是的');
INSERT INTO `articlesubjects` VALUES ('82', '10013', '40', '是的');
INSERT INTO `articlesubjects` VALUES ('83', '10013', '46', '还在');
INSERT INTO `articlesubjects` VALUES ('84', '10015', '44', 'take1');
INSERT INTO `articlesubjects` VALUES ('89', '10010', '37', '旅游什么的');
INSERT INTO `articlesubjects` VALUES ('90', '10016', '53', '发布资讯1');
INSERT INTO `articlesubjects` VALUES ('91', '10017', '56', '很好');
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
INSERT INTO `courseindustry` VALUES ('51', '10009', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('57', '10026', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('72', '10036', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('73', '10036', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('98', '10018', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('99', '10018', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('102', '10033', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('103', '10010', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('104', '10035', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('105', '10040', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('172', '10046', '008_4', '普通');
INSERT INTO `courseindustry` VALUES ('173', '10046', '008_3', '信息系统');
INSERT INTO `courseindustry` VALUES ('174', '10046', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('187', '10001', '008_02', '通信行业');
INSERT INTO `courseindustry` VALUES ('188', '10001', '008_01', '发电行业');
INSERT INTO `courseindustry` VALUES ('189', '10061', '008_5', '我的');
INSERT INTO `courseinfo` VALUES ('9', '20', '2013-11-16', '2013-11-25', '007_01');
INSERT INTO `courseinfo` VALUES ('10', '33', '2013-11-02', '2013-11-10', '007_04');
INSERT INTO `courseinfo` VALUES ('11', '33', '2013-11-25', '2013-11-26', '007_01');
INSERT INTO `courseinfo` VALUES ('12', '18', '2013-11-10', '2013-11-19', '007_02');
INSERT INTO `courseinfo` VALUES ('13', '10010', '2013-12-05', '2013-12-06', '007_03');
INSERT INTO `courseinfo` VALUES ('16', '10019', '2013-11-30', '2013-12-21', '007_03');
INSERT INTO `courseinfo` VALUES ('17', '10019', '2013-11-30', '2013-12-21', '007_03');
INSERT INTO `courseinfo` VALUES ('19', '10025', '2013-12-06', '2013-12-23', '007_02');
INSERT INTO `courseinfo` VALUES ('22', '10017', '2013-12-06', '2013-12-22', '007_03');
INSERT INTO `courseinfo` VALUES ('25', '10016', '2013-12-01', '2013-12-09', '007_03');
INSERT INTO `courseinfo` VALUES ('27', '10013', '2013-12-01', '2013-12-22', '007_04');
INSERT INTO `courseinfo` VALUES ('30', '10034', '2013-12-07', '2013-12-15', '007_03');
INSERT INTO `courseinfo` VALUES ('31', '10034', '2013-12-07', '2013-12-22', '007_04');
INSERT INTO `courseinfo` VALUES ('32', '10014', '2013-12-06', '2013-12-23', '007_02');
INSERT INTO `courseinfo` VALUES ('35', '10001', '2013-12-06', '2013-12-06', '007_03');
INSERT INTO `courseinfo` VALUES ('36', '10001', '2013-11-30', '2013-12-07', '007_02');
INSERT INTO `courseinfo` VALUES ('37', '10018', '2013-12-29', '2014-01-05', '007_03');
INSERT INTO `courseinfo` VALUES ('38', '10018', '2014-01-07', '2014-01-07', '007_04');
INSERT INTO `courseinfo` VALUES ('39', '10018', '2013-12-28', '2013-12-30', '007_01');
INSERT INTO `courseinfo` VALUES ('40', '10035', '2014-01-05', '2013-12-30', '007_02');
INSERT INTO `courseinfo` VALUES ('41', '10035', '2014-01-05', '2014-01-07', '007_03');
INSERT INTO `courseinfo` VALUES ('42', '10018', '2014-01-25', '2014-02-03', '007_02');
INSERT INTO `courseinfo` VALUES ('43', '10036', '2014-01-06', '2014-01-07', '007_02');
INSERT INTO `courseinfo` VALUES ('44', '10037', '2014-03-19', '2014-02-28', '007_03');
INSERT INTO `courseinfo` VALUES ('45', '10037', '2014-03-12', '2014-02-24', '007_02');
INSERT INTO `courseinfo` VALUES ('46', '10037', '2014-03-14', '2014-03-06', '007_03');
INSERT INTO `courseinfo` VALUES ('47', '10037', '2014-03-14', '2014-03-06', '007_03');
INSERT INTO `courseinfo` VALUES ('48', '10012', '2013-12-05', '2013-12-06', '007_03');
INSERT INTO `courseinfo` VALUES ('54', '10059', '2013-12-03', '2013-12-18', '007_03');
INSERT INTO `courseinfo` VALUES ('55', '10059', '2013-12-19', '2013-12-20', '007_05');
INSERT INTO `courseinfo` VALUES ('56', '10059', '2013-12-04', '2013-12-19', '007_04');
INSERT INTO `courseinfo` VALUES ('57', '10059', '2013-12-10', '2013-12-13', '007_06');
INSERT INTO `courseinfo` VALUES ('74', '10064', '2013-12-09', '2013-12-24', '007_04');
INSERT INTO `courseinfo` VALUES ('75', '10065', '2013-12-24', '2013-12-27', '007_03');
INSERT INTO `courseinfo` VALUES ('76', '10067', '2013-12-04', '2013-12-10', '007_03');
INSERT INTO `courseinfo` VALUES ('77', '10061', '2013-12-26', '2013-12-27', '007_05');
INSERT INTO `courseinfo` VALUES ('78', '10061', '2013-12-04', '2013-12-06', '007_04');
INSERT INTO `courseinfo` VALUES ('79', '10061', '2013-12-17', '2013-12-18', '007_01');
INSERT INTO `courseinfo` VALUES ('80', '10071', '2013-12-09', '2014-01-01', '007_05');
INSERT INTO `courseinfo` VALUES ('81', '10032', '2013-12-10', '2013-12-18', '007_05');
INSERT INTO `courseinfo` VALUES ('82', '10077', '2013-12-24', '2013-12-24', '007_02');
INSERT INTO `courseinfo` VALUES ('83', '10077', '2013-12-18', '2013-12-27', '007_03');
INSERT INTO `courseinfo` VALUES ('84', '10078', '2013-12-27', '2013-12-22', '007_03');
INSERT INTO `courseinfo` VALUES ('87', '10080', '2013-12-24', '2013-12-31', '007_02');
INSERT INTO `courseinfo` VALUES ('88', '10080', '2013-12-31', '2014-01-01', '007_03');
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
INSERT INTO `coursekeywords` VALUES ('555', '235', '10009', '中华');
INSERT INTO `coursekeywords` VALUES ('556', '234', '10009', '建设');
INSERT INTO `coursekeywords` VALUES ('557', '233', '10009', '国家');
INSERT INTO `coursekeywords` VALUES ('558', '123', '10009', '我们');
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
INSERT INTO `coursekeywords` VALUES ('821', '311', '10022', '培训');
INSERT INTO `coursekeywords` VALUES ('822', '313', '10022', '课程');
INSERT INTO `coursekeywords` VALUES ('823', '312', '10022', '项目');
INSERT INTO `coursekeywords` VALUES ('850', '200', '10018', '技巧');
INSERT INTO `coursekeywords` VALUES ('851', '197', '10018', '提升');
INSERT INTO `coursekeywords` VALUES ('852', '196', '10018', '投诉');
INSERT INTO `coursekeywords` VALUES ('853', '199', '10018', '服务');
INSERT INTO `coursekeywords` VALUES ('854', '198', '10018', '优质');
INSERT INTO `coursekeywords` VALUES ('855', '193', '10018', '客户');
INSERT INTO `coursekeywords` VALUES ('860', '221', '10033', '领导力');
INSERT INTO `coursekeywords` VALUES ('861', '222', '10033', '高效');
INSERT INTO `coursekeywords` VALUES ('863', '87', '10037', '抱怨');
INSERT INTO `coursekeywords` VALUES ('864', '86', '10037', '客户');
INSERT INTO `coursekeywords` VALUES ('865', '93', '10037', '技巧');
INSERT INTO `coursekeywords` VALUES ('866', '92', '10037', '服务');
INSERT INTO `coursekeywords` VALUES ('867', '89', '10037', '投诉');
INSERT INTO `coursekeywords` VALUES ('868', '88', '10037', '处理');
INSERT INTO `coursekeywords` VALUES ('869', '91', '10037', '优质');
INSERT INTO `coursekeywords` VALUES ('870', '90', '10037', '提升');
INSERT INTO `coursekeywords` VALUES ('871', '239', '10010', '最新');
INSERT INTO `coursekeywords` VALUES ('872', '238', '10010', '及其');
INSERT INTO `coursekeywords` VALUES ('873', '237', '10010', '税收优惠政策');
INSERT INTO `coursekeywords` VALUES ('874', '236', '10010', '纳税');
INSERT INTO `coursekeywords` VALUES ('875', '201', '10010', '筹划');
INSERT INTO `coursekeywords` VALUES ('876', '192', '10010', '企业');
INSERT INTO `coursekeywords` VALUES ('877', '85', '10035', '管理');
INSERT INTO `coursekeywords` VALUES ('878', '244', '10035', '深圳');
INSERT INTO `coursekeywords` VALUES ('879', '245', '10035', '电子');
INSERT INTO `coursekeywords` VALUES ('880', '242', '10035', '标杆');
INSERT INTO `coursekeywords` VALUES ('881', '243', '10035', '创新');
INSERT INTO `coursekeywords` VALUES ('882', '240', '10035', '之旅');
INSERT INTO `coursekeywords` VALUES ('883', '241', '10035', '学习');
INSERT INTO `coursekeywords` VALUES ('885', '124', '10028', '风格');
INSERT INTO `coursekeywords` VALUES ('892', '315', '10038', '精细');
INSERT INTO `coursekeywords` VALUES ('893', '314', '10038', '实战');
INSERT INTO `coursekeywords` VALUES ('894', '317', '10038', '门店');
INSERT INTO `coursekeywords` VALUES ('895', '316', '10038', '经营型');
INSERT INTO `coursekeywords` VALUES ('896', '319', '10038', '毛利');
INSERT INTO `coursekeywords` VALUES ('897', '318', '10038', '管理');
INSERT INTO `coursekeywords` VALUES ('898', '315', '10039', '精细');
INSERT INTO `coursekeywords` VALUES ('899', '314', '10039', '实战');
INSERT INTO `coursekeywords` VALUES ('900', '317', '10039', '门店');
INSERT INTO `coursekeywords` VALUES ('901', '316', '10039', '经营型');
INSERT INTO `coursekeywords` VALUES ('902', '319', '10039', '毛利');
INSERT INTO `coursekeywords` VALUES ('903', '318', '10039', '管理');
INSERT INTO `coursekeywords` VALUES ('904', '85', '10040', '管理');
INSERT INTO `coursekeywords` VALUES ('905', '320', '10040', '打造');
INSERT INTO `coursekeywords` VALUES ('906', '321', '10040', '金牌');
INSERT INTO `coursekeywords` VALUES ('911', '326', '10041', '人力资源');
INSERT INTO `coursekeywords` VALUES ('912', '85', '10041', '管理');
INSERT INTO `coursekeywords` VALUES ('913', '327', '10041', '战略');
INSERT INTO `coursekeywords` VALUES ('914', '328', '10041', '家族企业');
INSERT INTO `coursekeywords` VALUES ('915', '205', '10012', '优化');
INSERT INTO `coursekeywords` VALUES ('916', '204', '10012', '供应商');
INSERT INTO `coursekeywords` VALUES ('917', '207', '10012', '管理');
INSERT INTO `coursekeywords` VALUES ('918', '206', '10012', '流程');
INSERT INTO `coursekeywords` VALUES ('919', '203', '10012', '采购');
INSERT INTO `coursekeywords` VALUES ('920', '202', '10012', '评估');
INSERT INTO `coursekeywords` VALUES ('1037', '342', '10046', '浏览器');
INSERT INTO `coursekeywords` VALUES ('1038', '341', '10046', '是否');
INSERT INTO `coursekeywords` VALUES ('1039', '340', '10046', '你的');
INSERT INTO `coursekeywords` VALUES ('1040', '339', '10046', '缓存');
INSERT INTO `coursekeywords` VALUES ('1041', '343', '10047', '心情');
INSERT INTO `coursekeywords` VALUES ('1042', '345', '10047', '今天');
INSERT INTO `coursekeywords` VALUES ('1043', '344', '10047', '很不');
INSERT INTO `coursekeywords` VALUES ('1044', '349', '10048', '怎样');
INSERT INTO `coursekeywords` VALUES ('1045', '348', '10048', '今天');
INSERT INTO `coursekeywords` VALUES ('1046', '347', '10048', '很不');
INSERT INTO `coursekeywords` VALUES ('1047', '346', '10048', '心情');
INSERT INTO `coursekeywords` VALUES ('1048', '352', '10049', '反应');
INSERT INTO `coursekeywords` VALUES ('1049', '353', '10049', '一个');
INSERT INTO `coursekeywords` VALUES ('1050', '351', '10049', '新增');
INSERT INTO `coursekeywords` VALUES ('1051', '350', '10049', '后没');
INSERT INTO `coursekeywords` VALUES ('1052', '356', '10050', '公开');
INSERT INTO `coursekeywords` VALUES ('1053', '354', '10050', '新建');
INSERT INTO `coursekeywords` VALUES ('1054', '355', '10050', '测试');
INSERT INTO `coursekeywords` VALUES ('1055', '357', '10051', '新建');
INSERT INTO `coursekeywords` VALUES ('1056', '358', '10051', '测试');
INSERT INTO `coursekeywords` VALUES ('1057', '359', '10051', '公开');
INSERT INTO `coursekeywords` VALUES ('1058', '342', '10052', '浏览器');
INSERT INTO `coursekeywords` VALUES ('1059', '341', '10052', '是否');
INSERT INTO `coursekeywords` VALUES ('1060', '340', '10052', '你的');
INSERT INTO `coursekeywords` VALUES ('1061', '339', '10052', '缓存');
INSERT INTO `coursekeywords` VALUES ('1062', '342', '10056', '浏览器');
INSERT INTO `coursekeywords` VALUES ('1063', '341', '10056', '是否');
INSERT INTO `coursekeywords` VALUES ('1064', '340', '10056', '你的');
INSERT INTO `coursekeywords` VALUES ('1065', '339', '10056', '缓存');
INSERT INTO `coursekeywords` VALUES ('1066', '342', '10057', '浏览器');
INSERT INTO `coursekeywords` VALUES ('1067', '341', '10057', '是否');
INSERT INTO `coursekeywords` VALUES ('1068', '340', '10057', '你的');
INSERT INTO `coursekeywords` VALUES ('1069', '339', '10057', '缓存');
INSERT INTO `coursekeywords` VALUES ('1070', '364', '10058', '公开');
INSERT INTO `coursekeywords` VALUES ('1071', '283', '10058', '测试');
INSERT INTO `coursekeywords` VALUES ('1072', '363', '10058', '新建');
INSERT INTO `coursekeywords` VALUES ('1077', '342', '10060', '浏览器');
INSERT INTO `coursekeywords` VALUES ('1078', '341', '10060', '是否');
INSERT INTO `coursekeywords` VALUES ('1079', '340', '10060', '你的');
INSERT INTO `coursekeywords` VALUES ('1080', '339', '10060', '缓存');
INSERT INTO `coursekeywords` VALUES ('1201', '342', '10059', '浏览器');
INSERT INTO `coursekeywords` VALUES ('1202', '341', '10059', '是否');
INSERT INTO `coursekeywords` VALUES ('1203', '340', '10059', '你的');
INSERT INTO `coursekeywords` VALUES ('1204', '339', '10059', '缓存');
INSERT INTO `coursekeywords` VALUES ('1228', '342', '10064', '浏览器');
INSERT INTO `coursekeywords` VALUES ('1229', '341', '10064', '是否');
INSERT INTO `coursekeywords` VALUES ('1230', '340', '10064', '你的');
INSERT INTO `coursekeywords` VALUES ('1231', '339', '10064', '缓存');
INSERT INTO `coursekeywords` VALUES ('1232', '367', '10064', '112121');
INSERT INTO `coursekeywords` VALUES ('1233', '369', '10065', '课程');
INSERT INTO `coursekeywords` VALUES ('1234', '368', '10065', '用的');
INSERT INTO `coursekeywords` VALUES ('1235', '283', '10065', '测试');
INSERT INTO `coursekeywords` VALUES ('1236', '220', '10001', '即使');
INSERT INTO `coursekeywords` VALUES ('1237', '217', '10001', '如果');
INSERT INTO `coursekeywords` VALUES ('1238', '218', '10001', '那么');
INSERT INTO `coursekeywords` VALUES ('1239', '219', '10001', '及时');
INSERT INTO `coursekeywords` VALUES ('1240', '77', '10001', '进行');
INSERT INTO `coursekeywords` VALUES ('1241', '373', '10066', '缓存');
INSERT INTO `coursekeywords` VALUES ('1242', '372', '10066', '你的');
INSERT INTO `coursekeywords` VALUES ('1243', '371', '10066', '是否');
INSERT INTO `coursekeywords` VALUES ('1244', '370', '10066', '浏览器');
INSERT INTO `coursekeywords` VALUES ('1245', '373', '10067', '缓存');
INSERT INTO `coursekeywords` VALUES ('1246', '372', '10067', '你的');
INSERT INTO `coursekeywords` VALUES ('1247', '371', '10067', '是否');
INSERT INTO `coursekeywords` VALUES ('1248', '370', '10067', '浏览器');
INSERT INTO `coursekeywords` VALUES ('1249', '283', '10061', '测试');
INSERT INTO `coursekeywords` VALUES ('1250', '363', '10061', '新建');
INSERT INTO `coursekeywords` VALUES ('1251', '289', '10068', '测试');
INSERT INTO `coursekeywords` VALUES ('1252', '375', '10068', '公开');
INSERT INTO `coursekeywords` VALUES ('1253', '374', '10068', '新建');
INSERT INTO `coursekeywords` VALUES ('1254', '289', '10069', '测试');
INSERT INTO `coursekeywords` VALUES ('1255', '375', '10069', '公开');
INSERT INTO `coursekeywords` VALUES ('1256', '374', '10069', '新建');
INSERT INTO `coursekeywords` VALUES ('1257', '364', '10070', '公开');
INSERT INTO `coursekeywords` VALUES ('1258', '283', '10070', '测试');
INSERT INTO `coursekeywords` VALUES ('1259', '363', '10070', '新建');
INSERT INTO `coursekeywords` VALUES ('1260', '364', '10071', '公开');
INSERT INTO `coursekeywords` VALUES ('1261', '283', '10071', '测试');
INSERT INTO `coursekeywords` VALUES ('1262', '363', '10071', '新建');
INSERT INTO `coursekeywords` VALUES ('1263', '364', '10032', '公开');
INSERT INTO `coursekeywords` VALUES ('1264', '283', '10032', '测试');
INSERT INTO `coursekeywords` VALUES ('1265', '363', '10032', '新建');
INSERT INTO `coursekeywords` VALUES ('1270', '364', '10073', '公开');
INSERT INTO `coursekeywords` VALUES ('1271', '283', '10073', '测试');
INSERT INTO `coursekeywords` VALUES ('1272', '377', '10073', '页面');
INSERT INTO `coursekeywords` VALUES ('1273', '376', '10073', '发布');
INSERT INTO `coursekeywords` VALUES ('1274', '364', '10074', '公开');
INSERT INTO `coursekeywords` VALUES ('1275', '283', '10074', '测试');
INSERT INTO `coursekeywords` VALUES ('1276', '376', '10074', '发布');
INSERT INTO `coursekeywords` VALUES ('1277', '364', '10075', '公开');
INSERT INTO `coursekeywords` VALUES ('1278', '283', '10075', '测试');
INSERT INTO `coursekeywords` VALUES ('1279', '377', '10075', '页面');
INSERT INTO `coursekeywords` VALUES ('1280', '376', '10075', '发布');
INSERT INTO `coursekeywords` VALUES ('1281', '364', '10076', '公开');
INSERT INTO `coursekeywords` VALUES ('1282', '283', '10076', '测试');
INSERT INTO `coursekeywords` VALUES ('1283', '377', '10076', '页面');
INSERT INTO `coursekeywords` VALUES ('1284', '376', '10076', '发布');
INSERT INTO `coursekeywords` VALUES ('1285', '364', '10077', '公开');
INSERT INTO `coursekeywords` VALUES ('1286', '283', '10077', '测试');
INSERT INTO `coursekeywords` VALUES ('1287', '377', '10077', '页面');
INSERT INTO `coursekeywords` VALUES ('1288', '376', '10077', '发布');
INSERT INTO `coursekeywords` VALUES ('1289', '364', '10078', '公开');
INSERT INTO `coursekeywords` VALUES ('1290', '283', '10078', '测试');
INSERT INTO `coursekeywords` VALUES ('1291', '377', '10078', '页面');
INSERT INTO `coursekeywords` VALUES ('1292', '376', '10078', '发布');
INSERT INTO `coursekeywords` VALUES ('1293', '364', '10079', '公开');
INSERT INTO `coursekeywords` VALUES ('1294', '283', '10079', '测试');
INSERT INTO `coursekeywords` VALUES ('1295', '377', '10079', '页面');
INSERT INTO `coursekeywords` VALUES ('1296', '376', '10079', '发布');
INSERT INTO `coursekeywords` VALUES ('1301', '364', '10080', '公开');
INSERT INTO `coursekeywords` VALUES ('1302', '283', '10080', '测试');
INSERT INTO `coursekeywords` VALUES ('1303', '377', '10080', '页面');
INSERT INTO `coursekeywords` VALUES ('1304', '376', '10080', '发布');
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
INSERT INTO `coursemajor` VALUES ('67', '10009', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('68', '10009', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('72', '10026', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('80', '10036', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('85', '10031', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('86', '10031', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('108', '10018', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('111', '10033', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('112', '10010', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('113', '10035', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('116', '10038', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('117', '10039', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('118', '10040', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('119', '10012', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('120', '10012', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('172', '10046', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('173', '10046', '软件工程', '009_02');
INSERT INTO `coursemajor` VALUES ('186', '10065', '我的课程专业', '009_3');
INSERT INTO `coursemajor` VALUES ('187', '10001', '电子工程', '009_01');
INSERT INTO `coursemajor` VALUES ('188', '10061', '我的课程专业', '009_3');
INSERT INTO `courseproduct` VALUES ('35', '10026', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('36', '10026', '日用品', '011_02');
INSERT INTO `courseproduct` VALUES ('44', '10036', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('47', '10031', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('60', '10018', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('61', '10010', '日用品', '011_02');
INSERT INTO `courseproduct` VALUES ('62', '10035', '日用品', '011_02');
INSERT INTO `courseproduct` VALUES ('170', '10046', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('171', '10046', '没是的麻烦', '011_224');
INSERT INTO `courseproduct` VALUES ('172', '10046', '产品1缓存', '011_223');
INSERT INTO `courseproduct` VALUES ('173', '10046', '产品2', '011_222');
INSERT INTO `courseproduct` VALUES ('182', '10001', '软件产品', '011_01');
INSERT INTO `courseproduct` VALUES ('183', '10001', '日用品', '011_02');
INSERT INTO `courses` VALUES ('10001', '怎样有效的进行企业管理', '怎样有效的', '2', '003_01', '1', '0000005000', '<p style=\"text-align:left\"><a name=\"N1006B\"><strong>简介</strong></a></p>\r\n\r\n<p style=\"text-align:left\"><a href=\"http://www.baidu.com\">如果</a>您听说过 <a href=\"http://www.baidu.com\">Node</a>，或者阅读过一些文章，宣称 Node 是多么多么的棒，<a href=\"http://www.baidu.com\">那么</a>您可能会想：&ldquo;Node 究竟是什么东西？&rdquo; 即便是在参阅 Node 的主页之后，您甚至可能<em>还是</em> 不明白 Node 为何物？Node 肯定不适合每个程序员，但它可能是某些程序员一直苦苦追寻的东西。</p>\r\n\r\n<p style=\"text-align:left\">为 试图解释什么是 Node.js，本文将简要介绍一些背景信息：它要解决的问题，它如何工作，如何运行一个简单应用程序，最后，Node 在什么情况下是一个好的解决方案。本文不涉及如何编写一个复杂的 Node 应用程序，也不是一份全面的 Node 教程。阅读本文应该有助于您决定是否应该继续学习 Node，以便将其用于您的业务。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1007B\"><strong>Node 旨在解决什么问题？</strong></a></p>\r\n\r\n<p style=\"text-align:left\">Node 公开宣称的目标是 &ldquo;旨在提供一种简单的构建可伸缩网络程序的方法&rdquo;。当前的服务器程序有什么问题？我们来做个数学题。在 Java&trade; 和 PHP 这类语言中，每个连接都会生成一个新线程，每个新线程可能需要 2 MB 的配套内存。在一个拥有 8 GB RAM 的系统上，理论上最大的并发连接数量是 4,000 个用户。随着您的客户群的增长，<a href=\"http://www.baidu.com\">如果</a>希望您的 Web 应用程序支持更多用户，<a href=\"http://www.baidu.com\">那么</a>，您必须添加更多服务器。当然，这会增加服务器成本、流量成本和人工成本等成本。除这些成本上升外，还有一个潜在技术问题，即 用户可能针对每个请求使用不同的服务器，因此，任何共享资源都必须在所有服务器之间共享。鉴于上述所有原因，整个 Web 应用程序架构（包括流量、处理器速度和内存速度）中的瓶颈是：服务器能够处理的并发连接的最大数量。<img alt=\"\" src=\"http://www.baidu.com/img/bdlogo.gif\" /></p>\r\n\r\n<p style=\"text-align:left\">Node 解决这个问题的方法是：更改连接到服务器的方式。每个连接发射一个在 Node 引擎的进程中运行的事件，而不是为每个连接生成一个新的 OS 线程（并为其分配一些配套内存）。Node 声称它绝不会死锁，因为它根本不允许使用锁，它不会直接阻塞 I/O 调用。Node 还宣称，运行它的服务器能支持数万个并发连接。</p>\r\n\r\n<p style=\"text-align:left\">现在您有了一个能处理数万个并发连接的程 序，<a href=\"http://www.baidu.com\">那么</a>您能通过 Node 实际构建什么呢？<a href=\"http://www.baidu.com\">如果</a>您有一个 Web 应用程序需要处理这么多连接，那将是一件很 &ldquo;恐怖&rdquo; 的事！那是一种 &ldquo;<a href=\"http://www.baidu.com\">如果</a>您有这个问题，<a href=\"http://www.baidu.com\">那么</a>它根本不是问题&rdquo; 的问题。在回答上面的问题之前，我们先看看 Node 的工作原理以及它的设计运行方式。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1008D\"><strong>Node 肯定不是什么？</strong></a></p>\r\n\r\n<p style=\"text-align:left\">没错，Node 是一个服务器程序。但是，基础 Node 产品肯定<em>不</em> 像 Apache 或 Tomcat。本质上，那些服务器 &ldquo;安装就绪型&rdquo; 服 务器产品，支持立即部署应用程序。通过这些产品，您可以在一分钟内启动并运行一个服务器。Node 肯定不是这种产品。Apache 能通过添加一个 PHP 模块来允许开发人员创建动态 Web 页，添加一个 SSL 模块来实现安全连接，与此类似，Node 也有模块概念，允许向 Node 内核添加模块。实际上，可供选择的用于 Node 的模块有数百个之多，社区在创建、发布和更新模块方面非常活跃，一天甚至可以处理数十个模块。本文后面将讨论 Node 的整个模块部分。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1009A\"><strong>Node 如何工作？</strong></a></p>\r\n\r\n<p style=\"text-align:left\">Node 本身运行 V8 JavaScript。等等，服务器上的 JavaScript？没错，您没有看错。对于只在客户机上使用 JavaScript 的程序员而言，服务器端 JavaScript 可能是一个新概念，但这个概念本身并非遥不可及，因此为何不能在服务器上使用客户机上使用的编程语言？</p>\r\n\r\n<p style=\"text-align:left\">什 么是 V8？V8 JavaScript 引擎是 Google 用于其 Chrome 浏览器的底层 JavaScript 引擎。很少有人考虑 JavaScript 在客户机上实际做了些什么？实际上，JavaScript 引擎负责解释并执行代码。Google 使用 V8 创建了一个用 C++ 编写的超快解释器，该解释器拥有另一个独特特征；您可以下载该引擎并将其嵌入<em>任何</em> 应用程序。V8 JavaScript 引擎并不仅限于在一个浏览器中运行。因此，Node 实际上会使用 Google 编写的 V8 JavaScript 引擎，并将其重建为可在服务器上使用。太完美了！既然已经有一个不错的解决方案可用，为何还要创建一种新语言呢？</p>\r\n\r\n<p style=\"text-align:left\">&nbsp;</p>\r\n\r\n<p style=\"text-align:left\"><object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0\" height=\"200\" hspace=\"10\" vspace=\"10\" width=\"300\"><param name=\"quality\" value=\"high\" /><param name=\"movie\" value=\"http://player.youku.com/player.php/Type/Folder/Fid/19577274/Ob/1/sid/XNTk2ODg3OTY0/v.swf\" /><embed height=\"200\" hspace=\"10\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" quality=\"high\" src=\"http://player.youku.com/player.php/Type/Folder/Fid/19577274/Ob/1/sid/XNTk2ODg3OTY0/v.swf\" type=\"application/x-shockwave-flash\" vspace=\"10\" width=\"300\"></embed></object></p>\r\n', null, '1', '00000000207', 'admin', '2013-07-24 00:00:00', 'admin', '2013-12-13 23:21:06', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10002', '企业税务健康检查方法与实施', '企业税务健', '3', '003_02', '0', '0000005000', '<p><span style=\"background-color:rgb(250, 250, 250); color:rgb(66, 48, 9); font-family:arial,helvetica,sans-serif; font-size:14px\">【看中国：世界最大单体建筑成都开业】英国卫报关注了6月28日开业的&quot;世界最大单体建筑&quot;-成都新世界环球中心。里面酒店、购物中心、电影院等设施一应俱全，还有人造海洋、海滩。卫报网友对这座建筑进行热议，有赞扬，有想去的，有怕挤的，还有觉得热闹的。观点就是如此纷繁。详见：</span><a href=\"http://t.cn/zQ2qL24\" style=\"text-decoration: none; color: rgb(108, 99, 81); font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(250, 250, 250);\" target=\"_blank\" title=\"http://news.sina.com.cn/w/gc/2013-07-10/2021159.shtml\">http://t.cn/zQ2qL24</a></p>\r\n', null, null, '00000000202', 'admin', '2013-07-24 00:00:00', 'admin', '2013-08-01 23:00:00', '1', '0', '1', null);
INSERT INTO `courses` VALUES ('10009', '爱我中华，建设我们的国家', '爱我中华，', '4', '003_02', '0', '0000005000', '<p>五十六个民族&nbsp; 五十六之花</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-08-18 16:21:36', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10010', '最新企业税收优惠政策及其纳税筹划', '最新企业税', '2', '003_02', '0', '0000050002', '<div class=\"content\"><strong>培训收益</strong><br />\r\n充分有效利用<a href=\"http://www.baidu.com\">税收优惠政策</a>是降低<a href=\"http://www.baidu.com\">企业</a>税务成本的基本方法之一。<a href=\"http://www.baidu.com\">企业</a>在运用<a href=\"http://www.baidu.com\">税收优惠政策</a>中常见的误区包括：自2008年新<a href=\"http://www.baidu.com\">企业</a>所得法出台、2009年增值税、营业税条例修订以来，<a href=\"http://www.baidu.com\">税收优惠政策</a>大幅调整，对新政策比较陌生；只关注大的优惠政策，忽略小的优惠政策；缺乏针对享受优惠政策的有效税收<a href=\"http://www.baidu.com\">筹划</a>手段；申请税收优惠常常受阻于程序和资料的准备。&nbsp;&nbsp;&nbsp;<br />\r\n本培训课程总结归纳各项现行有效<a href=\"http://www.baidu.com\">税收优惠政策</a>，以及享受这些优惠政策的配套<a href=\"http://www.baidu.com\">筹划</a>手段，并分析了<a href=\"http://www.baidu.com\">企业</a>利用<a href=\"http://www.baidu.com\">税收优惠政策</a>失败原因<a href=\"http://www.baidu.com\">及其</a>改进方法。<br />\r\n&nbsp;<br />\r\n<strong>培训提纲</strong>\r\n<ul>\r\n	<li><strong>我国实施税收优惠的常见方式</strong></li>\r\n</ul>\r\n加速折旧、直接减免、先征后退、先征后返、即征即退、减计收入、减免所得、减按税率等举例介绍。\r\n\r\n<ul>\r\n	<li><strong>运用<a href=\"http://www.baidu.com\">税收优惠政策</a>的税务<a href=\"http://www.baidu.com\">筹划</a>技巧</strong></li>\r\n	<li>事前享受优惠规划</li>\r\n	<li>事中合理享受规划</li>\r\n	<li>事后补救享受规划</li>\r\n	<li>放弃优惠享受规划\r\n	<ul>\r\n		<li><strong>增值税<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>进项税额优惠<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li><a href=\"http://www.baidu.com\">纳税</a>时点延后<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>增营结合利用<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>销售已使用固定资产合理<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>资产重组优惠<a href=\"http://www.baidu.com\">筹划</a>\r\n	<ul>\r\n		<li><strong>营业税<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>特殊混合销售行为<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>分别核算<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li><a href=\"http://www.baidu.com\">纳税</a>主体分割<a href=\"http://www.baidu.com\">筹划</a>\r\n	<ul>\r\n		<li><strong><a href=\"http://www.baidu.com\">企业</a>所得税<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>小型微利<a href=\"http://www.baidu.com\">企业</a>税收优惠</li>\r\n	<li>非居民<a href=\"http://www.baidu.com\">企业</a>税收优惠</li>\r\n	<li>高新技术<a href=\"http://www.baidu.com\">企业</a>税收优惠</li>\r\n	<li>研发费、残疾人工资加计扣除优惠</li>\r\n	<li>创投<a href=\"http://www.baidu.com\">企业</a>税收优惠</li>\r\n	<li>四项免税收入税收优惠</li>\r\n	<li>不征税收入税收优惠</li>\r\n	<li>应计未计应扣未扣多交税处理</li>\r\n	<li>过渡期税收优惠</li>\r\n	<li>债务重组税收优惠</li>\r\n	<li>资本交易税收优惠\r\n	<ul>\r\n		<li><strong>个人所得税<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>工资薪金合理<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>保险与补充保险合理<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>利股红合理<a href=\"http://www.baidu.com\">筹划</a></li>\r\n	<li>其他税目合理<a href=\"http://www.baidu.com\">筹划</a>\r\n	<ul>\r\n		<li><strong>小税种<a href=\"http://www.baidu.com\">税收优惠政策</a>分析与<a href=\"http://www.baidu.com\">筹划</a></strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>房产税城镇土地使用税优惠</li>\r\n	<li>契税印花税优惠\r\n	<ul>\r\n		<li><strong><a href=\"http://www.baidu.com\">企业</a>税收优惠的征管程序规定</strong></li>\r\n	</ul>\r\n	</li>\r\n	<li>备案制优惠管理</li>\r\n	<li>审批制优惠管理</li>\r\n	<li>非居民优惠管理\r\n	<ul>\r\n		<li><strong><a href=\"http://www.baidu.com\">企业</a>享受税收优惠失败案例分析</strong></li>\r\n	</ul>\r\n	</li>\r\n</ul>\r\n&nbsp;<br />\r\n<strong>主讲嘉宾：王老师</strong><br />\r\n理道授权<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/index.php\" target=\"_blank\">讲师</a>，国家税务总局网站答疑专家，现供职于江苏地税稽查局，近20年税务管理经验，业务熟练、理解独到，授课以实战为主攻，以实用为目标，以实惠为理念，以实效为境界。<br />\r\n&nbsp;<br />\r\n<strong>培训形式</strong>：讲授与学员参与多种形式相结合，案例分析和情景模拟相结合</div>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-11-27 23:46:09', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10011', '如何建立有效的内部控制制度', '如何建立有', '2', '003_01', '1', '0000005000', '<p>我给大家讲一下<a href=\"http://www.baidu.com\">如何</a><a href=\"http://www.baidu.com\">建立</a><a href=\"http://www.baidu.com\">有效</a>的<a href=\"http://www.baidu.com\">内部</a><a href=\"http://www.baidu.com\">控制</a><a href=\"http://www.baidu.com\">制度</a></p>\r\n\r\n<p>blablabla</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-08-17 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10012', '采购流程优化及供应商评估与管理 ', '采购流程优', null, '003_02', '0', '0000005000', '<p>丰盛的刚是sdfsdf</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-11-30 14:34:48', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10013', '能够i无任何刚', '能够i无任', '4', '003_02', '0', '0000005000', '<p>个人工</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:34:23', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10014', '部门经理、管理干部综合管理技能提升 ', 'i狗狗哦该', '3', '003_02', '0', '0000005000', '<p>结果欧冠哦好吧来接你</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-08-05 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10015', '企业与税务机关打交道的技巧', '企业与税务', '2', '003_02', '1', '0000005000', '<p>哥和天然 差别差别呃呃</p>\r\n\r\n<p>v型风格</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-08-17 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10016', '刚认为该', '刚认为该', '3', '003_02', '0', '0000005000', '<p>工程让他华瑞通 本才v不错</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10017', '哦你胡poker平', '哦你胡po', '3', '003_02', '0', '0000005000', '', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10018', '优质客户服务与客户投诉、抱怨处理技巧提升', '优质客户服', '1', '003_02', '0', '0000008000', '<p><strong>培训收益</strong><br />\r\n很多财务人员都会犯愁：我的专业水平很好，可我写的财务报告怎么总是觉得不尽人意呢？报告演示的时候总是别别扭扭！本课程专门针对财务人员开发，特邀经验丰富的财务管理<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/index.php\" target=\"_blank\">讲师</a>，传授如何<a href=\"http://www.baidu.com\">提升</a>财务报告演示的技能。已经参训学员的评价：大开眼界！！！！<br />\r\n<br />\r\n<strong>培训提纲</strong><br />\r\n一、威力简报<br />\r\n&nbsp;</p>\r\n\r\n<ul>\r\n	<li>简报的问题所在</li>\r\n	<li>说服：从（起点）通往（终点）之路</li>\r\n	<li>豁然开朗</li>\r\n	<li>找错对象的危机</li>\r\n</ul>\r\n\r\n<p>&nbsp;<br />\r\n二、要有创意：脑力激荡的艺术</p>\r\n\r\n<ul>\r\n	<li>做好脑力激荡管理：架构表</li>\r\n	<li>脑力激荡：让垃圾资料开花结果</li>\r\n	<li>先专注，再流畅</li>\r\n	<li>结构</li>\r\n	<li>该选哪招（结构流）</li>\r\n	<li>选择结构流的价值</li>\r\n	<li>四个关键性问题</li>\r\n</ul>\r\n\r\n<p>&nbsp;<br />\r\n三、抓住听众<br />\r\n1、七种经典的开场白<br />\r\n2、复合式开场白<br />\r\n3、与（终点）连结<br />\r\n4、告诉听众你的计划<br />\r\n5、九十妙开场<br />\r\n6、赢得难缠的听众<br />\r\n&nbsp;<br />\r\n四、用视觉沟通<br />\r\n1、图表的功能<br />\r\n2、以简报者为焦点<br />\r\n3、少即是多<br />\r\n4、认知心理学<br />\r\n5、图表设计元素<br />\r\n&nbsp;<br />\r\n五、让文字说话</p>\r\n\r\n<ul>\r\n	<li>条列重点VS完整句子</li>\r\n	<li>自动换行</li>\r\n	<li>打造有效的条例重点式简报</li>\r\n	<li>用（对句法）减少眼球扫视</li>\r\n	<li>使用效果</li>\r\n	<li>小标层次</li>\r\n	<li>视觉风格</li>\r\n</ul>\r\n\r\n<p>&nbsp;<br />\r\n六、让数字发挥作用<br />\r\n1、数据图表的力量<br />\r\n2、柱状图<br />\r\n3、圆饼图<br />\r\n4、数据图表的版面格式<br />\r\n5、曲棍球棒曲线<br />\r\n6、很难捉摸吗？没错，但是&hellip;&hellip;<br />\r\n&nbsp;<br />\r\n七、量身定作简报内容</p>\r\n\r\n<ul>\r\n	<li>量身定作力量大</li>\r\n	<li>收集客制化简报的材料</li>\r\n	<li>活用外部串场话</li>\r\n	<li>有始有终</li>\r\n	<li>练习、练习、再练习</li>\r\n	<li>随时随地加以运用</li>\r\n</ul>\r\n\r\n<p>&nbsp;<br />\r\n<strong>培训<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/index.php\" target=\"_blank\">讲师</a>：</strong><strong>李</strong><strong>老师</strong><br />\r\n理道授权讲师。纽西兰威克图大学管理学博士，纽西兰奥克兰大学财管硕士。李老师是北京大学、清华大学、英国威尔斯大学EMBA特聘教授。具有扎实的财务管理功底，同时擅管理类培训，包括：领导力<a href=\"http://www.baidu.com\">提升</a>、MTP、内部讲师培训、沟通<a href=\"http://www.baidu.com\">技巧</a>、团队与激励、压力与情绪管理、非财务主管财务管理课程。<a class=\"keylink\" href=\"http://www.qgpx.com/neixun/\" target=\"_blank\">内训</a>企业包括麦当劳、百事可乐、广东移动、花旗银行、荷兰银行、第一银行、深圳华强集团、深圳福田汽车站、深圳福田酒店等企业。李老师授课幽默风趣，案例生动，能针对财务群体的特点讲解，深受企业欢迎。</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-11-27 23:36:48', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10019', '企业销售（服务）活动税务筹划', '企业销售', '2', '003_02', '0', '0000008022', '<p>被呃xcvs gfsr gth dth j yj</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-08-17 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10020', '哈哈哈撒旦法', '哈哈哈撒旦', '4', '003_02', '0', '0000008000', '<p>阿什顿飞</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10021', '被她法国湖人', '被她法国湖', '4', '003_01', '0', '0000008000', '<p>而嘎登飞</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10022', '项目培训课程', '111', '梵蒂冈', '003_02', '0', '0000008000', '<p>改哦i认为后宫ie然后各荣光和加尔哦该将</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-11-26 23:02:32', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10023', '4623425324', '46234', '4', '003_02', '0', '0000008000', '<p>撒旦法后天更好</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10024', '尔特让他', '尔特让他', '3', '003_02', '0', '0000008000', '<p>嘎登是</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10025', '经济合同的财税风险管理', '经济合同的', '2', '003_02', '0', '0000008000', '<p><a href=\"http://www.baidu.com\">财税</a><a href=\"http://www.baidu.com\">风险</a><a href=\"http://www.baidu.com\">管理</a> 之类的课程</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-08-17 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10026', '最新企业所得税税前扣除管理办法', '最新企业所', '2', '003_02', '0', '0000008000', '<p>而豆腐干</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-08-18 20:45:31', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10027', '不同意能否和', '不同意能否', '4', '003_02', '0', '0000008000', '<p>撒旦法</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10028', '风格化', '风格化', '3', '003_02', '0', '0000008000', '<p>高考<span style=\"color:#FF0000\"><strong>回家</strong></span></p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-11-27 23:48:58', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10029', '你让他4673434', '你让他46', '4', '003_02', '0', '0000008000', '<p>的放噶 是个外人</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10030', '十多个人呃ethernet', '十多个人呃', '4', '003_01', '0', '0000008000', '<p>阿什顿飞</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-07-24 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10031', '企业税务健康检查方法与实施', '企业税务健', '4', '003_01', '0', '0000008000', '<div class=\"WB_text\" style=\"font-size: 14px; line-height: 23px; padding: 4px 0px; color: rgb(66, 48, 9); font-family: Arial, Helvetica, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(250, 250, 250);\">【羽毛一开始是用来飞的吗？】鸟是会飞的恐龙，在它们还不会飞的时候就拥有羽毛222了。然而原始羽毛显然不是为了飞才演化出来的，但这样的结构却为飞行提供了可能性。像这样，在演化过程中性状的作是用发生改变的现象，被称为&ldquo;预适应&rdquo;。一个新研究对预适应的机制进行了阐述：<a href=\"http://t.cn/zQVmLT7\" style=\"text-decoration: none; color: rgb(108, 99, 81);\" target=\"_blank\" title=\"http://www.guokr.com/article/437222/\">http://t.cn/zQVmLT7</a></div>\r\n\r\n<div class=\"WB_media_expand SW_fun2 S_line1 S_bg1\" style=\"background-color: rgb(242, 242, 242); border: 1px solid rgb(224, 219, 209); padding: 10px 20px; margin: 5px 0px 15px; border-top-left-radius: 3px; border-top-right-radius: 3px; border-bottom-right-radius: 3px; border-bottom-left-radius: 3px; color: rgb(66, 48, 9); font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 13px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;\">\r\n<p>收起<em>|</em>查看大图<em>|</em>向左转<em>|</em>向右转</p>\r\n\r\n<div class=\"smallcursor\" style=\"cursor: url(http://img.t.sinajs.cn/t5/style/images/common/small.cur), auto !important; text-align: center;\"><img src=\"http://ww1.sinaimg.cn/bmiddle/6e53d84fjw1e6xq8y7kqnj20t50l6gn7.jpg\" style=\"border:0px; cursor:url(http://img.t.sinajs.cn/t5/style/images/common/small.cur), auto !important; width:440px\" /></div>\r\n</div>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-10-13 17:29:12', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10032', '我去', '我去', '4', '003_01', '0', '0000008000', '<p style=\"text-align:left\"><a name=\"N1006B\"><strong>简介</strong></a></p>\r\n\r\n<p style=\"text-align:left\">如果您听说过 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a>，或者阅读过一些文章，宣称 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 是多么多么的棒，那么您可能会想：&ldquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 究竟是什么东西？&rdquo; 即便是在参阅 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 的主页之后，您甚至可能<em>还是</em> 不明白 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 为何物？<a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 肯定不适合每个程序员，但它可能是某些程序员一直苦苦追寻的东西。</p>\r\n\r\n<p style=\"text-align:left\">为试图解释什么是 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a>.js，本文将简要介绍一些背景信息：它要解决的问题，它如何工作，如何运行一个简单应用程序，最后，<a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 在什么情况下是一个好的解决方案。本文不涉及如何编写一个复杂的 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 应用程序，也不是一份全面的 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 教程。阅读本文应该有助于您决定是否应该继续学习 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a>，以便将其用于您的业务。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1007B\"><strong><a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 旨在解决什么问题？</strong></a></p>\r\n\r\n<p style=\"text-align:left\"><a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 公开宣称的目标是 &ldquo;旨在提供一种简单的构建可伸缩网络程序的方法&rdquo;。当前的服务器程序有什么问题？我们来做个数学题。在 Java&trade; 和 PHP 这类语言中，每个连接都会生成一个新线程，每个新线程可能需要 2 MB 的配套内存。在一个拥有 8 GB RAM 的系统上，理论上最大的并发连接数量是 4,000 个用户。随着您的客户群的增长，如果希望您的 Web 应用程序支持更多用户，那么，您必须添加更多服务器。当然，这会增加服务器成本、流量成本和人工成本等成本。除这些成本上升外，还有一个潜在技术问题，即用户可能针对每个请求使用不同的服务器，因此，任何共享资源都必须在所有服务器之间共享。鉴于上述所有原因，整个 Web 应用程序架构（包括流量、处理器速度和内存速度）中的瓶颈是：服务器能够处理的并发连接的最大数量。</p>\r\n\r\n<p style=\"text-align:left\"><a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 解决这个问题的方法是：更改连接到服务器的方式。每个连接发射一个在 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 引擎的进程中运行的事件，而不是为每个连接生成一个新的 OS 线程（并为其分配一些配套内存）。<a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 声称它绝不会死锁，因为它根本不允许使用锁，它不会直接阻塞 I/O 调用。<a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 还宣称，运行它的服务器能支持数万个并发连接。</p>\r\n\r\n<p style=\"text-align:left\">现在您有了一个能处理数万个并发连接的程序，那么您能通过 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 实际构建什么呢？如果您有一个 Web 应用程序需要处理这么多连接，那将是一件很 &ldquo;恐怖&rdquo; 的事！那是一种 &ldquo;如果您有这个问题，那么它根本不是问题&rdquo; 的问题。在回答上面的问题之前，我们先看看 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 的工作原理以及它的设计运行方式。</p>\r\n\r\n<div class=\"ibm-alternate-rule\" style=\"clear: both; background-image: url(http://1.www.s81c.com/i/solid.gif); background-color: rgb(255, 255, 255); height: 1px; color: rgb(0, 0, 0); font-family: Simsun; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-position: initial initial; background-repeat: repeat no-repeat;\">&nbsp;</div>\r\n\r\n<p style=\"text-align:right\"><a class=\"ibm-anchor-up-link\" href=\"http://www.ibm.com/developerworks/cn/opensource/os-nodejs/#ibm-pcon\" style=\"color: rgb(153, 102, 153); display: inline; margin: 0px; padding: 0px 0px 0px 18px; text-decoration: none; background-image: url(http://1.www.s81c.com/i/v16/icons/u_bold.gif); font-weight: bold; background-position: 0px -1px; background-repeat: no-repeat no-repeat;\">回页首</a></p>\r\n\r\n<p style=\"text-align:left\"><a name=\"N1008D\"><strong><a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 肯定不是什么？</strong></a></p>\r\n\r\n<p style=\"text-align:left\">没错，<a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 是一个服务器程序。但是，基础 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 产品肯定<em>不</em> 像 Apache 或 Tomcat。本质上，那些服务器 &ldquo;安装就绪型&rdquo; 服 务器产品，支持立即部署应用程序。通过这些产品，您可以在一分钟内启动并运行一个服务器。<a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 肯定不是这种产品。Apache 能通过添加一个 PHP 模块来允许开发人员创建动态 Web 页，添加一个 SSL 模块来实现安全连接，与此类似，<a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 也有模块概念，允许向 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 内核添加模块。实际上，可供选择的用于 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 的模块有数百个之多，社区在创建、发布和更新模块方面非常活跃，一天甚至可以处理数十个模块。本文后面将讨论 <a href=\"http://www.baidu.com\"  target=\"_blank\">Node</a> 的整个模块部分。</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-12-21 11:15:31', '1', '1', '1', 'Node');
INSERT INTO `courses` VALUES ('10033', '高效的领导力', '高效的领导', '2', '003_01', '0', '0000006000', '<p>样式&nbsp; 普通&nbsp;</p>\r\n\r\n<p>课程内容</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>目的</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>大纲</p>\r\n', null, null, '00000000200', 'outsider', '2013-07-24 00:00:00', 'outsider', '2013-11-27 23:43:06', null, '1', null, null);
INSERT INTO `courses` VALUES ('10034', '成为卓越领导、构建高绩效团队', null, '2', '003_01', '0', '0000100045', '<div id=\"courseContent\">\r\n<div class=\"intro\">推荐理由</div>\r\n\r\n<p><a href=\"http://www.baidu.com\">高绩效</a><a href=\"http://www.baidu.com\">团队</a>课程旨在帮助学员对照新、旧工作模式及其结果来看清自身的&ldquo;行为短板&rdquo;，激发学员主动改变的动机；理解、掌握&ldquo;<a href=\"http://www.baidu.com\">团队</a>工作模式&rdquo;的过程和行为要 领，并结合自身的经验运用于实际工作中；了解在<a href=\"http://www.baidu.com\">团队</a>中实施&ldquo;<a href=\"http://www.baidu.com\">团队</a>工作模式&rdquo;的阻力与解决策略，使得他们愿意带领<a href=\"http://www.baidu.com\">团队</a>尝试改变。</p>\r\n\r\n<div class=\"intro\">课程内容</div>\r\n\r\n<p>目前中国已经成为全球电子制造业的中心,随着电子产品的高密化、环保化、低利润化、高质量要求,电子制造企业的生存越来越艰难,只有在保证产品功能的情况 下提高产品质量、降低产品成本,才能在竞争激烈的市场中争得一席之地。对电子产品质量影响最大的莫过于工艺缺陷,是否有能力准确地定位、分析、解决电子制 造工艺缺陷成为提高电子产品质量的关键,本课程总结讲师多年的工作经验和实例,并综合业界最新的成果拟制而成,是业内少见的系统讲解工艺缺陷分析诊断与解 决方案的精品课程。</p>\r\n\r\n<p><img alt=\"\" src=\"http://www.baidu.com/img/bdlogo.gif\" style=\"height:129px; width:270px\" /></p>\r\n\r\n<div class=\"intro\">课程特点</div>\r\n\r\n<p>本课程以电子组装焊接(软钎焊)基本原理和可焊性基础讲解为出发点,通过实例来系统深入地讲解电子组装工艺(SMT和波峰焊)工艺过程的数十种典型工艺缺 陷的机理和解决方案,通过该课程的学习可以掌握电子组装工艺典型缺陷的分析 定位与解决.在第二天的专项工艺缺陷的诊断分析中,将针对组装工艺的新问题和难点问题:无铅焊接 BGA焊接 QFN/MLF焊接问题进行讲解,介绍无铅焊接过程独特的工艺缺陷的分析与解决,介绍面阵列器件(BGA)10大类工艺缺陷的分析解决,介绍QFN /MLF器件工艺缺陷的分析和解决方案介绍.通过本课程的学习,学员能够基本掌握电子组装焊接(软钎焊)的基本原理和可焊性测量判断方法,能够系统准确地 定位分析解决电子组装过程典型工艺缺陷,有效提高公司产品的设计水平与质量水平,提高产品在市场的竞争力.</p>\r\n\r\n<div class=\"intro\">课程大纲</div>\r\n\r\n<p>第一天课程:</p>\r\n\r\n<h2>一、电子组装工艺技术介绍</h2>\r\n\r\n<h3>从THT到SMT工艺的驱动</h3>\r\n\r\n<h3>SMT工艺的发展趋势及面临的挑战</h3>\r\n\r\n<h2>二、电子组装焊接(软钎焊)原理及可焊性基础</h2>\r\n\r\n<h3>焊接方法分类</h3>\r\n\r\n<h3>电子组装焊接(软钎焊)的机理和优越性</h3>\r\n\r\n<h3>形成良好软钎焊的条件</h3>\r\n\r\n<h3>润湿 扩散 金属间化合物在焊接中的作用</h3>\r\n\r\n<h3>良好焊点与不良焊点举例</h3>\r\n\r\n<h2>三、SMT工艺缺陷的诊断分析与解决</h2>\r\n\r\n<h3>印刷工艺缺陷分析与解决:</h3>\r\n\r\n<h3>焊膏脱模不良</h3>\r\n\r\n<h3>焊膏印刷厚度问题</h3>\r\n\r\n<h3>焊膏塌陷</h3>\r\n\r\n<h3>布局不当引起印锡问题等</h3>\r\n\r\n<h3>回流焊接工艺缺陷分析诊断与解决方案:</h3>\r\n\r\n<h3>冷焊</h3>\r\n\r\n<h3>立碑</h3>\r\n\r\n<h3>连锡</h3>\r\n\r\n<h3>偏位</h3>\r\n\r\n<h3>芯吸(灯芯现象)</h3>\r\n\r\n<h3>开路</h3>\r\n\r\n<h3>焊点空洞</h3>\r\n\r\n<h3>锡珠</h3>\r\n\r\n<h3>不润湿</h3>\r\n\r\n<h3>半润湿</h3>\r\n\r\n<h3>退润湿</h3>\r\n\r\n<h3>焊料飞溅等</h3>\r\n\r\n<h3>回流焊接典型缺陷案例介绍</h3>\r\n\r\n<p>第二天课程(专项工艺缺陷的分析与诊断):</p>\r\n\r\n<h2>四、无铅焊接工艺缺陷的诊断分析与解决无铅焊接典型工艺缺陷分析诊断与解决:</h2>\r\n\r\n<h3>PCB分层与变形</h3>\r\n\r\n<h3>BAG/CSP曲翘变形导致连锡、开路</h3>\r\n\r\n<h3>无铅焊料润湿性差、扩散性差导致波峰焊的连锡缺陷</h3>\r\n\r\n<h3>黑焊盘Black pads</h3>\r\n\r\n<h3>焊盘脱离</h3>\r\n\r\n<h3>润湿不良;</h3>\r\n\r\n<h3>锡须Tin whisker;</h3>\r\n\r\n<h3>热损伤Thermadamage;</h3>\r\n\r\n<h3>导电阳极细丝Conductive anodic filament;</h3>\r\n\r\n<h3>无铅焊接典型工艺缺陷实例分析.</h3>\r\n\r\n<h2>五、面阵列类器件(BGA)十类典型工艺缺陷的诊断分析与解决</h2>\r\n\r\n<h3>BGA典型工艺缺陷的分析诊断与解决方案:</h3>\r\n\r\n<h3>空洞</h3>\r\n\r\n<h3>连锡</h3>\r\n\r\n<h3>虚焊</h3>\r\n\r\n<h3>锡珠</h3>\r\n\r\n<h3>爆米花现象</h3>\r\n\r\n<h3>润湿不良</h3>\r\n\r\n<h3>焊球高度不均</h3>\r\n\r\n<h3>自对中不良</h3>\r\n\r\n<h3>焊点不饱满</h3>\r\n\r\n<h3>焊料膜等.</h3>\r\n\r\n<h3>BGA工艺缺陷实例分析.</h3>\r\n\r\n<h2>六、QFN/MLF器件工艺缺陷的分析诊断与解决</h2>\r\n\r\n<h3>QFN/MLF器件封装设计上的考虑</h3>\r\n\r\n<h3>PCB设计指南</h3>\r\n\r\n<h3>钢网设计指南</h3>\r\n\r\n<h3>印刷工艺控制</h3>\r\n\r\n<h3>QFN/MLF器件潜在工艺缺陷的分析与解决</h3>\r\n\r\n<h3>典型工艺缺陷实例分析.</h3>\r\n\r\n<h2>七、讨论</h2>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"intro\">讲师介绍：王毅博士</div>\r\n\r\n<p>工学博士，曾任职华为技术有限公司，8年以上大型企业研发及生产实践经验。主持建立华为公司SMT工艺可靠性技术研究平台，参与建设华为公司SMT 工艺平台四大规范体系，擅长电子产品可制造性设计DFM 、SMT工艺可靠性设计DFR等DFx设计平台的建立与应用，在电子产品可制造性设计、SMT组装工艺缺陷机理分析与解决、失效分析、工艺可靠性等领域有 深入研究与丰富的实践应用经验。获省部级科技进步一等奖一次，包括在《CHINES SCIENCE BULLETINE》等国际一流刊物发表学术论文30多篇，包括《BGA空洞形成的机理及对焊点可靠性的影响》、《微型片式元件焊接过程立碑工艺缺陷的分 析与解决》、《QFN器件组装工艺缺陷的分析与解决》、《CCGA器件的可靠性返修》等SMT专业技术文章多篇。</p>\r\n\r\n<p>培训和咨询过的知名企业： 艾默生网络能源、南京熊猫爱立信、深圳市高新技术行业协会、日立汽车部件、霍尼韦尔安防（中国）有限公司、西蒙克拉电子(苏州)、上海大唐移动、中兴通 讯、Optel通讯、厦门华侨电子、海尔、美的集团、格力电器、创维集团、康佳集团、联想集团、比亚迪、同洲电子、同维电子、TCL、大族激光、迈瑞生物 医疗、富士康、英业达、炬力、固高科技、飞通光电、 步步高、万利达、宇龙、好易通、科立讯、金立、海康威视公司、长沙威胜集团、佛山伊戈尔集团、航盛电子、嘉兆电子科技（珠海）、斯比泰电子、中达电子、苏 州万旭光电、山东省东营科英激光电子、南京汉业电子实业有限公司、深圳安科讯、电子十所、西安东风仪表厂、中海油服、北京人民电器厂。</p>\r\n</div>\r\n', null, null, '00000000500', 'outsider', '2013-08-05 00:00:00', 'outsider', '2013-08-06 00:00:00', '1', '1', '1', null);
INSERT INTO `courses` VALUES ('10035', '创新管理·深圳电子标杆学习之旅', null, '1', '003_01', '0', '0000234234', '<p><strong>【<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>概述】</strong><br />\r\n&nbsp;&nbsp;&nbsp; 随着<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>经济时代的来临、市场的日益全球化和网络的广泛运用，<strong><a href=\"http://www.qgpx.com/neixun/qiyejingying/biaoganguanli/\">标杆学习</a></strong>越 来越成为企业实施流程再造、持续改善及建立核心竞争优势的关键<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>方法。据统计，全球500强企业中超过90%的企业应用了<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>法，如施乐、三星、 IBM等全球行业领袖。那些通过<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>取得系统突破的企业，其投资回报率都在普通公司的五倍以上。为此，华制国际秉持&ldquo;用世界级智慧推动中国经济腾飞， 让中国企业在全球更受尊敬！&rdquo;的使命，将行之有效的&ldquo;<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>&rdquo;和&ldquo;行动<a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>&rdquo;相结合，推出了&ldquo;<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>全球行&rdquo;系列产品。<br />\r\n　　　<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>全球行概念<br />\r\n　　<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>全球行是将<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>与行动<a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>相结合，以中国企业经营<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>中的实际问题为载体，以全球领先企业相同或相似主题的最佳实践为<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a>，并以此为基准 与本企业进行比较、分析、判断，对本企业的问题进行处理，从而使自己企业得到不断改进，赶超一流公司，创造优秀业绩的良性循环过程。<br />\r\n　　　<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>全球行方法<br />\r\n<br />\r\n<strong>【课程背景】&nbsp;</strong>&nbsp;<br />\r\n　　<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>是中国第一个经济特区，经过短短32年的发展，从一个仅有两三万人的小渔村发展为拥有1400万人口、经济繁荣、功能完备、环境优美的新兴现代化大都市，以举世瞩目的&ldquo;<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>速度&rdquo;，创造了世界工业化、城市化、现代化史上的奇迹。<br />\r\n　　创造奇迹的不仅仅是这座城市，还有众多<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>本土企业。华为书写了从两万到千亿的创业传奇，中兴位列国内发明专利申请量第一，腾讯改变了中国数以亿计网 民的沟通方式和生活习惯，创维、康佳依靠<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>跨界白色家电领域，变身家电业巨鳄。他们的诞生、强大直至成为行业强有力的领导者，除了依托特区优越的创业环 境及政策环境，更重要的是企业高瞻远瞩的战略眼光、先进的<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>模式以及持续<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>的能力。<br />\r\n　　在全球经济下滑的大背景下，中国经济面临严峻考验，着力转变发展方式、努力提升<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>能力成为众多中国企业应对危机的共同选择。而华为、中兴、腾讯等一 大批<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>企业用实践证明：只有不断优化企业<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>模式、提升自主<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>能力，才能紧跟时代脚步，在激烈的竞争中把握先机、赢得市场。<br />\r\n　　鉴于此，华制国际倾力打造《<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>&middot;<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a><a href=\"http://www.baidu.com\" target=\"_blank\">电子</a><a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a href=\"http://www.baidu.com\" target=\"_blank\">学习</a><a href=\"http://www.baidu.com\" target=\"_blank\">之旅</a>》，前往<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>高新技术产业园区，参观华为、中兴两家中国卓越企业，领略国际领先企业的风采，近距离<a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>其<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>模式、<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>思维与发展战略，总结其做到全球卓越的本质原因，为企业的<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>探寻路径。<br />\r\n<br />\r\n<strong>【课程特色及受益】</strong></p>\r\n\r\n<p>个性化主题研修&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 了解<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>高新技术企业飞速发展的原因，<a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>华为的<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>模式，系统梳理<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>对企业发展的影响及意义，探寻企业<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>的实施路径<br />\r\n实战型专家授课&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 具有丰富理论经验和多年企业<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>经验的实战型专家进行授课，讲述企业真实案例，分享实际<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>经验<br />\r\n<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a>企业现场参观&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 走进<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>高新技术产业园区，近距离参观中兴、华为等<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>型<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a>企业，感受企业<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>氛围，现场了解<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a>企业的运营模式<br />\r\n企业高管互动交流&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 深入业内领先的<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a>企业实地考察，与企业高管交流企业的<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>模式，<a href=\"http://www.baidu.com\" target=\"_blank\">学习</a><a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a><a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_0_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">企业战略</a>思维及<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a><a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>手段<br />\r\n学员总结分享心得&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 分享经验，碰撞智慧，分析自身企业在发展<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>中所遇的问题，讨论<a href=\"http://www.baidu.com\" target=\"_blank\">标杆</a>企业的先进的<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>理念、<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>模式以及<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>路径对于自身企业的启示</p>\r\n\r\n<p><strong>【学员对象】</strong><br />\r\n　　企业董事长/总裁/总经理、副总裁/副总经理、总监/部门经理等中高层<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>者<br />\r\n<br />\r\n<strong>【行程安排】</strong></p>\r\n\r\n<p>日期&nbsp;城市&nbsp;日程安排<br />\r\n&nbsp;&nbsp;时间&nbsp;内容<br />\r\n&nbsp;<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>&nbsp;下午&nbsp;报到/<a href=\"http://www.baidu.com\" target=\"_blank\">学习</a>资料发放/酒店入住安排&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />\r\n&nbsp;&nbsp;晚上&nbsp;晚餐</p>\r\n\r\n<p>第一天<br />\r\n&nbsp;<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>&nbsp;08:30-09:00&nbsp;开讲仪式：行程介绍、注意事项说明<br />\r\n&nbsp;&nbsp;09:00-12:00&nbsp;主题培训一：《华为<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>》上<br />\r\n&nbsp;&nbsp;12:00-14:00&nbsp;合影&amp;午餐&amp;休息<br />\r\n&nbsp;&nbsp;14:00-17:00&nbsp;主题培训一：《华为<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>》下<br />\r\n&nbsp;&nbsp;17:30-18:30&nbsp;晚餐<br />\r\n<br />\r\n第二天&nbsp;</p>\r\n\r\n<p>&nbsp;<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>&nbsp;08:30-09:30&nbsp;乘车前往<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>华为技术<br />\r\n&nbsp;&nbsp;09:30-11:30&nbsp;参观一：<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>华为技术<br />\r\n参观内容：华为产品展厅/<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_10_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">企业文化</a>展厅/华为大学主培楼/高培楼/ 华为百草园（单身公寓）<br />\r\n&nbsp;&nbsp;11:30-13:00&nbsp;午餐、休息<br />\r\n&nbsp;&nbsp;13:00-17:30&nbsp;主题培训二：《中兴基于客户价值的<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>》<br />\r\n&nbsp;&nbsp;17:30-18:30&nbsp;晚餐<br />\r\n&nbsp;&nbsp;18:30-20:30&nbsp;学员发表<br />\r\n主题：<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>对企业的启发</p>\r\n\r\n<p>第三天&nbsp;<br />\r\n<br />\r\n<a href=\"http://www.baidu.com\" target=\"_blank\">深圳</a>&nbsp;08:30-09:30&nbsp;乘车前往中兴通讯<br />\r\n&nbsp;&nbsp;09:30-11:30&nbsp;参观二：中兴通讯<br />\r\n参观流程：中兴通讯总部研发大楼/中兴产品与设备展厅/中兴生产车间/中兴历史文化博物馆<br />\r\n&nbsp;&nbsp;11:30-14:00&nbsp;午餐&amp;休息<br />\r\n&nbsp;&nbsp;14:00-17:00&nbsp;主题培训三：《中兴流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>体系》<br />\r\n&nbsp;&nbsp;17:00-17:30&nbsp;结业仪式、课程结束</p>\r\n\r\n<p>《华为<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>》<br />\r\n　一、流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>的原则<br />\r\n　 1.加快反应速度<br />\r\n　2.提高<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>效率<br />\r\n　二、华为的流程变革<br />\r\n　 1.变革<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>体系<br />\r\n　 2.变革<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>运作机制<br />\r\n　 3.变革历程与相关经验<br />\r\n　三、流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>的操作手法&nbsp;　 1.梳理作业流程<br />\r\n　 2.精简冗余程序<br />\r\n　 3.合并同类环节<br />\r\n　 4.合理排序<br />\r\n　四、华为的研发流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a><br />\r\n　 1.预研：专利转为商品的必经之路&nbsp;&nbsp;<br />\r\n　 2.IPD：集成产品开发&nbsp;&nbsp;<br />\r\n　 3.&ldquo;专利地图&rdquo;<br />\r\n《中兴基于客户价值的<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>》<br />\r\n一、中兴以客户为主的<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_10_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">企业文化</a><br />\r\n　1.互相尊重，忠于中兴事业<br />\r\n　2.精诚服务，凝聚顾客身上<br />\r\n　3.拼搏<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>，集成中兴名牌<br />\r\n　4.科学<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>，提高企业效益<br />\r\n二、中兴基于客户价值的&ldquo;<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>服务&rdquo;产品<br />\r\n　1.<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>服务支撑&nbsp;　2.故障<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>服务<br />\r\n　3.性能<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>与优化服务<br />\r\n　4.配置<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>服务<br />\r\n　5.业务<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>服务<br />\r\n　6.预防性维护服务<br />\r\n三、中兴的<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>机制及体系<br />\r\n四、中兴的<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>模式的<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>及发展<br />\r\n《中兴流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>体系》<br />\r\n一、流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>的原则<br />\r\n　加快反应速度 / 提高<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>效率<br />\r\n二、流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>的一般手法<br />\r\n三、中兴的流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>划分<br />\r\n　1.运行监控<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>&nbsp;&nbsp;&nbsp; 2.持续优化<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a><br />\r\n　3.审计<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.文件<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a><br />\r\n　四、流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a><a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><br />\r\n&nbsp;　1.<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>的必要性<br />\r\n　2.流程<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>的步骤<br />\r\n　　目标流程的选定&rarr;现状调查、设定目标<br />\r\n　&rarr;改进措施的确定和实施&rarr;巩固和标准化<br />\r\n　3.常见的<a href=\"http://www.baidu.com\" target=\"_blank\">创新</a>组织方式<br />\r\n　QC小组/6Sigma团队/<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_14_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">项目管理</a>/8D<br />\r\n4.中兴的流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a><a href=\"http://www.baidu.com\" target=\"_blank\">创新</a><br />\r\n<br />\r\n<strong>【核心师资】</strong><br />\r\n1. 刘老师<br />\r\n&nbsp;&nbsp;&nbsp; 具有10余年国际、国内知名高科技企业研发实践和研发<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>经验，先后在IBM、华为担任过系统工程师、项目经理、开发部经理、事业部总经理等职位，主持了某著名高科技企业电信业务软件平台的开发，具有非常丰富的产品开发<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>和<a class=\"keylink\" href=\"http://www.qgpx.com/jiangshi/search_14_-1_-1_-1_-1_-1_-1.html\" target=\"_blank\">项目管理</a>专业知识及实践经验。国内最早一批（2000年）美国项目<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>协会认证专家PMP。<br />\r\n2. 张老师<br />\r\n&nbsp; 经历了从质量专家到资深质量经理人的转换，体验了从国有企业到外资企业再到合资企业的文化差异。长期从事质量<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>工作，具有丰富的服务性、制造性企业质量 <a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>及实务经验，尤其在流程<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>领域上的研究受到国内外人士的推崇。10年工厂审核、咨询和培训的经验使师老师对各行业的制造过程和产品特征有深入的了 解，多年来担任质量<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>及现场改进领域的嘉宾，并成功辅导了十几家跨领域企业的质量改善项目。</p>\r\n', null, null, '00000000500', 'outsider', '2013-08-18 18:22:39', 'outsider', '2013-11-27 23:47:38', null, '1', null, null);
INSERT INTO `courses` VALUES ('10036', '修改一行SQL代码，性能提升了100倍', null, '2', '003_01', '0', '0000086000', '<p>在PostgreSQL中<a href=\"http://www.baidu.com\" target=\"_blank\">修改</a>了<a href=\"http://www.baidu.com\" target=\"_blank\">一行</a>不明显的<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>，把（ANY(ARRAY[...]) 改成 ANY(VALUES(...))），结果查询时间从20s变为0.2s。最初我们学习使用<a href=\"http://www.postgresql.org/docs/9.1/static/sql-explain.html\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\">EXPLAN ANALYZE</a>来优化<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>，到后来，<a href=\"http://www.postgresql.org/list/pgsql-performance/\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\">Postgres社区</a>也成为我们学习<a href=\"http://www.baidu.com\" target=\"_blank\">提升</a>的一个好帮手，付出总会有回报，我们产品的<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a>也因此得到了极大的<a href=\"http://www.baidu.com\" target=\"_blank\">提升</a>。</p>\r\n\r\n<p><strong>事出有因</strong></p>\r\n\r\n<p>我们所开发的产品是<a href=\"http://www.datadoghq.com/\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\">Datadog</a>， 这是专门为那些编写和运营大规模应用的团队、IT运营商提供监控服务的一个平台，帮助他们把海量的数据转化为切实可行的计划、操作方案。在这周早些时候， 我们的许多数据库所面临的一个<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a>问题是在一个较小的表上进行大量的key查询。这些查询中的99.9%都是高效灵活的。在极少数实例中，有些数量的<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a> 指标tag查询是费时的，这些查询需要花费20s时间。这也就意味着用户需要在浏览器面前花费这么长的时间来等待图形编辑器做出响应。即使是0.1%，这 样的用户体验也显然糟透了，对此，我们进行了监测，探究为何速度会这么慢。</p>\r\n\r\n<p><strong>查询与计划</strong></p>\r\n\r\n<p>结果令人震惊，罪魁祸首竟然是下面这个简单的查询：</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n\r\n<ol start=\"1\">\r\n	<li>SELECT&nbsp;c.key,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c.x_key,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c.tags,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;x.name&nbsp;&nbsp;</li>\r\n	<li>&nbsp;FROM&nbsp;context&nbsp;c&nbsp;&nbsp;</li>\r\n	<li>&nbsp;JOIN&nbsp;x&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;ON&nbsp;c.x_key&nbsp;=&nbsp;x.key&nbsp;&nbsp;</li>\r\n	<li>WHERE&nbsp;c.key&nbsp;=&nbsp;ANY&nbsp;(ARRAY[15368196,&nbsp;--&nbsp;11,000&nbsp;other&nbsp;keys&nbsp;--)])&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;AND&nbsp;c.x_key&nbsp;=&nbsp;1&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;AND&nbsp;c.tags&nbsp;@&gt;&nbsp;ARRAY[E&#39;blah&#39;];&nbsp;&nbsp;</li>\r\n</ol>\r\n</div>\r\n\r\n<p>X表拥有 上千行数据，C表拥有1500万行数据，这两个表的&ldquo;key&rdquo;列都带有适当的索引主键。简单地说，它就是一个简单的主键查询。但有趣地是，随着key列中 记录的增加，例如在1<a href=\"http://www.baidu.com\" target=\"_blank\">100</a>0行时，我们通过添加EXPLAIN (ANALYZE, BUFFERS)前缀来查看key列的值是否与数组中的值匹配：</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n</div>\r\n\r\n<p>这次查询共花费22s，我们可以通过下图对这22s进行很直观的了解，其中大部分时间花费在Postgres和OS之间，而磁盘I/O则花费非常少的时间。</p>\r\n\r\n<p style=\"text-align:center\"><img alt=\"\" src=\"http://dl2.iteye.com/upload/attachment/0088/6876/39007ce3-4097-38fe-9998-b86de8f00f50.jpg\" /></p>\r\n\r\n<p>在最低水平，这些查询看起来就像是这些CPU利用率的峰值。在这里主要是想证实一个关键点：数据库不会等待磁盘去读取数据，而是做排序、散列和行比较这些事。</p>\r\n\r\n<p>通过Postgres获取与峰值最接近的行数。</p>\r\n\r\n<p style=\"text-align:center\"><img alt=\"\" src=\"http://dl2.iteye.com/upload/attachment/0088/6878/fcaba5f9-b7f9-3e4f-ac70-749698af550b.jpg\" /></p>\r\n\r\n<p>显然，我们的查询在大多数情况下都有条不紊的执行着。</p>\r\n\r\n<p><strong>Postgres的<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a>问题：位图堆扫描</strong>&nbsp;</p>\r\n\r\n<p>rows_fetched度量与下面的部分计划是一致的：&nbsp;</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n</div>\r\n\r\n<p style=\"text-align:left\">Postgres使用位图堆扫描（&nbsp;<a href=\"http://www.postgresql.org/message-id/12553.1135634231@sss.pgh.pa.us\" style=\"font-size: 12px; cursor: pointer; color: #0066cc;\" target=\"_blank\">Bitmap Heap Scan</a>） 来读取C表数据。当关键字的数量较少时，它可以在内存中非常高效地使用索引构建位图。如果位图太大，查询优化器会改变其查找数据的方式。在我们这个案例 中，需要检查大量的关键字，所以它使用了非常相似的方法来检查候选行并且单独检查与x_key和tag相匹配的每<a href=\"http://www.baidu.com\" target=\"_blank\">一行</a>。而所有的这些&ldquo;在内存中加载&rdquo;和 &ldquo;检查每<a href=\"http://www.baidu.com\" target=\"_blank\">一行</a>&rdquo;都需要花费大量的时间。</p>\r\n\r\n<p style=\"text-align:left\">幸 运的是，我们的表有30%都是装载在RAM中，所以在从磁盘上检查行的时候，它不会表现的太糟糕。但在<a href=\"http://www.baidu.com\" target=\"_blank\">性能</a>上，它仍然存在非常明显的影响。查询过于简单， 这是一个非常简单的key查找，所以没有显而易见的数据库或应用重构，它很难找到一些简单的方式来解决这个问题。最后，我们使用<span style=\"font-size:14px\"><a href=\"http://www.postgresql.org/message-id/200209271205.49756.josh@agliodbs.com\" style=\"font-size: 12px; cursor: pointer; color: #0066cc;\" target=\"_blank\">PGSQL-Performance邮件</a></span>向社区寻求帮助。&nbsp;</p>\r\n\r\n<p><strong>解决方案</strong></p>\r\n\r\n<p>开源帮了我们，经验丰富的且<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>贡献量非常多的<a href=\"http://en.wikipedia.org/wiki/Tom_Lane_%28computer_scientist%29\" style=\"cursor: pointer; color: #0066cc;\">Tom Lane</a>让我们试试这个：</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n\r\n<ol start=\"1\">\r\n	<li>SELECT&nbsp;c.key,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c.x_key,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c.tags,&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;x.name&nbsp;&nbsp;</li>\r\n	<li>&nbsp;FROM&nbsp;context&nbsp;c&nbsp;&nbsp;</li>\r\n	<li>&nbsp;JOIN&nbsp;x&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;&nbsp;ON&nbsp;c.x_key&nbsp;=&nbsp;x.key&nbsp;&nbsp;</li>\r\n	<li>WHERE&nbsp;c.key&nbsp;=&nbsp;ANY&nbsp;(VALUES&nbsp;(15368196),&nbsp;--&nbsp;11,000&nbsp;other&nbsp;keys&nbsp;--)&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;AND&nbsp;c.x_key&nbsp;=&nbsp;1&nbsp;&nbsp;</li>\r\n	<li>&nbsp;&nbsp;AND&nbsp;c.tags&nbsp;@&gt;&nbsp;ARRAY[E&#39;blah&#39;];&nbsp;&nbsp;</li>\r\n</ol>\r\n</div>\r\n\r\n<p>你能发现有啥不同之处吗？把ARRAY换成了VALUES。</p>\r\n\r\n<p>我们使用ARRAY[...]列举出所有的关键字来进行查询，但却欺骗了查询优化器。Values(...)让优化器充分使用关键字索引。仅仅是<a href=\"http://www.baidu.com\" target=\"_blank\">一行</a><a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>的改变，并且没有产生任何语义的改变。</p>\r\n\r\n<p>下面是新查询语句的写法，差别就在于第三和第十四行。</p>\r\n\r\n<div class=\"dp-highlighter\">\r\n<div class=\"bar\">\r\n<div class=\"tools\">Sql<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a></div>\r\n</div>\r\n</div>\r\n\r\n<p style=\"text-align:left\"><strong>产品里新的查询</strong></p>\r\n\r\n<p>部署后的<a href=\"http://www.baidu.com\" target=\"_blank\">代码</a>：</p>\r\n\r\n<p><a href=\"http://cms.csdnimg.cn/article/201308/27/521c4cd925f9e.jpg\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\"><img alt=\"\" src=\"http://cms.csdnimg.cn/article/201308/27/521c4cd925f9e.jpg\" style=\"border-style:none; height:67px; vertical-align:middle; width:608.9117647058823px\" /></a></p>\r\n\r\n<p>数据库看起来更美观</p>\r\n\r\n<p style=\"text-align:center\"><a href=\"http://cms.csdnimg.cn/article/201308/27/521c4d43ab729.jpg\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\"><img alt=\"\" src=\"http://cms.csdnimg.cn/article/201308/27/521c4d43ab729.jpg\" style=\"border-style:none; vertical-align:middle\" />&nbsp;</a></p>\r\n\r\n<p style=\"text-align:center\"><a href=\"http://cms.csdnimg.cn/article/201308/27/521c4d93a92ef.jpg\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\"><img alt=\"\" src=\"http://cms.csdnimg.cn/article/201308/27/521c4d93a92ef.jpg\" style=\"border-style:none; vertical-align:middle\" /></a></p>\r\n\r\n<p>Postgres慢查询将一去不复返了。但有谁愿意因为这个0.1%的倒霉蛋再去折磨呢？我们使用Datadog来验证<a href=\"http://www.baidu.com\" target=\"_blank\">修改</a>是否正确，它能够做出即时验证。如果你想查看Postgres查询速度的各种影响，&nbsp;<a href=\"https://www.datadoghq.com/signup/\" style=\"cursor: pointer; color: #0066cc;\" target=\"_blank\">不妨试试Datadog</a>吧。</p>\r\n', null, null, '00000000500', 'outsider', '2013-08-31 16:06:13', 'outsider', '2013-10-12 11:26:08', null, '1', null, null);
INSERT INTO `courses` VALUES ('10037', '优质客户服务与客户投诉、抱怨处理技巧11', null, '1', '003_01', '0', '0000002323', '<p>哄我ie和范围范文芳的师范生非</p>\r\n', null, null, '00000000500', 'outsider', '2013-11-26 20:39:58', 'outsider', '2013-11-27 23:45:16', null, '1', null, null);
INSERT INTO `courses` VALUES ('10038', '经营型-高毛利门店精细化管理实战班', null, 'deng', '003_05', '0', '0000008000', '<div class=\"conObjective\" style=\"margin: 0px; padding: 0px 35px; line-height: 25px; font-size: 14px; text-align: left; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\"><strong><a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>遇到的挑战：</strong>\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n&nbsp;&nbsp;&nbsp; 近年来，家居建材、家具家电、服饰鞋业、珠宝皮具、IT手机、汽车配件等耐消品行业连锁<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>遍地开花。对品牌连锁企业来说，<a href=\"http://www.cnbm.net.cn/add/jxs.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>经销商</u></a>加盟商老板超过3家店时，是否感到吃力？开店数越开越多，面积越来越大，但<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>规模与效益平衡<a href=\"http://www.cnbm.net.cn/add/manage.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>困难重重，赢利能力是否降低？是否总是用老化赢利模式、营销方式去运作今天的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>，从厂家、经销商老板到<a href=\"http://www.cnbm.net.cn/add/liansuo.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>店长</u></a>都力不从心？你是否也遇到以下类似的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>运营问题呢？店长、团队、货品、数据、促销、<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>六大赢利基因如何解密？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、<a href=\"http://www.cnbm.net.cn/add/marketing.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>市场</u></a>竞争激烈，<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>营销方式、赢利模式已经老化，创新赢利模式难以建立，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、员工难招，社会<a href=\"http://www.cnbm.net.cn/add/chengben.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>成本</u></a>太高，<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>粗放制约效益，<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>处于亏损状态，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、大店库存控制压力大？大店货品结构不会组合，销售优势难形成，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>事情太多，店长<a href=\"http://www.cnbm.net.cn/add/tuandui.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>团队<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>能力不足，数据账目乱，怎么办？&nbsp;\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>中导购流失率高，如何让员工敬业又乐业，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n6、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>规模与效益不成比例，<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额难以提升，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n7、促销活动效益不断递减？<a href=\"http://www.cnbm.net.cn/add/financial.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>投资</u></a>回报率低，怎么办？\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n<strong>培训目标：</strong>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、系统培养&ldquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>出效益&rdquo;思维。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、系统打造<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>持续赢利的创新模式。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、系统提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>人货场的<a href=\"http://www.baidu.com\"  target=\"_blank\">精细</a>化<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>能力。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、系统提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>经理高效团队<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>与执行能力。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5、系统提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>经营数据分析与全面费用<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>能力。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n6、掌握一套货品组合结构优化方法与提升存货能力工具。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n7、掌握达成公司下达的目标任务与提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>的七大法宝。</div>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<h2 style=\"font-style:normal; text-align:center\">课程大纲</h2>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conObjective\" style=\"margin: 0px; padding: 0px 35px; line-height: 25px; font-size: 14px; text-align: left; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">课程大纲：\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n第一单元：如何培养店长一流的职业习惯？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：不少<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>店长，没有系统接收过优秀店长应具备的<a href=\"http://www.cnbm.net.cn/add/liyi.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>职业素养</u></a>要求，靠自己摸索，格局比较小，看眼前，看物质，看一个店的，对店长个人成长自我设限，制造前进障碍。职业习惯上也缺乏，<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>经营思路不清晰。本单元解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、&nbsp;做好职业&ldquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>人&rdquo;\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、培养一个<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.cnbm.net.cn/add/jingliren.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>职业经理人</u></a>不断成长的素养\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、店长胜任力模块&ldquo;三层楼&rdquo;：一层是知识、二层是技能、三层是价值观\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、五个职业化思维成就你一生：<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>为王、开源节流、货品组合、库存控制、资源配置\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、养成&ldquo;看<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>&rdquo;习惯\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、想看什么？为什么看？怎么去看？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、看自己的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>，看竞争对手的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>，看行业标杆的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、如何看现场？如何从现场的现象和细节看出自己想要的东西？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n三、爱上&ldquo;走动式&rdquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、走动式<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的由来\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、走动式<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的五步法\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、走动式<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>应注意的三个细节\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：四川&times;&times;著名家具品牌要求各店长运用&ldquo;走动式<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>&rdquo;方法提前发现<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>现场问题苗头，及早采取应对措施，大大提升<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>效益。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第二单元：如何打造一支高效执行的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>团队？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：没有一支高效的团队是不可能支撑起一个优秀品牌的。不少<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>者自我定位不清，对公司战略意图理解偏差，<a href=\"http://www.cnbm.net.cn/add/zxl.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>执行力</u></a>下降。工作上难以凝聚员工人心，执行力打折。作为<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>者而言，基本的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>技巧就是管人、管事和管团队三项。只有管人与管事并举，持续强化<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>终端团队精神，品牌<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>生意才能基业常青。解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、如何提升<a href=\"http://www.cnbm.net.cn/add/zxl.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>团队执行力</u></a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、人的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>提升：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>自我：树立榜样、<a href=\"http://www.cnbm.net.cn/add/qingxu.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>情绪<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>、不断学习\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>他人：培训辅导、授权激励、冲突化解、留住骨干\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、事的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>提升：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>制度：政策的执行与奖罚艺术\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>资源：合理利用内外各部门部资源实现目标的策略\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、团队打造的提升：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－营造氛围：如何创建一个相互尊重、快乐高效的工作环境？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－领导风格：在不同团队类型：小型店、中型店、大型店，如何形成独特领导风格？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、如何做好团队成员激励与<a href=\"http://www.cnbm.net.cn/add/performance.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>绩效<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、设计了很多激励指标，但就是不起作用，任务没完成，为什么？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、店员是否成为了流程&ldquo;机器&rdquo;的一个附件？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>员工积极性的10种创新方法\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：上海&times;&times;著名钟表卖场全体店员每月一次团队视频分享会，落实短片中团队精神，三个月就形成了<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>热火朝天的积极氛围。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第三单元：如何做好差异化货品组合与库存控制？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：不少<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>者对库存货品的理解是不负责任的。存货也是一种能力。<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>卖多少货是个数字概念。应是针对不同目标顾客的需求，提供不同品类的库存数量。库存是有成本的，库存也是可以赚钱的，&ldquo;<a href=\"http://www.cnbm.net.cn/add/cangchu.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>库存<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>&rdquo;对<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>者来说，是仅次于&ldquo;销售<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>&rdquo;的第二大<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>理念。解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、如何做好货品组合结构的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、明白零售经营的核心是货品\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、&ldquo;卖多少、卖什么和怎么卖&rdquo;这是个货品组合问题\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－商品是有生命和周期的，是该择优汰劣的\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－商品不是孤立的，是有&ldquo;朋友圈&rdquo;，相互关联和互补的关系\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、怎么卖的命题包含两层意思：一是用什么价格卖；二是如何促销\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、如何做好库存控制与有效订货<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>？　　\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、订货是不能拍脑袋的，必须用数据说话\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、缺品通常会给<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>带来12%的销售损失\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、特别是畅销商品的缺货，销售的提升轻而易举\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、滞销品对于<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>资源的消耗，也会增加<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>的经营成本\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5、实现商品的吐旧纳新与快速周转，<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>的竞争力和盈利能力才有保障\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n三、高水平的店长有很强的存货能力，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、对经营品牌的充分了解\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、有解决存活的方案，消化货品\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、有方法使资金占用额下降，利息下降\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、做到存货在可控范围内，减少损失发生\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：广东某家居照明专卖店运用货品组合金字塔原理，挖掘商品角色与使命，科学订货，快速提升销量，超越商圈竞争对手。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第四单元：如何提升每次<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销活动的效益？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：对于<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销活动，市场部疲了，经销商老板疲了、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>店员疲了、消费者疲了；怎么办？我们促销动机定位是什么？我们每一次的促销都有效吗？我们的促销活动亏钱了吗？我们的促销商品是否带动本品类或其他品类的销售？如何做好<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销活动的创新？解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、新形势下，促销活动的创新策略与效率提升\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、新形势下，促销与利润平衡的困惑\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－促销三境界：三流促销派传单、二流促销搞创新、一流促销精准化\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－促销功能日减，你的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销方式老化了吗？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销活动操作五步骤：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－如何进行促销的有效监控？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销商品的订货、陈列该如何做才比较有效？促销结果该怎样分析？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－衡量促销效率的标准、评价体系是什么？&nbsp;\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、如何做促销创新？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－10种促销创新思维的培养\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－26种促销方法利弊分析\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、&ldquo;精准化促销&rdquo;五种聚焦方法\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、&ldquo;精准化促销&rdquo;的理解\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、区域聚焦、产品聚焦、客类聚焦、单位聚焦、个体聚焦，如何操作？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n三、在促销活动中，如何维护品牌价格体系的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、在竞争商圈内做促销活动，如何科学维护品牌的价格体系？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>的价格体系是<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>利润的基本保障\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－商品是敏感而有价格弹性的，还遵循着边际效用递减规律\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、分析货品组合的金字塔原则，如何分配角色和定价呢？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－不同商品在价格体系中扮演着不同角色与使命\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－有树立形象的、有装主推的、有跑量的、有打击对手的、有赚利润的\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：河南&times;&times;电器连锁<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>运用客户分类聚焦法进行精准式促销，有效提升50%促销效益。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第五单元：如何看懂<a href=\"http://www.cnbm.net.cn/add/baobiao.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>财务报表</u></a>，进行经营数据分析与决策？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：我们不要求店长会设计财务报表，但他们必须看懂财务报表。通过对财务数据的解读，强化经营全局观，强化费用支出意识，强化<a href=\"http://www.cnbm.net.cn/add/caiwu.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>成本控制意识</u></a>，强化<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额意识，强化<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>利润最大化意识。解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、数据分析的6个作用，如何发现数据异动？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、课堂现场测试：<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>有多少可量化的数据\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、&ldquo;没有数据不开口，没有流程不动手&rdquo;\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、如何运用数据分析四步法进行<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>经营分析？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>数据分析的四步法的操作要领\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、运动服饰专卖店数据分析二则\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n三、店长如何看懂财务报表？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、不要被财务报表吓倒，性质一切都是围绕&ldquo;利润&rdquo;转\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、如何读懂三张财务报表：收入表、费用表、<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>表\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、非财务人员必须掌握的8个财务知识点\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n四、如何利用<a href=\"http://www.cnbm.net.cn/add/performance.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>平衡计分卡</u></a>的理念做好<a href=\"http://www.cnbm.net.cn/add/budget.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>全面预算<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、把<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>的经营预算指标，科学地分解到每月、每周、每天\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、分解到每个品类、小类、甚至每个单品\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、使得每天每人都有目标、压力，同时也有动力，如何做到呢？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：广州某建材市场A卫浴品牌专卖店一周《客户进店销售指标分析表》数据的解读与销售对策的形成。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第六单元：如何做好<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>规模与效益平衡，快速提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：有的连锁<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>不赚钱靠总部借钱维持经营，公司财务很受伤。在以<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额为中心的经营策略指导下，除从提升营业额规模获得更高<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>外，在<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>日常经营过程中，还有哪些方法来提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>？如何建立<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>模型？解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、掌握两个基本概念\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额＝营业收入－费用支出\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>率＝<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额／营业额&times;100%\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、建立<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>模型，提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额的七种核心&ldquo;武器&rdquo;：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、从日常<a href=\"http://www.baidu.com\"  target=\"_blank\">精细</a>化<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>10条成本&ldquo;水管&rdquo;中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、从货品组合结构优化中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、从<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>发育三阶段规律中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、从<a href=\"http://www.cnbm.net.cn/add/gyl.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>供应链</u></a>上游和下游中提高<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5、从货品<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>贡献度优化中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n6、从<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>盈亏<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>率平衡中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n7、从货品价格带的优化中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：某超市<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>从各品类<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>贡献度优化的分析出发，有效调整货品组合结构，提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>的经验分享。</div>\r\n', null, null, '00000000500', 'outsider', '2013-11-30 10:53:05', 'outsider', '2013-11-30 10:53:05', null, '1', null, null);
INSERT INTO `courses` VALUES ('10039', '经营型-高毛利门店精细化管理实战班`', null, 'deng', '003_05', '0', '0000008000', '<div class=\"conObjective\" style=\"margin: 0px; padding: 0px 35px; line-height: 25px; font-size: 14px; text-align: left; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\"><strong><a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>遇到的挑战：</strong>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n&nbsp;&nbsp;&nbsp; 近年来，家居建材、家具家电、服饰鞋业、珠宝皮具、IT手机、汽车配件等耐消品行业连锁<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>遍地开花。对品牌连锁企业来说，<a href=\"http://www.cnbm.net.cn/add/jxs.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>经销商</u></a>加盟商老板超过3家店时，是否感到吃力？开店数越开越多，面积越来越大，但<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>规模与效益平衡<a href=\"http://www.cnbm.net.cn/add/manage.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>困难重重，赢利能力是否降低？是否总是用老化赢利模式、营销方式去运作今天的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>，从厂家、经销商老板到<a href=\"http://www.cnbm.net.cn/add/liansuo.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>店长</u></a>都力不从心？你是否也遇到以下类似的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>运营问题呢？店长、团队、货品、数据、促销、<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>六大赢利基因如何解密？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、<a href=\"http://www.cnbm.net.cn/add/marketing.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>市场</u></a>竞争激烈，<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>营销方式、赢利模式已经老化，创新赢利模式难以建立，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、员工难招，社会<a href=\"http://www.cnbm.net.cn/add/chengben.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>成本</u></a>太高，<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>粗放制约效益，<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>处于亏损状态，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、大店库存控制压力大？大店货品结构不会组合，销售优势难形成，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>事情太多，店长<a href=\"http://www.cnbm.net.cn/add/tuandui.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>团队<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>能力不足，数据账目乱，怎么办？&nbsp;\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>中导购流失率高，如何让员工敬业又乐业，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n6、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>规模与效益不成比例，<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额难以提升，怎么办？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n7、促销活动效益不断递减？<a href=\"http://www.cnbm.net.cn/add/financial.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>投资</u></a>回报率低，怎么办？\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n<strong>培训目标：</strong>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、系统培养&ldquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>出效益&rdquo;思维。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、系统打造<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>持续赢利的创新模式。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、系统提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>人货场的<a href=\"http://www.baidu.com\"  target=\"_blank\">精细</a>化<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>能力。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、系统提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>经理高效团队<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>与执行能力。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5、系统提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>经营数据分析与全面费用<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>能力。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n6、掌握一套货品组合结构优化方法与提升存货能力工具。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n7、掌握达成公司下达的目标任务与提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>的七大法宝。</div>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<h2 style=\"font-style:normal; text-align:center\">课程大纲</h2>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conObjective\" style=\"margin: 0px; padding: 0px 35px; line-height: 25px; font-size: 14px; text-align: left; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">课程大纲：\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n第一单元：如何培养店长一流的职业习惯？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：不少<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>店长，没有系统接收过优秀店长应具备的<a href=\"http://www.cnbm.net.cn/add/liyi.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>职业素养</u></a>要求，靠自己摸索，格局比较小，看眼前，看物质，看一个店的，对店长个人成长自我设限，制造前进障碍。职业习惯上也缺乏，<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>经营思路不清晰。本单元解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、&nbsp;做好职业&ldquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>人&rdquo;\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、培养一个<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.cnbm.net.cn/add/jingliren.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>职业经理人</u></a>不断成长的素养\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、店长胜任力模块&ldquo;三层楼&rdquo;：一层是知识、二层是技能、三层是价值观\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、五个职业化思维成就你一生：<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>为王、开源节流、货品组合、库存控制、资源配置\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、养成&ldquo;看<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>&rdquo;习惯\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、想看什么？为什么看？怎么去看？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、看自己的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>，看竞争对手的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>，看行业标杆的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、如何看现场？如何从现场的现象和细节看出自己想要的东西？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n三、爱上&ldquo;走动式&rdquo;<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、走动式<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的由来\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、走动式<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的五步法\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、走动式<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>应注意的三个细节\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：四川&times;&times;著名家具品牌要求各店长运用&ldquo;走动式<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>&rdquo;方法提前发现<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>现场问题苗头，及早采取应对措施，大大提升<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>效益。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第二单元：如何打造一支高效执行的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>团队？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：没有一支高效的团队是不可能支撑起一个优秀品牌的。不少<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>者自我定位不清，对公司战略意图理解偏差，<a href=\"http://www.cnbm.net.cn/add/zxl.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>执行力</u></a>下降。工作上难以凝聚员工人心，执行力打折。作为<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>者而言，基本的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>技巧就是管人、管事和管团队三项。只有管人与管事并举，持续强化<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>终端团队精神，品牌<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>生意才能基业常青。解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、如何提升<a href=\"http://www.cnbm.net.cn/add/zxl.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>团队执行力</u></a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、人的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>提升：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>自我：树立榜样、<a href=\"http://www.cnbm.net.cn/add/qingxu.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>情绪<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>、不断学习\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>他人：培训辅导、授权激励、冲突化解、留住骨干\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、事的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>提升：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>制度：政策的执行与奖罚艺术\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>资源：合理利用内外各部门部资源实现目标的策略\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、团队打造的提升：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－营造氛围：如何创建一个相互尊重、快乐高效的工作环境？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－领导风格：在不同团队类型：小型店、中型店、大型店，如何形成独特领导风格？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、如何做好团队成员激励与<a href=\"http://www.cnbm.net.cn/add/performance.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>绩效<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、设计了很多激励指标，但就是不起作用，任务没完成，为什么？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、店员是否成为了流程&ldquo;机器&rdquo;的一个附件？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>员工积极性的10种创新方法\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：上海&times;&times;著名钟表卖场全体店员每月一次团队视频分享会，落实短片中团队精神，三个月就形成了<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>热火朝天的积极氛围。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第三单元：如何做好差异化货品组合与库存控制？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：不少<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>者对库存货品的理解是不负责任的。存货也是一种能力。<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>卖多少货是个数字概念。应是针对不同目标顾客的需求，提供不同品类的库存数量。库存是有成本的，库存也是可以赚钱的，&ldquo;<a href=\"http://www.cnbm.net.cn/add/cangchu.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>库存<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>&rdquo;对<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>者来说，是仅次于&ldquo;销售<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>&rdquo;的第二大<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>理念。解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、如何做好货品组合结构的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、明白零售经营的核心是货品\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、&ldquo;卖多少、卖什么和怎么卖&rdquo;这是个货品组合问题\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－商品是有生命和周期的，是该择优汰劣的\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－商品不是孤立的，是有&ldquo;朋友圈&rdquo;，相互关联和互补的关系\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、怎么卖的命题包含两层意思：一是用什么价格卖；二是如何促销\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、如何做好库存控制与有效订货<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>？　　\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、订货是不能拍脑袋的，必须用数据说话\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、缺品通常会给<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>带来12%的销售损失\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、特别是畅销商品的缺货，销售的提升轻而易举\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、滞销品对于<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>资源的消耗，也会增加<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>的经营成本\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5、实现商品的吐旧纳新与快速周转，<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>的竞争力和盈利能力才有保障\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n三、高水平的店长有很强的存货能力，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、对经营品牌的充分了解\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、有解决存活的方案，消化货品\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、有方法使资金占用额下降，利息下降\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、做到存货在可控范围内，减少损失发生\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：广东某家居照明专卖店运用货品组合金字塔原理，挖掘商品角色与使命，科学订货，快速提升销量，超越商圈竞争对手。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第四单元：如何提升每次<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销活动的效益？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：对于<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销活动，市场部疲了，经销商老板疲了、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>店员疲了、消费者疲了；怎么办？我们促销动机定位是什么？我们每一次的促销都有效吗？我们的促销活动亏钱了吗？我们的促销商品是否带动本品类或其他品类的销售？如何做好<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销活动的创新？解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、新形势下，促销活动的创新策略与效率提升\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、新形势下，促销与利润平衡的困惑\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－促销三境界：三流促销派传单、二流促销搞创新、一流促销精准化\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－促销功能日减，你的<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销方式老化了吗？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销活动操作五步骤：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－如何进行促销的有效监控？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>促销商品的订货、陈列该如何做才比较有效？促销结果该怎样分析？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－衡量促销效率的标准、评价体系是什么？&nbsp;\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、如何做促销创新？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－10种促销创新思维的培养\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－26种促销方法利弊分析\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、&ldquo;精准化促销&rdquo;五种聚焦方法\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、&ldquo;精准化促销&rdquo;的理解\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、区域聚焦、产品聚焦、客类聚焦、单位聚焦、个体聚焦，如何操作？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n三、在促销活动中，如何维护品牌价格体系的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、在竞争商圈内做促销活动，如何科学维护品牌的价格体系？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>的价格体系是<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>利润的基本保障\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－商品是敏感而有价格弹性的，还遵循着边际效用递减规律\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、分析货品组合的金字塔原则，如何分配角色和定价呢？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－不同商品在价格体系中扮演着不同角色与使命\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n－有树立形象的、有装主推的、有跑量的、有打击对手的、有赚利润的\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：河南&times;&times;电器连锁<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>运用客户分类聚焦法进行精准式促销，有效提升50%促销效益。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第五单元：如何看懂<a href=\"http://www.cnbm.net.cn/add/baobiao.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>财务报表</u></a>，进行经营数据分析与决策？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：我们不要求店长会设计财务报表，但他们必须看懂财务报表。通过对财务数据的解读，强化经营全局观，强化费用支出意识，强化<a href=\"http://www.cnbm.net.cn/add/caiwu.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>成本控制意识</u></a>，强化<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额意识，强化<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>利润最大化意识。解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、数据分析的6个作用，如何发现数据异动？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、课堂现场测试：<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>有多少可量化的数据\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、&ldquo;没有数据不开口，没有流程不动手&rdquo;\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、如何运用数据分析四步法进行<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>经营分析？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>数据分析的四步法的操作要领\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、运动服饰专卖店数据分析二则\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n三、店长如何看懂财务报表？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、不要被财务报表吓倒，性质一切都是围绕&ldquo;利润&rdquo;转\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、如何读懂三张财务报表：收入表、费用表、<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>表\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、非财务人员必须掌握的8个财务知识点\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n四、如何利用<a href=\"http://www.cnbm.net.cn/add/performance.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>平衡计分卡</u></a>的理念做好<a href=\"http://www.cnbm.net.cn/add/budget.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>全面预算<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、把<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>的经营预算指标，科学地分解到每月、每周、每天\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、分解到每个品类、小类、甚至每个单品\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、使得每天每人都有目标、压力，同时也有动力，如何做到呢？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：广州某建材市场A卫浴品牌专卖店一周《客户进店销售指标分析表》数据的解读与销售对策的形成。\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n第六单元：如何做好<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>规模与效益平衡，快速提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n问题背景：有的连锁<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>不赚钱靠总部借钱维持经营，公司财务很受伤。在以<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额为中心的经营策略指导下，除从提升营业额规模获得更高<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>外，在<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>日常经营过程中，还有哪些方法来提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>？如何建立<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>模型？解决方案如下：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、掌握两个基本概念\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额＝营业收入－费用支出\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>率＝<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额／营业额&times;100%\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n二、建立<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>模型，提升<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a><a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>额的七种核心&ldquo;武器&rdquo;：\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1、从日常<a href=\"http://www.baidu.com\"  target=\"_blank\">精细</a>化<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>10条成本&ldquo;水管&rdquo;中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2、从货品组合结构优化中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3、从<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>发育三阶段规律中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4、从<a href=\"http://www.cnbm.net.cn/add/gyl.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>供应链</u></a>上游和下游中提高<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5、从货品<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>贡献度优化中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n6、从<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>盈亏<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>率平衡中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n7、从货品价格带的优化中提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>，如何做到？\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n●&nbsp;案例分析：某超市<a href=\"http://www.baidu.com\"  target=\"_blank\">门店</a>从各品类<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>贡献度优化的分析出发，有效调整货品组合结构，提升<a href=\"http://www.baidu.com\"  target=\"_blank\">毛利</a>的经验分享。</div>\r\n', null, null, '00000000500', 'outsider', '2013-11-30 11:00:18', 'outsider', '2013-11-30 11:00:18', null, '1', null, null);
INSERT INTO `courses` VALUES ('10040', '(内训)管理型-打造金牌店长特训营', null, 'deng', '003_01', '0', '0000134123', '<h2 style=\"font-style:normal; text-align:center\"><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>型-<a href=\"http://www.baidu.com\"  target=\"_blank\">打造</a><a href=\"http://www.baidu.com\"  target=\"_blank\">金牌</a>店长特训营课程特色与背景</h2>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conObjective\" style=\"margin: 0px; padding: 0px 35px; line-height: 25px; font-size: 14px; text-align: left; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">\r\n<div style=\"margin: 0px; padding: 0px;\"><strong>&nbsp;&nbsp;&nbsp; 直面挑战</strong>：</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">&nbsp;&nbsp;&nbsp; 你知道最优秀的<a href=\"http://www.cnbm.net.cn/add/liansuo.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>店长</u></a>与普通的店长之间到底有什么不同特质吗？你是否听说过一个门店更换店长后，三个月内业绩就达到原来的三倍。产品一样，价格一样，店员一样，什么都一样，只是换了一个店长而已。为什么？因为他们的思维不一样，<a href=\"http://www.cnbm.net.cn/add/manage.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u><a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>方法不一样，员工激励模式不一样，其他都一样。我们知道，店长是门店的灵魂，直接影响到店面形象、运作<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>、销售业绩、店面氛围、团队士气。拥有一个称职的优秀的店长，是门店产生良好销售业绩的首要条件！本课程根据世界五百强品牌连锁专卖店工作实践经验研发而成，是零售业中高层人员的必修课程。&ldquo;回去就能用，行动就见效&rdquo;是本次店长系统成长训练营的最大卖点。</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\"><strong>培训目标:</strong></div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、牢记开店的目的：&ldquo;盈利才是硬道理&rdquo;!</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、明确店长的角色定位，服务意识及系统<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>能力。</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">3、掌握高效率门店领导与<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>的方法，迅速提升员工效率。</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">4、树立品牌在门店落地生根信念，学会品牌宣传与塑造的有效方法。</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">5、掌握门店日常营运<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>七大核心&ldquo;武器&rdquo;，确保门店业绩的持续成长。</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">6、学习有效激励与<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>员工和新员工辅导的技巧，迅速提升店长领导才能。</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">7、加强VIP 客户<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>，用优质服务塑造品牌；赢得忠诚顾客，确保门店持续经营。</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">&nbsp;</div>\r\n</div>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<h2 style=\"font-style:normal; text-align:center\">课程大纲</h2>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conObjective\" style=\"margin: 0px; padding: 0px 35px; line-height: 25px; font-size: 14px; text-align: left; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">\r\n<div style=\"margin: 0px; padding: 0px;\"><strong>课程大纲</strong>：</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">第一单元：&ldquo;猴子穿衣不算人&rdquo;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、新任店长的苦恼</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">我的苦恼：&ldquo;猴子穿衣不算人&rdquo;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、作为门店领头羊的＂六大＂角色</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①夹心饼 ②指挥官 ③兴奋剂 ④调和者 ⑤协助者 ⑥培训者</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">3、由&ldquo;超级导购&rdquo;到&ldquo;团队教练&rdquo;的四个角色转换</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①好&ldquo;太太&rdquo;&mdash;做好本职树榜样 ②好&ldquo;媳妇&rdquo;&mdash;上司职务代理人</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">③好&ldquo;妯娌&rdquo;&mdash;部门协作创绩效 ④好&ldquo;妈妈&rdquo;&mdash;带人带心还带性</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">4、明确店面营运的四大目标</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①销售目标 ②盈利目标 ③员工满意目标 ④客户满意目标</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">5、你知道店长每天开门7 件事吗？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">6、快乐的奶牛产奶多：店长的自我情绪与<a href=\"http://www.cnbm.net.cn/add/yali.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>压力<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>方法</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">●你属于哪一幅：《店长的18 张通病画像》</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">第二单元：&ldquo;带人带心，带心带性&rdquo;的<a href=\"http://www.cnbm.net.cn/add/ldl.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>领导力</u></a></div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">一、树立店长权威的123 工程</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①一颗公心 ②两手专业 ③三身榜样</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、店长服众由弱到强的五种权力来源</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①头衔权 ②利益权 ③人事权 ④专业权 ⑤典范权</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">二、分派工作与OJT 教导法</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①分派工作三原则</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">②工作教导四步法</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">教导四步曲：我说你听-我做你看-你做我看-我检查你</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">三、有效的领导激励方法</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①以人为本的四性<a href=\"http://www.cnbm.net.cn/add/communication.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>沟通</u></a>法</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">②细节夸奖的艺术与先麻醉后开刀的批评方法</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">③店面现场人事问题处理的思路与方法</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">④激励员工工作积极性的&ldquo;10 台发动机&rdquo;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">⑤十种&ldquo;刺头&rdquo;员工的<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>艺术</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">●案例分析：IQ 高EQ 低的80 后店员<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>故事</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">第三单元：<a href=\"http://www.baidu.com\"  target=\"_blank\">打造</a>狼性门店团队的＂136 部队＂</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">一、门店团队认知</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">明星队与冠军队，你选谁？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">二、团队协作的困难分析</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①&ldquo;三个和尚&rdquo;扛水过桥启示录</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">②门店内十种无效团队成员</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">③&ldquo;漏水木桶&rdquo;启示录</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">三、狼性门店团队与凝聚力塑造的&quot;136 部队&quot;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①一个观点②三个阶段③六个指标</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">四、<a href=\"http://www.baidu.com\"  target=\"_blank\">打造</a>狼性门店&ldquo;136 部队&rdquo;的六项沟通与协作原则</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">●团队游戏：《报数》与《明镜高悬》的深刻启示</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">第四单元：门店有效营运七大＂武器＂</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">一、七种武器之一：《激情四射的早会经营表》</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、晨会内容-决定销售目标的关键</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、晨会流程-5 分钟晨会推动销售的技巧</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">3、晨会主持&ldquo;推土机&rdquo;：一推士气，二推产品，三推服务</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">二、七种武器之二：《店面客户满意评价表》操作</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、怎样衡量顾客的满意度？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、让顾客满意的两个条件</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">三、七种武器之三：《员工岗位规范检查表》操作</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">四、七种武器之四：《班前检查表》操作</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">五、七种武器之五：《工作待办单》操作</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、工作繁忙，怎么办？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、最有效的<a href=\"http://www.cnbm.net.cn/add/shijian.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>时间<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>工具</u></a>：《工作待办单》</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">3、如何有效运用工作待办单，提升工作效率？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">六、七种武器之六：《销售<a href=\"http://www.cnbm.net.cn/add/mubiao.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>目标<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></u></a>表》操作</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、为什么要做目标<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、店铺目标<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>方法</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①目标分解落实 ②学会用目标激励部属达标</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">3、门店目标<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>中应注意几个问题</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">4、激励部属达成业绩目标的123 方法：</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">①一个窗口：周哈利窗原理</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">②两个公式：Ａ、业绩=意愿&times;能力 Ｂ、表现=潜能－干扰</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">③三个关键: Ａ、连续追踪 Ｂ、强化技能 Ｃ、突出陈列</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">●案例分析：白云国际机场xx 皮具专卖店AB 两班目标PK，创造销量奇迹。</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">七、七种武器之七：《客户信息包》操作</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、做好VIP 客户<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>，持续经营有后劲</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、《客户信息包》的三<a href=\"http://www.cnbm.net.cn/add/vipcustomers.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>大客户</u></a>档案内容</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">3、活用《客户信息包》创造更多业绩</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">●情景实战；店面销售<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>工具应用</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">第五单元：树立服务创新的思维理念</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">一、服务的理念</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、谁是我们的顾客？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、顾客的分类</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">二、顾客的价值</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、失去一个顾客的代价</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、不满意的顾客怎么做？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">3、满意顾客带来的价值</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">三、顾客在购买什么？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、顾客对价格质疑的根本原因在哪里？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、哪些行为在为品牌加分？哪些行为在为品牌减分？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">3、顾客定位-朋友</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">4、导购定位-顾问</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">四、店面服务中的四类明星与四大恶人</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">五、顾客抱怨处理与&ldquo;五步消气法&rdquo;演练</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">第六单元：优质顾客关系<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a></div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">1、优质顾客对门店发展的战略意义</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">2、如何建立优质顾客信息<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>系统？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">3、小组讨论与发表：阻止VIP 顾客跳槽的十大策略</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">●案例分析：&times;&times;著名咖啡<a href=\"http://www.cnbm.net.cn/add/liansuo.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>连锁店</u></a>的顾客关系<a href=\"http://www.baidu.com\"  target=\"_blank\">管理</a>法</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">第七单元：如何使用改善门店问题的工具？</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">大力推行门店问题改善活动：</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">工具一：《改善提案书》应用</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\">工具二：《销售日／周／月报表系统》的正确使用</div>\r\n</div>\r\n', null, null, '00000000500', 'outsider', '2013-11-30 11:07:07', 'outsider', '2013-11-30 11:07:07', null, '1', null, null);
INSERT INTO `courses` VALUES ('10041', '(内训)家族企业战略人力资源管理', null, '我', '003_01', '0', '0000234234', '<h2 style=\"font-style:normal; text-align:center\"><a href=\"http://www.baidu.com\" target=\"_blank\">家族企业</a><a href=\"http://www.baidu.com\" target=\"_blank\">战略</a><a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>课程特色与背景</h2>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conObjective\" style=\"margin: 0px; padding: 0px 35px; line-height: 25px; font-size: 14px; text-align: left; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp; <a href=\"http://www.baidu.com\" target=\"_blank\">家族企业</a>要树立一种&ldquo;得人才，得天下&rdquo;的人才观.坚持以人为本的<a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>思想，建立持续的人才提升和企业<a href=\"http://www.baidu.com\" target=\"_blank\">战略</a>实现的<a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a>策略：\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n1.形成求才、选才、用才、育才、激才、留才的机制&nbsp;.\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2.人员的技能开发与能力培养,建立学习型组织；\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3.建立三个层面<a href=\"http://www.cnbm.net.cn/add/yuangong.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>员工关系</u></a><u><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a></u>及员工职业生涯规划；\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4.建立企业的核心能力体系；\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5.建立规则文化;\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n6.建立经营目标<a href=\"http://www.baidu.com\" target=\"_blank\">战略</a>相统一的能力体系。\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n</div>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<h2 style=\"font-style:normal; text-align:center\">课程大纲</h2>\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n\r\n<div class=\"conObjective\" style=\"margin: 0px; padding: 0px 35px; line-height: 25px; font-size: 14px; text-align: left; color: rgb(0, 0, 0); font-family: 宋体, Arial, sans-serif; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\">课程大纲\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n一、<a href=\"http://www.baidu.com\" target=\"_blank\">战略</a><u><a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a></u>的总体思路\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1.<a href=\"http://www.baidu.com\" target=\"_blank\">战略</a>实施的四个阶段、三大层次\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2.<a href=\"http://www.baidu.com\" target=\"_blank\">战略</a>方案制定四大步骤\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3.竞争力评估框架：三角模型\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4.<a href=\"http://www.baidu.com\" target=\"_blank\">战略</a>相适应的<a href=\"http://www.cnbm.net.cn/add/tuandui.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>组织体系</u></a>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5.<a href=\"http://www.baidu.com\" target=\"_blank\">战略</a>竞争力所需组织能力分析\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n二、组织结构与流程优化\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1:组织结构及岗位调整\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2.&nbsp;岗位调整与流程体系规划\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3．关键流程(BPR)优化完善\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4．关键流程优化与组织结构及岗位细化调整\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n三、<a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>模块\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1:<a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>整体解决方案\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2:<a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>核心内容\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3:<a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>咨询技术说明\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4：现代化<a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a>系统\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5：<a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>体系的实施步骤\r\n\r\n<div class=\"conDivbLank\" style=\"margin: 0px; padding: 0px; width: auto; height: 20px; overflow: hidden;\">&nbsp;</div>\r\n四、<u><a href=\"http://www.baidu.com\" target=\"_blank\">人力资源</a>体系</u>的实施\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n1.职位分析评估\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n2.目标与<a href=\"http://www.cnbm.net.cn/add/performance.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>绩效</u></a><u><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a></u>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n3.<a href=\"http://www.cnbm.net.cn/add/salaries.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>薪酬</u></a><u><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a></u>体系优化\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n4.&nbsp;<a href=\"http://www.cnbm.net.cn/add/recruitment.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>招聘</u></a><u><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a>体系</u>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n5.<a href=\"http://www.cnbm.net.cn/add/trainingsys.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>培训</u></a><u><a href=\"http://www.baidu.com\" target=\"_blank\">管理</a></u>体系\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n6.胜任<a href=\"http://www.cnbm.net.cn/add/recruitment.asp\" style=\"margin: 0px; padding: 0px; text-decoration: none; color: rgb(0, 0, 0);\" target=\"_blank\"><u>素质模型</u></a>\r\n\r\n<div class=\"spctrl\" style=\"margin: 0px; padding: 0px; clear: both;\">&nbsp;</div>\r\n7.员工职业规划</div>\r\n', null, null, '00000000500', 'outsider', '2013-11-30 11:28:44', 'outsider', '2013-11-30 11:28:59', null, '1', null, null);
INSERT INTO `courses` VALUES ('10046', '你的浏览器是否有缓存', null, '2', '003_01', '0', '0000001111', '<p><a href=\"http://www.baidu.com\" target=\"_blank\">课程</a>里面有<a href=\"http://www.baidu.com\" target=\"_blank\">超链接</a>吗？有的话拿出来<a href=\"http://www.baidu.com\" target=\"_blank\">测试</a>一下啊&nbsp; 红啊啊&nbsp; 这是<a href=\"http://www.baidu.com\" target=\"_blank\">另外</a>&nbsp; <a href=\"http://www.baidu.com\" target=\"_blank\">一个</a>&nbsp; <a href=\"http://www.baidu.com\" target=\"_blank\">测试</a></p>\r\n', null, null, '00000000500', 'outsider', '2013-12-05 21:10:03', 'outsider', '2013-12-07 14:43:37', '1', '1', '1', '一个,测试');
INSERT INTO `courses` VALUES ('10047', '今天的心情很不好', null, '2', '003_01', '0', '0000001111', '<p>怎么样啊 的&nbsp; 地方都是【飞是地方了吗上来干嘛利润刚进门了了</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 13:58:36', 'outsider', '2013-12-08 13:58:36', null, '1', null, '很不好');
INSERT INTO `courses` VALUES ('10048', '今天的心情很不好又怎样', null, '1', '003_06', '0', '0000023423', '<p>隔热个软骨软化途径一看</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 14:01:40', 'outsider', '2013-12-08 14:01:40', null, '1', null, '撒旦法');
INSERT INTO `courses` VALUES ('10049', '新增了一个后没反应', null, '4', '003_01', '0', '0000000345', '<p>是个</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 14:07:39', 'outsider', '2013-12-08 14:07:39', '1', '1', '1', '多少分');
INSERT INTO `courses` VALUES ('10050', '新建公开课测试1', null, '3', '003_08', '0', '0000345346', '<p>十多个</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 14:53:17', 'outsider', '2013-12-08 14:53:17', null, '1', '1', '测试,公开');
INSERT INTO `courses` VALUES ('10051', '新建公开课测试2', null, '4', '003_06', '0', '0000111111', '<p>是的</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 19:47:46', 'outsider', '2013-12-08 19:47:46', null, '1', null, '');
INSERT INTO `courses` VALUES ('10052', '新建公开课测试3', null, '2', '003_01', '0', '0000001111', '<p>撒旦法<a class=\"easyui-linkbutton l-btn\" href=\"javascript:void(0)\" iconcls=\"icon-ok\" onclick=\"saveCourse(true)\"><span class=\"l-btn-left\"><span class=\"icon-ok l-btn-focus l-btn-icon-left l-btn-text\">保存</span></span></a></p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 19:51:26', 'outsider', '2013-12-08 19:51:26', null, '1', null, '');
INSERT INTO `courses` VALUES ('10056', '新建公开课测试4', null, '2', '003_01', '0', '0000234234', '<p>成功啦！！</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 20:19:58', 'outsider', '2013-12-08 20:19:58', '0', '1', '0', '');
INSERT INTO `courses` VALUES ('10057', '新建公开课测试5', null, '3', '003_01', '0', '0000008685', '<p>是否个</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 20:26:27', 'outsider', '2013-12-08 20:26:27', '0', '1', '0', '');
INSERT INTO `courses` VALUES ('10058', '新建公开课测试6', null, '2', '003_01', '0', '0000111111', '<p><a href=\"http://www.baidu.com\"  target=\"_blank\">撒旦法</a></p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 20:29:13', 'outsider', '2013-12-08 20:29:13', '0', '1', '0', '撒旦法');
INSERT INTO `courses` VALUES ('10059', '新建公开课测试7', null, '4', '003_01', '0', '0000000234', '<p>时了的房价<a href=\"http://www.baidu.com\" target=\"_blank\">撒旦法</a></p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 20:45:13', 'outsider', '2013-12-12 22:58:28', '0', '1', '0', '撒旦法');
INSERT INTO `courses` VALUES ('10060', '新建公开课测试7', null, '4', '003_01', '1', '0000000234', '<p>时了的房价<a href=\"http://www.baidu.com\"  target=\"_blank\">撒旦法</a></p>\r\n', null, null, '00000000500', 'outsider', '2013-12-08 20:45:16', 'outsider', '2013-12-08 20:45:16', '0', '1', '0', '撒旦法');
INSERT INTO `courses` VALUES ('10061', '新建公开课测试9', null, '2', '003_01', '0', '0000000234', '<p>sdf</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-12 22:59:18', 'outsider', '2013-12-13 23:52:48', '1', '1', '1', '撒旦法');
INSERT INTO `courses` VALUES ('10064', '你的浏览器是否有缓存112121', null, '2', '003_01', '1', '0000000234', '<p>撒旦法</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-13 23:04:40', 'outsider', '2013-12-13 23:04:40', '1', '1', '0', '');
INSERT INTO `courses` VALUES ('10065', '测试用的课程啊啊 啊啊啊', null, '3', '003_01', '1', '0000234234', '<p>硌窝儿个人而而个人</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-13 23:09:26', 'outsider', '2013-12-13 23:09:26', '0', '1', '0', '');
INSERT INTO `courses` VALUES ('10066', '同步到内训的测试', null, '1', '003_02', null, '0000000234', '<p>供热哥和天然已经</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-13 23:50:22', 'outsider', '2013-12-13 23:50:22', '0', '1', '0', '');
INSERT INTO `courses` VALUES ('10067', '同步到内训的测试', null, '1', '003_02', '1', '0000000234', '<p>供热哥和天然已经</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-13 23:50:26', 'outsider', '2013-12-13 23:50:26', '0', '1', '0', '');
INSERT INTO `courses` VALUES ('10068', '新建公开课测试7', null, '2', '003_02', null, '0000000213', '<p>的人格</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-13 23:53:32', 'outsider', '2013-12-13 23:53:32', '0', '1', '0', '');
INSERT INTO `courses` VALUES ('10069', '新建公开课测试7', null, '2', '003_02', '1', '0000000213', '<p>的人格</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-13 23:53:34', 'outsider', '2013-12-13 23:53:34', '0', '1', '0', '');
INSERT INTO `courses` VALUES ('10070', '你的浏览器是否有缓存撒旦法', null, '4', '003_01', '0', '0000000254', '<p>隔热个他华瑞通华瑞通</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-13 23:57:28', 'outsider', '2013-12-13 23:57:28', '1', '0', '1', '');
INSERT INTO `courses` VALUES ('10071', '你的浏览器是否有缓存撒旦法', null, '4', '003_01', '1', '0000000254', '<p>隔热个他华瑞通华瑞通</p>\r\n', null, null, '00000000500', 'outsider', '2013-12-13 23:57:29', 'outsider', '2013-12-13 23:57:29', '1', '1', '1', '');
INSERT INTO `courses` VALUES ('10073', '发布公开课页面测试', null, '2', '003_01', '1', '0000000234', '<p><a href=\"http://www.baidu.com\"  target=\"_blank\">撒旦法</a>&nbsp; 哈哈哈哈&nbsp; 课程啊&nbsp; 在杭州<a href=\"http://www.baidu.com\"  target=\"_blank\">举行</a></p>\r\n', null, null, '00000000500', null, '2013-12-21 15:41:07', null, '2013-12-21 15:41:07', '0', '1', '0', '撒旦法,举行');
INSERT INTO `courses` VALUES ('10074', '发布公开课页面测试1', null, '1', '003_01', '0', '0002343434', '<p>为俄国和认同和认同和ethernet挺好玩问题吃吧途径伊利临沂优酷法国吧</p>\r\n', null, null, '00000000500', null, '2013-12-21 15:45:59', null, '2013-12-21 15:45:59', '0', '1', '0', '撒旦法,哈哈');
INSERT INTO `courses` VALUES ('10075', '发布公开课页面测试2', null, '1', '003_01', '0', '0000000234', '<p>刚我热管</p>\r\n', null, null, '00000000500', null, '2013-12-21 15:48:43', null, '2013-12-21 15:48:43', '1', '1', '0', '');
INSERT INTO `courses` VALUES ('10076', '发布公开课页面测试2', null, '1', '003_01', '1', '0000000234', '<p>刚我热管</p>\r\n', null, null, '00000000500', null, '2013-12-21 15:48:44', null, '2013-12-21 15:48:44', '1', '1', '0', '');
INSERT INTO `courses` VALUES ('10077', '发布公开课页面测试3', null, '1', '003_01', '0', '0000001111', '<p>硌窝儿个人刚</p>\r\n', null, null, '00000000500', null, '2013-12-21 15:57:32', null, '2013-12-21 15:57:32', '1', '1', '0', '');
INSERT INTO `courses` VALUES ('10078', '发布公开课页面测试4', null, '2', '003_01', '0', '0000000234', '<p>刚我热管二哥特惠忽悠人家i杨阔了u；了</p>\r\n', null, null, '00000000500', null, '2013-12-21 16:08:43', null, '2013-12-21 16:08:43', '0', '1', '0', '');
INSERT INTO `courses` VALUES ('10079', '发布公开课页面测试5', null, '2', '003_01', '0', '0000000213', '<p>和天然和人员u7 u愉快愉快看</p>\r\n', null, null, '00000000500', null, '2013-12-21 16:11:26', null, '2013-12-21 16:11:26', '0', '1', '0', '');
INSERT INTO `courses` VALUES ('10080', '发布公开课页面测试5', null, '2', '003_01', '0', '0000000213', '<p>和天然和人员u7 u愉快愉快看</p>\r\n', null, null, '00000000500', null, '2013-12-21 16:11:27', null, '2013-12-21 16:12:14', '0', '1', '0', '');
INSERT INTO `coursesubjects` VALUES ('11', '10014', '7', '综合');
INSERT INTO `coursesubjects` VALUES ('12', '10014', '8', '部门经理');
INSERT INTO `coursesubjects` VALUES ('43', '10034', '1', '企业管理');
INSERT INTO `coursesubjects` VALUES ('44', '10034', '2', '企业发展');
INSERT INTO `coursesubjects` VALUES ('71', '10025', '11', '财税风险管理');
INSERT INTO `coursesubjects` VALUES ('98', '10009', '20', '五十六个民族是一家');
INSERT INTO `coursesubjects` VALUES ('105', '10026', '27', '企业所得税税前扣除管理办法');
INSERT INTO `coursesubjects` VALUES ('122', '10036', '29', '性能提升');
INSERT INTO `coursesubjects` VALUES ('123', '10036', '28', '修改代码');
INSERT INTO `coursesubjects` VALUES ('126', '10031', '19', '企业税务健康检查');
INSERT INTO `coursesubjects` VALUES ('158', '10022', '52', '培训课程');
INSERT INTO `coursesubjects` VALUES ('163', '10018', '18', '抱怨处理技巧提升');
INSERT INTO `coursesubjects` VALUES ('166', '10033', '9', '领导力高效');
INSERT INTO `coursesubjects` VALUES ('169', '10037', '51', '抱怨处理技巧提升');
INSERT INTO `coursesubjects` VALUES ('170', '10010', '25', '企业在运用税收优惠政策中常见的误');
INSERT INTO `coursesubjects` VALUES ('171', '10010', '24', '最新企业税收优惠政策及其纳税筹划');
INSERT INTO `coursesubjects` VALUES ('172', '10035', '26', '深圳电子标杆学习之旅');
INSERT INTO `coursesubjects` VALUES ('175', '10028', '5', '企业管理');
INSERT INTO `coursesubjects` VALUES ('176', '10028', '6', '企业发展');
INSERT INTO `coursesubjects` VALUES ('179', '10038', '54', '门店精细化管理实战班');
INSERT INTO `coursesubjects` VALUES ('180', '10039', '54', '门店精细化管理实战班');
INSERT INTO `coursesubjects` VALUES ('181', '10040', '55', '打造金牌店长特训营');
INSERT INTO `coursesubjects` VALUES ('183', '10041', '57', '家族企业战略人力资源管理');
INSERT INTO `coursesubjects` VALUES ('184', '10012', '3', '采购');
INSERT INTO `coursesubjects` VALUES ('185', '10012', '4', '供应商');
INSERT INTO `coursesubjects` VALUES ('215', '10046', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('216', '10047', '60', '很不好的心情');
INSERT INTO `coursesubjects` VALUES ('217', '10048', '61', 'jojO');
INSERT INTO `coursesubjects` VALUES ('218', '10049', '62', '是个');
INSERT INTO `coursesubjects` VALUES ('219', '10050', '64', '公开');
INSERT INTO `coursesubjects` VALUES ('220', '10050', '63', '测试');
INSERT INTO `coursesubjects` VALUES ('221', '10051', '65', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('222', '10052', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('223', '10056', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('224', '10057', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('225', '10058', '66', '公司个');
INSERT INTO `coursesubjects` VALUES ('227', '10060', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('258', '10059', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('269', '10064', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('270', '10065', '68', '的');
INSERT INTO `coursesubjects` VALUES ('271', '10001', '1', '企业管理');
INSERT INTO `coursesubjects` VALUES ('272', '10001', '2', '企业发展');
INSERT INTO `coursesubjects` VALUES ('273', '10066', '67', '同步测试');
INSERT INTO `coursesubjects` VALUES ('274', '10067', '67', '同步测试');
INSERT INTO `coursesubjects` VALUES ('275', '10061', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('276', '10068', '67', '同步测试');
INSERT INTO `coursesubjects` VALUES ('277', '10069', '67', '同步测试');
INSERT INTO `coursesubjects` VALUES ('278', '10070', '69', '撒旦法');
INSERT INTO `coursesubjects` VALUES ('279', '10071', '69', '撒旦法');
INSERT INTO `coursesubjects` VALUES ('280', '10032', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('282', '10073', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('283', '10074', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('284', '10075', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('285', '10076', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('286', '10077', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('287', '10078', '59', '浏览器缓存');
INSERT INTO `coursesubjects` VALUES ('288', '10079', '70', '同步测试');
INSERT INTO `coursesubjects` VALUES ('290', '10080', '70', '同步测试');
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
INSERT INTO `coursetarget` VALUES ('134', '10009', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('135', '10009', '秘书', '010_03');
INSERT INTO `coursetarget` VALUES ('141', '10026', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('142', '10026', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('152', '10036', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('186', '10018', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('187', '10018', '秘书', '010_03');
INSERT INTO `coursetarget` VALUES ('192', '10033', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('193', '10033', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('194', '10010', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('195', '10035', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('198', '10012', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('199', '10012', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('278', '10046', '好吧就这样吧', '010_11');
INSERT INTO `coursetarget` VALUES ('279', '10046', '我的课程', '010_8');
INSERT INTO `coursetarget` VALUES ('280', '10046', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('281', '10046', '测试测试一下想', '010_10');
INSERT INTO `coursetarget` VALUES ('282', '10047', '怎么回事啊', '010_7');
INSERT INTO `coursetarget` VALUES ('283', '10047', '测试测试一下想', '010_10');
INSERT INTO `coursetarget` VALUES ('302', '10001', '企业老总', '010_01');
INSERT INTO `coursetarget` VALUES ('303', '10001', '财务从业人员', '010_02');
INSERT INTO `coursetarget` VALUES ('304', '10061', '好吧就这样吧', '010_11');
INSERT INTO `coursetarget` VALUES ('305', '10061', '我的课程', '010_8');
INSERT INTO `coursetarget` VALUES ('306', '10077', '测试测试一下想', '010_10');
INSERT INTO `downloadkeywords` VALUES ('34', '381', '20', 'whatthe66');
INSERT INTO `downloadkeywords` VALUES ('35', '380', '20', 'whatthefuck');
INSERT INTO `downloadkeywords` VALUES ('36', '387', '22', '资料');
INSERT INTO `downloadkeywords` VALUES ('37', '386', '22', '讲课');
INSERT INTO `downloadkeywords` VALUES ('38', '225', '18', '如何');
INSERT INTO `downloadkeywords` VALUES ('39', '241', '18', '学习');
INSERT INTO `downloadkeywords` VALUES ('40', '366', '21', '同步');
INSERT INTO `downloadkeywords` VALUES ('41', '289', '21', '测试');
INSERT INTO `downloadkeywords` VALUES ('42', '388', '21', '然后');
INSERT INTO `downloadkeywords` VALUES ('43', '391', '23', '第一次');
INSERT INTO `downloadkeywords` VALUES ('44', '390', '23', '接触');
INSERT INTO `downloadkeywords` VALUES ('45', '389', '23', '亲密');
INSERT INTO `downloadkeywords` VALUES ('46', '394', '24', '有效');
INSERT INTO `downloadkeywords` VALUES ('47', '395', '24', '进行');
INSERT INTO `downloadkeywords` VALUES ('48', '392', '24', '企业管理');
INSERT INTO `downloadkeywords` VALUES ('49', '393', '24', '下载');
INSERT INTO `downloadkeywords` VALUES ('50', '398', '24', '课程');
INSERT INTO `downloadkeywords` VALUES ('51', '396', '24', '怎样');
INSERT INTO `downloadkeywords` VALUES ('52', '397', '24', '讲义');
INSERT INTO `downloadkeywords` VALUES ('53', '402', '25', '测试');
INSERT INTO `downloadkeywords` VALUES ('54', '400', '25', '专题');
INSERT INTO `downloadkeywords` VALUES ('55', '401', '25', '实现');
INSERT INTO `downloadkeywords` VALUES ('56', '399', '25', '实行');
INSERT INTO `downloadkeywords` VALUES ('57', '407', '26', '通知');
INSERT INTO `downloadkeywords` VALUES ('58', '409', '26', '文件');
INSERT INTO `downloadkeywords` VALUES ('59', '408', '26', '人力资源');
INSERT INTO `downloadkeywords` VALUES ('60', '410', '27', '财务管理');
INSERT INTO `downloadkeywords` VALUES ('61', '414', '27', '强化');
INSERT INTO `downloadkeywords` VALUES ('62', '413', '27', '培训班');
INSERT INTO `downloadkeywords` VALUES ('63', '412', '27', '系统');
INSERT INTO `downloadkeywords` VALUES ('64', '411', '27', '资料');
INSERT INTO `downloadkeywords` VALUES ('65', '418', '28', '资料');
INSERT INTO `downloadkeywords` VALUES ('66', '420', '28', '强化训练');
INSERT INTO `downloadkeywords` VALUES ('67', '419', '28', '培训');
INSERT INTO `downloadkeywords` VALUES ('68', '422', '28', '技能');
INSERT INTO `downloadkeywords` VALUES ('69', '421', '28', '管理');
INSERT INTO `downloadkeywords` VALUES ('70', '423', '28', '战略');
INSERT INTO `downloadkeywords` VALUES ('71', '427', '29', '仓储');
INSERT INTO `downloadkeywords` VALUES ('72', '203', '29', '采购');
INSERT INTO `downloadkeywords` VALUES ('73', '424', '29', '之类');
INSERT INTO `downloadkeywords` VALUES ('74', '387', '29', '资料');
INSERT INTO `downloadkeywords` VALUES ('75', '425', '29', '供应');
INSERT INTO `downloadkeywords` VALUES ('76', '426', '29', '蔡锷');
INSERT INTO `downloadkeywords` VALUES ('77', '429', '30', '有效');
INSERT INTO `downloadkeywords` VALUES ('78', '430', '30', '进行');
INSERT INTO `downloadkeywords` VALUES ('79', '428', '30', '企业管理');
INSERT INTO `downloadkeywords` VALUES ('80', '431', '30', '怎样');
INSERT INTO `downloadkeywords` VALUES ('81', '432', '30', '435345');
INSERT INTO `downloadkeywords` VALUES ('82', '434', '31', '物料');
INSERT INTO `downloadkeywords` VALUES ('83', '203', '31', '采购');
INSERT INTO `downloadkeywords` VALUES ('84', '433', '31', '无聊');
INSERT INTO `downloadkeywords` VALUES ('85', '427', '31', '仓储');
INSERT INTO `downloadkeywords` VALUES ('86', '387', '31', '资料');
INSERT INTO `downloadkeywords` VALUES ('87', '425', '31', '供应');
INSERT INTO `downloadkeywords` VALUES ('88', '289', '32', '测试');
INSERT INTO `downloadkeywords` VALUES ('89', '435', '32', '小数点');
INSERT INTO `downloadkeywords` VALUES ('90', '436', '32', '精度');
INSERT INTO `downloads` VALUES ('18', '如何学习', '2', 'ppt', '如何学习', '雷理超', '2013-12-29 11:42:48', '200', '200', '3.2', '003_01');
INSERT INTO `downloads` VALUES ('20', '财务管理的讲解ppt', 'sd', 'ppt', '财务管理的线性性', 'John Dou', '2013-12-28 21:11:07', '123', '234', '3.2', '003_02');
INSERT INTO `downloads` VALUES ('21', '同步到内训的测试', 'D:\\test\\files\\同步到内训的测试.pdf', 'ppt', '测试测试而已啦，不用大惊小怪的', '雷理超', '2013-12-29 11:45:00', '200', '200', '8.4', '003_02');
INSERT INTO `downloads` VALUES ('22', '讲课的资料', 'D:\\test\\files\\讲课的资料.pdf', 'doc', '为了你为何地方 是东方和佛号', '雷理超', '2013-12-28 22:19:04', '200', '200', '6.8', '003_02');
INSERT INTO `downloads` VALUES ('23', '第一次的亲密接触', 'D:\\test\\files\\第一次的亲密接触.docx', 'doc', '第一次的情谜接触', '轻舞飞扬', '2013-12-29 11:46:39', '200', '200', '907', '003_06');
INSERT INTO `downloads` VALUES ('24', '怎样有效的进行企业管理的课程讲义下载', 'D:\\test\\files\\怎样有效的进行企业管理的课程讲义下载.rar', 'pdf', '请稍后', '雷理超', '2013-12-29 11:48:23', '200', '200', '36756', '003_07');
INSERT INTO `downloads` VALUES ('25', '测试专题的实行实现', 'D:\\test\\files\\测试专题的实行实现.pdf', 'ppt', '撒旦法', '雷理超', '2013-12-29 12:50:55', '200', '200', '4926', '003_03');
INSERT INTO `downloads` VALUES ('26', '人力资源部通知文件', 'D:\\test\\files\\人力资源部通知文件.mp3', 'doc', '刚认为该', '雷理超', '2013-12-29 13:54:55', '200', '200', '3793', '003_07');
INSERT INTO `downloads` VALUES ('27', '财务管理系统强化培训班资料', 'D:\\test\\files\\财务管理系统强化培训班资料.mp3', 'doc', '和认同和让他 ', '雷理超', '2013-12-29 13:57:03', '200', '200', '10842', '003_05');
INSERT INTO `downloads` VALUES ('28', '战略管理与技能培训强化训练资料', 'D:\\test\\files\\战略管理与技能培训强化训练资料.mp3', 'doc', '隔天刚 ', '雷理超', '2013-12-29 14:02:21', '200', '200', '12559837', '003_06');
INSERT INTO `downloads` VALUES ('29', '蔡锷采购供应链仓储之类的资料', 'D:\\test\\files\\蔡锷采购供应链仓储之类的资料.mp3', 'doc', 'hertz', '雷理超', '2013-12-29 14:03:49', '200', '200', '11', '003_02');
INSERT INTO `downloads` VALUES ('30', '怎样有效的进行企业管理435345', 'D:\\test\\files\\怎样有效的进行企业管理435345.zip', 'doc', '华瑞通', '和人', '2013-12-29 14:06:51', '200', '200', '17', '003_03');
INSERT INTO `downloads` VALUES ('31', '采购供应链仓储无聊物料资料', 'D:\\test\\files\\采购供应链仓储无聊物料资料.themepack', 'doc', '和人格', '雷理超', '2013-12-29 14:13:53', '200', '200', '11', '003_02');
INSERT INTO `downloads` VALUES ('32', '小数点的精度测试', 'D:\\test\\files\\小数点的精度测试.mp3', 'doc', '和个人刚', '雷理超', '2013-12-29 14:20:54', '200', '200', '11.11', '003_02');
INSERT INTO `downloadsubjects` VALUES ('1', '25', '74', '测试');
INSERT INTO `downloadsubjects` VALUES ('2', '25', '72', '专题');
INSERT INTO `downloadsubjects` VALUES ('3', '25', '73', '实现');
INSERT INTO `downloadsubjects` VALUES ('4', '25', '71', '实行');
INSERT INTO `downloadsubjects` VALUES ('5', '26', '75', '通知');
INSERT INTO `downloadsubjects` VALUES ('6', '26', '77', '文件');
INSERT INTO `downloadsubjects` VALUES ('7', '26', '76', '人力资源');
INSERT INTO `downloadsubjects` VALUES ('8', '27', '78', '强化');
INSERT INTO `downloadsubjects` VALUES ('9', '27', '79', '培训');
INSERT INTO `downloadsubjects` VALUES ('10', '27', '80', '财务');
INSERT INTO `downloadsubjects` VALUES ('11', '28', '82', '强化训练合集');
INSERT INTO `downloadsubjects` VALUES ('12', '28', '83', '资料');
INSERT INTO `downloadsubjects` VALUES ('13', '29', '84', '采购资料');
INSERT INTO `downloadsubjects` VALUES ('14', '29', '85', '治疗');
INSERT INTO `downloadsubjects` VALUES ('15', '30', '86', '隔热个');
INSERT INTO `downloadsubjects` VALUES ('16', '31', '87', '资料合集');
INSERT INTO `downloadsubjects` VALUES ('17', '32', '88', '测试合集');
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
INSERT INTO `keywords` VALUES ('311', '培训', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('312', '项目', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('313', '课程', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('314', '实战', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('315', '精细', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('316', '经营型', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('317', '门店', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('318', '管理', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('319', '毛利', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('320', '打造', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('321', '金牌', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('322', '世纪', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('323', '21', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('324', '形势', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('325', '贸易', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('326', '人力资源', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('327', '战略', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('328', '家族企业', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('329', '我们', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('330', '好孩子', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('331', '都是', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('332', '早点', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('333', '起来', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('334', '做事', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('335', '那个', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('336', '老师', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('337', '你是', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('338', '干什么', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('339', '缓存', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('340', '你的', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('341', '是否', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('342', '浏览器', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('343', '心情', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('344', '很不', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('345', '今天', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('346', '心情', null, null, '003_06', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('347', '很不', null, null, '003_06', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('348', '今天', null, null, '003_06', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('349', '怎样', null, null, '003_06', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('350', '后没', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('351', '新增', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('352', '反应', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('353', '一个', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('354', '新建', null, null, '003_08', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('355', '测试', null, null, '003_08', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('356', '公开', null, null, '003_08', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('357', '新建', null, null, '003_06', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('358', '测试', null, null, '003_06', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('359', '公开', null, null, '003_06', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('363', '新建', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('364', '公开', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('365', '同步', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('366', '同步', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('367', '112121', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('368', '用的', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('369', '课程', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('370', '浏览器', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('371', '是否', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('372', '你的', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('373', '缓存', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('374', '新建', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('375', '公开', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('376', '发布', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('377', '页面', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `keywords` VALUES ('378', '内训车', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('379', 'Ilovetofuck', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('380', 'whatthefuck', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('381', 'whatthe66', null, null, '003_01', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('382', 'whatthe66', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('383', 'Ilovetofuck', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('384', 'whatthefuck', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('385', '学习', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('386', '讲课', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('387', '资料', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('388', '然后', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('389', '亲密', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('390', '接触', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('391', '第一次', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('392', '企业管理', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('393', '下载', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('394', '有效', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('395', '进行', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('396', '怎样', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('397', '讲义', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('398', '课程', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('399', '实行', null, null, '003_03', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('400', '专题', null, null, '003_03', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('401', '实现', null, null, '003_03', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('402', '测试', null, null, '003_03', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('403', '实行', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('404', '专题', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('405', '实现', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('406', '再次', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('407', '通知', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('408', '人力资源', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('409', '文件', null, null, '003_07', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('410', '财务管理', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('411', '资料', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('412', '系统', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('413', '培训班', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('414', '强化', null, null, '003_05', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('415', '实行', null, null, '003_08', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('416', '专题', null, null, '003_08', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('417', '实现', null, null, '003_08', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('418', '资料', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('419', '培训', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('420', '强化训练', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('421', '管理', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('422', '技能', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('423', '战略', null, null, '003_06', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('424', '之类', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('425', '供应', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('426', '蔡锷', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('427', '仓储', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('428', '企业管理', null, null, '003_03', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('429', '有效', null, null, '003_03', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('430', '进行', null, null, '003_03', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('431', '怎样', null, null, '003_03', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('432', '435345', null, null, '003_03', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('433', '无聊', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('434', '物料', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('435', '小数点', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `keywords` VALUES ('436', '精度', null, null, '003_02', '500', '500', null, null, '1');
INSERT INTO `orginfo` VALUES ('1', '2', '人人培训', '天河东路', '51000123', '邓生啊阿斯蒂芬', '13640713241', '8960', '8960', 'www.baidu.com', '内训培训', '我们是个好机构，专门培养各种人才我去阿的发放');
INSERT INTO `questions` VALUES ('1', '天气预报怎么生成的', '撒的发松岛枫', '1', '2013-11-12', '五金');
INSERT INTO `questions` VALUES ('2', '公积金问题', '我的公积金账户出问题啦', '1', '2013-11-19', '雷理超');
INSERT INTO `questions` VALUES ('3', '优质客户服务与客户投诉、抱怨处理技巧提升', '发生什么事情，需要怎样解决', '1', '2013-11-19', '地方');
INSERT INTO `questions` VALUES ('8', '豆腐干', '多少分', '1', '2013-11-19', '雷理超');
INSERT INTO `questions` VALUES ('9', '高效的领导力', '的个', '0', '2013-11-19', '豆腐干');
INSERT INTO `questions` VALUES ('10', '风格化', '个人让他和任何让他华瑞通和认同和', '0', '2013-11-19', '地方');
INSERT INTO `questions` VALUES ('11', '公积金问题1', '公积金问题   很多疑问  求解答', '0', '2013-11-20', '雷理超');
INSERT INTO `requirements` VALUES ('1', '1', '怎样创建中国共产党', '12', '2', '2013-11-06', '2013-11-22', '广州', '毛泽东', '110', '119', '中华人民共和国', '上课上课', 'haode', '1', '2013-11-06 23:16:34', '763658583@qq.com');
INSERT INTO `requirements` VALUES ('2', '1', '怎样创建中国共产党', '12', '2', '2013-11-06', '2013-11-22', '广州', '毛泽东', '110', '119', '中华人民共和国', '上课上课', 'yes sir', '1', '2013-11-06 23:16:34', '763658583@qq.com');
INSERT INTO `subjects` VALUES ('1', '企业管理', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('2', '企业发展', null, null, '003_01', '500', '500', '1', '2013-08-18 16:03:19', '0');
INSERT INTO `subjects` VALUES ('3', '采购', null, null, '003_02', '500', '500', '1', '2013-08-18 16:03:19', '0');
INSERT INTO `subjects` VALUES ('4', '供应商', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('5', '企业管理', null, null, '003_02', '500', '500', '1', '2013-08-18 16:03:19', '0');
INSERT INTO `subjects` VALUES ('6', '企业发展', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('7', '综合', null, null, '003_02', '500', '500', '1', '2013-12-29 12:47:15', '0');
INSERT INTO `subjects` VALUES ('8', '部门经理', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('9', '领导力高效', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('10', '什么意思啊？', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('11', '财税风险管理', null, null, '003_02', '500', '500', '1', '2013-08-18 16:26:04', '0');
INSERT INTO `subjects` VALUES ('18', '抱怨处理技巧提升', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('19', '企业税务健康检查', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('20', '五十六个民族是一家', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('21', '我们为什么要走社会主义道路', '1', null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('22', '社会怎么了', '1', null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('23', '资本主义不好吗', '1', null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('24', '最新企业税收优惠政策及其纳税筹划', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('25', '企业在运用税收优惠政策中常见的误', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('26', '深圳电子标杆学习之旅', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('27', '企业所得税税前扣除管理办法', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('28', '修改代码', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('29', '性能提升', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('34', '人', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('35', '犯规', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('36', '旅游什么的', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('37', '旅游什么的', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('38', '资本主义垮台', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('39', '意外', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('40', '是的', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('41', '星期一', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('42', '什么意思啊', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('43', '中文文章', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('44', 'take1', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('45', '发布资讯', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('46', '还在', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('51', '抱怨处理技巧提升', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('52', '培训课程', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('53', '发布资讯1', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('54', '门店精细化管理实战班', null, null, '003_05', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('55', '打造金牌店长特训营', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('56', '很好', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('57', '家族企业战略人力资源管理', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('59', '浏览器缓存', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('60', '很不好的心情', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('61', 'jojO', null, null, '003_06', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('62', '是个', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('63', '测试', null, null, '003_08', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('64', '公开', null, null, '003_08', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('65', '浏览器缓存', null, null, '003_06', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('66', '公司个', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('67', '同步测试', null, null, '003_02', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('68', '的', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('69', '撒旦法', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('70', '同步测试', null, null, '003_01', '500', '500', null, null, '0');
INSERT INTO `subjects` VALUES ('71', '实行', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('72', '专题', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('73', '实现', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('74', '测试', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('75', '通知', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('76', '人力资源', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('77', '文件', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('78', '强化', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('79', '培训', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('80', '财务', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('82', '强化训练合集', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('83', '资料', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('84', '采购资料', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('85', '治疗', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('86', '隔热个', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('87', '资料合集', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
INSERT INTO `subjects` VALUES ('88', '测试合集', null, null, '[\\pP‘’“”_]', '500', '500', null, null, '1');
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
INSERT INTO `sys_dictionary` VALUES ('33', '003', '003_01', '财务管理', null, null, null, null, '1', '财务管理相关课程');
INSERT INTO `sys_dictionary` VALUES ('35', '998', '004', '测试分类', null, null, null, null, '1', '个人股');
INSERT INTO `sys_dictionary` VALUES ('36', '003', '003_02', '采购供应链仓储', null, null, null, null, '1', '采购供应链仓储相关的课程');
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
INSERT INTO `sys_dictionary` VALUES ('58', '007', '007_04', '苏州', null, null, null, null, '1', '苏州');
INSERT INTO `sys_dictionary` VALUES ('59', '998', '011', '产品', null, null, null, null, '1', '产品类别');
INSERT INTO `sys_dictionary` VALUES ('60', '011', '011_01', '软件产品', null, null, null, null, '1', '软件产品');
INSERT INTO `sys_dictionary` VALUES ('61', '011', '011_02', '日用品', null, null, null, null, '1', '日用品');
INSERT INTO `sys_dictionary` VALUES ('62', '007', '007_05', '上海', null, null, null, null, '1', '上海');
INSERT INTO `sys_dictionary` VALUES ('63', '007', '007_06', '长沙', null, null, null, null, '1', '长沙');
INSERT INTO `sys_dictionary` VALUES ('64', '003', '003_03', '人力资源管理', null, null, null, null, '1', '人力资源管理');
INSERT INTO `sys_dictionary` VALUES ('65', '003', '003_04', '生产管理', null, null, null, null, '1', '生产管理');
INSERT INTO `sys_dictionary` VALUES ('66', '003', '003_05', '市场营销', null, null, null, null, '1', '市场营销');
INSERT INTO `sys_dictionary` VALUES ('67', '003', '003_06', '战略管理', null, null, null, null, '1', '战略管理');
INSERT INTO `sys_dictionary` VALUES ('68', '003', '003_07', '项目管理', null, null, null, null, '1', '项目管理');
INSERT INTO `sys_dictionary` VALUES ('69', '003', '003_08', '职业技能', null, null, null, null, '1', '职业技能');
INSERT INTO `sys_dictionary` VALUES ('70', '011', '011_122', '产品1', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('71', '011', '011_222', '产品2', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('72', '002', '002_009', '文章分类测试分类', '1', null, null, null, '1', '没什么');
INSERT INTO `sys_dictionary` VALUES ('74', '002', '002_10', '文章分类测试分类3', '3', null, null, null, '1', '撒旦法');
INSERT INTO `sys_dictionary` VALUES ('77', '002', '002_11', '文章分类测试分类4', '1', null, null, null, '1', '');
INSERT INTO `sys_dictionary` VALUES ('78', '002', '002_12', '地方', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('79', '002', '002_13', '个', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('84', '002', '002_14', '在重复', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('85', '002', '002_15', '再重复', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('86', '002', '002_16', '重复', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('87', '002', '002_17', '哈哈', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('88', '002', '002_18', 'greg', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('91', '011', '011_223', '产品1缓存', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('92', '011', '011_224', '没是的麻烦', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('93', '008', '008_3', '信息系统', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('94', '008', '008_4', '普通', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('95', '010', '010_4', '干嘛啊', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('96', '010', '010_5', '抽风的', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('97', '005', '005_0000', 'value3', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('98', '005', '005_1', 'value1', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('99', '005', '005_2', 'value2', null, null, null, null, '1', null);
INSERT INTO `sys_dictionary` VALUES ('100', '010', '010_6', '就是这个', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('101', '010', '010_7', '怎么回事啊', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('102', '010', '010_8', '我的课程', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('103', '010', '010_9', '测试测试', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('104', '010', '010_10', '测试测试一下想', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('105', '010', '010_11', '好吧就这样吧', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('106', '009', '009_3', '我的课程专业', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('107', '008', '008_5', '我的', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('108', '009', '009_4', '还有个什么呢', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('109', '011', '011_225', '高级课程产品', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('110', '011', '011_226', '对应高级课程的高级', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('111', '011', '011_227', '123456', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('112', '011', '011_228', '我的产品听我的', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('113', '011', '011_229', '1234546787', null, null, null, null, null, null);
INSERT INTO `sys_dictionary` VALUES ('114', '002', '002_19', '测试扯淡-df', null, null, null, null, '1', '');
INSERT INTO `teacher_info` VALUES ('1', '3', '邓卫华', '2013-06-20', '人力资源', '1000', '800', '8960', '13640713241', '13640713241', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '人力资源，内部培训等');
INSERT INTO `teacher_info` VALUES ('2', '13', '雷理超', '1988-12-06', '', '1000', '1000', '', '020-89608900', '', '123445', '123456');
INSERT INTO `teacher_info` VALUES ('3', null, '路人甲', '2013-06-20', '人力资源', '1231', '234234', '1234123', '13450461343', '13454335433', '税费改革', '个人');
INSERT INTO `teacher_info` VALUES ('4', null, '路人艺', '2013-06-20', '人力资源', '1231', '234234', '1234123', '13450461343', '13454335433', '税费改革', '个人');
INSERT INTO `teacher_info` VALUES ('5', null, '路人修行', '2013-06-20', '人力资源', '1231', '234234', '1234123', '13450461343', '13454335433', '税费改革', '个人');
INSERT INTO `teacher_info` VALUES ('6', null, '讲师6', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('7', null, '讲师7', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('8', null, '讲师8', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('9', null, '讲师9', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('10', null, '讲师10', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('11', null, '讲师11', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('12', null, '讲师12', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('13', null, '讲师13', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('14', null, '讲师14', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('15', null, '讲师15', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('16', null, '讲师16', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('17', null, '讲师17', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('18', null, '讲师18', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('19', null, '讲师19', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('20', null, '讲师20', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('21', null, '讲师21', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('22', null, '讲师22', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('23', null, '讲师23', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('24', null, '讲师24', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('25', null, '讲师25', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('26', null, '讲师26', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('27', null, '讲师27', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('28', null, '讲师28', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('29', null, '讲师29', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('30', null, '讲师30', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('31', null, '讲师31', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('32', null, '讲师32', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('33', null, '讲师33', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('34', null, '讲师34', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('35', null, '讲师35', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('36', null, '讲师36', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('37', null, '讲师37', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('38', null, '讲师38', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('39', null, '讲师39', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('40', null, '讲师40', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('41', null, '讲师41', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('42', null, '讲师42', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('43', null, '讲师43', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('44', null, '讲师44', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('45', null, '讲师45', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('46', null, '讲师46', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('47', null, '讲师47', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('48', null, '讲师48', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('49', null, '讲师49', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('50', null, '讲师50', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('51', null, '讲师51', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('52', null, '讲师52', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('53', null, '讲师53', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('54', null, '讲师54', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('55', null, '讲师55', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('56', null, '讲师56', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('57', null, '讲师57', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('58', null, '讲师58', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('59', null, '讲师59', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('60', null, '讲师60', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('61', null, '讲师61', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('62', null, '讲师62', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('63', null, '讲师63', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('64', null, '讲师64', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('65', null, '讲师65', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('66', null, '讲师66', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('67', null, '讲师67', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('68', null, '讲师68', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('69', null, '讲师69', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('70', null, '讲师70', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('71', null, '讲师71', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('72', null, '讲师72', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('73', null, '讲师73', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('74', null, '讲师74', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('75', null, '讲师75', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('76', null, '讲师76', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('77', null, '讲师77', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('78', null, '讲师78', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('79', null, '讲师79', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('80', null, '讲师80', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('81', null, '讲师81', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('82', null, '讲师82', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('83', null, '讲师83', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('84', null, '讲师84', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('85', null, '讲师85', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('86', null, '讲师86', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('87', null, '讲师87', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('88', null, '讲师88', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('89', null, '讲师89', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('90', null, '讲师90', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('91', null, '讲师91', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('92', null, '讲师92', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('93', null, '讲师93', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('94', null, '讲师94', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('95', null, '讲师95', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('96', null, '讲师96', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('97', null, '讲师97', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('98', null, '讲师98', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('99', null, '讲师99', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('100', null, '讲师100', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('101', null, '讲师101', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('102', null, '讲师102', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('103', null, '讲师103', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('104', null, '讲师104', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('105', null, '讲师105', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('106', null, '讲师106', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('107', null, '讲师107', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('108', null, '讲师108', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('109', null, '讲师109', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('110', null, '讲师110', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('111', null, '讲师111', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('112', null, '讲师112', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('113', null, '讲师113', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('114', null, '讲师114', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('115', null, '讲师115', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('116', null, '讲师116', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('117', null, '讲师117', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('118', null, '讲师118', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('119', null, '讲师119', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('120', null, '讲师120', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('121', null, '讲师121', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('122', null, '讲师122', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('123', null, '讲师123', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('124', null, '讲师124', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('125', null, '讲师125', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('126', null, '讲师126', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('127', null, '讲师127', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('128', null, '讲师128', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('129', null, '讲师129', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('130', null, '讲师130', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('131', null, '讲师131', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('132', null, '讲师132', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('133', null, '讲师133', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('134', null, '讲师134', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('135', null, '讲师135', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('136', null, '讲师136', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('137', null, '讲师137', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('138', null, '讲师138', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('139', null, '讲师139', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('140', null, '讲师140', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('141', null, '讲师141', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('142', null, '讲师142', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('143', null, '讲师143', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('144', null, '讲师144', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('145', null, '讲师145', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('146', null, '讲师146', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('147', null, '讲师147', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('148', null, '讲师148', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('149', null, '讲师149', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('150', null, '讲师150', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('151', null, '讲师151', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('152', null, '讲师152', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('153', null, '讲师153', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('154', null, '讲师154', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('155', null, '讲师155', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('156', null, '讲师156', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('157', null, '讲师157', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('158', null, '讲师158', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('159', null, '讲师159', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('160', null, '讲师160', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('161', null, '讲师161', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('162', null, '讲师162', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('163', null, '讲师163', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('164', null, '讲师164', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('165', null, '讲师165', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('166', null, '讲师166', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('167', null, '讲师167', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('168', null, '讲师168', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('169', null, '讲师169', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('170', null, '讲师170', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('171', null, '讲师171', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('172', null, '讲师172', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('173', null, '讲师173', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('174', null, '讲师174', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('175', null, '讲师175', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('176', null, '讲师176', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('177', null, '讲师177', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('178', null, '讲师178', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('179', null, '讲师179', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('180', null, '讲师180', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('181', null, '讲师181', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('182', null, '讲师182', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('183', null, '讲师183', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('184', null, '讲师184', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('185', null, '讲师185', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('186', null, '讲师186', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('187', null, '讲师187', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('188', null, '讲师188', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('189', null, '讲师189', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('190', null, '讲师190', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('191', null, '讲师191', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('192', null, '讲师192', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('193', null, '讲师193', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('194', null, '讲师194', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('195', null, '讲师195', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('196', null, '讲师196', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('197', null, '讲师197', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('198', null, '讲师198', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('199', null, '讲师199', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('200', null, '讲师200', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('201', null, '讲师201', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('202', null, '讲师202', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('203', null, '讲师203', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('204', null, '讲师204', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('205', null, '讲师205', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('206', null, '讲师206', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('207', null, '讲师207', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('208', null, '讲师208', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('209', null, '讲师209', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('210', null, '讲师210', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('211', null, '讲师211', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('212', null, '讲师212', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('213', null, '讲师213', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('214', null, '讲师214', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('215', null, '讲师215', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('216', null, '讲师216', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('217', null, '讲师217', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('218', null, '讲师218', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('219', null, '讲师219', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('220', null, '讲师220', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('221', null, '讲师221', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('222', null, '讲师222', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('223', null, '讲师223', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('224', null, '讲师224', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('225', null, '讲师225', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('226', null, '讲师226', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('227', null, '讲师227', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('228', null, '讲师228', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('229', null, '讲师229', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('230', null, '讲师230', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('231', null, '讲师231', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('232', null, '讲师232', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('233', null, '讲师233', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('234', null, '讲师234', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('235', null, '讲师235', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('236', null, '讲师236', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('237', null, '讲师237', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('238', null, '讲师238', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('239', null, '讲师239', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('240', null, '讲师240', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('241', null, '讲师241', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('242', null, '讲师242', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('243', null, '讲师243', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('244', null, '讲师244', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('245', null, '讲师245', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('246', null, '讲师246', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('247', null, '讲师247', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('248', null, '讲师248', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('249', null, '讲师249', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('250', null, '讲师250', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('251', null, '讲师251', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('252', null, '讲师252', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('253', null, '讲师253', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('254', null, '讲师254', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('255', null, '讲师255', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('256', null, '讲师256', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('257', null, '讲师257', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('258', null, '讲师258', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('259', null, '讲师259', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('260', null, '讲师260', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('261', null, '讲师261', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('262', null, '讲师262', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('263', null, '讲师263', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('264', null, '讲师264', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('265', null, '讲师265', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('266', null, '讲师266', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('267', null, '讲师267', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('268', null, '讲师268', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('269', null, '讲师269', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('270', null, '讲师270', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('271', null, '讲师271', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('272', null, '讲师272', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('273', null, '讲师273', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('274', null, '讲师274', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('275', null, '讲师275', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('276', null, '讲师276', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('277', null, '讲师277', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('278', null, '讲师278', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('279', null, '讲师279', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('280', null, '讲师280', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('281', null, '讲师281', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('282', null, '讲师282', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('283', null, '讲师283', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('284', null, '讲师284', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('285', null, '讲师285', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('286', null, '讲师286', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('287', null, '讲师287', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('288', null, '讲师288', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('289', null, '讲师289', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('290', null, '讲师290', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('291', null, '讲师291', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('292', null, '讲师292', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('293', null, '讲师293', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('294', null, '讲师294', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('295', null, '讲师295', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('296', null, '讲师296', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('297', null, '讲师297', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('298', null, '讲师298', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('299', null, '讲师299', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('300', null, '讲师300', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('301', null, '讲师301', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('302', null, '讲师302', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('303', null, '讲师303', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('304', null, '讲师304', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('305', null, '讲师305', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('306', null, '讲师306', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('307', null, '讲师307', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('308', null, '讲师308', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('309', null, '讲师309', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('310', null, '讲师310', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('311', null, '讲师311', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('312', null, '讲师312', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('313', null, '讲师313', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('314', null, '讲师314', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('315', null, '讲师315', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('316', null, '讲师316', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('317', null, '讲师317', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('318', null, '讲师318', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('319', null, '讲师319', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('320', null, '讲师320', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('321', null, '讲师321', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('322', null, '讲师322', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('323', null, '讲师323', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('324', null, '讲师324', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('325', null, '讲师325', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('326', null, '讲师326', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('327', null, '讲师327', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('328', null, '讲师328', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('329', null, '讲师329', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('330', null, '讲师330', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('331', null, '讲师331', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('332', null, '讲师332', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('333', null, '讲师333', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('334', null, '讲师334', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('335', null, '讲师335', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('336', null, '讲师336', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('337', null, '讲师337', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('338', null, '讲师338', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('339', null, '讲师339', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('340', null, '讲师340', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('341', null, '讲师341', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('342', null, '讲师342', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('343', null, '讲师343', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('344', null, '讲师344', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('345', null, '讲师345', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('346', null, '讲师346', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('347', null, '讲师347', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('348', null, '讲师348', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('349', null, '讲师349', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('350', null, '讲师350', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('351', null, '讲师351', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('352', null, '讲师352', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('353', null, '讲师353', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('354', null, '讲师354', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('355', null, '讲师355', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('356', null, '讲师356', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('357', null, '讲师357', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('358', null, '讲师358', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('359', null, '讲师359', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('360', null, '讲师360', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('361', null, '讲师361', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('362', null, '讲师362', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('363', null, '讲师363', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('364', null, '讲师364', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('365', null, '讲师365', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('366', null, '讲师366', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('367', null, '讲师367', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('368', null, '讲师368', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('369', null, '讲师369', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('370', null, '讲师370', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('371', null, '讲师371', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('372', null, '讲师372', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('373', null, '讲师373', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('374', null, '讲师374', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('375', null, '讲师375', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('376', null, '讲师376', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('377', null, '讲师377', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('378', null, '讲师378', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('379', null, '讲师379', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('380', null, '讲师380', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('381', null, '讲师381', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('382', null, '讲师382', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('383', null, '讲师383', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('384', null, '讲师384', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('385', null, '讲师385', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('386', null, '讲师386', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('387', null, '讲师387', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('388', null, '讲师388', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('389', null, '讲师389', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('390', null, '讲师390', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('391', null, '讲师391', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('392', null, '讲师392', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('393', null, '讲师393', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('394', null, '讲师394', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('395', null, '讲师395', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('396', null, '讲师396', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('397', null, '讲师397', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('398', null, '讲师398', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('399', null, '讲师399', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('400', null, '讲师400', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('401', null, '讲师401', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('402', null, '讲师402', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('403', null, '讲师403', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('404', null, '讲师404', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('405', null, '讲师405', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('406', null, '讲师406', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('407', null, '讲师407', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('408', null, '讲师408', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('409', null, '讲师409', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('410', null, '讲师410', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('411', null, '讲师411', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('412', null, '讲师412', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('413', null, '讲师413', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('414', null, '讲师414', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('415', null, '讲师415', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('416', null, '讲师416', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('417', null, '讲师417', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('418', null, '讲师418', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('419', null, '讲师419', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('420', null, '讲师420', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('421', null, '讲师421', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('422', null, '讲师422', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('423', null, '讲师423', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('424', null, '讲师424', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('425', null, '讲师425', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('426', null, '讲师426', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('427', null, '讲师427', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('428', null, '讲师428', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('429', null, '讲师429', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('430', null, '讲师430', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('431', null, '讲师431', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('432', null, '讲师432', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('433', null, '讲师433', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('434', null, '讲师434', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('435', null, '讲师435', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('436', null, '讲师436', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('437', null, '讲师437', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('438', null, '讲师438', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('439', null, '讲师439', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('440', null, '讲师440', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('441', null, '讲师441', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('442', null, '讲师442', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('443', null, '讲师443', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('444', null, '讲师444', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('445', null, '讲师445', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('446', null, '讲师446', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('447', null, '讲师447', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('448', null, '讲师448', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('449', null, '讲师449', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('450', null, '讲师450', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('451', null, '讲师451', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('452', null, '讲师452', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('453', null, '讲师453', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('454', null, '讲师454', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('455', null, '讲师455', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('456', null, '讲师456', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('457', null, '讲师457', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('458', null, '讲师458', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('459', null, '讲师459', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('460', null, '讲师460', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('461', null, '讲师461', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('462', null, '讲师462', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('463', null, '讲师463', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('464', null, '讲师464', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('465', null, '讲师465', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('466', null, '讲师466', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('467', null, '讲师467', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('468', null, '讲师468', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('469', null, '讲师469', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('470', null, '讲师470', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('471', null, '讲师471', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('472', null, '讲师472', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('473', null, '讲师473', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('474', null, '讲师474', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('475', null, '讲师475', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('476', null, '讲师476', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('477', null, '讲师477', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('478', null, '讲师478', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('479', null, '讲师479', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('480', null, '讲师480', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('481', null, '讲师481', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('482', null, '讲师482', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('483', null, '讲师483', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('484', null, '讲师484', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('485', null, '讲师485', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('486', null, '讲师486', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('487', null, '讲师487', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('488', null, '讲师488', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('489', null, '讲师489', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('490', null, '讲师490', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('491', null, '讲师491', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('492', null, '讲师492', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('493', null, '讲师493', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('494', null, '讲师494', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('495', null, '讲师495', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('496', null, '讲师496', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('497', null, '讲师497', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('498', null, '讲师498', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('499', null, '讲师499', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
INSERT INTO `teacher_info` VALUES ('500', null, '讲师500', '2013-11-30', '企业培训', '1222', '3444', '23423423', '10086', '13800138000', '我是一个很牛逼的讲师，我一个堂课收费10w，还是很多人听课吗，你说牛逼不', '企业培训');
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
