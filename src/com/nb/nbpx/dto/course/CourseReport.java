package com.nb.nbpx.dto.course;

import java.io.Serializable;

/**
 * 课程报表导出dto，
 * @author Roger
 * @date 2013年11月2日
 */
public class CourseReport  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Integer courseId;
	public String title;
	public Double price;
	public String teacher;
	public String startDate;
	public String endDate;
	public String city;
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	
	public CourseReport(Integer courseId, String title, Double price,
			String teacher, String startDate, String endDate, String city) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.price = price;
		this.teacher = teacher;
		this.startDate = startDate;
		this.endDate = endDate;
		this.city = city;
	}
}
