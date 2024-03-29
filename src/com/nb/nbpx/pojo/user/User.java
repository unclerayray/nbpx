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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.nb.nbpx.pojo.BaseEntity;

@Entity
@Table(name = "users", catalog = "nbpx")
public class User extends BaseEntity  implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer           userId;
    private String            userName;
    private String            passWord;
    private String            userType;
	private String            email;
	private Date			  registerDate;
	private Boolean			  state;
	private String 			  city;
	private String			  typeName;	
	private CompInfo		  compInfo;
	private OrgInfo	          orgInfo;
	private TeacherInfo		  teacherInfo;
	
	public User(){
	}
	
	public User(Integer userId, String userName, String passWord,
			String userType, String email, String typeName, 
			String city,Boolean state,Date registerDate) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.passWord = passWord;
		this.userType = userType;
		this.email = email;
		this.typeName = typeName;
		this.city = city;
		this.state = state;
		this.registerDate = registerDate;
	}
	
	
	
	
	public User(Integer userId, String userName, String passWord,
			String userType, String email, Date registerDate, Boolean state,
			String city, String typeName, CompInfo compInfo, OrgInfo orgInfo,
			TeacherInfo teacherInfo) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.passWord = passWord;
		this.userType = userType;
		this.email = email;
		this.registerDate = registerDate;
		this.state = state;
		this.city = city;
		this.typeName = typeName;
		this.compInfo = compInfo;
		this.orgInfo = orgInfo;
		this.teacherInfo = teacherInfo;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "userId", unique = true, nullable = false)
    public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
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
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public Boolean getState() {
		return state;
	}
	public void setState(Boolean state) {
		this.state = state;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	@Transient
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
	public CompInfo getCompInfo() {
		return compInfo;
	}

	public void setCompInfo(CompInfo compInfo) {
		this.compInfo = compInfo;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
	public OrgInfo getOrgInfo() {
		return orgInfo;
	}

	public void setOrgInfo(OrgInfo orgInfo) {
		this.orgInfo = orgInfo;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
	public TeacherInfo getTeacherInfo() {
		return teacherInfo;
	}

	public void setTeacherInfo(TeacherInfo teacherInfo) {
		this.teacherInfo = teacherInfo;
	}
	
}
