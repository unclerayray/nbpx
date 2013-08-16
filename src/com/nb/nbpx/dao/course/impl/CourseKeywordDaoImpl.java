package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseKeywordDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.Course;
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
