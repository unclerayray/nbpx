/**
 * @author Roger
 */
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
 * @date 2013-5-11
 */
@Entity
@Table(name = "articles", catalog = "nbpx")
public class Article extends BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer articleId;

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
}
