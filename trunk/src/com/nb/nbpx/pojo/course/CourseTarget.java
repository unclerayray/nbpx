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
 * 课程对象POJO
 * @author Roger
 * @date 2013年7月21日
 */
@Entity
@Table(name = "coursetarget", catalog = "nbpx")
public class CourseTarget  extends BaseEntity   implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Integer courseTargetId;
	public Integer courseId;
	public String targetCode;
	public String target;
		
	public CourseTarget() {
		super();
	}
	
	

	
	
	public CourseTarget(Integer courseTargetId, Integer courseId,
			String targetCode, String target) {
		super();
		this.courseTargetId = courseTargetId;
		this.courseId = courseId;
		this.targetCode = targetCode;
		this.target = target;
	}





	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "courseTargetId", unique = true, nullable = false)
	public Integer getCourseTargetId() {
		return courseTargetId;
	}
	public void setCourseTargetId(Integer courseTargetId) {
		this.courseTargetId = courseTargetId;
	}
	
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}

	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}

	public String getTargetCode() {
		return targetCode;
	}

	public void setTargetCode(String targetCode) {
		this.targetCode = targetCode;
	}
	
	
}
