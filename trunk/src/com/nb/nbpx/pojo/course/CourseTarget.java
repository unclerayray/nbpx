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
	public Integer courseTargetTd;
	public Integer courseId;
	public Integer targetTd;
	public String target;
		
	public CourseTarget() {
		super();
	}
	public CourseTarget(Integer courseTargetTd, Integer courseId,
			Integer targetTd, String target) {
		super();
		this.courseTargetTd = courseTargetTd;
		this.courseId = courseId;
		this.targetTd = targetTd;
		this.target = target;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "courseTargetTd", unique = true, nullable = false)
	public Integer getCourseTargetTd() {
		return courseTargetTd;
	}
	public void setCourseTargetTd(Integer courseTargetTd) {
		this.courseTargetTd = courseTargetTd;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public Integer getTargetTd() {
		return targetTd;
	}
	public void setTargetTd(Integer targetTd) {
		this.targetTd = targetTd;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	
	
}
