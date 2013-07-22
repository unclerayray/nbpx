package com.nb.nbpx.dao.system.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.pojo.system.Dictionary;

@Component("dictionaryDao")
@SuppressWarnings({ "unchecked", "rawtypes" })
/**
 * 
 */
public class DictionaryDaoImpl extends BaseDaoImpl<Dictionary, Integer>
		implements IDictionaryDao {

	@Override
	public List<Dictionary> queryDictionary(final String dicType,
			final String codeName, final Integer rows, final Integer start) {
		List<Dictionary> list = new ArrayList<Dictionary>();
		list = getHibernateTemplate().executeFind(
				new HibernateCallback() {

					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						int i = 0;
						StringBuffer hql = new StringBuffer(
								"select new com.nb.nbpx.pojo.system.Dictionary"
										+ " (d.dicId, d.dicType, d.codeName, d.showName, d.orderNum,"
										+ " d.attribute1, d.attribute2, d.attribute3, d.flag,"
										+ " d.discription, fd.showName) from Dictionary d, Dictionary fd"
										+ " where 1 = 1 ");
						if (dicType != null && !dicType.isEmpty()) {
							hql.append(" and d.dicType = ? ");
						}

						if (codeName != null && !codeName.isEmpty()) {
							hql.append(" and d.codeName = ? ");
						}

						hql.append(" and d.dicType = fd.codeName ");
						Query query = session.createQuery(hql.toString());

						if (dicType != null && !dicType.isEmpty()) {
							query.setString(i++, dicType);
						}

						if (codeName != null && !codeName.isEmpty()) {
							query.setString(i++, codeName);
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
	public List<Dictionary> queryDicTypes(final Integer rows, final Integer start) {
		List<Dictionary> list = new ArrayList<Dictionary>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new Dictionary(d.dicId,d.codeName,d.showName,d.discription,d.flag) from Dictionary d where dicType = '998'");
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
	public void addDic(Dictionary dictionary) {

	}

	@Override
	public void deleteDic(Dictionary dictionary) {

	}

	@Override
	public Long queryDictionaryCount(final String dicType, final String showName) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select count(d) from Dictionary d where 1 = 1 and d.dicType !='998'");
				if (dicType != null && !dicType.isEmpty()) {
					hql.append(" and d.dicType = ? ");
				}

				if (showName != null && !showName.isEmpty()) {
					hql.append(" and d.showName = ? ");
				}
				Query query = session.createQuery(hql.toString());

				if (dicType != null && !dicType.isEmpty()) {
					query.setString(i++, dicType);
				}

				if (showName != null && !showName.isEmpty()) {
					query.setString(i++, showName);
				}

				return query.list();
			}
		});
		return (Long) list.get(0);
	}

	@Override
	public Long queryDicTypesCount() {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(d) from Dictionary d where 1 = 1 and d.dicType ='998'");
				Query query = session.createQuery(hql.toString());
				return query.list();
			}
		});
		return (Long) list.get(0);
	}

	@Override
	public boolean checkDuplicateProp(final Dictionary dictionary) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(d) from Dictionary d where 1 = 1 ");
				hql.append(" and codeName = '" + dictionary.getCodeName() + "' ");
				hql.append(" and ( dicType = '" + dictionary.getDicType() + "' ");
				hql.append(" or showName = '" + dictionary.getShowName() + "' ) ");
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

	@Override
	public boolean checkShouldDelete(final Dictionary dictionary) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(d) from Dictionary d where 1 = 1 ");
				hql.append(" and dicType = '" + dictionary.getCodeName() + "' ");
				Query query = session.createQuery(hql.toString());
				return query.list();
			}
		});
		Long countL = (Long) list.get(0);
		if(countL.intValue()>0){
			return false;
		}else{
			return true;
		}
	}
	
	@Override
	public Dictionary getDictionary(final String codeName,final String showName){
		List<Dictionary> list = new ArrayList<Dictionary>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new Dictionary(d.dicId,d.codeName,d.showName,d.discription,d.flag) from Dictionary d where 1=1 ");
				if(codeName != null && !"".equals(codeName))
					hql.append(" and d.codeName ='"+codeName+"'");
				if(showName != null && !"".equals(showName))
					hql.append(" and d.showName ='"+showName+"'");
				Query query = session.createQuery(hql.toString());

				return query.list();
			}

		});
		if(list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}

}
