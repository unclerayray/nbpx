package com.nb.nbpx.service.course;

import com.nb.nbpx.pojo.course.Requirement;
import com.nb.nbpx.service.IBaseService;

public interface IRequirementService extends IBaseService {
	public String queryRequirements(Integer hasReplied,String q_company,String q_contact, Integer rows,
			Integer start, String sort, String order);

	public void replyRequirement(Integer requirementId,String reply);
	public void saveRequirement(Requirement requirement);
}
