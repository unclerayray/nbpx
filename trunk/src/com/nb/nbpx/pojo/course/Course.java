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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((blockedContent == null) ? 0 : blockedContent.hashCode());
		result = prime * result
				+ ((category == null) ? 0 : category.hashCode());
		result = prime * result
				+ ((categoryName == null) ? 0 : categoryName.hashCode());
		result = prime * result + ((classic == null) ? 0 : classic.hashCode());
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result
				+ ((courseId == null) ? 0 : courseId.hashCode());
		result = prime * result
				+ ((createdBy == null) ? 0 : createdBy.hashCode());
		result = prime * result
				+ ((creationDate == null) ? 0 : creationDate.hashCode());
		result = prime * result
				+ ((goldenPic == null) ? 0 : goldenPic.hashCode());
		result = prime * result
				+ ((hasVideo == null) ? 0 : hasVideo.hashCode());
		result = prime * result + ((hits == null) ? 0 : hits.hashCode());
		result = prime * result + ((isInner == null) ? 0 : isInner.hashCode());
		result = prime * result
				+ ((lastUpdateDate == null) ? 0 : lastUpdateDate.hashCode());
		result = prime * result
				+ ((lastUpdatedBy == null) ? 0 : lastUpdatedBy.hashCode());
		result = prime * result + ((links == null) ? 0 : links.hashCode());
		result = prime * result
				+ ((planflag == null) ? 0 : planflag.hashCode());
		result = prime * result + ((price == null) ? 0 : price.hashCode());
		result = prime * result
				+ ((recommanded == null) ? 0 : recommanded.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		result = prime * result
				+ ((teacherId == null) ? 0 : teacherId.hashCode());
		result = prime * result
				+ ((teacherName == null) ? 0 : teacherName.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Course other = (Course) obj;
		if (blockedContent == null) {
			if (other.blockedContent != null)
				return false;
		} else if (!blockedContent.equals(other.blockedContent))
			return false;
		if (category == null) {
			if (other.category != null)
				return false;
		} else if (!category.equals(other.category))
			return false;
		if (categoryName == null) {
			if (other.categoryName != null)
				return false;
		} else if (!categoryName.equals(other.categoryName))
			return false;
		if (classic == null) {
			if (other.classic != null)
				return false;
		} else if (!classic.equals(other.classic))
			return false;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (courseId == null) {
			if (other.courseId != null)
				return false;
		} else if (!courseId.equals(other.courseId))
			return false;
		if (createdBy == null) {
			if (other.createdBy != null)
				return false;
		} else if (!createdBy.equals(other.createdBy))
			return false;
		if (creationDate == null) {
			if (other.creationDate != null)
				return false;
		} else if (!creationDate.equals(other.creationDate))
			return false;
		if (goldenPic == null) {
			if (other.goldenPic != null)
				return false;
		} else if (!goldenPic.equals(other.goldenPic))
			return false;
		if (hasVideo == null) {
			if (other.hasVideo != null)
				return false;
		} else if (!hasVideo.equals(other.hasVideo))
			return false;
		if (hits == null) {
			if (other.hits != null)
				return false;
		} else if (!hits.equals(other.hits))
			return false;
		if (isInner == null) {
			if (other.isInner != null)
				return false;
		} else if (!isInner.equals(other.isInner))
			return false;
		if (lastUpdateDate == null) {
			if (other.lastUpdateDate != null)
				return false;
		} else if (!lastUpdateDate.equals(other.lastUpdateDate))
			return false;
		if (lastUpdatedBy == null) {
			if (other.lastUpdatedBy != null)
				return false;
		} else if (!lastUpdatedBy.equals(other.lastUpdatedBy))
			return false;
		if (links == null) {
			if (other.links != null)
				return false;
		} else if (!links.equals(other.links))
			return false;
		if (planflag == null) {
			if (other.planflag != null)
				return false;
		} else if (!planflag.equals(other.planflag))
			return false;
		if (price == null) {
			if (other.price != null)
				return false;
		} else if (!price.equals(other.price))
			return false;
		if (recommanded == null) {
			if (other.recommanded != null)
				return false;
		} else if (!recommanded.equals(other.recommanded))
			return false;
		if (state == null) {
			if (other.state != null)
				return false;
		} else if (!state.equals(other.state))
			return false;
		if (teacherId == null) {
			if (other.teacherId != null)
				return false;
		} else if (!teacherId.equals(other.teacherId))
			return false;
		if (teacherName == null) {
			if (other.teacherName != null)
				return false;
		} else if (!teacherName.equals(other.teacherName))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}

//	public String getShortName() {
//		return shortName;
//	}
//
//	public void setShortName(String shortName) {
//		this.shortName = shortName;
//	}
	
	
}
