package com.nb.nbpx.pojo.course;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.google.gson.annotations.Expose;
import com.nb.nbpx.pojo.BaseEntity;

@Entity
@Table(name = "followups", catalog = "nbpx")
public class FollowUp   extends BaseEntity   implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Expose
	public Integer followUpId;
	@Expose
	public String adminUserName;
	@Expose
	public String followup;
	@Expose
	public Date followDate;
	@Expose
	public Integer applyId;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "followUp_id", unique = true, nullable = false)
	public Integer getFollowUpId() {
		return followUpId;
	}
	public void setFollowUpId(Integer followUpId) {
		this.followUpId = followUpId;
	}
	
	@Column(name = "admin_username", unique = true, nullable = false)
	public String getAdminUserName() {
		return adminUserName;
	}
	public void setAdminUserName(String adminUserName) {
		this.adminUserName = adminUserName;
	}

	@Column(name = "followup", unique = true, nullable = false, length = 10)
	public String getFollowup() {
		return followup;
	}
	public void setFollowup(String followup) {
		this.followup = followup;
	}
	
	@Column(name = "follow_date", unique = true, nullable = false, length = 10)
	public Date getFollowDate() {
		return followDate;
	}
	public void setFollowDate(Date followDate) {
		this.followDate = followDate;
	}
	
	@Column(name = "apply_id", unique = true, nullable = false, length = 10)
	public Integer getApplyId() {
		return applyId;
	}
	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}
	
	public FollowUp() {
		super();
	}
	public FollowUp(Integer followUpId, String adminUserName, String followup,
			Date followDate) {
		super();
		this.followUpId = followUpId;
		this.adminUserName = adminUserName;
		this.followup = followup;
		this.followDate = followDate;
	}
	
	
}
