package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseMajorDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.CourseMajor;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Component("courseMajorDao")
public class CourseMajorDaoImpl extends BaseDaoImpl<CourseMajor, Integer> implements ICourseMajorDao{
	
	public List<CourseMajor> getCourseMajorByCourseId(final String courseId){
		List<CourseMajor> list = new ArrayList<CourseMajor>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select * from coursemajor t where t.courseId="+courseId);
				Query query = session.createSQLQuery(sql.toString()).addEntity(CourseMajor.class);
				return query.list();
			}
		});
		return list;
	}
}
