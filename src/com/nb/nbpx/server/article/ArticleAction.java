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

/**
 * @author Roger
 * @date 2013年10月12日
 */
@Component("ArticleAction")
@Scope("prototype")
public class ArticleAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Resource
	private IArticleService articleService;
	private String category;
	private ArticleDetail articleDetail;
	@Resource
	private ISolrArticleService solrArticleService;
	@Resource
	private IKeywordService keywordService;
	private Integer selected_articleId;
	private Article article;

	public String queryArticles(){
		String json = articleService.queryArticles(category, rows, getStartPosi(), sort, order);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	/**
	 * <p>
	 * 通过courseId查找课程安排
	 * </p>
	 * 
	 * @return
	 */
	public String queryArticleDetail() {
		String json = articleService.queryArticleDetail(selected_articleId);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String queryComboArticleCode() {
		String json = articleService.queryComboArticleCode(category);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String saveArticle(){
		String regEx1 = "[\\pP‘’“”]";
		if(articleDetail.getKeywords()!=null){
			articleDetail.setKeywords(articleDetail.getKeywords().replaceAll(regEx1, ","));
		}
		if(articleDetail.getSubjects()!=null){
			articleDetail.setSubjects(articleDetail.getSubjects().replaceAll(regEx1, ","));
		}
		List<Keyword> keywords = keywordService.saveKeywords(articleDetail);
		Article art = new Article(articleDetail);
		art.setContent(keywordService.setKeywordHyperLink(keywords, art.getContent()));//生成超链接
		try {
			Boolean deleteBeforeInsert=false;
			if(articleDetail.getArticleId()!=null){
				deleteBeforeInsert = true;
			}
			articleService.saveArticle(art);
			articleDetail.setArticleId(art.getArticleId());
			articleService.saveArticleDetail(articleDetail, deleteBeforeInsert);
			solrArticleService.addArticle2Solr(articleDetail);
			//TODO add article records to solr
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}
	
	public String deleteArticle(){
		articleService.deleteArticle(article);
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}
	
	public IArticleService getArticleService() {
		return articleService;
	}

	public void setArticleService(IArticleService articleService) {
		this.articleService = articleService;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}

	public ArticleDetail getArticleDetail() {
		return articleDetail;
	}

	public void setArticleDetail(ArticleDetail articleDetail) {
		this.articleDetail = articleDetail;
	}

	public Article getArticle() {
		return article;
	}

	public void setArticle(Article article) {
		this.article = article;
	}

	public IKeywordService getKeywordService() {
		return keywordService;
	}

	public void setKeywordService(IKeywordService keywordService) {
		this.keywordService = keywordService;
	}

	public Integer getSelected_articleId() {
		return selected_articleId;
	}

	public void setSelected_articleId(Integer selected_articleId) {
		this.selected_articleId = selected_articleId;
	}

}
