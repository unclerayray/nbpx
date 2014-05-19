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
@Table(name = "admins", catalog = "nbpx")
public class Admin extends BaseEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer           adminId;
    private String            userName;
    private String            passWord;
    private String            realname;
    private Boolean			  flag;
    

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "adminId", unique = true, nullable = false)
	public Integer getAdminId() {
		return adminId;
	}
	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public Boolean getFlag() {
		return flag;
	}
	public void setFlag(Boolean flag) {
		this.flag = flag;
	}
	public Admin(Integer adminId, String userName, String passWord,
			String realname, Boolean flag) {
		super();
		this.adminId = adminId;
		this.userName = userName;
		this.passWord = passWord;
		this.realname = realname;
		this.flag = flag;
	}

    public Admin(){
    	
    }
}
