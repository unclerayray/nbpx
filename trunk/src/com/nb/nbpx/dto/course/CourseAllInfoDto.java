package com.nb.nbpx.dto.course;

import java.io.Serializable;

import com.nb.nbpx.pojo.course.Course;

/**
 * 课程的所有信息DTO
 * @author Roger
 * @date 2013年7月21日
 */
public class CourseAllInfoDto extends Course implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String keywords;
	private String targets;
	private String major;
	private String industry;
	
	
	public CourseAllInfoDto(){
		
	}
	
	public CourseAllInfoDto(Course course){
		this.courseId = course.courseId;
		this.title = course.title;
		this.courseCode = course.courseCode;
		this.teacherId = course.teacherId;
		this.isInner = course.isInner;
		this.teacherName = course.teacherName;
		this.category = course.category;
		this.categoryName = course.categoryName;
		this.state = course.state;
		this.hits = course.hits;
		this.price = course.price;
		this.recommanded = course.recommanded;
		this.classic = course.classic;
	}
	
	public CourseAllInfoDto(String keywords, String targets, String major,
			String industry) {
		super();
		//this.setCourseId(courseId);
		this.keywords = keywords;
		this.targets = targets;
		this.major = major;
		this.industry = industry;
	}
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getTargets() {
		return targets;
	}
	public void setTargets(String targets) {
		this.targets = targets;
	}
}
