/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.1.37-community : Database - nbpx
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`nbpx` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `nbpx`;

/*Table structure for table `courseapply` */

DROP TABLE IF EXISTS `courseapply`;

CREATE TABLE `courseapply` (
  `applyID` int(11) NOT NULL AUTO_INCREMENT,
  `teacherName` varchar(30) DEFAULT NULL,
  `courseName` varchar(200) DEFAULT NULL,
  `compName` varchar(200) DEFAULT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `celphone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `departName` varchar(100) DEFAULT NULL,
  `msn` varchar(100) DEFAULT NULL,
  `compType` varchar(100) DEFAULT NULL,
  `comRange` varchar(300) DEFAULT NULL,
  `starttime` date DEFAULT NULL,
  `endtime` date DEFAULT NULL,
  `budget` varchar(200) DEFAULT NULL,
  `languaue` varchar(200) DEFAULT NULL,
  `studentDesc` varchar(500) DEFAULT NULL,
  `basicDesc` varchar(500) DEFAULT NULL,
  `compDesc` varchar(500) DEFAULT NULL,
  `questionDesc` varchar(500) DEFAULT NULL,
  `contentDesc` varchar(500) DEFAULT NULL,
  `targetDesc` varchar(500) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `notice` varchar(500) DEFAULT NULL,
  `createtime` date DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`applyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
