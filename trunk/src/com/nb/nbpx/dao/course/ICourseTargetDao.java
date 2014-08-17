package com.nb.nbpx.dao.course;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.CourseTarget;

public interface ICourseTargetDao extends IBaseDao<CourseTarget, Integer>{

	List<CourseTarget> getCourseTargetsByCourseId(String courseId);
	//获取培训职位
	List<CourseTarget> getCourseTarget(Integer start,Integer rows);
	//获取总条数
	Long countCourseTarget();
}
