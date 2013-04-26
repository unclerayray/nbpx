package com.nb.nbpx.dao.system.impl;

import java.sql.SQLException;
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
public class DictionaryDaoImpl extends BaseDaoImpl<Dictionary, Integer>
		implements IDictionaryDao {

	@Override
	public List<Dictionary> queryDictionary(final String dicType,
			final String showName, final Integer rows, final Integer start) {
		List<Dictionary> list = getHibernateTemplate().executeFind(
				new HibernateCallback() {

					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						int i = 0;
						StringBuffer hql = new StringBuffer(
								"select new com.nb.nbpx.pojo.system.Dictionary" +
								"(d.dicId, d.dicType, d.codeName, d.showName, d.orderNum," +
								" d.attribute1, d.attribute2, d.attribute3, d.flag," +
								" d.discription, fd.showName) from Dictionary d, Dictionary fd" +
								" where 1 = 1 ");
						if (dicType != null) {
							hql.append("and d.dicType = ");
						}

						if (showName != null) {
							hql.append("and d.showName = ");
						}
						
						hql.append("and d.dicType = fd.codeName ");
						Query query = session.createQuery(hql.toString());

						if (dicType != null) {
							query.setString(i++, dicType);
						}

						if (showName != null) {
							query.setString(i++, showName);
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
	public List queryDicTypes() {
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new Dictionary(d.codeName,d.showName) from Dictionary d where dicType = '998'");
				Query query = session.createQuery(hql.toString());
				return query.list();
			}

		});
		return list;
	}

	@Override
	public void addDic(Dictionary dictionary) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteDic(Dictionary dictionary) {
		// TODO Auto-generated method stub

	}

	@Override
	public Long queryDictionaryCount(final String dicType, final String showName) {
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select count(d) from Dictionary d where 1 = 1 ");
				if (dicType != null) {
					hql.append("and d.dicType = ");
				}

				if (showName != null) {
					hql.append("and d.showName = ");
				}
				Query query = session.createQuery(hql.toString());

				if (dicType != null) {
					query.setString(i++, dicType);
				}

				if (showName != null) {
					query.setString(i++, showName);
				}

				return query.list();
			}
		});
		return (Long) list.get(0);
	}

}
