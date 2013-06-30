package com.nb.nbpx.service.course;

import com.nb.nbpx.service.IBaseService;

/**
 * 
 * @author Roger
 *
 */
public interface ICourseService extends IBaseService {
	public String queryCourses(String category,String courseCode,Integer rows, Integer start);
	public String queryComboCourseType();
	public String queryComboCourseName(String category);
	public String queryComboTeacher();
	public String queryCourseById(Integer courseId);
}
