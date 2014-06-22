/**
 * @author Roger
 */
package com.nb.nbpx.pojo.course;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2013-6-20
 */
@Entity
@Table(name = "courses", catalog = "nbpx")
public class Course extends BaseEntity implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Integer courseId;
	public String title;
	public Double price;
	// public String courseCode;
	//public String shortName;
	public String teacherId;
	public String teacherName;
	public String category;
	public String links;
	public String content;
	public String blockedContent;
	public Boolean isInner = false;
	public Boolean state = false;
	public Boolean hasVideo;
	public Integer hits;
	public String createdBy;
	public String lastUpdatedBy;
	public Date creationDate;
	public Date lastUpdateDate;
	public String categoryName;
	public Boolean recommanded = false;
	public Boolean classic = false;
	public String goldenPic;
	public Boolean planflag = false;

	public Course() {
	}

	/**
	 * 后台管理系统的查询函数Constructor
	 * @param courseId
	 * @param title
	 * @param isInner
	 * @param teacherId
	 * @param teacherName
	 * @param category
	 * @param categoryName
	 * @param lastUpdateDate
	 * @param createdBy
	 * @param lastUpdatedBy
	 * @param state
	 * @param hits
	 * @param price
	 * @param recommanded
	 * @param classic
	 */
	public Course(Integer courseId, String title, Boolean isInner,
			String teacherId, String teacherName, String category,
			String categoryName, Date lastUpdateDate, String createdBy, String lastUpdatedBy, Boolean state, Integer hits,
			Double price, Boolean recommanded, Boolean classic, String goldenPic, Boolean planflag) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.teacherId = teacherId;
		this.isInner = isInner;
		this.teacherName = teacherName;
		this.category = category;
		this.categoryName = categoryName;
//		this.shortName = shortName;
		this.lastUpdateDate = lastUpdateDate;
		this.createdBy = createdBy;
		this.lastUpdatedBy = lastUpdatedBy;
		this.state = state;
		this.hits = hits;
		this.price = price;
		this.recommanded = recommanded;
		this.classic = classic;
		this.planflag = planflag;
		this.goldenPic = goldenPic;
	}
	
	/**
	 * 前台显示view class 的 Constructor
	 * @param courseId
	 * @param title
	 * @param isInner
	 * @param teacherId
	 * @param teacherName
	 * @param category
	 * @param categoryName
	 * @param lastUpdateDate
	 * @param createdBy
	 * @param lastUpdatedBy
	 * @param state
	 * @param hits
	 * @param price
	 * @param recommanded
	 * @param classic
	 */
	public Course(Integer courseId, String title, Boolean isInner,
			String teacherId, String teacherName, String category,
			String categoryName, Date lastUpdateDate, String createdBy, String lastUpdatedBy, Boolean state, Integer hits,
			Double price, Boolean recommanded, Boolean classic) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.teacherId = teacherId;
		this.isInner = isInner;
		this.teacherName = teacherName;
		this.category = category;
		this.categoryName = categoryName;
