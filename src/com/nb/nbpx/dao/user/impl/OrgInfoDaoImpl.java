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
import com.nb.nbpx.dao.user.IOrgInfoDao;
import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.pojo.user.User;

@Component("OrgInfoDao")
@SuppressWarnings({ "unchecked", "rawtypes" })
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
		Boolean result = (Boolean)getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
			throws HibernateException, SQLException {
				if(orgInfor.getOrgId()==null){
					session.save(orgInfor);
				}else{
					session.merge(orgInfor);
				}
				return true;
			}
		});
		return result;
	}

	@Override
	public List<OrgInfo> queryOrgInfo(final String userName, final String orgName,
			final Integer rows, final Integer start, final String sort, final String order) {
		List<OrgInfo> list = new ArrayList<OrgInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(" from OrgInfo o"
						+ " where 1=1 ");
				if (orgName != null && !orgName.isEmpty()) {
					hql.append(" and o.orgName like '%");
					hql.append(orgName + "%' ");
				}
				if (userName != null && !userName.isEmpty()) {
					hql.append(" and o.user.userName like '%");
					hql.append(userName + "%' ");
				}

				if (sort != null && !sort.isEmpty()) {
					hql.append(" order by o." + sort);
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				} else {
					hql.append(" order by o.createDate desc ");
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
	public Long queryOrgInfoCount(final String userName, final String orgName) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(o) from OrgInfo o" + " where 1=1 ");
				if (orgName != null && !orgName.isEmpty()) {
					hql.append(" and o.orgName like '%");
					hql.append(orgName + "%' ");
				}
				if (userName != null && !userName.isEmpty()) {
					hql.append(" and o.user.userName like '%");
					hql.append(userName + "%' ");
				}

				Query query = session.createQuery(hql.toString());

				return query.list();
			}
		});
		return (Long) list.get(0);
	}
	
}
