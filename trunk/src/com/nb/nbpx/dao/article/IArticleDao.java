/**
 * @author Roger
 */
package com.nb.nbpx.dao.article;

import java.util.List;
import java.util.Map;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.article.*;
import com.nb.nbpx.pojo.course.Course;

/**
 * @author Roger
 * @date 2013-5-11
 */
public interface IArticleDao extends IBaseDao<Article, Integer> {
	public List<Article> getArticles(String category, String articleTitle, Integer articleId, Boolean p_outside, Integer rows,
			Integer start, String sort, String order);

	//public Article getArticleDetailById();
	
	public Long queryArticleCount(String category);


	public void addArticleDetail(Integer articleId,
			Map<Integer, String> keywordMap, Map<Integer, String> subjectMap);
	
	/**
	 * 用于在保存的时候删除原有的文章相关的关键词和专题等，把新的数据全部插入
	 * 
	 * @param articleId
	 */
	public void deleteArticleDetail(Integer articleId);
	
	public Course updateArticle(Article article);
	//根据文章ID获取文章的关键词
	public List<ArticleKeyword> getArticleKeywordsById(String articleID);
	//根据文章ID获取文章的专题
	public List<ArticleSubject> getArticleSubjectById(String articleID);
	//默认按照更新时间排序
	public List<Article> getArticleList(String category,Integer rows,Integer start);
	//获取排行数据点击率
	public List<Article> getHotArticleList(Integer rows,Integer start);
	//获取排行数据推荐，默认按照时间倒叙排序
	public List<Article> getRecommendArticleList(Integer rows,Integer start);
	

}
