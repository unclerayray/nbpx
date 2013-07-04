package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.pojo.user.TeacherInfo;
@Component("courseDao")
@SuppressWarnings({ "unchecked", "rawtypes" })
public class CourseDaoImpl extends BaseDaoImpl<Course, Integer> implements
		ICourseDao {

	@Override
	public List<Course> queryCourses(final String category, final String courseCode,
			final Integer rows, final Integer start) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(
				new HibernateCallback() {

					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						int i = 0;
						StringBuffer hql = new StringBuffer(
								"select new com.nb.nbpx.pojo.course.Course"
										+ " (c.courseId, c.title, c.courseCode, c.teacherId, " +
												"c.teacherName, c.category, fd.showName," +
												" c.state, c.hits) from Course c, Dictionary fd"
										+ " where 1 = 1 ");
						if (category != null && !category.isEmpty()) {
							hql.append(" and category = ? ");
						}

						if (courseCode != null && !courseCode.isEmpty()) {
							hql.append(" and courseCode = ? ");
						}
						hql.append(" and c.category = fd.codeName ");
						Query query = session.createQuery(hql.toString());

						if (category != null && !category.isEmpty()) {
							query.setString(i++, category);
						}

						if (courseCode != null && !courseCode.isEmpty()) {
							query.setString(i++, courseCode);
						}

						if (start != null && rows != null) {
							query.setFirstResult(start);
							query.setMaxResults(rows);
						}

						return query.list();
					}
				});
		return list;
	}

	@Override
	public Long queryCourseCount(final String category, final String courseCode) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select count(c) from Course c where 1 = 1");
				if (category != null && !category.isEmpty()) {
					hql.append(" and category = ? ");
				}

				if (courseCode != null && !courseCode.isEmpty()) {
					hql.append(" and courseCode = ? ");
				}
				Query query = session.createQuery(hql.toString());

				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}

				if (courseCode != null && !courseCode.isEmpty()) {
					query.setString(i++, courseCode);
				}

				return query.list();
			}
		});
		return (Long) list.get(0);
	}

	@Override
	public List<Dictionary> queryCourseType() {
		List<Dictionary> list = new ArrayList<Dictionary>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new Dictionary(d.codeName,d.showName) from Dictionary d where dicType = '003'");
				Query query = session.createQuery(hql.toString());
				return query.list();
			}

		});
		return list;
	}

	@Override
	public List<TeacherInfo> queryTeachers() {
		List<TeacherInfo> list = new ArrayList<TeacherInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.user.TeacherInfo(teacherId,realName) from TeacherInfo ");
				Query query = session.createQuery(hql.toString());
				return query.list();
			}

		});
		return list;
	}

	@Override
	public boolean checkDuplicateProp(final Course course) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(d) from Course d where 1 = 1 ");
				hql.append(" and courseCode = '" + course.getCourseCode() + "' ");
				Query query = session.createQuery(hql.toString());
				return query.list();
			}
		});
		Long countL = (Long) list.get(0);
		if(countL.intValue()>0){
			return true;
		}else{
			return false;
		}
	}

}
