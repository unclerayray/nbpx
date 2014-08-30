ALTER TABLE nbpx.applications
 CHANGE applicant applicant VARCHAR(20) COMMENT '申请人username can be empty',
 ADD qq VARCHAR(20) AFTER createDate,
 ADD participants MEDIUMINT;
 
 ALTER TABLE nbpx.applications
 CHANGE cellphone cellphone VARCHAR(20) COMMENT '联系人移动电话',
 CHANGE telephone telephone VARCHAR(20) COMMENT '座机',
 CHANGE fax fax VARCHAR(20);
 
 ALTER TABLE nbpx.applications
 CHANGE participants participants MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci;
