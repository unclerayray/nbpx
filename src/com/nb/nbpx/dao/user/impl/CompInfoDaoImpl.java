package com.nb.nbpx.dao.user.impl;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.user.ICompInfoDao;
import com.nb.nbpx.pojo.user.CompInfo;
import com.nb.nbpx.pojo.user.User;

@Component("CompInfoDao")
public class CompInfoDaoImpl extends BaseDaoImpl<CompInfo, Integer>  implements ICompInfoDao{

	@Override
	public Boolean saveCompInfor(final CompInfo compInfor) {
		@SuppressWarnings("unchecked")
		Boolean result = (Boolean)getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
			throws HibernateException, SQLException {
				session.saveOrUpdate(compInfor);
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
	
}
