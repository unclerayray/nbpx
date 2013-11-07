package com.nb.nbpx.service.requirement;

import com.nb.nbpx.pojo.requirement.Requirement;
import com.nb.nbpx.service.IBaseService;

public interface IRequirementService extends IBaseService {
	public String queryRequirements(Integer hasReplied, Integer rows,
			Integer start, String sort, String order);

	public void replyRequirement(Integer requirementId,String reply);
	public void saveRequirement(Requirement requirement);
}
