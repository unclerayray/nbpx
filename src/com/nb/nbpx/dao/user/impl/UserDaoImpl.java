package com.nb.nbpx.dao.user.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.HqlConstants;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.user.IUserDao;
import com.nb.nbpx.pojo.user.User;

@Component("UserDao")
public class UserDaoImpl extends BaseDaoImpl<User, Integer> implements IUserDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<User> queryUserByType(final int userType,final Integer limit, final Integer start) {
		@SuppressWarnings("rawtypes")
		List<User> list = getHibernateTemplate().executeFind(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                List<User> list = new ArrayList<User>();
                int i = 0;
                String hql = HqlConstants.USER_QUERY_BY_USERTYPE;
                org.hibernate.Query query = session.createQuery(hql);
                query.setInteger(i++, userType);
                if (start != null && limit != null) {
					query.setFirstResult(start);
					query.setMaxResults(limit);
				}
                list = query.list();
                return list;
            }
        });
        return list;
	}

	@Override
	public Long queryUserCountByType(final int userType) {
		@SuppressWarnings({ "rawtypes" })
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                List list = new ArrayList<User>();
                int i = 0;
                String hql = "select count(*) from users where userType = ?";
                org.hibernate.Query query = session.createQuery(hql);
                query.setInteger(i++, userType);
                list = query.list();
                return list;
            }
        });
		return (Long)list.get(0);
	}

}
