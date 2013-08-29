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
@SuppressWarnings("unchecked")
public class CourseKeywordDaoImpl extends BaseDaoImpl<CourseKeyword, Integer> implements ICourseKeywordDao{

	
	@Override																											
	public List<CourseKeyword> getCourseKeyWords(final int courseId) {
		List<CourseKeyword> list = new ArrayList<CourseKeyword>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select * from coursekeywords t where t.courseId="+courseId);
				Query query = session.createSQLQuery(sql.toString()).addEntity(CourseKeyword.class);
				return query.list();
			}
		});
		return list;
	}
	

}
