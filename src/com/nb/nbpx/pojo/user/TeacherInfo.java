package com.nb.nbpx.pojo.user;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "teacher_info", catalog = "nbpx")
public class TeacherInfo implements Serializable{
	private Integer teacherId;
	private Integer userId;
	private String realName;
	private Date birthday;
	private String majorCatgory;
	private float externalPayment;
	private float internalPayment;
	private String fax;
	private String telephone;
	private String cellphone;
	private String introduction;
	private String expertIn;
	
	
	
	public TeacherInfo(Integer teacherId, String realName) {
		super();
		this.teacherId = teacherId;
		this.realName = realName;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "teacherId", unique = true, nullable = false)
	public Integer getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getMajorCatgory() {
		return majorCatgory;
	}
	public void setMajorCatgory(String majorCatgory) {
		this.majorCatgory = majorCatgory;
	}
	public float getExternalPayment() {
		return externalPayment;
	}
	public void setExternalPayment(float externalPayment) {
		this.externalPayment = externalPayment;
	}
	public float getInternalPayment() {
		return internalPayment;
	}
	public void setInternalPayment(float internalPayment) {
		this.internalPayment = internalPayment;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
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
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getExpertIn() {
		return expertIn;
	}
	public void setExpertIn(String expertIn) {
		this.expertIn = expertIn;
	}
	public TeacherInfo(){}
	public TeacherInfo(Integer teacherId, Integer userId, String realName,
			Date birthday, String majorCatgory, float externalPayment,
			float internalPayment, String fax, String telephone,
			String cellphone, String introduction, String expertIn) {
		super();
		this.teacherId = teacherId;
		this.userId = userId;
		this.realName = realName;
		this.birthday = birthday;
		this.majorCatgory = majorCatgory;
		this.externalPayment = externalPayment;
		this.internalPayment = internalPayment;
		this.fax = fax;
		this.telephone = telephone;
		this.cellphone = cellphone;
		this.introduction = introduction;
		this.expertIn = expertIn;
	}
	
	
	
	
}
