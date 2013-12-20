package com.nb.nbpx.dao.user.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.user.ITeacherInfoDao;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.pojo.user.User;

@Component("TeacherInfoDao")
public class TeacherInfoDaoImpl extends BaseDaoImpl<TeacherInfo, Integer>  implements ITeacherInfoDao{

	@Override
	public List<TeacherInfo> getTeacherInforByUserId(final Integer userId) {
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				List list = new ArrayList<User>();
				int i = 0;
				String hql = "select new com.nb.nbpx.pojo.user.TeacherInfo(u.teacherId,u.userId,u.realName,u.birthday,u.majorCatgory,u.externalPayment,u.internalPayment,u.fax,u.telephone,u.cellphone,u.introduction,u.expertIn) from TeacherInfo u where 1 = 1";
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
	public Boolean saveTeacherInfor(final TeacherInfo teacherInfor) {
		@SuppressWarnings("unchecked")
		Boolean result = (Boolean)getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
			throws HibernateException, SQLException {
				if(teacherInfor.getTeacherId() == null)
					session.save(teacherInfor);
				else
					session.saveOrUpdate(teacherInfor);
				return true;
			}
		});
		
		return result;
	}
	//根据Id获取老师的信息
	public TeacherInfo getTeacherInfoById(final Integer teacherId){
			List teacherList = getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				String hql = "select new com.nb.nbpx.pojo.user.TeacherInfo(u.teacherId,u.userId,u.realName,u.birthday,u.majorCatgory,u.externalPayment,u.internalPayment,u.fax,u.telephone,u.cellphone,u.introduction,u.expertIn) from TeacherInfo u where 1 = 1";
				if (teacherId != null) {
					hql += " and teacherId = ?";
				}
				org.hibernate.Query query = session.createQuery(hql);
				if (teacherId != null) {
					query.setInteger(i++, teacherId);
				}
				
				List list = query.list();
				if(list == null || list.size() == 0)
					return null;
				return list;
			}
		});
		
		if(teacherList == null || teacherList.size() == 0)
			return null;
		else
			return (TeacherInfo)teacherList.get(0);
	}

}
