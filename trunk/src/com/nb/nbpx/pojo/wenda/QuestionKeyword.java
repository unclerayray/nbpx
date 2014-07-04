package com.nb.nbpx.pojo.wenda;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2014年3月30日
 */
@Entity
@Table(name = "questionkeywords", catalog = "nbpx", uniqueConstraints = @UniqueConstraint(columnNames = {
		"keywordId", "questionId" }))
public class QuestionKeyword extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	public Integer questionKeywordId;
	public Question question;
	public Integer keywordId;
	public String keyword;
	
	public QuestionKeyword() {
		super();
	}
	public QuestionKeyword(Integer questionKeywordId, Question question,
			Integer keywordId, String keyword) {
		super();
		this.questionKeywordId = questionKeywordId;
		this.question = question;
		this.keywordId = keywordId;
		this.keyword = keyword;
	}
	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "questionKeywordId", unique = true, nullable = false)
	public Integer getQuestionKeywordId() {
		return questionKeywordId;
	}
	public void setQuestionKeywordId(Integer questionKeywordId) {
		this.questionKeywordId = questionKeywordId;
	}
	

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "questionId", nullable = false)
	public Question getQuestion() {
		return question;
	}
	public void setQuestion(Question question) {
		this.question = question;
	}
	
	@Column(name = "keywordId", unique = true, nullable = false)
	public Integer getKeywordId() {
		return keywordId;
	}
	public void setKeywordId(Integer keywordId) {
		this.keywordId = keywordId;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((keyword == null) ? 0 : keyword.hashCode());
		result = prime * result
				+ ((keywordId == null) ? 0 : keywordId.hashCode());
		result = prime * result
				+ ((question == null) ? 0 : question.hashCode());
		result = prime
				* result
				+ ((questionKeywordId == null) ? 0 : questionKeywordId
						.hashCode());
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
		QuestionKeyword other = (QuestionKeyword) obj;
		if (keyword == null) {
			if (other.keyword != null)
				return false;
		} else if (!keyword.equals(other.keyword))
			return false;
		if (keywordId == null) {
			if (other.keywordId != null)
				return false;
		} else if (!keywordId.equals(other.keywordId))
			return false;
		if (question == null) {
			if (other.question != null)
				return false;
		} else if (!question.equals(other.question))
			return false;
		if (questionKeywordId == null) {
			if (other.questionKeywordId != null)
				return false;
		} else if (!questionKeywordId.equals(other.questionKeywordId))
			return false;
		return true;
	}
	
	
}
