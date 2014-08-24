package com.nb.nbpx.dao.zixun.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.zixun.IDownloadDao;
import com.nb.nbpx.pojo.article.ArticleKeyword;
import com.nb.nbpx.pojo.article.ArticleSubject;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.zixun.Download;
import com.nb.nbpx.pojo.zixun.DownloadKeyword;
import com.nb.nbpx.pojo.zixun.DownloadSubject;

@Component("DownloadDao")
public class DownloadDaoImpl extends BaseDaoImpl<Download, Integer> implements
		IDownloadDao {
		
	@SuppressWarnings("unchecked")
	public List<Download> getDownLoads(final String type, final Integer rows, final Integer start,
			final String sort, final String order){
		List<Download> list = new ArrayList<Download>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.zixun.Download"
								+ " (c.downloadId, c.title, c.filepath, "
								+ "c.filetype,c.description,c.author,c.uploadDate,c.downloadCnt,c.hits,c.size,c.category) from Download c"
								+ " where 1 = 1 ");
				if(type != null && !type.isEmpty())
					hql.append(" and c.category="+type);
				
				if (sort != null && !sort.isEmpty()) {
					hql.append(" order by c." + sort);
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				}else{
					hql.append(" order by c.uploadDate desc ");
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
	
	@SuppressWarnings("rawtypes")
	public Integer getDownLoadsCount(final String type, final Integer rows, final Integer start,
			final String sort, final String order){
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer sql = new StringBuffer(
						"select count(*) value from download c"
								+ " where 1 = 1 ");

				if(type != null && !type.isEmpty())
					sql.append(" and c.category="+type);
				
				if (sort != null && !sort.isEmpty()) {
					sql.append(" order by c." + sort);
					if (order != null && !order.isEmpty()) {
						sql.append(" " + order);
					}
				}else{
					sql.append(" order by c.uploadDate desc ");
				}
				Query query = session.createSQLQuery(sql.toString());
				
				return query.list();
			}
		});
		return (Integer)list.get(0);
		
	}
	
	//根据文章ID获取文章的关键词
	public List<DownloadKeyword> getDownloadKeywordsById(final String downloadID){
		List<DownloadKeyword> list = new ArrayList<DownloadKeyword>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
			String sql = "select a.* from downloadkeywords a,keywords b where a.keywordId = b.keyId and a.downloadkeywordId='"+downloadID+"'";
			Query query = session.createSQLQuery(sql).addEntity(DownloadKeyword.class);
			
			return query.list();
			}
			});		
		return list;
	}
	
	//根据文章ID获取文章的专题
	public List<DownloadSubject> getDownloadSubjectById(final String downloadID){
		List<DownloadSubject> list = new ArrayList<DownloadSubject>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
			String sql = "select a.* from downloadsubjects a,subjects b where a.subjectId = b.subjectId  and a.downloadSubjectId='"+downloadID+"'";
			Query query = session.createSQLQuery(sql).addEntity(DownloadSubject.class);
			
			return query.list();
			}
			});		
		return list;
	}
}
