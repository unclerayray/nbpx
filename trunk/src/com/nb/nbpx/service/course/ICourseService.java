package com.nb.nbpx.service.course;

import java.util.List;

import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.keyword.Keyword;
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
	/**
	 * 存储（新增或根据主键更新）行业、专业、对象、关键词及专题等信息，返回存储好的关键词List
	 * @param courseDto
	 * @param deleteBeforeInsert 在插入前删除所有其他数据
	 * @return
	 */
	public void saveOtherCourseInfo(CourseAllInfoDto courseDto, Boolean deleteBeforeInsert);
	/**
	 * 删除课程及课程相关的其他信息
	 * @param course
	 * @throws NbpxException
	 */
	public void deleteCourse(Course course) throws NbpxException ;
	
	//首页加载课程
	public String getCoursesByCity(String city,Integer rows, Integer start);
	public String getTopCourse(int flag,Boolean isInner);
	public String getPXCourse(String type,int flag);
	public String getNXCourse(String type,int flag);
	//查看课程内容
	public String viewCourse(String courseId);
	
	public String queryCourseInfo(String courseInfoId);
	public void saveCourseInfo(CourseInfo courseInfo);
	public void deleteCourseInfo(CourseInfo courseInfo);
	public String queryKeywords(Integer courseId);
}
