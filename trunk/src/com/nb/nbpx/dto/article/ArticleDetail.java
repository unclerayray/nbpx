package com.nb.nbpx.dto.article;

import java.io.Serializable;
import java.util.Date;

import com.nb.nbpx.pojo.article.Article;

public class ArticleDetail extends Article implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String keywords;
	private String subjects;

	public ArticleDetail(){
		
	}
	
	public ArticleDetail(Integer articleId, String articleTitle, String author,
			String category, Boolean state, Integer hits, Date lastUpdateDate,
			String categoryName, Boolean recommanded) {
		super(articleId, articleTitle, author, category, state, hits, lastUpdateDate,
				categoryName, recommanded);
	}
	

	
	public ArticleDetail(Article article) {
		this.articleId = article.articleId;
		this.articleTitle = article.articleTitle;
		this.author = article.author;
		this.category = article.category;
		this.content = article.content;
		this.state = article.state;
		this.hits = article.hits;
		this.creationDate = article.creationDate;
		this.lastUpdateDate = article.lastUpdateDate;
		this.categoryName = article.categoryName;
		this.recommanded = article.recommanded;
	}


	public ArticleDetail(Integer articleId, String articleTitle, String author,
			String category, Boolean state, Integer hits, Date lastUpdateDate,
			String categoryName, Boolean recommanded, String keywords,
			String subjects) {
		super(articleId, articleTitle, author, category, state, hits,
				lastUpdateDate, categoryName, recommanded);
		this.keywords = keywords;
		this.subjects = subjects;
	}

	public ArticleDetail(Integer articleId, String keywords,
			String subjects) {
		this.articleId = articleId;
		this.keywords = keywords;
		this.subjects = subjects;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getSubjects() {
		return subjects;
	}

	public void setSubjects(String subjects) {
		this.subjects = subjects;
	}
	
	
}
