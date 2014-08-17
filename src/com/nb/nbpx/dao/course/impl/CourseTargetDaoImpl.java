package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseTargetDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.CourseTarget;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Component("courseTargetDao")
public class CourseTargetDaoImpl extends BaseDaoImpl<CourseTarget, Integer> implements ICourseTargetDao {

	@Override
	public List<CourseTarget> getCourseTargetsByCourseId(final String courseId) {
		List<CourseTarget> list = new ArrayList<CourseTarget>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select * from coursetarget t where t.courseId="+courseId);
				Query query = session.createSQLQuery(sql.toString()).addEntity(CourseTarget.class);
				return query.list();
			}
		});
		return list;
	}
	public List<CourseTarget> getCourseTarget(final Integer start,final Integer rows){
		List<CourseTarget> list = new ArrayList<CourseTarget>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select * from coursetarget t ");
				Query query = session.createSQLQuery(sql.toString()).addEntity(CourseTarget.class);
				if(start != null && rows != null){
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				
				return query.list();
			}
		});
		return list;
		
	}
	
	public Long countCourseTarget(){
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(c) from CourseTarget c ");
				
				Query query = session.createQuery(hql.toString());
				
				return query.list();
			}
		});
		return (Long) list.get(0);
	}

}
