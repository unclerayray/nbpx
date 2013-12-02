package com.nb.nbpx.pojo.zixun;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2013年11月18日
 */
@Entity
@Table(name = "downloads", catalog = "nbpx")
public class Download extends BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	public Integer downloadId;
	public String title;
	public String filepath;
	public String filetype;
	public String description;
	public String author;
	public Date uploadDate;
	public Integer downloadCnt;
	public Integer hits;
	public Double size;
	
	
	
	
	public Download() {
		super();
	}

	/**
	 * Full constructor
	 * @param downloadId
	 * @param title
	 * @param filepath
	 * @param filetype
	 * @param description
	 * @param author
	 * @param uploadDate
	 * @param downloadCnt
	 * @param hits
	 */
	public Download(Integer downloadId, String title, String filepath,
			String filetype, String description, String author,
			Date uploadDate, Integer downloadCnt, Integer hits, Double size) {
		super();
		this.downloadId = downloadId;
		this.title = title;
		this.filepath = filepath;
		this.filetype = filetype;
		this.description = description;
		this.author = author;
		this.uploadDate = uploadDate;
		this.downloadCnt = downloadCnt;
		this.hits = hits;
		this.size = size;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "downloadId", unique = true, nullable = false)
	public Integer getDownloadId() {
		return downloadId;
	}


	public void setDownloadId(Integer downloadId) {
		this.downloadId = downloadId;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getFilepath() {
		return filepath;
	}


	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}


	public String getFiletype() {
		return filetype;
	}


	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


	public Date getUploadDate() {
		return uploadDate;
	}


	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}


	public Integer getDownloadCnt() {
		return downloadCnt;
	}


	public void setDownloadCnt(Integer downloadCnt) {
		this.downloadCnt = downloadCnt;
	}


	public Integer getHits() {
		return hits;
	}


	public void setHits(Integer hits) {
		this.hits = hits;
	}

	public Double getSize() {
		return size;
	}

	public void setSize(Double size) {
		this.size = size;
	}
	
	
	
}
