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
	private Boolean indexed;

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

	public Boolean getIndexed() {
		return indexed;
	}

	public void setIndexed(Boolean indexed) {
		this.indexed = indexed;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((category == null) ? 0 : category.hashCode());
		result = prime * result
				+ ((categoryName == null) ? 0 : categoryName.hashCode());
		result = prime * result + ((flag == null) ? 0 : flag.hashCode());
		result = prime * result + ((hits == null) ? 0 : hits.hashCode());
		result = prime * result + ((indexed == null) ? 0 : indexed.hashCode());
		result = prime * result
				+ ((recommandDate == null) ? 0 : recommandDate.hashCode());
		result = prime * result
				+ ((recommanded == null) ? 0 : recommanded.hashCode());
		result = prime * result
				+ ((searchCnt == null) ? 0 : searchCnt.hashCode());
		result = prime * result + ((subject == null) ? 0 : subject.hashCode());
		result = prime * result
				+ ((subjectId == null) ? 0 : subjectId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Subject other = (Subject) obj;
		if (category == null) {
			if (other.category != null)
				return false;
		} else if (!category.equals(other.category))
			return false;
		if (categoryName == null) {
			if (other.categoryName != null)
				return false;
		} else if (!categoryName.equals(other.categoryName))
			return false;
		if (flag == null) {
			if (other.flag != null)
				return false;
		} else if (!flag.equals(other.flag))
			return false;
		if (hits == null) {
			if (other.hits != null)
				return false;
		} else if (!hits.equals(other.hits))
			return false;
		if (indexed == null) {
			if (other.indexed != null)
				return false;
		} else if (!indexed.equals(other.indexed))
			return false;
		if (recommandDate == null) {
			if (other.recommandDate != null)
				return false;
		} else if (!recommandDate.equals(other.recommandDate))
			return false;
		if (recommanded == null) {
			if (other.recommanded != null)
				return false;
		} else if (!recommanded.equals(other.recommanded))
			return false;
		if (searchCnt == null) {
			if (other.searchCnt != null)
				return false;
		} else if (!searchCnt.equals(other.searchCnt))
			return false;
		if (subject == null) {
			if (other.subject != null)
				return false;
		} else if (!subject.equals(other.subject))
			return false;
		if (subjectId == null) {
			if (other.subjectId != null)
				return false;
		} else if (!subjectId.equals(other.subjectId))
			return false;
		return true;
	}
	
	
	
}
