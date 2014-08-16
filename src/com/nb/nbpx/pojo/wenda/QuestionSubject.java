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
@Table(name = "questionsubjects", catalog = "nbpx", uniqueConstraints = @UniqueConstraint(columnNames = {
		"subjectId", "questionId" }))
public class QuestionSubject  extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	public Integer questionSubjectId;
	public Question question;
	public Integer subjectId;
	public String subject;
	
	
	public QuestionSubject() {
		super();
	}
	public QuestionSubject(Integer questionSubjectId, Question question,
			Integer subjectId, String subject) {
		super();
		this.questionSubjectId = questionSubjectId;
		this.question = question;
		this.subjectId = subjectId;
		this.subject = subject;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "questionSubjectId", unique = true, nullable = false)
	public Integer getQuestionSubjectId() {
		return questionSubjectId;
	}
	public void setQuestionSubjectId(Integer questionSubjectId) {
		this.questionSubjectId = questionSubjectId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "questionId", nullable = false)
	public Question getQuestion() {
		return question;
	}
	public void setQuestion(Question question) {
		this.question = question;
	}
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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((subject == null) ? 0 : subject.hashCode());
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
		QuestionSubject other = (QuestionSubject) obj;
		if (subject == null) {
			if (other.subject != null)
				return false;
		} else if (!subject.equals(other.subject))
			return false;
		return true;
	}
	
	
	
}
