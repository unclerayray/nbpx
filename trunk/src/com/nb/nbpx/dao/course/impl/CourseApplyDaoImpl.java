package com.nb.nbpx.dao.course.impl;

import java.util.List;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseApplyDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.CourseApply;;

@Component("CourseApplyDao")
public class CourseApplyDaoImpl extends BaseDaoImpl<CourseApply, Integer> implements ICourseApplyDao{

	@Override
	public List<CourseApply> getCourseApply() {
		
		return null;
	}
	
}
