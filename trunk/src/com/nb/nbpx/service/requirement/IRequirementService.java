package com.nb.nbpx.service.requirement;

import com.nb.nbpx.pojo.requirement.Requirement;
import com.nb.nbpx.service.IBaseService;

public interface IRequirementService extends IBaseService{
	public void saveRequirement(Requirement requirement);
}
