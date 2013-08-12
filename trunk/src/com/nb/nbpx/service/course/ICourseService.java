package com.nb.nbpx.service.course;

import com.nb.nbpx.dto.course.CourseAllInfoDto;
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
	public String queryCourses(String category,Integer courseId,Integer rows, Integer start);
	public String queryComboCourseType();
	public String queryComboCourseName(String category);
	public String queryComboTeacher();
	public String queryCourseById(Integer courseId);
	public Course saveCourse(Course course) throws Exception ;
	public void saveOtherCourseInfo(CourseAllInfoDto courseDto, Boolean deleteBeforeInsert);
	public void deleteCourse(Course course) throws NbpxException ;
	//首页加载课程
	public String getCoursesByCity(String city,Integer rows, Integer start);
	public String getTopCourse(int flag,Boolean isInner);
	public String getNXCourse(String type,int flag);
	//查看课程内容
	public String viewCourse(String courseId);
	
	public String queryCourseInfo(String courseInfoId);
	public void saveCourseInfo(CourseInfo courseInfo);
	public void deleteCourseInfo(CourseInfo courseInfo);
	public String queryKeywords(Integer courseId);
}
