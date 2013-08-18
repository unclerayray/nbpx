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
 * @date 2013年8月17日
 */
@Entity
@Table(name = "courseproduct", catalog = "nbpx")
public class CourseProduct   extends BaseEntity   implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public Integer courseProductId;
	public Integer courseId;
	public String productCode;
	public String product;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "courseProductId", unique = true, nullable = false)
	public Integer getCourseProductId() {
		return courseProductId;
	}
	public void setCourseProductId(Integer courseProductId) {
		this.courseProductId = courseProductId;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public CourseProduct(Integer courseProductId, Integer courseId,
			String productCode, String product) {
		super();
		this.courseProductId = courseProductId;
		this.courseId = courseId;
		this.productCode = productCode;
		this.product = product;
	}
	public CourseProduct() {
		super();
	}
	
	
}
