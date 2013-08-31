package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseIndustryDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.pojo.course.CourseIndustry;
import com.nb.nbpx.pojo.course.CourseKeyword;
import com.nb.nbpx.pojo.system.Dictionary;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Component("courseIndustryDao")
public class CourseIndustryDaoImpl extends BaseDaoImpl<CourseIndustry, Integer> implements ICourseIndustryDao{

	private IDictionaryDao dicDao;
	
	@Override
	public CourseIndustry saveCourseIndustry(CourseIndustry courseIndustry) {
		if(courseIndustry.getIndustry()==null){
			Dictionary dic = dicDao.getDictionary(courseIndustry.industryCode,null);
			courseIndustry.setIndustry(dic.getShowName());
		}
		save(courseIndustry);
		return courseIndustry;
	}

	public IDictionaryDao getDicDao() {
		return dicDao;
	}

	@Resource
	public void setDicDao(IDictionaryDao dicDao) {
		this.dicDao = dicDao;
	}

	@Override
	public void deleteAllCourseIndustry(final Integer courseId) {
		getHibernateTemplate().execute(new HibernateCallback(){

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				String sql = "delete from courseIndustry where courseId =" + courseId;
				
				session.createQuery(sql).executeUpdate(); 
				return null;
			}   
			
		});
	}

	@Override
	public List<CourseIndustry> getCourseIndustryByCourseId(final String courseId) {
		List<CourseIndustry> list = new ArrayList<CourseIndustry>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select * from courseindustry t where t.courseId="+courseId);
				Query query = session.createSQLQuery(sql.toString()).addEntity(CourseIndustry.class);
				return query.list();
			}
		});
		return list;
	}

}
