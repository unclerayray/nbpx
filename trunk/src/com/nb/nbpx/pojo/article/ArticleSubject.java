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
 * @author Roger
 * @date 2013年8月4日
 */

@Entity
@Table(name = "articlesubjects", catalog = "nbpx")
public class ArticleSubject  extends BaseEntity   implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public Integer articleSubjectId;
	public Integer subjectId;
	public Integer articleId;
	public String subject;
	
	public ArticleSubject(){
	}
	
	public ArticleSubject(Integer articleSubjectId, Integer subjectId,
			Integer articleId, String subject) {
		super();
		this.articleSubjectId = articleSubjectId;
		this.subjectId = subjectId;
		this.articleId = articleId;
		this.subject = subject;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "articleSubjectId", unique = true, nullable = false)
	public Integer getArticleSubjectId() {
		return articleSubjectId;
	}
	public void setArticleSubjectId(Integer articleSubjectId) {
		this.articleSubjectId = articleSubjectId;
	}
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	public Integer getArticleId() {
		return articleId;
	}
	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}

}
