package com.nb.nbpx.dao.user.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.user.IOrgInfoDao;
import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.pojo.user.User;

@Component("OrgInfoDao")
public class OrgInfoDaoImpl extends BaseDaoImpl<OrgInfo, Integer>  implements IOrgInfoDao{
	
	@Override
	public List<OrgInfo> getOrgInforByUserId(final Integer userId) {
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				List list = new ArrayList<User>();
				int i = 0;
				String hql = "select new com.nb.nbpx.pojo.user.OrgInfo(u.orgId,u.userId,u.orgName,u.address,u.postCode,u.contact,u.cellphone,u.telephone,u.fax,u.website,u.category,u.introduction) from OrgInfo u where 1 = 1";
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
	public Boolean saveOrgInfo(final OrgInfo orgInfor) {
		@SuppressWarnings("unchecked")
		Boolean result = (Boolean)getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
			throws HibernateException, SQLException {
				session.saveOrUpdate(orgInfor);
				return true;
			}
		});
		return result;
	}
	
}
