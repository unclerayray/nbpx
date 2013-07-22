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
@Table(name = "courseindustry", catalog = "nbpx")
public class CourseIndustry  extends BaseEntity   implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Integer courseIndustryId;
	public String industryCode;
	public Integer courseId;
	public String industry;
	
	
	
	
	public CourseIndustry() {
		super();
	}
	 
	
	
	
	public CourseIndustry(Integer courseIndustryId, String industryCode,
			Integer courseId, String industry) {
		super();
		this.courseIndustryId = courseIndustryId;
		this.industryCode = industryCode;
		this.courseId = courseId;
		this.industry = industry;
	}




	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "courseIndustryId", unique = true, nullable = false)
	public Integer getCourseIndustryId() {
		return courseIndustryId;
	}
	public void setCourseIndustryId(Integer courseIndustryId) {
		this.courseIndustryId = courseIndustryId;
	}

	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}




	public String getIndustryCode() {
		return industryCode;
	}




	public void setIndustryCode(String industryCode) {
		this.industryCode = industryCode;
	}
	
	
}
