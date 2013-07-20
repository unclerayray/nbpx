package com.nb.nbpx.pojo.course;

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
 * 课程安排POJO
 * @author Roger
 * @date 2013年7月20日
 */
@Entity
@Table(name = "courses", catalog = "nbpx")
public class CourseInfo extends BaseEntity  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer courseInfoId;
	private Integer courseId;
	private Date startDate;
	private Date endDate;
	private String city;
	
	public CourseInfo(){
		
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "courseInfoId", unique = true, nullable = false)
	public Integer getCourseInfoId() {
		return courseInfoId;
	}
	public void setCourseInfoId(Integer courseInfoId) {
		this.courseInfoId = courseInfoId;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
}
