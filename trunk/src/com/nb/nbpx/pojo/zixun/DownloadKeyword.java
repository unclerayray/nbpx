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
import javax.persistence.UniqueConstraint;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2013年12月25日
 */
@Entity
@Table(name = "downloadkeywords", catalog = "nbpx", uniqueConstraints = @UniqueConstraint(columnNames = {
		"keywordId", "downloadId" }))
public class DownloadKeyword extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	public Integer downloadKeywordId;
	public Download download;
	public Integer keywordId;
	public String keyword;

	public DownloadKeyword() {
	}

	public DownloadKeyword(Integer downloadKeywordId, Integer keywordId,
			String keyword) {
		super();
		this.downloadKeywordId = downloadKeywordId;
		this.keywordId = keywordId;
		this.keyword = keyword;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "downloadKeywordId", unique = true, nullable = false)
	public Integer getDownloadKeywordId() {
		return downloadKeywordId;
	}

	public void setDownloadKeywordId(Integer downloadKeywordId) {
		this.downloadKeywordId = downloadKeywordId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "downloadId", nullable = false)
	public Download getDownload() {
		return download;
	}

	public void setDownload(Download download) {
		this.download = download;
	}

	public Integer getKeywordId() {
		return keywordId;
	}

	public void setKeywordId(Integer keywordId) {
		this.keywordId = keywordId;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((download == null) ? 0 : download.hashCode());
		result = prime * result
				+ ((keywordId == null) ? 0 : keywordId.hashCode());
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
		DownloadKeyword other = (DownloadKeyword) obj;
		if (download == null) {
			if (other.download != null)
				return false;
		} else if (!download.equals(other.download))
			return false;
		if (keywordId == null) {
			if (other.keywordId != null)
				return false;
		} else if (!keywordId.equals(other.keywordId))
			return false;
		return true;
	}
	
	

}
