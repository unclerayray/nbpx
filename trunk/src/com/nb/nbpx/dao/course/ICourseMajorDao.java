package com.nb.nbpx.dao.course;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.CourseMajor;

public interface ICourseMajorDao extends IBaseDao<CourseMajor, Integer>{

	List<CourseMajor> getCourseMajorByCourseId(String courseId);
}
