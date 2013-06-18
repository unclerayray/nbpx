package com.nb.nbpx.pojo.user;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "orginfo", catalog = "nbpx")
public class OrgInfo implements Serializable{
	
	private Integer orgId;
	private Integer userId;
	private String orgName;
	private String address;
	private Integer postCode;
	private String contact;
	private String cellphone;
	private String telephone;
	private String fax;
	private String website;
	private String category;
	private String introduction;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "orgId", unique = true, nullable = false)
	public Integer getOrgId() {
		return orgId;
	}
	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getPostCode() {
		return postCode;
	}
	public void setPostCode(Integer postCode) {
		this.postCode = postCode;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	
	public OrgInfo(){}
	
	public OrgInfo(Integer orgId, Integer userId, String orgName,
			String address, Integer postCode, String contact, String cellphone,
			String telephone, String fax, String website, String category,
			String introduction) {
		super();
		this.orgId = orgId;
		this.userId = userId;
		this.orgName = orgName;
		this.address = address;
		this.postCode = postCode;
		this.contact = contact;
		this.cellphone = cellphone;
		this.telephone = telephone;
		this.fax = fax;
		this.website = website;
		this.category = category;
		this.introduction = introduction;
	}

	
	
}
