package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseSubjectDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.CourseSubject;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Component("courseSubjectDao")
public class CourseSubjectDaoImpl extends BaseDaoImpl<CourseSubject, Integer> implements ICourseSubjectDao {

	@Override
	public List<CourseSubject> getCourseSubjectByCourseId(final String courseId) {
			List<CourseSubject> list = new ArrayList<CourseSubject>();
			list = getHibernateTemplate().executeFind(new HibernateCallback() {
				@Override
				public Object doInHibernate(Session session)
						throws HibernateException, SQLException {
					StringBuffer sql = new StringBuffer(
							"select * from coursesubjects t where t.courseId="+courseId);
					Query query = session.createSQLQuery(sql.toString()).addEntity(CourseSubject.class);
					return query.list();
				}
			});
			return list;
		}

}
