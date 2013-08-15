package com.nb.nbpx.dao.course;

import java.util.List;
import java.util.Map;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.pojo.user.TeacherInfo;

/**
 * @author Roger
 * @date 2013-4-29
 */
public interface ICourseDao extends IBaseDao<Course, Integer>{
	public List<Course> queryCourses(String category,Integer courseId,Integer rows, Integer start);
	public Long queryCourseCount(String category,Integer courseId);
	public List<Dictionary> queryCourseType();
	public List<TeacherInfo> queryTeachers();
	public Course updateCourse(Course course);
	
	
	public void addAllCourseInfo(CourseAllInfoDto courseDto);
	
	/**
	 * 一次性插入所有与课程相关的信息实体
	 * @param courseId
	 * @param industryMap
	 * @param tagetMap
	 * @param majorMap
	 * @param keywordMap
	 */
	public void addAllOtherCourseInfo(Integer courseId,Map<String,String> industryMap,Map<String,String> tagetMap,Map<String,String> majorMap,Map<Integer,String> keywordMap,Map<Integer,String> subjectMap);
	/**
	 * 验证CourseCode的唯一性，重复返回true
	 * @param course
	 * @return
	 */
	public boolean checkDuplicateProp(Course course);
	
	//获取热门的课程
	public List<Course> getHotCourse(final Boolean ifInner,final String type,final Integer rows,final Integer start);
	//获取首页顶部推荐课程
	public List<Course> getLastedCourse(final Boolean ifInner,final String type,final Boolean ifRecommand,final Boolean ifClassic,final Integer rows,final Integer start);
	//根据地点获取课程
	public List<Course> getCourseByCity(final String city, final Integer rows, final Integer start);
	//获取课程的信息
	public List<CourseInfo> getCourseInfoByCity(final String city, final Integer courseId,final Integer flag);
	//根据课程ID获取课程信息
	public Course getCourseById(final Integer courseId);
	/**
	 * 用于在保存的时候删除原有的课程下所有的行业、专业、对象、关键字等，把新的数据全部插入
	 * @param courseId
	 */
	public void deleteAllOtherInfosCourse(Integer courseId,Boolean deleteCourseInfo);
}
