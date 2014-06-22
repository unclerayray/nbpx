package com.nb.nbpx.dto.course;

import java.util.List;

/**
 * 报表DTO
 * @author Roger
 * @date 2013年11月2日
 */
public class ReportDTO {
	public Integer year;
	public Integer month;
	public String category;
	public String prefix;
	public List<CourseReport> courseList;
	
	
	
	public ReportDTO(Integer year, Integer month, String category,
			List<CourseReport> courseList,String prefix) {
		super();
		this.year = year;
		this.month = month;
		this.category = category;
		this.courseList = courseList;
		this.prefix = prefix;
	}
	
	
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public List<CourseReport> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<CourseReport> courseList) {
		this.courseList = courseList;
	}


	public String getPrefix() {
		return prefix;
	}


	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	
}
