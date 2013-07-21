package com.nb.nbpx.pojo.course;

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
@Table(name = "coursekeywords", catalog = "nbpx")
public class CourseKeyword extends BaseEntity   implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Integer courseKeywordId;
	public Integer keywordId;
	public Integer courseId;
	public String keyword;
	
	public CourseKeyword(){
	}
	
	public CourseKeyword(Integer courseKeywordId, Integer keywordId,
			Integer courseId, String keyword) {
		super();
		this.courseKeywordId = courseKeywordId;
		this.keywordId = keywordId;
		this.courseId = courseId;
		this.keyword = keyword;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "courseKeywordId", unique = true, nullable = false)
	public Integer getCourseKeywordId() {
		return courseKeywordId;
	}
	public void setCourseKeywordId(Integer courseKeywordId) {
		this.courseKeywordId = courseKeywordId;
	}
	public Integer getKeywordId() {
		return keywordId;
	}
	public void setKeywordId(Integer keywordId) {
		this.keywordId = keywordId;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
}
