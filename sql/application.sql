ALTER TABLE nbpx.applications
 CHANGE applicant applicant VARCHAR(20) COMMENT '������username can be empty',
 ADD qq VARCHAR(20) AFTER createDate,
 ADD participants MEDIUMINT;