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
 * @date 2013年12月29日
 */
@Entity
@Table(name = "downloadsubjects", catalog = "nbpx", uniqueConstraints = @UniqueConstraint(columnNames = {
		"subjectId", "downloadId" }))
public class DownloadSubject  extends BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public Integer downloadSubjectId;
	public Download download;
	public Integer subjectId;
	public String subject;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "downloadSubjectId", unique = true, nullable = false)
	
	public Integer getDownloadSubjectId() {
		return downloadSubjectId;
	}
	public void setDownloadSubjectId(Integer downloadSubjectId) {
		this.downloadSubjectId = downloadSubjectId;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "downloadId", nullable = false)
	public Download getDownload() {
		return download;
	}
	public void setDownload(Download download) {
		this.download = download;
	}
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((subject == null) ? 0 : subject.hashCode());
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
		DownloadSubject other = (DownloadSubject) obj;
		if (subject == null) {
			if (other.subject != null)
				return false;
		} else if (!subject.equals(other.subject))
			return false;
		return true;
	}
	

}
