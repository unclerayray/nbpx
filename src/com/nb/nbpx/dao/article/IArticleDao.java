/**
 * @author Roger
 */
package com.nb.nbpx.dao.article;

import java.util.List;
import java.util.Map;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.article.Article;
import com.nb.nbpx.pojo.course.Course;

/**
 * @author Roger
 * @date 2013-5-11
 */
public interface IArticleDao extends IBaseDao<Article, Integer> {
	public List<Article> getArticles(String category, Integer rows,
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
}
