package com.nb.nbpx.dao.course.impl;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.IFollowUpDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.FollowUp;

@Component("FollowUpDao")
public class FollowUpDaoImpl extends BaseDaoImpl<FollowUp, Integer> implements IFollowUpDao {
}
