package com.nb.nbpx.service.course;

import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

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
	public Course saveCourse(Course course) throws NbpxException ;
	public void deleteCourse(Course course) throws NbpxException ;

	public String getCoursesByCity(String city,Integer rows, Integer start);
	public String getTopCourse(int flag,Boolean isInner);
	public String getNXCourse(String type,int flag);
	
	public String queryCourseInfo(String courseInfoId);
	public void saveCourseInfo(CourseInfo courseInfo);
	public void deleteCourseInfo(CourseInfo courseInfo);
	public String queryKeywords(Integer courseId);
}
