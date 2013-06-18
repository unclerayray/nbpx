package com.nb.nbpx.dto.user;

public class CompInfoDto {
	
	private Integer compInfoId;
	private Integer userId;
	private String contact;
	private String company;
	private String telephone;
	private String cellphone;
	private String fax;
	private String department;
	private String password;
	
	public CompInfoDto(Integer compInfoId, Integer userId, String contact,
			String company, String telephone, String cellphone, String fax,
			String department, String password) {
		super();
		this.compInfoId = compInfoId;
		this.userId = userId;
		this.contact = contact;
		this.company = company;
		this.telephone = telephone;
		this.cellphone = cellphone;
		this.fax = fax;
		this.department = department;
		this.password = password;
	}
	
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
}
