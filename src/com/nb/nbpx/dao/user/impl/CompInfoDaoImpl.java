package com.nb.nbpx.dao.user.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.user.ICompInfoDao;
import com.nb.nbpx.pojo.user.CompInfo;
import com.nb.nbpx.pojo.user.User;

@Component("CompInfoDao")
@SuppressWarnings({ "unchecked", "rawtypes" })
public class CompInfoDaoImpl extends BaseDaoImpl<CompInfo, Integer> implements
		ICompInfoDao {

	@Override
	public Boolean saveCompInfor(final CompInfo compInfor) {
		Boolean result = (Boolean) getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						if(compInfor.getCompInfoId()==null){
							session.save(compInfor);
						}else{
							session.merge(compInfor);
						}
						return true;
					}
				});

		return result;
	}

	@Override
	public List<CompInfo> getCompInforByUserId(final Integer userId) {
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				List list = new ArrayList<User>();
				int i = 0;
				String hql = "select new com.nb.nbpx.pojo.user.CompInfo(u.compInfoId,u.userId,u.contact,u.company,u.telephone,u.cellphone,u.fax,u.department) from CompInfo u where 1 = 1";
				if (userId != null) {
					hql += " and userId = ?";
				}
				org.hibernate.Query query = session.createQuery(hql);
				if (userId != null) {
					query.setInteger(i++, userId);
				}
				list = query.list();
				return list;
			}
		});
		return list;
	}

	@Override
	public List<CompInfo> queryCompInfo(final String userName,
			final String company, final String contact,
			final String department, final Integer rows, final Integer start,
			final String sort, final String order) {
		List<CompInfo> list = new ArrayList<CompInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(" from CompInfo c"
						+ " where 1=1 ");
				if (company != null && !company.isEmpty()) {
					hql.append(" and c.company like '%");
					hql.append(company + "%' ");
				}
				if (userName != null && !userName.isEmpty()) {
					hql.append(" and c.user.userName like '%");
					hql.append(userName + "%' ");
				}
				if (contact != null && !contact.isEmpty()) {
					hql.append(" and c.contact = '");
					hql.append(contact + "' ");
				}
				if (department != null && !department.isEmpty()) {
					hql.append(" and c.department = '");
					hql.append(department + "' ");
				}

				if (sort != null && !sort.isEmpty()) {
					hql.append(" order by c." + sort);
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				} else {
					hql.append(" order by c.createDate desc ");
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
	public Long queryCompInfoCount(final String userName, final String company,  final String contact,
			final String department) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(c) from CompInfo c" + " where 1=1 ");
				if (company != null && !company.isEmpty()) {
					hql.append(" and c.company like '%");
					hql.append(company + "%' ");
				}
				if (userName != null && !userName.isEmpty()) {
					hql.append(" and c.user.userName like '%");
					hql.append(userName + "%' ");
				}

				if (contact != null && !contact.isEmpty()) {
					hql.append(" and c.contact = '");
					hql.append(contact + "' ");
				}
				if (department != null && !department.isEmpty()) {
					hql.append(" and c.department = '");
					hql.append(department + "' ");
				}
				Query query = session.createQuery(hql.toString());

				return query.list();
			}
		});
		return (Long) list.get(0);
	}

}
