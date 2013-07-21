package com.nb.nbpx.dao.course;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.pojo.user.TeacherInfo;

/**
 * @author Roger
 * @date 2013-4-29
 */
public interface ICourseDao extends IBaseDao<Course, Integer>{
	public List<Course> queryCourses(String category,String courseCode,Integer rows, Integer start);
	public Long queryCourseCount(String category,String courseCode);
	public List<Dictionary> queryCourseType();
	public List<TeacherInfo> queryTeachers();
	/**
	 * 验证CourseCode的唯一性，重复返回true
	 * @param course
	 * @return
	 */
	public boolean checkDuplicateProp(Course course);
	
	//根据地点获取课程
	public List<Course> getCourseByCity(final String city, final Integer rows, final Integer start);
	//获取课程的信息
	public List<CourseInfo> getCourseInfoByCity(final String city, final Integer courseId,final Integer flag);
}
