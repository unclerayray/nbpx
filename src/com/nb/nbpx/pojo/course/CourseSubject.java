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
 * @author Roger
 * @date 2013年8月4日
 */

@Entity
@Table(name = "coursesubjects", catalog = "nbpx")
public class CourseSubject  extends BaseEntity   implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public Integer courseSubjectId;
	public Integer subjectId;
	public Integer courseId;
	public String subject;
	
	public CourseSubject(){
	}
	
	public CourseSubject(Integer courseSubjectId, Integer subjectId,
			Integer courseId, String subject) {
		super();
		this.courseSubjectId = courseSubjectId;
		this.subjectId = subjectId;
		this.courseId = courseId;
		this.subject = subject;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "courseSubjectId", unique = true, nullable = false)
	public Integer getCourseSubjectId() {
		return courseSubjectId;
	}
	public void setCourseSubjectId(Integer courseSubjectId) {
		this.courseSubjectId = courseSubjectId;
	}
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}

}
