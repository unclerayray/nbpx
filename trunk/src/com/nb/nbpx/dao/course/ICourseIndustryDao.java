package com.nb.nbpx.dao.course;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.CourseIndustry;

/**
 * @author Roger
 * @date 2013年7月22日
 */
public interface ICourseIndustryDao extends IBaseDao<CourseIndustry, Integer>{
	/**
	 * 存储CourseIndustry，如果没有industry属性，会查询字典补全
	 * @param courseIndustry 这个参数可以没有industry属性
	 * @return
	 */
	public CourseIndustry saveCourseIndustry(CourseIndustry courseIndustry);
	
	/**
	 * 用于在保存的时候删除原有的课程下所有的行业，把新的数据全部插入
	 * @param courseId
	 */
	public void deleteAllCourseIndustry(Integer courseId);
}
