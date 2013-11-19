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

@Entity
@Table(name = "questions", catalog = "nbpx")
public class Question extends BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	public Integer questionId;
	public String title;
	public String content;
	public Boolean isClosed;
	public Date askDate;
	public String askedBy;

	
	
	
	
	public Question() {
		super();
	}



	/**
	 * Full Constructor
	 * @param questionId
	 * @param title
	 * @param content
	 * @param isClosed
	 * @param askDate
	 * @param askedBy
	 */
	public Question(Integer questionId, String title, String content,
			Boolean isClosed, Date askDate, String askedBy) {
		super();
		this.questionId = questionId;
		this.title = title;
		this.content = content;
		this.isClosed = isClosed;
		this.askDate = askDate;
		this.askedBy = askedBy;
	}
	
	

	/**
	 * 后台用构造函数
	 * @param questionId
	 * @param title
	 * @param isClosed
	 * @param askDate
	 * @param askedBy
	 */
	public Question(Integer questionId, String title, Boolean isClosed,
			Date askDate, String askedBy) {
		super();
		this.questionId = questionId;
		this.title = title;
		this.isClosed = isClosed;
		this.askDate = askDate;
		this.askedBy = askedBy;
	}



	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "questionId", unique = true, nullable = false)
	public Integer getQuestionId() {
		return questionId;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Boolean getIsClosed() {
		return isClosed;
	}

	public void setIsClosed(Boolean isClosed) {
		this.isClosed = isClosed;
	}

	public Date getAskDate() {
		return askDate;
	}

	public void setAskDate(Date askDate) {
		this.askDate = askDate;
	}

	public String getAskedBy() {
		return askedBy;
	}

	public void setAskedBy(String askedBy) {
		this.askedBy = askedBy;
	}
}
