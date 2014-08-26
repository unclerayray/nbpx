package com.nb.nbpx.server.course;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.IRequirementService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.course.Requirement;
import com.nb.nbpx.pojo.user.User;

@Component("RequirementAction")
@Scope("prototype")
public class RequirementAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	
	public Requirement requirement;
	public String requiredCourse;
	public Integer headCount;
	public Integer validDays;
	public Date startTime;
	public Date endTime;
	public String city;
	public String contact;
	public String telephone;
	public String cellphone;
	public String comp_name;
	public String description;
	public String email;
	public Integer hasReplied;
	private IRequirementService requirementService;
	public Integer requirementId;
	public String reply;
	public String q_company;
	public String q_contact;
	
	//添加培训需求
	public String addRequirement(){
		String json = "";
		Requirement req = new Requirement();
		req.setCellphone(cellphone);
		req.setCity(city);
		req.setComp_name(comp_name);
		req.setContact(contact);
		req.setDescription(description);
		req.setEmail(email);
		req.setEndTime(endTime);
		req.setHasReplied(0);
		req.setHeadCount(headCount);
		req.setRequiredCourse(requiredCourse);
		req.setStartTime(startTime);
		req.setTelephone(telephone);
		req.setValidDays(validDays);
		req.setCreateDate(new Date());
		req.setUsername(getClientSessionUserName());
		try {	
			requirementService.saveRequirement(req);
			json = "发布需求成功,请等候工作人员处理";
		} catch (Exception e) {
			e.printStackTrace();
			json = "发布需求失败";
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String queryRequirements(){
		String json = requirementService.queryRequirements(hasReplied, q_company, q_contact, rows, getStartPosi(), sort, order);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String replyRequirement(){
		try {
			requirementService.replyRequirement(requirementId, reply,super.getSessionUserName());
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}
	
	public Requirement getRequirement() {
		return requirement;
	}
	public void setRequirementDao(Requirement requirement) {
		this.requirement = requirement;
	}
	public IRequirementService getRequirementService() {
		return requirementService;
	}
	@Resource
	public void setRequirementService(IRequirementService requirementService) {
		this.requirementService = requirementService;
	}
	public String getRequiredCourse() {
		return requiredCourse;
	}

	public void setRequiredCourse(String requiredCourse) {
		this.requiredCourse = requiredCourse;
	}

	public Integer getHeadCount() {
		return headCount;
	}

	public void setHeadCount(Integer headCount) {
		this.headCount = headCount;
	}

	public Integer getValidDays() {
		return validDays;
	}

	public void setValidDays(Integer validDays) {
		this.validDays = validDays;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
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

	public String getComp_name() {
		return comp_name;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public Integer getHasReplied() {
		return hasReplied;
	}

	public void setHasReplied(Integer hasReplied) {
		this.hasReplied = hasReplied;
	}

	public Integer getRequirementId() {
		return requirementId;
	}

	public void setRequirementId(Integer requirementId) {
		this.requirementId = requirementId;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getQ_company() {
		return q_company;
	}

	public void setQ_company(String q_company) {
		this.q_company = q_company;
	}

	public String getQ_contact() {
		return q_contact;
	}

	public void setQ_contact(String q_contact) {
		this.q_contact = q_contact;
	}

	public void setRequirement(Requirement requirement) {
		this.requirement = requirement;
	}	
}
