ALTER TABLE nbpx.applications
 CHANGE applicant applicant VARCHAR(20) COMMENT '������username can be empty',
 ADD qq VARCHAR(20) AFTER createDate,
 ADD participants MEDIUMINT;
 
 ALTER TABLE nbpx.applications
 CHANGE cellphone cellphone VARCHAR(20) COMMENT '��ϵ���ƶ��绰',
 CHANGE telephone telephone VARCHAR(20) COMMENT '����',
 CHANGE fax fax VARCHAR(20);
 
 ALTER TABLE nbpx.applications
 CHANGE participants participants MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci;
