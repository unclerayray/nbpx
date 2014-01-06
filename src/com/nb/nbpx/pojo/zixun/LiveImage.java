package com.nb.nbpx.pojo.zixun;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.nb.nbpx.pojo.BaseEntity;

@Entity
@Table(name = "images", catalog = "nbpx")
public class LiveImage extends BaseEntity implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Integer imageId;
	public String url;
	public LiveScene liveScene;
	public String imageName;

	
	
	public LiveImage() {
		super();
	}

	public LiveImage(Integer imageId, String url, LiveScene liveScene,
			String imageName) {
		super();
		this.imageId = imageId;
		this.url = url;
		this.liveScene = liveScene;
		this.imageName = imageName;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "imageId", unique = true, nullable = false)
	public Integer getImageId() {
		return imageId;
	}

	public void setImageId(Integer imageId) {
		this.imageId = imageId;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "liveSceneId", nullable = false)
	public LiveScene getLiveScene() {
		return liveScene;
	}

	public void setLiveScene(LiveScene liveScene) {
		this.liveScene = liveScene;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
}
