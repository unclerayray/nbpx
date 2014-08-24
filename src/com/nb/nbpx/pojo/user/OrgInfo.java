package com.nb.nbpx.pojo.user;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;


@Entity
@Table(name = "orginfo", catalog = "nbpx")
public class OrgInfo implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	private Integer orgId;
	private User user;
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
	private String qq;
	private String logoUrl;
	private Boolean state;
	private Date createDate;
	private String createBy;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "orgId", unique = true, nullable = false)
	public Integer getOrgId() {
		return orgId;
	}
	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}	
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userId", nullable = false)
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getLogoUrl() {
		return logoUrl;
	}
	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
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
	
	public Boolean getState() {
		return state;
	}
	public void setState(Boolean state) {
		this.state = state;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public OrgInfo(){}
	public OrgInfo(Integer orgId, Integer userId, String orgName,
			String address, Integer postCode, String contact, String cellphone,
			String telephone, String fax, String website, String category,
			String introduction) {
		super();
		this.orgId = orgId;
		User user = new User();
		user.setUserId(userId);
		this.user = user;
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
	
	public OrgInfo(Integer orgId, User user, String orgName, String address,
			Integer postCode, String contact, String cellphone,
			String telephone, String fax, String website, String category,
			String introduction) {
		super();
		this.orgId = orgId;
		this.user = user;
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
	public OrgInfo(Integer orgId, User user, String orgName, String address,
			Integer postCode, String contact, String cellphone,
			String telephone, String fax, String website, String category,
			String introduction, Boolean state, Date createDate, String createBy) {
		super();
		this.orgId = orgId;
		this.user = user;
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
		this.state = state;
		this.createDate = createDate;
		this.createBy = createBy;
	}


	public OrgInfo(Integer orgId, Integer userId, String orgName, String address,
			Integer postCode, String contact, String cellphone,
			String telephone, String fax, String website, String category,
			String introduction, Boolean state, Date createDate, String createBy) {
		super();
		this.orgId = orgId;
		this.user = new User();
		this.user.setUserId(userId);
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
		this.state = state;
		this.createDate = createDate;
		this.createBy = createBy;
	}
	public OrgInfo(Integer orgId, Integer userId, String orgName, String address,
			Integer postCode, String contact, String cellphone,
			String telephone, String fax, String website, String category,
			String introduction,String qq,String logoUrl, Boolean state, Date createDate, String createBy) {
		super();
		this.orgId = orgId;
		this.user = new User();
		this.user.setUserId(userId);
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
		this.qq = qq;
		this.logoUrl = logoUrl;
		this.state = state;
		this.createDate = createDate;
		this.createBy = createBy;
	}

	
}
