package com.nb.nbpx.dao.course;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.CourseSubject;


public interface ICourseSubjectDao extends IBaseDao<CourseSubject, Integer>{
	
	List<CourseSubject> getCourseSubjectByCourseId(String courseId);
}
