package com.nb.nbpx.pojo.zixun;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2014年1月4日
 */
@Entity
@Table(name = "livescenes", catalog = "nbpx")
public class LiveScene extends BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	public Integer liveSceneId;
	public String category;
	public String title;
	public String site;
	public Date liveDate;
	public String teacher;
	
	public Set<LiveImage> images = new HashSet<LiveImage>(
			0);
	
	
	
	public LiveScene() {
		super();
	}

	public LiveScene(Integer liveSceneId, String category, String title,
			String site, Date liveDate, String teacher, Set<LiveImage> images) {
		super();
		this.liveSceneId = liveSceneId;
		this.category = category;
		this.title = title;
		this.site = site;
		this.liveDate = liveDate;
		this.teacher = teacher;
		this.images = images;
	}

	/**
	 * @param liveSceneId
	 * @param category
	 * @param title
	 * @param site
	 * @param liveDate
	 * @param teacher
	 */
	public LiveScene(Integer liveSceneId, String category, String title,
			String site, Date liveDate, String teacher) {
		super();
		this.liveSceneId = liveSceneId;
		this.category = category;
		this.title = title;
		this.site = site;
		this.liveDate = liveDate;
		this.teacher = teacher;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "livesceneId", unique = true, nullable = false)
	public Integer getLiveSceneId() {
		return liveSceneId;
	}
	public void setLiveSceneId(Integer liveSceneId) {
		this.liveSceneId = liveSceneId;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSite() {
		return site;
	}
	public void setSite(String site) {
		this.site = site;
	}
	public Date getLiveDate() {
		return liveDate;
	}
	public void setLiveDate(Date liveDate) {
		this.liveDate = liveDate;
	}
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "liveScene")
	@Cascade({CascadeType.SAVE_UPDATE, CascadeType.DELETE})
	public Set<LiveImage> getImages() {
		return images;
	}
	public void setImages(Set<LiveImage> images) {
		this.images = images;
	}
	
	
}
