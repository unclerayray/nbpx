package com.nb.nbpx.pojo.user;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.nb.nbpx.pojo.BaseEntity;

@Entity
@Table(name = "companyinfo", catalog = "nbpx")
public class CompInfo extends BaseEntity  implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private Integer compInfoId;
	private User user;
	private String contact;
	private String company;
	private String telephone;
	private String cellphone;
	private String fax;
	private String department;
	private Boolean state;
	private Date createDate;
	private String createBy;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "compInfoId", unique = true, nullable = false)
	public Integer getCompInfoId() {
		return compInfoId;
	}
	public void setCompInfoId(Integer compInfoId) {
		this.compInfoId = compInfoId;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userId", nullable = false)
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
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

	public CompInfo(){}
	
	/**
	 * full constructor
	 * @param compInfoId
	 * @param userId
	 * @param contact
	 * @param company
	 * @param telephone
	 * @param cellphone
	 * @param fax
	 * @param department
	 * @param state
	 * @param createDate
	 * @param createBy
	 */
	public CompInfo(Integer compInfoId, User user, String contact,
			String company, String telephone, String cellphone, String fax,
			String department, Boolean state, Date createDate, String createBy) {
		super();
		this.compInfoId = compInfoId;
		this.user = user;
		this.contact = contact;
		this.company = company;
		this.telephone = telephone;
		this.cellphone = cellphone;
		this.fax = fax;
		this.department = department;
		this.state = state;
		this.createDate = createDate;
		this.createBy = createBy;
	}

	public CompInfo(Integer compInfoId, Integer userId, String contact,
			String company, String telephone, String cellphone, String fax,
			String department, Boolean state, Date createDate, String createBy) {
		super();
		this.compInfoId = compInfoId;
		this.user.setUserId(userId);
		this.contact = contact;
		this.company = company;
		this.telephone = telephone;
		this.cellphone = cellphone;
		this.fax = fax;
		this.department = department;
		this.state = state;
		this.createDate = createDate;
		this.createBy = createBy;
	}
	
}
