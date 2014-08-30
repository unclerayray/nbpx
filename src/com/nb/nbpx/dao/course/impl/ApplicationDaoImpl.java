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

import com.nb.nbpx.common.QueryCriteria;
import com.nb.nbpx.dao.course.IApplicationDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.Application;
import com.nb.nbpx.pojo.course.Course;

@Component("ApplicationDao")
@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
public class ApplicationDaoImpl extends BaseDaoImpl<Application, Integer>
		implements IApplicationDao {
	
	@Override
	public List<Application> queryWithQueryCriteria(final QueryCriteria qc){
		List<Application> list = new ArrayList<Application>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Application"
								+ " (a.applyId, a.email, a.applicant, a.applyCourseId, c.title, a.applicantCompany, a.headCount, a.contact,"
								+ "a.telephone, a.cellphone, a.fax, a.department,"
								+ "a.remarks, a.confirmed, a.followed, a.createDate, a.qq, a.participants) from Application a, Course c"
								+ " where 1 = 1 and a.applyCourseId = c.courseId ");
				if (qc.equalParamMap.get("follow") != null) {
					if((Boolean) qc.equalParamMap.get("follow")){
						hql.append(" and a.followed = true ");
					}else{
						hql.append(" and a.followed = false ");
					}
				}
				
				if (qc.equalParamMap.get("confirmed") != null) {
					if((Boolean) qc.equalParamMap.get("confirmed")){
						hql.append(" and a.confirmed = true ");
					}else{
						hql.append(" and a.confirmed = false ");
					}
				}
				
				if (qc.likeParamMap.get("company") != null && !qc.likeParamMap.get("company").isEmpty()) {
					hql.append(" and a.applicantCompany like ? ");
				}
				
				if (qc.likeParamMap.get("contact") != null && !qc.likeParamMap.get("contact").isEmpty()) {
					hql.append(" and a.contact like ? ");
				}
				
				if (qc.likeParamMap.get("department") != null && !qc.likeParamMap.get("department").isEmpty()) {
					hql.append(" and a.department like ? ");
				}
				
				if (qc.likeParamMap.get("course") != null && !qc.likeParamMap.get("course").isEmpty()) {
					hql.append(" and c.title like ? ");
				}

				if (qc.sort != null && !qc.sort.isEmpty()) {
					hql.append(" order by a." + qc.sort);
					if (qc.order != null && !qc.order.isEmpty()) {
						hql.append(" " + qc.order);
					}
				} else {
					hql.append(" order by a.applyId desc ");
				}
				Query query = session.createQuery(hql.toString());
				

				if (qc.likeParamMap.get("company") != null && !qc.likeParamMap.get("company").isEmpty()) {
					query.setString(i++, "%"+qc.likeParamMap.get("company")+"%");
				}
				
				if (qc.likeParamMap.get("contact") != null && !qc.likeParamMap.get("contact").isEmpty()) {
					query.setString(i++, "%"+qc.likeParamMap.get("contact")+"%");
				}
				
				if (qc.likeParamMap.get("department") != null && !qc.likeParamMap.get("department").isEmpty()) {
					query.setString(i++, "%"+qc.likeParamMap.get("department")+"%");
				}
				
				if (qc.likeParamMap.get("course") != null && !qc.likeParamMap.get("course").isEmpty()) {
					query.setString(i++, "%"+qc.likeParamMap.get("course")+"%");
				}

				if (qc.start != null && qc.rows != null) {
					query.setFirstResult(qc.start);
					query.setMaxResults(qc.rows);
				}

				return query.list();
			}
		});
		return list;
	}
	
	@Override
	public int queryCountWithQueryCriteria(final QueryCriteria qc) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select count(a) from Application a where 1 = 1");

				if (qc.likeParamMap.get("course") != null && !qc.likeParamMap.get("course").isEmpty()) {
					hql = new StringBuffer("select count(a) from Application a, Course c where 1 = 1");
				}
				if (qc.equalParamMap.get("follow") != null) {
					if((Boolean) qc.equalParamMap.get("follow")){
						hql.append(" and a.followed = true ");
					}else{
						hql.append(" and a.followed = false ");
					}
				}
				
				if (qc.equalParamMap.get("confirmed") != null) {
					if((Boolean) qc.equalParamMap.get("confirmed")){
						hql.append(" and a.confirmed = true ");
					}else{
						hql.append(" and a.confirmed = false ");
					}
				}
				
				if (qc.likeParamMap.get("company") != null && !qc.likeParamMap.get("company").isEmpty()) {
					hql.append(" and a.applicantCompany like ? ");
				}
				
				if (qc.likeParamMap.get("contact") != null && !qc.likeParamMap.get("contact").isEmpty()) {
					hql.append(" and a.contact like ? ");
				}
				
				if (qc.likeParamMap.get("department") != null && !qc.likeParamMap.get("department").isEmpty()) {
					hql.append(" and a.department like ? ");
				}
				
				if (qc.likeParamMap.get("course") != null && !qc.likeParamMap.get("course").isEmpty()) {
					hql.append(" and c.title like ? ");
				}
				Query query = session.createQuery(hql.toString());


				if (qc.likeParamMap.get("company") != null && !qc.likeParamMap.get("company").isEmpty()) {
					query.setString(i++, "%"+qc.likeParamMap.get("company")+"%");
				}
				
				if (qc.likeParamMap.get("contact") != null && !qc.likeParamMap.get("contact").isEmpty()) {
					query.setString(i++, "%"+qc.likeParamMap.get("contact")+"%");
				}
				
				if (qc.likeParamMap.get("department") != null && !qc.likeParamMap.get("department").isEmpty()) {
					query.setString(i++, "%"+qc.likeParamMap.get("department")+"%");
				}
				
				if (qc.likeParamMap.get("course") != null && !qc.likeParamMap.get("course").isEmpty()) {
					query.setString(i++, "%"+qc.likeParamMap.get("course")+"%");
				}

				return query.list();
			}
		});
		return ((Long) list.get(0)).intValue();
	}
	
	@Override
	public List<Application> queryApplications(final Integer rows,
			final Integer start, final String sort, final String order,
			final Boolean confirmed, final Boolean follow, final String company, final String contact) {
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
								+ "a.remarks, a.confirmed, a.followed, a.createDate) from Application a, Course c"
								+ " where 1 = 1 and a.applyCourseId = c.courseId ");
				if (follow != null) {
					if(follow){
						hql.append(" and followed = true ");
					}else{
						hql.append(" and followed = false ");
					}
				}
				
				if (confirmed != null) {
					if(confirmed){
						hql.append(" and confirmed = true ");
					}else{
						hql.append(" and confirmed = false ");
					}
				}
				
				if (company != null && !company.isEmpty()) {
					hql.append(" and applicantCompany like ? ");
				}
				
				if (contact != null && !contact.isEmpty()) {
					hql.append(" and contact = ? ");
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
				

				if(company!=null && !company.isEmpty()){
					query.setString(i++, "%"+company+"%");
				}
				
				if(contact!=null && !contact.isEmpty()){
					query.setString(i++, contact);
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
