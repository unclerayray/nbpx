package com.nb.nbpx.dao.subject.impl;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.subject.ISubjectDao;
import com.nb.nbpx.pojo.subject.Subject;

/**
 * @author Roger
 * @date 2013年8月4日
 */
@Component("SubjectDao")
@SuppressWarnings({ "unchecked", "rawtypes" })
public class SubjectDaoImpl extends BaseDaoImpl<Subject, Integer> implements ISubjectDao{
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	@Resource
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Subject saveOrGetExistsSubject(Subject subject) {

		List list = find("from Subject where subject = '"
				+ subject.getSubject() + "' and category = '"
				+ subject.getCategory() + "'");
		if (list.isEmpty()) {
			// 不存在重复
			save(subject);
		} else {
			// 存在重复
			subject = (Subject) list.get(0);
		}

		return subject;
	}

	@Override
	public List<Subject> querySubjects(final Integer limit,
			final Integer start, final String category, final String subjectText,
			final Integer subjectId, final String sort, final String order) {
		List<Subject> list = getHibernateTemplate().executeFind(
				new HibernateCallback() {

					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						StringBuffer sql = new StringBuffer(
								"select new Subject(k.subjectId, k.subject, k.flag,"
										+ " d.showName, k.category, k.recommanded,"
										+ " k.hits, k.searchCnt, k.recommandDate) from Subject k, Dictionary d "
										+ " where k.category = d.codeName ");
						if (subjectId != null) {
							sql.append(" and k.subjectId = ? ");
						}
						if (category != null && !category.isEmpty()) {
							sql.append(" and k.category = ?");
						}
						if (subjectText != null && !subjectText.isEmpty()) {
							sql.append(" and k.subject like ?");
						}
						if (sort != null && !sort.isEmpty()) {
							sql.append(" order by k." + sort);
						}
						if (order != null && !order.isEmpty()) {
							sql.append(" " + order);
						}
						Query query = session.createQuery(sql.toString());
						int n = 0;
						if (subjectId != null) {
							query.setInteger(n++, subjectId);
						}
						if (category != null && !category.isEmpty()) {
							query.setString(n++, category);
						}
						if (subjectText != null && !subjectText.isEmpty()) {
							query.setString(n++, "%" + subjectText + "%");
						}
						if (start != null && limit != null) {
							query.setFirstResult(start);
							query.setMaxResults(limit);
						}
						return query.list();
					}
				});
		return list;
	}

	@Override
	public Long querysubjectsCount(Integer limit, Integer start,
			final String category, final String subjectText, final Integer subjectId) {
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select count(k) from Subject k " + " where 1=1 ");
				if (subjectId != null) {
					sql.append(" and k.subjectId = ? ");
				}
				if (category != null && !category.isEmpty()) {
					sql.append(" and k.category = ?");
				}
				if (subjectText != null && !subjectText.isEmpty()) {
					sql.append(" and k.subject like ?");
				}
				Query query = session.createQuery(sql.toString());
				int n = 0;
				if (subjectId != null) {
					query.setInteger(n++, subjectId);
				}
				if (category != null && !category.isEmpty()) {
					query.setString(n++, category);
				}
				if (subjectText != null && !subjectText.isEmpty()) {
					query.setString(n++, "%" + subjectText + "%");
				}
				return query.list();
			}
		});
		return (Long) list.get(0);
	}

	@Override
	public Boolean recommandSubjects(String[] subjectIds) {
		String[] sqlArr = new String[subjectIds.length];
		for (int i = 0; i < subjectIds.length; i++) {
			String subjectId = subjectIds[i];
			StringBuffer sql = new StringBuffer(
					"update subjects set recommanded = 1,recommandDate = sysdate() where subjectId =");
			sql.append(subjectId);
			sqlArr[i] = sql.toString();
		}
		try {
			jdbcTemplate.batchUpdate(sqlArr);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public Boolean importSubjects(final String category, final String[] subjects) {
		int[] subjectIds = new int[subjects.length];
		String sql = "INSERT INTO subjects(subject ,flag ,category ,hits ,searchCnt) VALUES (?,1,?,500,500) ;";

		try {
			subjectIds = jdbcTemplate.batchUpdate(sql,
					new BatchPreparedStatementSetter() {

						@Override
						public int getBatchSize() {
							return subjects.length;
						}

						@Override
						public void setValues(PreparedStatement ps, int i)
								throws SQLException {
							ps.setString(1, subjects[i]);
							ps.setString(2, category);
						}
					});
		} catch (DataAccessException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	//得到专题列表，flag:1代表点击率，2代表推荐，3代表热搜
	public List<Subject> getSubjectsList(final boolean isInner,final String type,final Integer flag,final Integer start,final Integer rows){
		List<Subject> list = getHibernateTemplate().executeFind(
				new HibernateCallback() {

					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						StringBuffer sql = new StringBuffer(
								"select s.*  from subjects s,coursesubjects a, courses b where a.courseId = b.courseId  and s.subjectId=a.subjectId and s.flag=1 ");
						if(isInner)//因为是内训课程，就肯定是培训课程，所以内训的关键词也是培训的关键词，但是培训的关键词不一定是内训的关键词
							sql.append("and b.isInner = 1");
						if(type != null && "".equals(type))//关键词类别
							sql.append(" and s.category="+type);
							
						if(flag == 1)
							sql.append(" order by s.hits desc");
						else if(flag == 2)
							sql.append(" and s.recommanded =1 order by s.recommandDate desc");
						else
							sql.append(" order by s.searchCnt desc");
						
						Query query =  session.createSQLQuery(sql.toString()).addEntity(Subject.class);
						if (start != null && rows != null) {
							query.setFirstResult(start);
							query.setMaxResults(rows);
						}
						return query.list();
					}
				});
		return list;
	}

}
