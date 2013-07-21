package com.nb.nbpx.server.requirement;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.requirement.*;
import com.nb.nbpx.pojo.requirement.Requirement;

@Component("RequirmentAction")
@Scope("prototype")
public class RequirementAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	
	public Requirement requirement;
	private IRequirementService requirementService;
	
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

	
	
	
}
