package com.nb.nbpx.pojo.subject;

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
 * @date 2013年8月4日
 */
@Entity
@Table(name = "subjects", catalog = "nbpx")
public class Subject extends BaseEntity implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer subjectId;
	private String subject;
	private Boolean flag;
	private String categoryName;
	private String category;
	private Boolean recommanded;
	private Integer hits;
	private Integer searchCnt;
	private Date recommandDate;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "subjectId", unique = true, nullable = false)
	public Integer getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
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

	public Subject() {
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

	public Subject(Integer subjectId, String subject, Boolean flag,
			String categoryName, String category, Boolean recommanded,
			Integer hits, Integer searchCnt, Date recommandDate) {
		super();
		this.subjectId = subjectId;
		this.subject = subject;
		this.flag = flag;
		this.categoryName = categoryName;
		this.category = category;
		this.recommanded = recommanded;
		this.hits = hits;
		this.searchCnt = searchCnt;
		this.recommandDate = recommandDate;
	}
	
}
