package com.nb.nbpx.dao.course.impl;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseKeywordDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.CourseKeyword;

/**
 * 课程关键字的数据库接口实现类
 * @author Roger
 * @date 2013年7月21日
 */
@Component("courseKeywordDaoDao")
//@SuppressWarnings({ "unchecked", "rawtypes" })
public class CourseKeywordDaoImpl extends BaseDaoImpl<CourseKeyword, Integer> implements ICourseKeywordDao{

}
