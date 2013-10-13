package com.nb.nbpx.pojo.article;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * 
 * @author Roger
 * @date 2013年7月21日
 */
@Entity
@Table(name = "articlekeywords", catalog = "nbpx")
public class ArticleKeyword extends BaseEntity   implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Integer articleKeywordId;
	public Integer keywordId;
	public Integer articleId;
	public String keyword;
	
	public ArticleKeyword(){
	}
	
	public ArticleKeyword(Integer articleKeywordId, Integer keywordId,
			Integer articleId, String keyword) {
		super();
		this.articleKeywordId = articleKeywordId;
		this.keywordId = keywordId;
		this.articleId = articleId;
		this.keyword = keyword;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "articleKeywordId", unique = true, nullable = false)
	public Integer getArticleKeywordId() {
		return articleKeywordId;
	}
	public void setArticleKeywordId(Integer articleKeywordId) {
		this.articleKeywordId = articleKeywordId;
	}
	public Integer getKeywordId() {
		return keywordId;
	}
	public void setKeywordId(Integer keywordId) {
		this.keywordId = keywordId;
	}
	public Integer getArticleId() {
		return articleId;
	}
	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
}
