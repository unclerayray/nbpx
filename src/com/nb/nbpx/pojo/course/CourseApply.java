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
@Table(name = "CourseApply", catalog = "nbpx")
public class CourseApply  implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer applyID;
	private String teacherName;
	private String courseName;
	private String compName;
	private String contact;
	private String fax;
	private String celphone;
	private String email;
	private String telephone;
	private String departName;
	private String msn;
	private String compType;
	private String comRange;
	private Date starttime;
	private Date endtime;
	private String budget;
	private String languaue;
	private String studentDesc;
	private String basicDesc;
	private String compDesc;
	private String questionDesc;
	private String contentDesc;
	private String targetDesc;
	private String notice;
	private Integer state;
	private Date createtime;
	private Integer userId;
	private Integer personCount;


	public CourseApply(){
		super();
	}
	
	public CourseApply(Integer applyID,String teacherName,String courseName,String compName,
			String contact,String fax,String celphone,String email,String telephone,String departName,
			String msn,String compType,String comRange,Date starttime,Date endtime,String budget,
			String languaue,String studentDesc,String basicDesc,String compDesc,String questionDesc,
			String contentDesc,String targetDesc,String notice,Integer state,Date createtime,Integer userId,Integer personCount) {
		super();
		this.applyID = applyID;
		this.teacherName=teacherName;
		this.courseName=courseName;
		this.compName=compName;
		this.contact=contact;
		this.fax=fax;
		this.celphone=celphone;
		this.email=email;
		this.telephone=telephone;
		this.departName=departName;
		this.msn = msn;
		this.compType=compType;
		this.comRange = comRange;
		this.starttime = starttime;
		this.endtime =endtime;
		this.budget= budget;
		this.languaue = languaue;
		this.studentDesc=studentDesc;
		this.basicDesc=basicDesc;
		this.compDesc=compDesc;
		this.questionDesc = questionDesc;
		this.contentDesc = contentDesc;
		this.targetDesc = targetDesc;
		this.notice = notice;
		this.state = state;
		this.createtime = createtime;
		this.userId = userId;
		this.personCount = personCount;
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "applyID", unique = true, nullable = false)
	public Integer getApplyID() {
		return applyID;
	}

	public void setApplyID(Integer applyID) {
		this.applyID = applyID;
	}
	public Integer getUserId() {
		return userId;
	}
	public Integer getPersonCount() {
		return personCount;
	}

	public void setPersonCount(Integer personCount) {
		this.personCount = personCount;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCompName() {
		return compName;
	}

	public void setCompName(String compName) {
		this.compName = compName;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getCelphone() {
		return celphone;
	}

	public void setCelphone(String celphone) {
		this.celphone = celphone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getMsn() {
		return msn;
	}

	public void setMsn(String msn) {
		this.msn = msn;
	}

	public String getCompType() {
		return compType;
	}

	public void setCompType(String compType) {
		this.compType = compType;
	}

	public String getComRange() {
		return comRange;
	}

	public void setComRange(String comRange) {
		this.comRange = comRange;
	}

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public String getBudget() {
		return budget;
	}

	public void setBudget(String budget) {
		this.budget = budget;
	}

	public String getLanguaue() {
		return languaue;
	}

	public void setLanguaue(String languaue) {
		this.languaue = languaue;
	}

	public String getStudentDesc() {
		return studentDesc;
	}

	public void setStudentDesc(String studentDesc) {
		this.studentDesc = studentDesc;
	}

	public String getBasicDesc() {
		return basicDesc;
	}

	public void setBasicDesc(String basicDesc) {
		this.basicDesc = basicDesc;
	}

	public String getCompDesc() {
		return compDesc;
	}

	public void setCompDesc(String compDesc) {
		this.compDesc = compDesc;
	}

	public String getQuestionDesc() {
		return questionDesc;
	}

	public void setQuestionDesc(String questionDesc) {
		this.questionDesc = questionDesc;
	}

	public String getContentDesc() {
		return contentDesc;
	}

	public void setContentDesc(String contentDesc) {
		this.contentDesc = contentDesc;
	}

	public String getTargetDesc() {
		return targetDesc;
	}

	public void setTargetDesc(String targetDesc) {
		this.targetDesc = targetDesc;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
}
