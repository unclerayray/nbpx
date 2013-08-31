package com.nb.nbpx.dao.course;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.CourseTarget;

public interface ICourseTargetDao extends IBaseDao<CourseTarget, Integer>{

	List<CourseTarget> getCourseTargetsByCourseId(String courseId);
}
