package com.nb.nbpx.pojo.user;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.nb.nbpx.pojo.BaseEntity;

@Entity
@Table(name = "companyinfo", catalog = "nbpx")
public class CompInfo extends BaseEntity  implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private Integer compInfoId;
	private Integer userId;
	private String contact;
	private String company;
	private String telephone;
	private String cellphone;
	private String fax;
	private String department;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "compInfoId", unique = true, nullable = false)
	public Integer getCompInfoId() {
		return compInfoId;
	}
	public void setCompInfoId(Integer compInfoId) {
		this.compInfoId = compInfoId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
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
	public CompInfo(){}
	public CompInfo(Integer compInfoId, Integer userId, String contact,
			String company, String telephone, String cellphone, String fax,
			String department) {
		super();
		this.compInfoId = compInfoId;
		this.userId = userId;
		this.contact = contact;
		this.company = company;
		this.telephone = telephone;
		this.cellphone = cellphone;
		this.fax = fax;
		this.department = department;
	}
	
}
