package com.nb.nbpx.pojo.course;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "requirements", catalog = "nbpx")
public class Requirement  implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer requirementId;
	private String username;
	private String requiredCourse;
	private Integer headCount;
	private Integer validDays;
	private Date startTime;
	private Date endTime;
	private String city;
	private String contact;
	private String telephone;
	private String cellphone;
	private String comp_name;
	private String description;
	private String reply;
	private Integer hasReplied;
	private String email;
	private Date createDate;

	public Requirement(){
		super();
	}
	
	public Requirement(Integer requirementId, String username,
			String requiredCourse, Integer headCount, Integer validDays,
			Date startTime, Date endTime, String city, String contact,
			String telephone, String cellphone, String comp_name,
			String description, String reply, Integer hasReplied,
			String email,Date createDate) {
		super();
		this.requirementId = requirementId;
		this.username = username;
		this.requiredCourse = requiredCourse;
		this.headCount = headCount;
		this.validDays = validDays;
		this.startTime = startTime;
		this.endTime = endTime;
		this.city = city;
		this.contact = contact;
		this.telephone = telephone;
		this.cellphone = cellphone;
		this.comp_name = comp_name;
		this.description = description;
		this.reply = reply;
		this.hasReplied = hasReplied;
		this.email = email;
		this.createDate = createDate;
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "requirementId", unique = true, nullable = false)
	public Integer getRequirementId() {
		return requirementId;
	}

	public void setRequirementId(Integer requirementId) {
		this.requirementId = requirementId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getRequiredCourse() {
		return requiredCourse;
	}

	public void setRequiredCourse(String requiredCourse) {
		this.requiredCourse = requiredCourse;
	}

	public Integer getHeadCount() {
		return headCount;
	}

	public void setHeadCount(Integer headCount) {
		this.headCount = headCount;
	}

	public Integer getValidDays() {
		return validDays;
	}

	public void setValidDays(Integer validDays) {
		this.validDays = validDays;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
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

	public String getComp_name() {
		return comp_name;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getHasReplied() {
		return hasReplied;
	}

	public void setHasReplied(Integer hasReplied) {
		this.hasReplied = hasReplied;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}
}