package com.nb.nbpx.dao.keyword.impl;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
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
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.pojo.keyword.Keyword;

/**
 * @author Roger
 * @date 2013年7月21日
 */
@Component("KeywordDao")
@SuppressWarnings({ "unchecked", "rawtypes" })
public class KeywordDaoImpl extends BaseDaoImpl<Keyword, Integer> implements
		IKeywordDao {
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	@Resource
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Keyword saveOrGetExistsKeyword(Keyword keyword) {

		List list = find("from Keyword where keyword = '"
				+ keyword.getKeyword() + "' and category = '"
				+ keyword.getCategory() + "'");
		if (list.isEmpty()) {
			// 不存在重复
			save(keyword);
		} else {
			// 存在重复
			keyword = (Keyword) list.get(0);
		}

		return keyword;
	}

	@Override
	public List<Keyword> queryKeywords(final Integer limit,
			final Integer start, final String category, final String keyText,
			final Integer keyId, final String sort, final String order) {
		List<Keyword> list = getHibernateTemplate().executeFind(
				new HibernateCallback() {

					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						StringBuffer sql = new StringBuffer(
								"select new Keyword(k.keyId, k.keyword, k.flag,"
										+ " d.showName, k.category, k.recommanded,"
										+ " k.hits, k.searchCnt, k.recommandDate) from Keyword k, Dictionary d "
										+ " where k.category = d.codeName ");
						if (keyId != null) {
							sql.append(" and k.keyId = ? ");
						}
						if (category != null && !category.isEmpty()) {
							sql.append(" and k.category = ?");
						}
						if (keyText != null && !keyText.isEmpty()) {
							sql.append(" and k.keyword like ?");
						}
						if (sort != null && !sort.isEmpty()) {
							sql.append(" order by k." + sort);
						}
						if (order != null && !order.isEmpty()) {
							sql.append(" " + order);
						}
						Query query = session.createQuery(sql.toString());
						int n = 0;
						if (keyId != null) {
							query.setInteger(n++, keyId);
						}
						if (category != null && !category.isEmpty()) {
							query.setString(n++, category);
						}
						if (keyText != null && !keyText.isEmpty()) {
							query.setString(n++, "%" + keyText + "%");
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
	public Long querykeywordsCount(Integer limit, Integer start,
			final String category, final String keyText, final Integer keyId) {
		List list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select count(k) from Keyword k " + " where 1=1 ");
				if (keyId != null) {
					sql.append(" and k.keyId = ? ");
				}
				if (category != null && !category.isEmpty()) {
					sql.append(" and k.category = ?");
				}
				if (keyText != null && !keyText.isEmpty()) {
					sql.append(" and k.keyword like ?");
				}
				Query query = session.createQuery(sql.toString());
				int n = 0;
				if (keyId != null) {
					query.setInteger(n++, keyId);
				}
				if (category != null && !category.isEmpty()) {
					query.setString(n++, category);
				}
				if (keyText != null && !keyText.isEmpty()) {
					query.setString(n++, "%" + keyText + "%");
				}
				return query.list();
			}
		});
		return (Long) list.get(0);
	}

	@Override
	public Boolean recommandKeywords(String[] keyIds) {
		String[] sqlArr = new String[keyIds.length];
		for (int i = 0; i < keyIds.length; i++) {
			String keyId = keyIds[i];
			StringBuffer sql = new StringBuffer(
					"update keywords set recommanded = 1,recommandDate = sysdate() where keyId =");
			sql.append(keyId);
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
	public Boolean importKeywords(final String category, final String[] keywords) {
		int[] keyIds = new int[keywords.length];
		String sql = "INSERT INTO keywords(keyword ,flag ,category ,hits ,searchCnt) VALUES (?,1,?,500,500) ;";
		// String[] sqlArr = new String[keywords.length];
		// for(int i=0;i<keywords.length;i++){
		// String keyword = keywords[i];
		// StringBuffer sql = new
		// StringBuffer("INSERT INTO keywords(keyword ,flag ,category ,hits ,searchCnt) VALUES ('");
		// sql.append(keyword+"',");
		// sql.append(1+",'");
		// sql.append(category+"',");
		// sql.append(500+",");
		// sql.append(500+")");
		// sqlArr[i] = sql.toString();
		// }

		try {
			keyIds = jdbcTemplate.batchUpdate(sql,
					new BatchPreparedStatementSetter() {

						@Override
						public int getBatchSize() {
							return keywords.length;
						}

						@Override
						public void setValues(PreparedStatement ps, int i)
								throws SQLException {
							ps.setString(1, keywords[i]);
							ps.setString(2, category);
						}
					});
		} catch (DataAccessException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	public List<Keyword> getKeyWordsListOnly(final Integer flag,final String type,final Integer start,final Integer rows){
		List<Keyword> list = new ArrayList<Keyword>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select k.*  from keywords k,coursekeywords a where k.keyId=a.keywordId and k.flag=1 ");
				
				if(type != null && !"".equals(type))//关键词类别
					sql.append(" and k.category='"+type+"'");
					
				if(flag == 1)
					sql.append(" order by k.hits desc");
				else if(flag == 2)
					sql.append(" and k.recommanded =1 order by k.recommandDate desc");
				else
					sql.append(" order by k.searchCnt desc");
				
				Query query = session.createSQLQuery(sql.toString()).addEntity(Keyword.class);

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}

				return query.list();
			}
		});
		return list;
	}
	
	//得到搜索排行关键词,flag:1代表点击率，2代表推荐，3代表热搜
	@SuppressWarnings("unchecked")
	public List<Keyword> getKeyWordsList(final boolean isInner,final Integer flag,final String type,final Integer start,final Integer rows){
		List<Keyword> list = new ArrayList<Keyword>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select k.*  from keywords k,coursekeywords a, courses b where a.courseId = b.courseId  and k.keyId=a.keywordId and k.flag=1 ");
				if(isInner)//因为是内训课程，就肯定是培训课程，所以内训的关键词也是培训的关键词，但是培训的关键词不一定是内训的关键词
					sql.append(" and b.isInner = 1");
				
				if(type != null && !"".equals(type))//关键词类别
					sql.append(" and k.category='"+type+"'");
					
				if(flag == 1)
					sql.append(" order by k.hits desc");
				else if(flag == 2)
					sql.append(" and k.recommanded =1 order by k.recommandDate desc");
				else
					sql.append(" order by k.searchCnt desc");
				
				Query query = session.createSQLQuery(sql.toString()).addEntity(Keyword.class);

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}

				return query.list();
			}
		});
		return list;
	}
	//关键词
	public List<Keyword> getKeyWordsListByType(final String type,final Integer start,final Integer rows){
		List<Keyword> list = new ArrayList<Keyword>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select k.*  from keywords k,coursekeywords a, courses b where a.courseId = b.courseId  and k.keyId=a.keywordId and k.flag=1 ");
				
				if(type != null && !"".equals(type))//关键词类别
					sql.append(" and k.category='"+type+"'");
					
				sql.append(" order by k.recommanded desc,keyId desc");
				
				Query query = session.createSQLQuery(sql.toString()).addEntity(Keyword.class);

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}

				return query.list();
			}
		});
		return list;
	}
	
	public int countKeyWordsListByType(final String type){
		List<Keyword> list = new ArrayList<Keyword>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select k.*  from keywords k,coursekeywords a, courses b where a.courseId = b.courseId  and k.keyId=a.keywordId and k.flag=1 ");
				
				if(type != null && !"".equals(type))//关键词类别
					sql.append(" and k.category='"+type+"'");
					
				sql.append(" order by k.recommanded desc,keyId desc");
				
				Query query = session.createSQLQuery(sql.toString()).addEntity(Keyword.class);


				return query.list();
			}
		});
		return list.size();
	}
	
	//获取最新的关键词 
	public List<Keyword> getLastedKeyWords(final Integer start,final Integer rows){
		List<Keyword> list = new ArrayList<Keyword>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select k.*  from keywords k ");

				sql.append(" order by k.keyId desc");
				
				Query query = session.createSQLQuery(sql.toString()).addEntity(Keyword.class);

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
	public List<Keyword> getNotIndexedKeyWordsList() {
		List<Keyword> list = new ArrayList<Keyword>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer(
						"select k.*  from keywords k where k.indexed = 0 ");
				Query query = session.createSQLQuery(sql.toString()).addEntity(Keyword.class);
				return query.list();
			}
		});
		return list;
	}
}
