/**
 * @author Roger
 */
package com.nb.nbpx.service.article;

import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.pojo.article.Article;
import com.nb.nbpx.service.IBaseService;

/**
 * @author Roger
 * @date 2013-5-11
 */
public interface IArticleService extends IBaseService {
	public String queryArticles(String category, Integer rows, Integer start, String sort, String order);
	public String queryComboArticleCode(String category);
	public Article saveArticle(Article article) throws Exception ;
	public void deleteArticle(Article article);
	public String queryArticleDetail(Integer articleId);
	/**
	 * 存储（新增或根据主键更新）和文章相关的其他信息
	 * @param article
	 * @param deleteBeforeInsert 在插入前删除所有其他数据
	 * @return
	 */
	public void saveArticleDetail(ArticleDetail articleDetail, Boolean deleteBeforeInsert);
	
	//根据分类获取文章列表
	public String getArticleList(String category,Integer rows, Integer start);
	//根据ID获取文章的内容
	public String getArticleDetail(String id);
}
