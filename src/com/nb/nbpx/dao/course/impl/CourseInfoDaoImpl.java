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
	public List<CourseInfo> queryCourseInfo(final String courseInfoId) {
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
				if (courseInfoId != null && !courseInfoId.isEmpty()) {
					hql.append(" and courseId=? ");
				}

				Query query = session.createQuery(hql.toString());

				if (courseInfoId != null && !courseInfoId.isEmpty()) {
					query.setString(0, courseInfoId);
				}
				return query.list();
			}

		});
		return list;
	}

}
