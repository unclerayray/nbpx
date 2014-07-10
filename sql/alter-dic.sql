ALTER TABLE nbpx.sys_dictionary
 CHANGE attribute2 attribute2 INT(20) COMMENT '备用2（用来排序）';
 ALTER TABLE nbpx.sys_dictionary
  ADD INDEX order_index (attribute2);
