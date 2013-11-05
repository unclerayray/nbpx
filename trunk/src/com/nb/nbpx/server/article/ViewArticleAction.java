package com.nb.nbpx.server.article;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.pojo.article.Article;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.article.IArticleService;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrArticleService;
import com.nb.nbpx.utils.JsonUtil;


@Component("ViewArticleAction")
@Scope("prototype")
public class ViewArticleAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private IArticleService articleService;
	private String id;

	//查看文章
	public String viewArticle(){
		//文章阅读次数+1
		articleService.addReadTime(id);
		String result = articleService.getArticleDetail(id);
		
		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	//获取热门文章排行
	public String getHotArticle(){
		String result = articleService.getHotArticle(8, 0);
		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	//获取推荐文章排行
	public String getRecommandArticle(){
		String result = articleService.getRecommandArticle(8, 0);
		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	//category值为004_01、004_02等
	public String getArticleList(){
		String category = "004_0"+id;
		String result = articleService.viewArticleType(category, rows, this.getStartPosi());
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public IArticleService getArticleService() {
		return articleService;
	}
	@Resource
	public void setArticleService(IArticleService articleService) {
		this.articleService = articleService;
	}
	

}
