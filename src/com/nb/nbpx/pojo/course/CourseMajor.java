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
@Table(name = "coursemajor", catalog = "nbpx")
public class CourseMajor  extends BaseEntity   implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Integer courseMajorId;
	public Integer majorId;
	public Integer courseId;
	public String major;
	
	
	public CourseMajor() {
		super();
	}
	public CourseMajor(Integer courseMajorId, Integer majorId,
			Integer courseId, String major) {
		super();
		this.courseMajorId = courseMajorId;
		this.majorId = majorId;
		this.courseId = courseId;
		this.major = major;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "courseMajorId", unique = true, nullable = false)
	public Integer getCourseMajorId() {
		return courseMajorId;
	}
	public void setCourseMajorId(Integer courseMajorId) {
		this.courseMajorId = courseMajorId;
	}
	public Integer getMajorId() {
		return majorId;
	}
	public void setMajorId(Integer majorId) {
		this.majorId = majorId;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	
	
}
