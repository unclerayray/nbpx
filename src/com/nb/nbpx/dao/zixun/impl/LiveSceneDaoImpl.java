package com.nb.nbpx.dao.zixun.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.zixun.ILiveSceneDao;
import com.nb.nbpx.pojo.zixun.LiveImage;
import com.nb.nbpx.pojo.zixun.LiveScene;

@Component("LiveSceneDao")
@SuppressWarnings({"unchecked","rawtypes"})
public class LiveSceneDaoImpl  extends BaseDaoImpl<LiveScene, Integer> implements
ILiveSceneDao {
	
	@Override
	public List<LiveImage> getImages(final String liveID){
		List<LiveImage> list = new ArrayList<LiveImage>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.zixun.LiveImage"
								+ " (l.imageId, l.url, l.liveScene,l.imageName) from LiveImage l"
								+ " where 1 = 1 and l.liveScene='"+liveID+"'");
			    hql.append(" order by l.imageId desc ");
				Query query = session.createQuery(hql.toString());
				
				return query.list();
			}
		});
		return list;
	}
	
	@Override
	public List<LiveScene> queryLiveScence(final Map<String, Object> propsMap, final String title,
			 final Integer rows,  final Integer start, final String sort,  final String order) {
		List<LiveScene> list = new ArrayList<LiveScene>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.zixun.LiveScene"
								+ " (l.liveSceneId, l.category, l.title,l.site, l.liveDate, l.teacher) from LiveScene l"
								+ " where 1 = 1 ");
				hql.append(" and l.teacher is not null ");
				if (title != null&&!title.isEmpty()) {
					hql.append(" and l.title like '%");
					hql.append(title + "%' ");
				}
				hql.append(createNormalHql(LiveScene.class,
						propsMap));

				if (sort != null && !sort.isEmpty()) {
					hql.append(" order by l." + sort);
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				} else {
					hql.append(" order by l.liveDate desc ");
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
	public List<LiveScene> queryTuozhan(final Map<String, Object> propsMap, final String title,
			final Integer rows, final Integer start, final String sort, final String order) {
		List<LiveScene> list = new ArrayList<LiveScene>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.zixun.LiveScene"
								+ " (l.liveSceneId, l.category, l.title,l.site, l.liveDate, l.teacher) from LiveScene l"
								+ " where 1 = 1 ");
				hql.append(" and l.teacher is null ");
				if (title != null&&!title.isEmpty()) {
					hql.append(" and l.title like '%");
					hql.append(title + "%' ");
				}

				hql.append(createNormalHql(LiveScene.class,
						propsMap));

				if (sort != null && !sort.isEmpty()) {
					hql.append(" order by l." + sort);
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				} else {
					hql.append(" order by l.liveDate desc ");
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
	public Long queryLiveScenceTotalCount(final Map<String, Object> propsMap, final String title){
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(l) from LiveScene l where 1 = 1 ");
				hql.append(" and l.teacher is not null ");
				if (title != null&&!title.isEmpty()) {
					hql.append(" and l.title like '%");
					hql.append(title + "%' ");
				}
				hql.append(createNormalHql(LiveScene.class,
						propsMap));
				Query query = session.createQuery(hql.toString());

				return query.list();
			}
		});
		return (Long) list.get(0);
	}
	
	@Override
	public Long queryTuozhanTotalCount(final Map<String, Object> propsMap, final String title){
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(l) from LiveScene l where 1 = 1 ");
				hql.append(" and l.teacher is null ");
				if (title != null&&!title.isEmpty()) {
					hql.append(" and l.title like '%");
					hql.append(title + "%' ");
				}
				hql.append(createNormalHql(LiveScene.class,
						propsMap));
				Query query = session.createQuery(hql.toString());

				return query.list();
			}
		});
		return (Long) list.get(0);
	}

}
