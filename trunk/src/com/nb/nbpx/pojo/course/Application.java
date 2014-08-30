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

import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2013年11月9日
 */
@Entity
@Table(name = "applications", catalog = "nbpx")
public class Application extends BaseEntity  implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private Integer applyId;
	private String email;
	private String applicant;
	private String applyCourseId;
	private String applyCourse;
	private String applicantCompany;
	private Integer headCount;
	private String contact;
	private String telephone;
	private String cellphone;
	private String fax;
	private String department;
	private String remarks;
	private Boolean confirmed;
	private Boolean followed;
	private Date createDate;
	private String qq;
	private String participants;

	public Application() {
	}

	
	
	
	/**
	 * 后台展示所用构造函数
	 * @param applyId
	 * @param email
	 * @param applyCourseId
	 * @param applyCourse
	 * @param applicantCompany
	 * @param headCount
	 * @param contact
	 * @param telephone
	 * @param cellphone
	 * @param fax
	 * @param department
	 * @param remarks
	 * @param confirmed
	 * @param followed
	 * @param createDate
	 * @param qq
	 * @param participants
	 */
	public Application(Integer applyId, String email,String applicant, String applyCourseId, String applyCourse,
			String applicantCompany, Integer headCount, String contact,
			String telephone, String cellphone, String fax, String department,
			String remarks, Boolean confirmed,Boolean followed, Date createDate,
			String qq,String participants) {
		super();
		this.applyId = applyId;
		this.email = email;
		this.applyCourseId = applyCourseId;
		this.applicant = applicant;
		this.applyCourse = applyCourse;
		this.applicantCompany = applicantCompany;
		this.headCount = headCount;
		this.contact = contact;
		this.telephone = telephone;
		this.cellphone = cellphone;
		this.fax = fax;
		this.department = department;
		this.remarks = remarks;
		this.confirmed = confirmed;
		this.followed = followed;
		this.createDate = createDate;
		this.qq = qq;
		this.participants = participants;
	}




	/**
	 * full constructor
	 * @param applyId
	 * @param email
	 * @param applicant
	 * @param applyCourseId
	 * @param applyCourse
	 * @param applicantCompany
	 * @param headCount
	 * @param contact
	 * @param telephone
	 * @param cellphone
	 * @param fax
	 * @param department
	 * @param remarks
	 * @param confirmed
	 * @param createDate
	 * @param qq
	 * @param participants
	 */
	public Application(Integer applyId, String email, String applicant,
			String applyCourseId, String applyCourse,
			String applicantCompany, Integer headCount, String contact,
			String telephone, String cellphone, String fax, String department,
			String remarks, Boolean confirmed, Date createDate,
			String qq,String participants) {
		super();
		this.applyId = applyId;
		this.email = email;
		this.applicant = applicant;
		this.applyCourseId = applyCourseId;
		this.applyCourse = applyCourse;
		this.applicantCompany = applicantCompany;
		this.headCount = headCount;
		this.contact = contact;
		this.telephone = telephone;
		this.cellphone = cellphone;
		this.fax = fax;
		this.department = department;
		this.remarks = remarks;
		this.confirmed = confirmed;
		this.createDate = createDate;
		this.qq = qq;
		this.participants = participants;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "applyId", unique = true, nullable = false)
	public Integer getApplyId() {
		return applyId;
	}

	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getApplicant() {
		return applicant;
	}

	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}

	public String getApplyCourseId() {
		return applyCourseId;
	}

	public void setApplyCourseId(String applyCourseId) {
		this.applyCourseId = applyCourseId;
	}
	
	@Transient
	public String getApplyCourse() {
		return applyCourse;
	}

	public void setApplyCourse(String applyCourse) {
		this.applyCourse = applyCourse;
	}

	public String getApplicantCompany() {
		return applicantCompany;
	}

	public void setApplicantCompany(String applicantCompany) {
		this.applicantCompany = applicantCompany;
	}

	public Integer getHeadCount() {
		return headCount;
	}

	public void setHeadCount(Integer headCount) {
		this.headCount = headCount;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Boolean getConfirmed() {
		return confirmed;
	}

	public void setConfirmed(Boolean confirmed) {
		this.confirmed = confirmed;
	}

	public Boolean getFollowed() {
		return followed;
	}




	public void setFollowed(Boolean followed) {
		this.followed = followed;
	}




	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}




	public String getQq() {
		return qq;
	}




	public void setQq(String qq) {
		this.qq = qq;
	}




	public String getParticipants() {
		return participants;
	}




	public void setParticipants(String participants) {
		this.participants = participants;
	}
}
