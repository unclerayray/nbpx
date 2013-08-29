package com.nb.nbpx.dao.course;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.CourseKeyword;

/**
 * 课程关键字的数据库接口
 * @author Roger
 * @date 2013年7月21日
 */
public interface ICourseKeywordDao extends IBaseDao<CourseKeyword, Integer>{
	
	List<CourseKeyword> getCourseKeyWords(int courseId);
	
}
