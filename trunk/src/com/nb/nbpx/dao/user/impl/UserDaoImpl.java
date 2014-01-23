package com.nb.nbpx.dao.user.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.user.IUserDao;
import com.nb.nbpx.pojo.user.User;

@Component("UserDao")
public class UserDaoImpl extends BaseDaoImpl<User, Integer> implements IUserDao {
	
	@SuppressWarnings("unchecked")
	@Override
	/**
	 * 根据用户名查找用户
	 */
	public List<User> queryUserByUserName(final String username){
		List<User> list = getHibernateTemplate().executeFind(
				new HibernateCallback() {
					public Object doInHibernate(Session session)throws HibernateException, SQLException {
					List<User> list = new ArrayList<User>();
					int i = 0;
					StringBuffer hql = new StringBuffer(
							"select new com.nb.nbpx.pojo.user.User(u.userId, u.userName, u.passWord, u.userType, u.email, d.showName,u.city,u.state,u.registerDate)"
									+ " from User u,Dictionary d where 1 = 1 "
									+ " and u.userType = d.codeName");
					
					hql.append(" and u.userName = ?");
					org.hibernate.Query query = session.createQuery(hql.toString());
		
					query.setString(i++, username);

					list = query.list();
					//System.out.println("hql = " + hql);
					return list;
					}
				});
		return list;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<User> queryUserByType(final String userName,final String userType,
			final Integer rows, final Integer start, final String sort, final String order) {
		@SuppressWarnings("rawtypes")
		List<User> list = getHibernateTemplate().executeFind(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						List<User> list = new ArrayList<User>();
						int i = 0;
						StringBuffer hql = new StringBuffer(
								"select new com.nb.nbpx.pojo.user.User(u.userId, u.userName, u.passWord, u.userType, u.email, d.showName,u.city,u.state,u.registerDate)"
										+ " from User u,Dictionary d where 1 = 1 "
										+ " and u.userType = d.codeName");
						if (userType != null) {
							hql.append(" and u.userType = ?");
						}
						
						if (userName != null&&!userName.isEmpty()) {
							hql.append(" and u.userName like ?");
						}

						if (sort != null && !sort.isEmpty()) {
							hql.append(" order by u." + sort);
							if (order != null && !order.isEmpty()) {
								hql.append(" " + order);
							}
						} else {
							hql.append(" order by u.userId desc ");
						}
						org.hibernate.Query query = session.createQuery(hql
								.toString());
						if (userType != null) {
							query.setString(i++, userType);
						}
						if (userName != null&&!userName.isEmpty()) {
							query.setString(i++, "%"+userName+"%");
						}
						if (start != null && rows != null) {
							query.setFirstResult(start);
							query.setMaxResults(rows);
						}
						list = query.list();
						//System.out.println("hql = " + hql);
						return list;
					}
				});
		return list;
	}

	@Override
	public Long queryUserCountByType(final String userName,final String userType) {
		@SuppressWarnings({ "rawtypes" })
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				List list = new ArrayList<User>();
				int i = 0;
				String hql = "select count(u) from User u where 1 = 1";
				if (userType != null) {
					hql += " and userType = ?";
				}
				
				if (userName != null&&!userName.isEmpty()) {
					hql +=" and u.userName like ?";
				}

				org.hibernate.Query query = session.createQuery(hql);
				if (userType != null) {
					query.setString(i++, userType);
				}
				if (userName != null&&!userName.isEmpty()) {
					query.setString(i++, "%"+userName+"%");
				}
				list = query.list();
				return list;
			}
		});
		return (Long) list.get(0);
	}

	@Override
	public boolean checkDuplicateProp(final String username, final String email) {
		@SuppressWarnings("rawtypes")
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@SuppressWarnings("unchecked")
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				List<User> list = new ArrayList<User>();
				String hql2 = "from User where username = ?";
				Integer i = 0;
				org.hibernate.Query query = session.createQuery(hql2);
				query.setString(i++, username);
				list = query.list();
				return list;
			}
		});
		if (list != null && list.size() > 0) {
			return true;
		} else {
			return false;
		}
	}

}
