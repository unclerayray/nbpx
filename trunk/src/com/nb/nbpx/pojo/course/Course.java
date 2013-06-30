/**
 * @author Roger
 */
package com.nb.nbpx.pojo.course;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2013-6-20
 */
@Entity
@Table(name = "courses", catalog = "nbpx")
public class Course extends BaseEntity  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer courseId;
	private String title;
	private String courseCode;
	private Integer teacherId;
	private String teacherName;
	private String category;
	private String content;
	private String blockedContent;
	private Boolean isInner;
	private Boolean state;
	private String videoUrl;
	private Integer hits;
	private Integer createdBy;
	private Integer lastUpdatedBy;
	private String creationDate;
	private String lastUpdateDate;
	private String categoryName;
	
	public Course(){
		
	}
	
	
	
	
	public Course(Integer courseId, String title, String courseCode,
			Integer teacherId, String teacherName, String category,
			String categoryName,Boolean state, Integer hits) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.courseCode = courseCode;
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.category = category;
		this.categoryName = categoryName;
		this.state = state;
		this.hits = hits;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "courseId", unique = true, nullable = false)
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
	public String getCourseCode() {
		return courseCode;
	}
	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}
	public Integer getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBlockedContent() {
		return blockedContent;
	}
	public void setBlockedContent(String blockedContent) {
		this.blockedContent = blockedContent;
	}
	public Boolean getIsInner() {
		return isInner;
	}
	public void setIsInner(Boolean isInner) {
		this.isInner = isInner;
	}
	public Boolean getState() {
		return state;
	}
	public void setState(Boolean state) {
		this.state = state;
	}
	public String getVideoUrl() {
		return videoUrl;
	}
	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}
	public Integer getHits() {
		return hits;
	}
	public void setHits(Integer hits) {
		this.hits = hits;
	}
	public Integer getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}
	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}
	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}
	public String getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}
	public String getLastUpdateDate() {
		return lastUpdateDate;
	}
	public void setLastUpdateDate(String lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	@Transient
	public String getCategoryName() {
		return categoryName;
	}
}
