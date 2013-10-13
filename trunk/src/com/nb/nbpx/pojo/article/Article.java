/**
 * @author Roger
 */
package com.nb.nbpx.pojo.article;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2013-5-11
 */
@Entity
@Table(name = "articles", catalog = "nbpx")
public class Article extends BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public Integer articleId;
	public String articleTitle;
	public String author;
	public String category;
	public String content;
	public Boolean state;
	public Integer hits;
	public Date creationDate;
	public Date lastUpdateDate;
	public String categoryName;
	public Boolean recommanded;

	public Article(){
		
	}
	
	
	
	public Article(ArticleDetail detail) {
		super();
		this.articleId = detail.articleId;
		this.articleTitle = detail.articleTitle;
		this.author = detail.author;
		this.category = detail.category;
		this.content = detail.content;
		this.state = detail.state;
		this.hits = detail.hits;
		this.creationDate = detail.creationDate;
		this.lastUpdateDate = detail.lastUpdateDate;
		this.categoryName = detail.categoryName;
		this.recommanded = detail.recommanded;
	}



	/**
	 * 后台管理系统查询类表所用的构造函数
	 * @param articleId
	 * @param articleTitle
	 * @param author
	 * @param category
	 * @param state
	 * @param hits
	 * @param lastUpdateDate
	 * @param categoryName
	 * @param recommanded
	 */
	public Article(Integer articleId, String articleTitle, String author,
			String category, Boolean state, Integer hits,
			Date lastUpdateDate, String categoryName, Boolean recommanded) {
		super();
		this.articleId = articleId;
		this.articleTitle = articleTitle;
		this.author = author;
		this.category = category;
		this.state = state;
		this.hits = hits;
		this.lastUpdateDate = lastUpdateDate;
		this.categoryName = categoryName;
		this.recommanded = recommanded;
	}
	
	public Article(Integer articleId, String articleTitle, String author,
			String category, String content, Boolean state, Integer hits,
			Date lastUpdateDate, String categoryName, Boolean recommanded) {
		super();
		this.articleId = articleId;
		this.articleTitle = articleTitle;
		this.author = author;
		this.category = category;
		this.content = content;
		this.state = state;
		this.hits = hits;
		this.lastUpdateDate = lastUpdateDate;
		this.categoryName = categoryName;
		this.recommanded = recommanded;
	}

	public Article(Integer articleId, String articleTitle, String author,
			String category, String content, Boolean state, Integer hits,
			Date creationDate,
			Date lastUpdateDate, String categoryName, Boolean recommanded) {
		super();
		this.articleId = articleId;
		this.articleTitle = articleTitle;
		this.author = author;
		this.category = category;
		this.content = content;
		this.state = state;
		this.hits = hits;
		this.creationDate = creationDate;
		this.lastUpdateDate = lastUpdateDate;
		this.categoryName = categoryName;
		this.recommanded = recommanded;
	}

	/**
	 * @param articleId the articleId to set
	 */
	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "articleId", unique = true, nullable = false)
	public Integer getArticleId() {
		return articleId;
	}

	public String getArticleTitle() {
		return articleTitle;
	}

	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Boolean getState() {
		return state;
	}

	public void setState(Boolean state) {
		this.state = state;
	}

	public Integer getHits() {
		return hits;
	}

	public void setHits(Integer hits) {
		this.hits = hits;
	}


	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}

	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}

	@Transient
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public Boolean getRecommanded() {
		return recommanded;
	}

	public void setRecommanded(Boolean recommanded) {
		this.recommanded = recommanded;
	}
}
