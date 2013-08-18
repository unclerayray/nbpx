package com.nb.nbpx.pojo.keyword;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2013年7月21日
 */
/**
 * @author Roger
 * @date 2013年7月21日
 */
@Entity
@Table(name = "keywords", catalog = "nbpx")
public class Keyword extends BaseEntity implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer keyId;
	private String keyword;
	private Boolean flag;
	private String categoryName;
	private String category;
	private Boolean recommanded;
	private Integer hits;
	private Integer searchCnt;
	private Date recommandDate;
	private Boolean indexed;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "keyId", unique = true, nullable = false)
	public Integer getKeyId() {
		return keyId;
	}

	public void setKeyId(Integer keyId) {
		this.keyId = keyId;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Boolean getFlag() {
		return flag;
	}

	public void setFlag(Boolean flag) {
		this.flag = flag;
	}

	@Transient
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Keyword() {
		super();
	}

	public Boolean getRecommanded() {
		return recommanded;
	}

	public void setRecommanded(Boolean recommanded) {
		this.recommanded = recommanded;
	}

	public Integer getHits() {
		return hits;
	}

	public void setHits(Integer hits) {
		this.hits = hits;
	}

	public Integer getSearchCnt() {
		return searchCnt;
	}

	public void setSearchCnt(Integer searchCnt) {
		this.searchCnt = searchCnt;
	}

	public Date getRecommandDate() {
		return recommandDate;
	}

	public void setRecommandDate(Date recommandDate) {
		this.recommandDate = recommandDate;
	}

	public Keyword(Integer keyId, String keyword, Boolean flag,
			String categoryName, String category, Boolean recommanded,
			Integer hits, Integer searchCnt, Date recommandDate) {
		super();
		this.keyId = keyId;
		this.keyword = keyword;
		this.flag = flag;
		this.categoryName = categoryName;
		this.category = category;
		this.recommanded = recommanded;
		this.hits = hits;
		this.searchCnt = searchCnt;
		this.recommandDate = recommandDate;
	}

	public Boolean getIndexed() {
		return indexed;
	}

	public void setIndexed(Boolean indexed) {
		this.indexed = indexed;
	}
	
}
