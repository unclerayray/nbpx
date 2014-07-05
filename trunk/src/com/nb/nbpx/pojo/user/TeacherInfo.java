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

@Entity
@Table(name = "teacher_info", catalog = "nbpx")
public class TeacherInfo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	private Integer teacherId;
	private User user;
	private String realName;
	private Date birthday;
	private String majorCatgory;
	private Double externalPayment;
	private Double internalPayment;
	private String fax;
	private String telephone;
	private String cellphone;
	private String introduction;
	private String expertIn;
	private String isInner;
	private String photo;
	
	/**
	 * 表示是否已注册
	 */
	private Boolean state;
	private Date createDate;
	private String createBy;
	
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
	
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userId", nullable = false)
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getIsInner() {
		return isInner;
	}
	public void setIsInner(String isInner) {
		this.isInner = isInner;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
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
	public Double getExternalPayment() {
		return externalPayment;
	}
	public void setExternalPayment(Double externalPayment) {
		this.externalPayment = externalPayment;
	}
	public Double getInternalPayment() {
		return internalPayment;
	}
	public void setInternalPayment(Double internalPayment) {
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
	
	
	/**
	 * Full constructor
	 * @param teacherId
	 * @param user
	 * @param realName
	 * @param birthday
	 * @param majorCatgory
	 * @param externalPayment
	 * @param internalPayment
	 * @param fax
	 * @param telephone
	 * @param cellphone
	 * @param introduction
	 * @param expertIn
	 * @param photo
	 * @param state
	 * @param createDate
	 * @param createBy
	 */
	public TeacherInfo(Integer teacherId, User user, String realName,
			Date birthday, String majorCatgory, Double externalPayment,
			Double internalPayment, String fax, String telephone,
			String cellphone, String introduction, String expertIn,
			String photo, Boolean state, Date createDate, String createBy) {
		super();
		this.teacherId = teacherId;
		this.user = user;
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
		this.photo = photo;
		this.state = state;
		this.createDate = createDate;
		this.createBy = createBy;
	}
	public TeacherInfo(){}
	public TeacherInfo(Integer teacherId, Integer userId, String realName,
			Date birthday, String majorCatgory, Double externalPayment,
			Double internalPayment, String fax, String telephone,
			String cellphone, String introduction, String expertIn) {
		super();
		this.teacherId = teacherId;
		this.user.setUserId(userId);
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
	public TeacherInfo(Integer teacherId, User user, String realName,
			Date birthday, String majorCatgory, Double externalPayment,
			Double internalPayment, String fax, String telephone,
			String cellphone, String introduction, String expertIn) {
		super();
		this.teacherId = teacherId;
		this.user = user;
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
	public TeacherInfo(Integer teacherId, User user, String realName,
			Date birthday, String majorCatgory, Double externalPayment,
			Double internalPayment, String fax, String telephone,
			String cellphone, String introduction, String expertIn,
			Boolean state, Date createDate, String createBy) {
		super();
		this.teacherId = teacherId;
		this.user = user;
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
		this.state = state;
		this.createDate = createDate;
		this.createBy = createBy;
	}
	

	public TeacherInfo(Integer teacherId, Integer userId, String realName,
			Date birthday, String majorCatgory, Double externalPayment,
			Double internalPayment, String fax, String telephone,
			String cellphone, String introduction, String expertIn,
			Boolean state, Date createDate, String createBy) {
		super();
		this.teacherId = teacherId;
		this.user.setUserId(userId);
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
		this.state = state;
		this.createDate = createDate;
		this.createBy = createBy;
	}
	
	public TeacherInfo(Integer teacherId, String realName,
			Date birthday, String majorCatgory, Double externalPayment,
			Double internalPayment, String fax, String telephone,
			String cellphone, String introduction, String expertIn,
			Boolean state, Date createDate, String createBy,String isInner,String photo) {
		super();
		this.teacherId = teacherId;
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
		this.state = state;
		this.createDate = createDate;
		this.createBy = createBy;
		this.isInner = isInner;
		this.photo = photo;
	}
	
	
}
