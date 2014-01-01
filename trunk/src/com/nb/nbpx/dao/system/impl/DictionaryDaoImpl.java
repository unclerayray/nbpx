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
			final String codeName, final Integer rows, final Integer start, final String sort, final String order) {
		List<Dictionary> list = new ArrayList<Dictionary>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

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
				

				if (sort != null && !sort.isEmpty()) {
					hql.append(" order by d." + sort);
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				}else{
					hql.append(" order by d.dicId desc ");
				}
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
	public List<Dictionary> queryDicTypes(final Integer rows,
			final Integer start) {
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
				hql.append(" and dicType = '" + dictionary.getDicType()
						+ "' ");
				hql.append(" and showName = '" + dictionary.getShowName()
						+ "'");
				Query query = session.createQuery(hql.toString());
				return query.list();
			}
		});
		Long countL = (Long) list.get(0);
		if (countL.intValue() > 0) {
			return true;
		} else {
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
		if (countL.intValue() > 0) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public Dictionary getDictionary(final String codeName, final String showName) {
		List<Dictionary> list = new ArrayList<Dictionary>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new Dictionary(d.dicId,d.codeName,d.showName,d.discription,d.flag) from Dictionary d where 1=1 ");
				if (codeName != null && !"".equals(codeName))
					hql.append(" and d.codeName ='" + codeName + "'");
				if (showName != null && !"".equals(showName))
					hql.append(" and d.showName ='" + showName + "'");
				Query query = session.createQuery(hql.toString());

				return query.list();
			}

		});
		if (list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}

	@Override
	public Dictionary getDictionary(final String codeName, final String showName, final String dicType) {
		List<Dictionary> list = new ArrayList<Dictionary>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new Dictionary(d.dicId,d.codeName,d.showName,d.discription,d.flag) from Dictionary d where 1=1 ");
				if (codeName != null && !"".equals(codeName))
					hql.append(" and d.codeName ='" + codeName + "'");
				if (showName != null && !"".equals(showName))
					hql.append(" and d.showName ='" + showName + "'");
				if (dicType != null && !"".equals(dicType))
						hql.append(" and d.dicType ='" + dicType + "'");
				Query query = session.createQuery(hql.toString());

				return query.list();
			}

		});
		if (list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}

	@Override
	public String getLatestCode(String type) {
		String sql = "select substring_index(codeName,'_',-1)+1 from  Dictionary d where d.dicType =  "
				+ "'"
				+ type
				+ "'"
				+ " order by substring_index(codeName,'_',-1)+1 desc limit 1;";
		if("998".equals(type)){
			sql = "select codeName+1 from Dictionary d where d.dicType = '998' order by codeName+1 desc limit 1;";
		}
		List list = find(sql);
		if (list == null || list.isEmpty()) {
			return type + "_" + "0000";
		} else {
			if("998".equals(type)){
				return list.get(0).toString();
			}else{
				return type + "_" + list.get(0).toString();
			}
		}
	}

}
