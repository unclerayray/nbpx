package com.nb.nbpx.pojo.course;

import java.io.Serializable;
import java.util.List;


/**
 * 课程的搜索结果DTO
 * @author Roger
 * @date 2013年8月24日
 */
public class CourseSearchResult  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Integer courseId;
	public String title;
	public Double price;
	public String teacherName;
	public String content;
	public List<String> courseInfo;
	
	public CourseSearchResult(){
		super();
	}
	
	public CourseSearchResult(Integer courseId, String title, Double price,
			String teacherName, String content, List<String> courseInfo) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.price = price;
		this.teacherName = teacherName;
		this.content = content;
		this.courseInfo = courseInfo;
	}

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

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public List<String> getCourseInfo() {
		return courseInfo;
	}

	public void setCourseInfo(List<String> courseInfo) {
		this.courseInfo = courseInfo;
	}
	
	
}
