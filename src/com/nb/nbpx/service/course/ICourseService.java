package com.nb.nbpx.service.course;

import java.util.List;

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
	public String queryCourses(String category,Integer courseId,Integer rows, Integer start, String sort, String order);
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
	
	public String queryCourseInfo(String courseId);
	public void saveCourseInfo(CourseInfo courseInfo);
	public void deleteCourseInfo(CourseInfo courseInfo);
	public String queryKeywords(Integer courseId);
	//选择本周或者本月最热的培训课程
	public String selectTimeTopCourse(String timeFlag,String cityName,int start,int rows);
	
	/**
	 * 根据CourseId得到课程安排
	 * @param courseId
	 * @return
	 */
	public List<CourseInfo> queryCourseInfoList(Integer courseId);
	//分页获取地点下的课程（可以按照月份）
	public String queryCourseByCity(String cityName,String year,String month,String orderFlag,Integer rows,Integer start);
	public String queryHotCourseByPlace(Boolean ifInner, String cityName,Integer rows,Integer start);
	//按照行业、专业、职位、产品获取热门课程
	public String queryHotCourseByType(Boolean isInner,String flag,String type,Integer rows,Integer start);
	//获取高端课程
	public String queryCourseByPrice(Boolean isInner,String type,Integer rows,Integer start);
	//获取热门课程，不分类别
	public String queryHotCourse(Boolean isInner,Integer rows,Integer start);
	//获取经典课程，不分类别
	public String queryClassiscCourse(Boolean isInner,Integer rows,Integer start);
	//获取行业、专业、职位、产品
	public String queryCourseType(String flag,Integer rows,Integer start);
	//获取高端课程推荐的内训师或者培训师
	public String getTeacherRecommand(Boolean isInner,String type,Integer rows,Integer start);
}