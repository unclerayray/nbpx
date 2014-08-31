package com.nb.nbpx.dao.article.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.article.IArticleDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.article.Article;
import com.nb.nbpx.pojo.article.ArticleKeyword;
import com.nb.nbpx.pojo.article.ArticleSubject;
import com.nb.nbpx.pojo.course.Course;

/**
 * @author Roger
 * @date 2013年10月12日
 */
@Component("articleDao")
@SuppressWarnings({ "unchecked", "rawtypes" })
public class ArticleDaoImpl extends BaseDaoImpl<Article, Integer> implements
		IArticleDao {
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	@Resource
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public List<Article> getArticles(final String category, final String articleTitle, final Integer articleId, final Boolean p_outside, final Integer rows,
			final Integer start, final String sort, final String order) {
		List<Article> list = new ArrayList<Article>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.article.Article"
								+ " (c.articleId, c.articleTitle, c.author, "
								+ " c.category, c.state, c.hits, c.lastUpdateDate, "
								+ " fd.showName, c.recommanded, c.links, c.createdBy) from Article c, Dictionary fd"
								+ " where 1 = 1 ");
				if (articleId != null) {
					hql.append(" and c.articleId = ? ");
				}
				if (category != null && !category.isEmpty()) {
					hql.append(" and c.category = ? ");
				}
				if (articleTitle != null && !articleTitle.isEmpty()) {
					hql.append(" and c.articleTitle like ? ");
				}
				if (p_outside != null){
					if(p_outside){
						hql.append(" and c.createdBy not in (select userName from Admin) ");
					}else{
						hql.append(" and c.createdBy in (select userName from Admin) ");
					}
				}

				hql.append(" and c.category = fd.codeName ");

				if (sort != null && !sort.isEmpty()) {
					hql.append(" order by c." + sort);
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				} else {
					hql.append(" order by c.lastUpdateDate desc ");
				}
				Query query = session.createQuery(hql.toString());

				if (articleId != null) {
					query.setInteger(i++, articleId);
				}
				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}
				if (articleTitle != null && !articleTitle.isEmpty()) {
					query.setString(i++, "%"+articleTitle+"%");
				}


				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}

				return query.list();
			}
		});
		//Map<String, Object> propertyMap = new HashMap<String, Object>();
		return list;
	}
	
	@Override
	public Long getArticlesCount(final String category, final String articleTitle, final Integer articleId, final Boolean p_outside, final Integer rows,
			final Integer start, final String sort, final String order) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select count(c) from Article c"
								+ " where 1 = 1 ");
				if (articleId != null) {
					hql.append(" and c.articleId = ? ");
				}
				if (category != null && !category.isEmpty()) {
					hql.append(" and c.category = ? ");
				}
				if (articleTitle != null && !articleTitle.isEmpty()) {
					hql.append(" and c.articleTitle like ? ");
				}
				if (p_outside != null){
					if(p_outside){
						hql.append(" and c.createdBy not in (select userName from Admin) ");
					}else{
						hql.append(" and c.createdBy in (select userName from Admin) ");
					}
				}

				if (sort != null && !sort.isEmpty()) {
					hql.append(" order by c." + sort);
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				} else {
					hql.append(" order by c.lastUpdateDate desc ");
				}
				Query query = session.createQuery(hql.toString());

				if (articleId != null) {
					query.setInteger(i++, articleId);
				}
				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}
				if (articleTitle != null && !articleTitle.isEmpty()) {
					query.setString(i++, "%"+articleTitle+"%");
				}


				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}

				return query.list();
			}
		});
		//Map<String, Object> propertyMap = new HashMap<String, Object>();
		return (Long) list.get(0);
	}

	@Override
	public Long queryArticleCount(final String category) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select count(c) from Article c where 1 = 1");
				if (category != null && !category.isEmpty()) {
					hql.append(" and category = ? ");
				}

				Query query = session.createQuery(hql.toString());

				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}

				return query.list();
			}
		});
		return (Long) list.get(0);
	}

	@Override
	public void addArticleDetail(Integer articleId,
			Map<Integer, String> keywordMap, Map<Integer, String> subjectMap) {
		List<String> list = new ArrayList<String>();
		Iterator keywordIter = keywordMap.entrySet().iterator();
		Iterator subjectIter = subjectMap.entrySet().iterator();

		while (keywordIter.hasNext()) {
			Map.Entry entry = (Map.Entry) keywordIter.next();
			Integer wordId = (Integer) (entry.getKey());
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into articlekeywords (articleId,keyword,keywordId) values ");
			sql.append("(").append(articleId).append(",'").append(value)
					.append("','").append(wordId).append("');");
			list.add(sql.toString());
		}

		while (subjectIter.hasNext()) {
			Map.Entry entry = (Map.Entry) subjectIter.next();
			Integer subjectId = (Integer) (entry.getKey());
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into articlesubjects (articleId,subject,subjectId) values ");
			sql.append("(").append(articleId).append(",'").append(value)
					.append("','").append(subjectId).append("');");
			list.add(sql.toString());
		}

		String[] sqlArr = list.toArray(new String[list.size()]);
		if(sqlArr != null&& sqlArr.length != 0)
			jdbcTemplate.batchUpdate(sqlArr);
	}

	@Override
	public void deleteArticleDetail(Integer articleId) {
		String sql1 = "delete from articlekeywords where articleId ="
				+ articleId;
		String sql2 = "delete from articlesubjects where articleId ="
				+ articleId;

		String[] sqlArr = { sql1, sql2 };
		jdbcTemplate.batchUpdate(sqlArr);
	}

	@Override
	public Course updateArticle(Article article) {
		String sql = "update Article SET articleTitle = ?,author = ?  ,category = ? ,content = ? "
				+ ",lastUpdateDate = ? , recommanded = ? ,state = ? ,links = ?, createdBy = ?  WHERE articleId = ?";
		Object[] values = { article.getArticleTitle(), article.getAuthor(),
				article.getCategory(), article.getContent(), article.getLastUpdateDate(),
				article.getRecommanded(), article.getState(), article.getLinks() , article.getCreatedBy(), article.getArticleId()};
		getHibernateTemplate().bulkUpdate(sql, values);
		return null;
	}
	
	//按照发布时间，获取文章列表
	public List<Article> getArticleList(final String category,final Integer rows,final Integer start){
		List<Article> list = new ArrayList<Article>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
			String sql = "select t.* from articles t where t.category = '"+category+"' and t.state = '1' order by t.lastUpdateDate desc ";
			Query query = session.createSQLQuery(sql).addEntity(Article.class);
			
			if (start != null && rows != null) {
				query.setFirstResult(start);
				query.setMaxResults(rows);
			}
			
			return query.list();
			}
			});		
		return list;
	}
	
	//获取排行数据(点击率、推荐),默认按照时间倒叙排序
	public List<Article> getHotArticleList(final Integer rows,final Integer start){
		List<Article> list = new ArrayList<Article>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
			String sql = "select t.* from articles t where t.state = '1' order by t.hits desc";
			Query query = session.createSQLQuery(sql).addEntity(Article.class);
			
			if (start != null && rows != null) {
				query.setFirstResult(start);
				query.setMaxResults(rows);
			}
			
			return query.list();
			}
			});		
		return list;
		
	}
	
	//获取推荐的文章，按照更新时间倒序
	public List<Article> getRecommendArticleList(final Integer rows,final Integer start){
		List<Article> list = new ArrayList<Article>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
			String sql = "select t.* from articles t where t.state = '1' and t.recommanded=1 order by t.lastUpdateDate desc";
			Query query = session.createSQLQuery(sql).addEntity(Article.class);
			
			if (start != null && rows != null) {
				query.setFirstResult(start);
				query.setMaxResults(rows);
			}
			
			return query.list();
			}
			});		
		return list;
	}
	
	//根据文章ID获取文章的关键词
	public List<ArticleKeyword> getArticleKeywordsById(final String articleID){
		List<ArticleKeyword> list = new ArrayList<ArticleKeyword>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
			String sql = "select a.* from articlekeywords a,keywords b where a.keywordId = b.keyId and a.articleId='"+articleID+"'";
			Query query = session.createSQLQuery(sql).addEntity(ArticleKeyword.class);
			
			return query.list();
			}
			});		
		return list;
	}
	
	//根据文章ID获取文章的专题
	public List<ArticleSubject> getArticleSubjectById(final String articleID){
		List<ArticleSubject> list = new ArrayList<ArticleSubject>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
			String sql = "select a.* from articlesubjects a,subjects b where a.subjectId = b.subjectId  and a.articleId='"+articleID+"'";
			Query query = session.createSQLQuery(sql).addEntity(ArticleSubject.class);
			
			return query.list();
			}
			});		
		return list;
	}
	
}
