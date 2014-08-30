package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseInfoDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.CourseInfo;

/**
 * @author Roger
 * @date 2013年7月20日
 */
@Component("courseInfoDao")
@SuppressWarnings({ "unchecked", "rawtypes" })
public class CourseInfoDaoImpl extends BaseDaoImpl<CourseInfo, Integer>
		implements ICourseInfoDao {

	@Override
	public List<CourseInfo> queryCourseInfo(final String courseId) {
		List<CourseInfo> list = new ArrayList<CourseInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer("");
				hql.append("select new com.nb.nbpx.pojo.course.CourseInfo"
						+ "(c.courseInfoId,c.courseId,c.startDate,c.endDate,c.city,d.showName)"
						+ " from CourseInfo c, Dictionary d where 1=1 ");
				hql.append("and c.city = d.codeName ");
				if (courseId != null && !courseId.isEmpty()) {
					hql.append(" and courseId=? ");
				}

				Query query = session.createQuery(hql.toString());

				if (courseId != null && !courseId.isEmpty()) {
					query.setString(0, courseId);
				}
				return query.list();
			}

		});
		return list;
	}
	
	public List<CourseInfo> queryCourseInfoByCourseId(final String courseId){
		List<CourseInfo> list = new ArrayList<CourseInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.CourseInfo(c.courseInfoId, c.courseId, c.startDate,"
								+ "c.endDate, c.city,'') from CourseInfo c where c.courseId="+courseId);
				Query query = session.createQuery(hql.toString());

				return query.list();
			}
		});
		return list;
	}
	//检索当前日期之后的有效的课程信息
	public List<CourseInfo> queryCourseInfoWithTime(final String year,final String month, final String courseId){
		List<CourseInfo> list = new ArrayList<CourseInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.CourseInfo(c.courseInfoId, c.courseId, c.startDate,"
								+ "c.endDate, c.city,d.showName) from CourseInfo c,Dictionary d where c.city= d.codeName and c.courseId='"+courseId+"'");
			   if(year != null)
					hql.append(" and year(c.startDate) = '"+year+"'");
			   if(month != null)
				   hql.append(" and month(c.startDate)='"+month+"'");
				hql.append(" and TO_DAYS(NOW())-TO_DAYS(c.startDate)<0 order by c.startDate");
				Query query = session.createQuery(hql.toString());

				return query.list();
			}
		});
		return list;
	}
	
	public List<CourseInfo> queryCourseInfoByCity(final String city, final Integer start,final Integer rows){
		List<CourseInfo> list = new ArrayList<CourseInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.CourseInfo(c.courseInfoId, c.courseId, c.startDate,"
								+ "c.endDate, c.city,'') from CourseInfo c,Dictionary d where c.city= d.codeName and d.showName like '%"+city +
								"%' and TO_DAYS(NOW())-TO_DAYS(c.startDate)<0 order by c.startDate");
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
	
	public List<CourseInfo> queryTop30CourseInfo(final Boolean isInner,final Boolean isRecommand,final Boolean isClassic){
		List<CourseInfo> list = new ArrayList<CourseInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer sql = new StringBuffer(
						"select  c.courseInfoId, c.courseId, c.startDate,c.endDate, c.city from courseinfo c,(select  count(*) value,t.* from courseinfo t ,courses d   where t.courseId=d.courseId ");
				if(isInner)
					sql.append(" and d.isInner = 1 ");
				else
					sql.append(" and d.isInner = 0 ");
				if(isRecommand)
					sql.append(" and d.recommanded = 1 ");
				if(isClassic)
					sql.append(" and d.classic = 1 ");

				sql.append("and TO_DAYS(NOW())-TO_DAYS(t.startDate)<0  group by t.courseId ) a where a.value >=3 and c.courseid =a.courseid");
				
				sql.append(" order by c.startDate asc");
				Query query = session.createSQLQuery(sql.toString()).addEntity(CourseInfo.class);
				
				return query.list();
			}
		});
		return list;
	}
}
