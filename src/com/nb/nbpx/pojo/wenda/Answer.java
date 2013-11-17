package com.nb.nbpx.pojo.wenda;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2013年11月17日
 */
@Entity
@Table(name = "answers", catalog = "nbpx")
public class Answer extends BaseEntity implements Serializable {

	public Answer() {
		super();
	}
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	public Integer answerId;
	public String answeredBy;
	public Date answerdDate;
	public Boolean isBest;
	public String content;
	public Integer questionId;
	
	
	
	/**
	 * Full constructor
	 * @param answerId
	 * @param answeredBy
	 * @param answerdDate
	 * @param isBest
	 * @param content
	 * @param questionId
	 */
	public Answer(Integer answerId, String answeredBy, Date answerdDate,
			Boolean isBest, String content, Integer questionId) {
		super();
		this.answerId = answerId;
		this.answeredBy = answeredBy;
		this.answerdDate = answerdDate;
		this.isBest = isBest;
		this.content = content;
		this.questionId = questionId;
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "answerId", unique = true, nullable = false)
	public Integer getAnswerId() {
		return answerId;
	}
	public void setAnswerId(Integer answerId) {
		this.answerId = answerId;
	}
	public String getAnsweredBy() {
		return answeredBy;
	}
	public void setAnsweredBy(String answeredBy) {
		this.answeredBy = answeredBy;
	}
	public Date getAnswerdDate() {
		return answerdDate;
	}
	public void setAnswerdDate(Date answerdDate) {
		this.answerdDate = answerdDate;
	}
	public Boolean getIsBest() {
		return isBest;
	}
	public void setIsBest(Boolean isBest) {
		this.isBest = isBest;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getQuestionId() {
		return questionId;
	}
	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}
	
	

}
