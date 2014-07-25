package com.nb.nbpx.dao.course;

import com.nb.nbpx.dao.IBaseDao;

import java.util.List;

import com.nb.nbpx.pojo.course.CourseApply;;

public interface ICourseApplyDao  extends IBaseDao<CourseApply, Integer>{
	public List<CourseApply> getCourseApply();
}
