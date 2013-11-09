package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.IRequirementService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.course.Requirement;

@Component("RequirementAction")
@Scope("prototype")
public class RequirementAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	
	public Requirement requirement;
	public Integer hasReplied;
	private IRequirementService requirementService;
	public Integer requirementId;
	public String reply;
	
	//添加培训需求
	public String addRequirement(){
		String json = "";
		try {	
			requirementService.saveRequirement(requirement);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String queryRequirements(){
		String json = requirementService.queryRequirements(hasReplied, rows, getStartPosi(), sort, order);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String replyRequirement(){
		try {
			requirementService.replyRequirement(requirementId, reply);
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
}
