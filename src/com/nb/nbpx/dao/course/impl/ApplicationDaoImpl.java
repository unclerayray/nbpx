package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.IApplicationDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.Application;
import com.nb.nbpx.pojo.course.Course;

@Component("ApplicationDao")
@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
public class ApplicationDaoImpl extends BaseDaoImpl<Application, Integer>
		implements IApplicationDao {

	@Override
	public List<Application> queryApplications(final Integer rows,
			final Integer start, final String sort, final String order,
			final Boolean confirmed, final Boolean follow) {
		List<Application> list = new ArrayList<Application>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Application"
								+ " (a.applyId, a.email, a.applyCourseId, c.title, a.applicantCompany, a.headCount, a.contact,"
								+ "a.telephone, a.cellphone, a.fax, a.department,"
								+ "a.remarks, a.stateInfo, a.confirmed, a.createDate) from Application a, Course c"
								+ " where 1 = 1 and a.applyCourseId = c.courseId ");
				if (follow != null) {
					if(follow){
						hql.append(" and stateInfo is not null ");
					}else{
						hql.append(" and stateInfo is null ");
					}
				}
				
				if (confirmed != null) {
					if(confirmed){
						hql.append(" and confirmed = true ");
					}else{
						hql.append(" and confirmed = false ");
					}
				}

				if (sort != null && !sort.isEmpty()) {
					hql.append(" order by a." + sort);
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				} else {
					hql.append(" order by a.applyId desc ");
				}
				Query query = session.createQuery(hql.toString());

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
	public Long queryApplicationCount(final Boolean confirmed, final Boolean follow) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select count(a) from Application a where 1 = 1");
				if (follow != null && follow) {
					if(follow){
						hql.append(" and stateInfo is null ");
					}else{
						hql.append(" and stateInfo is not null ");
					}
				}
				
				if (confirmed != null && confirmed) {
					if(confirmed){
						hql.append(" and confirmed = true ");
					}else{
						hql.append(" and confirmed = false ");
					}
				}
				Query query = session.createQuery(hql.toString());
				return query.list();
			}
		});
		return (Long) list.get(0);
	}

}
