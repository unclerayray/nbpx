package com.nb.nbpx.dao.course;

import java.util.List;
import java.util.Map;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.dto.course.CourseReport;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.pojo.user.TeacherInfo;

/**
 * @author Roger
 * @date 2013-4-29
 */
public interface ICourseDao extends IBaseDao<Course, Integer> {
	public List<Course> queryCourses(String category, Integer courseId, String teachName,Boolean p_outside,
			Integer rows, Integer start , String sort, String order, Boolean isInner);
	
	public List<Course> queryCoursesWithTitle(String category, String courseTitle, String teachName,Boolean p_outside,
			Integer rows, Integer start , String sort, String order, Boolean isInner);

	public Long queryCourseCount(String category, String courseTitle, String teachName,Boolean p_outside,Boolean isInner);
	
	public Long queryCourseCount(String category, Integer courseId, String teachName,Boolean p_outside,Boolean isInner);

	public List<Dictionary> queryCourseType();

	public List<TeacherInfo> queryTeachers();

	public Course updateCourse(Course course);

	public void addAllCourseInfo(CourseAllInfoDto courseDto);

	/**
	 * 一次性插入所有与课程相关的信息实体
	 * 
	 * @param courseId
	 * @param industryMap
	 * @param tagetMap
	 * @param majorMap
	 * @param keywordMap
	 */
	public void addAllOtherCourseInfo(Integer courseId,
			Map<String, String> industryMap, Map<String, String> tagetMap,
			Map<String, String> majorMap, Map<Integer, String> keywordMap,
			Map<Integer, String> subjectMap, Map<String, String> productMap);

	/**
	 * 验证CourseCode的唯一性，重复返回true
	 * 
	 * @param course
	 * @return
	 */
	public boolean checkDuplicateProp(Course course);
	
	/**
	 * 验证CourseCode的唯一性，重复返回true
	 * 
	 * @param course
	 * @return
	 */
	public Course checkDuplicateCourse(Course course);
	//获取内训视频
	public List<Course> getVedioCourse(final Boolean ifInner,final Boolean ifRecommend,final Boolean byHit, final String type,
			final Integer rows, final Integer start);
	
	public Long queryCourseCount(final Boolean ifInner,final Boolean ifRecommend, final String type,final Boolean hasVedio);
	
	// 获取热门的课程
	public List<Course> getHotCourseWithNoTime(final Boolean ifInner, final String type,
			final Integer rows, final Integer start);
	// 获取热门的课程
	public List<Course> getHotCourse(final Boolean ifInner, final String type,
			final Integer rows, final Integer start);

	// 获取首页顶部推荐课程
	public List<Course> getLastedCourse(final Boolean ifInner,
			final String type, final Boolean ifRecommand,
			final Boolean ifClassic, final Integer rows, final Integer start);

	// 根据地点获取课程
	public List<Course> getCourseByCity(final String city, final Integer rows,
			final Integer start);
	
	//地点分页，获取总页数
	public Integer CountCourseByCity(final String cityName,final String year,final String month,final String flag,final Integer rows,final Integer start);
	//根据地点分页获取课程
	public List<CourseInfo> getCourseInfoByCity(final String cityName,final String year,final String month,final String flag,final Integer rows,final Integer start);

	
	// 获取课程的信息
	public List<CourseInfo> getCourseInfoByCity(final String city,
			final Integer courseId, final Integer flag);

	// 根据课程ID获取课程信息
	public Course getCourseById(final Integer courseId);

	/**
	 * 用于在保存的时候删除原有的课程下所有的行业、专业、对象、关键字等，把新的数据全部插入
	 * 
	 * @param courseId
	 */
	public void deleteAllOtherInfosCourse(Integer courseId,
			Boolean deleteCourseInfo);
	//获取培训或者内训的最热课程(可以按照地点)
	public List<Course> getHotCourseByPlace(final Boolean ifInner, final String cityName,final Integer rows, final Integer start);
	//获取本月或者本周最热的培训课程
	public List<Course> selectTimeTopCourse(String flag,String cityName,Boolean isInner,Integer start,Integer rows);
	//根据行业、专业、产品、职位获取(flag:1-行业，2-专业，3-产品，4-职位)
	public List<Course> getHotCourseByType(Boolean isInner,String type,String flag,Integer start,Integer rows);
	//获取培训中价格最贵的高端课程，按照日期和价格排序
	public List<Course> getCourseByPrice(Boolean isInner,String type,Integer start,Integer rows);
	//获取经典培训或者内训
	public List<Course> getClassicCourse(Boolean isInner,String type,Integer start,Integer rows);
	//获取内训或培训中推荐老师信息
	public List<TeacherInfo> getTeacherRecommand(Boolean isInner,String type,Integer start,Integer rows);
	
	//根据月份获取培训计划
	public List<Course> getTrainPlanByMonth(String year,String month,Integer start,Integer rows);
	//获得当前时间之后，有培训计划的月数总数
	public List<String> getTrainPlanMonth(Integer start,Integer rows);
	//获取金牌课程
	public List<Course> getGoldCourse(final Boolean isInner,final String type, final Integer start,
			final Integer rows,final Integer price);
	//根据课程类别获取课程列表，按照开课日期倒叙
	public List<Course> getCourseType(Boolean isInner,String type,Integer start,Integer rows);
	
	/**
	 * 查找培训或内训计划
	 * @param category 类型字典代码
	 * @param year
	 * @param month
	 * @param isInner
	 * @param city 城市字典代码
	 * @return
	 */
	public List<CourseReport> queryCoursePlan(String category, int year, Integer month, Boolean isInner, String city);

	//获取讲师的培训或者内训课程，按照创建日期排序
	public List<Course> getCourseByTeacher(Boolean isInner,String teacherID,Integer start,Integer rows);
	public Long getCourseByTeacherRowsCount(Boolean isInner,String teacherID,Integer start,Integer rows);
	public String getNoHtmlStr(String htmlStr);
}
