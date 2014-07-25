package com.nb.nbpx.server.course;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseApplyService;

import com.nb.nbpx.pojo.course.CourseApply;
import com.nb.nbpx.pojo.user.User;

@Component("CourseApplyAction")
@Scope("prototype")
public class CourseApplyAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	
	private ICourseApplyService courseApplyService;
	
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
	private String starttime;
	private String endtime;
	private String budget;
	private String languaue;
	private String studentDesc;
	private String basicDesc;
	private String compDesc;
	private String state;
	private String questionDesc;
	private String contentDesc;
	private String targetDesc;
	private String notice;
	
	//添加内训需求
	public String addApply(){
		String json = "";
		CourseApply apply = new CourseApply();
		apply.setBasicDesc(basicDesc);
		apply.setBudget(budget);
		apply.setCelphone(celphone);
		apply.setCompDesc(compDesc);
		apply.setCompName(compName);
		apply.setCompType(compType);
		apply.setComRange(comRange);
		apply.setContact(contact);
		apply.setContentDesc(contentDesc);
		apply.setCourseName(courseName);
		apply.setCreatetime(new Date());
		apply.setDepartName(departName);
		apply.setEmail(email);
		apply.setEndtime(new Date(endtime));
		apply.setFax(fax);
		apply.setLanguaue(languaue);
		apply.setMsn(msn);
		apply.setNotice(notice);
		apply.setQuestionDesc(questionDesc);
		apply.setStarttime(new Date(starttime));
		apply.setState(Integer.parseInt(state));
		apply.setStudentDesc(studentDesc);
		apply.setTargetDesc(targetDesc);
		apply.setTeacherName(teacherName);
		apply.setTelephone(telephone);
		
		User user = (User)session.getAttribute("user");
		if(user == null)
			return "请先登陆!";
		apply.setUserId(user.getUserId());
		try {	
			courseApplyService.saveCourseApply(apply);
			json = "内训需求保存成功,请等候工作人员处理";
		} catch (Exception e) {
			e.printStackTrace();
			json = "内训需求保存失败";
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	
	public ICourseApplyService getCourseApplyService() {
		return courseApplyService;
	}
	@Resource
	public void setCourseApplyService(ICourseApplyService courseApplyService) {
		this.courseApplyService = courseApplyService;
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
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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


	public String getStarttime() {
		return starttime;
	}


	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}


	public String getEndtime() {
		return endtime;
	}


	public void setEndtime(String endtime) {
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

}