//		this.shortName = shortName;
		this.lastUpdateDate = lastUpdateDate;
		this.createdBy = createdBy;
		this.lastUpdatedBy = lastUpdatedBy;
		this.state = state;
		this.hits = hits;
		this.price = price;
		this.recommanded = recommanded;
		this.classic = classic;
	}

	public Course(Integer courseId, String title, Double price,
			String teacherId, String teacherName, String category,
			String content, Boolean isInner, Boolean state, Integer hits) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.price = price;
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.category = category;
		this.content = content;
		this.isInner = isInner;
		this.state = state;
		this.hits = hits;
	}

	/**
	 * 测试用的
	 * 
	 * @param courseId
	 * @param title
	 * @param content
	 */
	public Course(Integer courseId, String title, String content) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.content = content;
	}

	/**
	 * 转换DTO用
	 * 
	 * @param courseDto
	 */
	public Course(CourseAllInfoDto courseDto) {
		super();
		this.courseId = courseDto.courseId;
		this.title = courseDto.title;
		this.price = courseDto.price;
		this.teacherId = courseDto.teacherId;
		this.teacherName = courseDto.teacherName;
		this.links = courseDto.links;
		//this.shortName = courseDto.shortName;
		this.category = courseDto.category;
		this.content = courseDto.content;
		this.blockedContent = courseDto.blockedContent;
		this.isInner = courseDto.isInner;
		this.state = courseDto.state;
		this.hasVideo = courseDto.hasVideo;
		this.hits = courseDto.hits;
		this.createdBy = courseDto.createdBy;
		this.lastUpdatedBy = courseDto.lastUpdatedBy;
		this.creationDate = courseDto.creationDate;
		this.lastUpdateDate = courseDto.lastUpdateDate;
		this.categoryName = courseDto.categoryName;
		this.recommanded = courseDto.recommanded;
		this.classic = courseDto.classic;
		this.goldenPic = courseDto.goldenPic;
		this.planflag = courseDto.planflag;
	}

	public Course(Integer courseId, String title, String teacherId,
			String teacherName, String category, String categoryName,
			Boolean state, Integer hits, Double price, Boolean recommanded,
			Boolean classic) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.category = category;
		this.categoryName = categoryName;
		this.state = state;
		this.hits = hits;
		this.price = price;
		this.recommanded = recommanded;
		this.classic = classic;
	}

	/**
	 * Full constructor
	 * 
	 * @param courseId
	 * @param title
	 * @param price
	 * @param teacherId
	 * @param teacherName
	 * @param category
	 * @param content
	 * @param blockedContent
	 * @param isInner
	 * @param state
	 * @param hasVideo
	 * @param hits
	 * @param createdBy
	 * @param lastUpdatedBy
	 * @param creationDate
	 * @param lastUpdateDate
	 * @param categoryName
	 * @param recommanded
	 * @param classic
	 */
	public Course(Integer courseId, String title, Double price,
			String teacherId, String teacherName, String category, String links, 
			String content, String blockedContent, Boolean isInner,
			Boolean state, Boolean hasVideo, Integer hits, String createdBy,
			String lastUpdatedBy, Date creationDate, Date lastUpdateDate,
			String categoryName, Boolean recommanded, Boolean classic, Boolean planflag, String goldenPic) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.price = price;
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.category = category;
		this.content = content;
		this.blockedContent = blockedContent;
		this.isInner = isInner;
		this.links = links;
		this.state = state;
		this.hasVideo = hasVideo;
		this.hits = hits;
		this.createdBy = createdBy;
		this.lastUpdatedBy = lastUpdatedBy;
		this.creationDate = creationDate;
		this.lastUpdateDate = lastUpdateDate;
		this.categoryName = categoryName;
		this.recommanded = recommanded;
		this.classic = classic;
		this.planflag = planflag;
		this.goldenPic = goldenPic;
	}
	
	
	/**
	 * 前台查看课程详情构造函数
	 * @param courseId
	 * @param title
	 * @param price
	 * @param teacherId
	 * @param teacherName
	 * @param category
	 * @param content
	 * @param blockedContent
	 * @param isInner
	 * @param state
	 * @param hasVideo
	 * @param hits
	 * @param createdBy
	 * @param lastUpdatedBy
	 * @param creationDate
	 * @param lastUpdateDate
	 * @param categoryName
	 * @param recommanded
	 * @param classic
	 */
	public Course(Integer courseId, String title, Double price,
			String teacherId, String teacherName, String category,
			String content, String blockedContent, Boolean isInner,
			Boolean state, Boolean hasVideo, Integer hits, String createdBy,
			String lastUpdatedBy, Date creationDate, Date lastUpdateDate,
			String categoryName, Boolean recommanded, Boolean classic, Boolean planflag) {
		super();
		this.courseId = courseId;
		this.title = title;
		this.price = price;
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.category = category;
		this.content = content;
		this.blockedContent = blockedContent;
		this.isInner = isInner;
		this.state = state;
		this.hasVideo = hasVideo;
		this.hits = hits;
		this.createdBy = createdBy;
		this.lastUpdatedBy = lastUpdatedBy;
		this.creationDate = creationDate;
		this.lastUpdateDate = lastUpdateDate;
		this.categoryName = categoryName;
		this.recommanded = recommanded;
		this.classic = classic;
		this.planflag = planflag;
	}
 
	public Course(Integer courseId, String title, Double price,
			String teacherId, String teacherName, String category,
			String content, String blockedContent, Boolean isInner,
			Boolean state, Boolean hasVideo, Integer hits, String createdBy,
			String lastUpdatedBy, Date creationDate, Date lastUpdateDate,
			String categoryName, Boolean recommanded, Boolean classic){
		super();
		this.courseId = courseId;
		this.title = title;
		this.price = price;
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.category = category;
		this.content = content;
		this.blockedContent = blockedContent;
		this.isInner = isInner;
		this.state = state;
		this.hasVideo = hasVideo;
		this.hits = hits;
		this.createdBy = createdBy;
		this.lastUpdatedBy = lastUpdatedBy;
		this.creationDate = creationDate;
		this.lastUpdateDate = lastUpdateDate;
		this.categoryName = categoryName;
		this.recommanded = recommanded;
		this.classic = classic;
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

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

	public String getLinks() {
		return links;
	}

	public void setLinks(String links) {
		this.links = links;
	}

	@Transient
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
	
	@Column(name="isInner", columnDefinition=" tinyint(1) default '0'")
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

	public Boolean getHasVideo() {
		return hasVideo;
	}

	public void setHasVideo(Boolean hasVideo) {
		this.hasVideo = hasVideo;
	}

	public Integer getHits() {
		return hits;
	}

	public void setHits(Integer hits) {
		this.hits = hits;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(String lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}

	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Transient
	public String getCategoryName() {
		return categoryName;
	}

	public Boolean getRecommanded() {
		return recommanded;
	}

	public void setRecommanded(Boolean recommanded) {
		this.recommanded = recommanded;
	}

	public Boolean getClassic() {
		return classic;
	}

	public void setClassic(Boolean classic) {
		this.classic = classic;
	}

	public String getGoldenPic() {
		return goldenPic;
	}

	public void setGoldenPic(String goldenPic) {
		this.goldenPic = goldenPic;
	}

	public Boolean getPlanflag() {
		return planflag;
	}

	public void setPlanflag(Boolean planflag) {
		this.planflag = planflag;
	}

//	public String getShortName() {
//		return shortName;
//	}
//
//	public void setShortName(String shortName) {
//		this.shortName = shortName;
//	}
}
