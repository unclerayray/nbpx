package com.nb.nbpx.service.course;

import com.nb.nbpx.service.IBaseService;

public interface IApplicationService  extends IBaseService {
	public String queryApplications(Integer rows,
			Integer start, String sort, String order, Boolean confirmed, Boolean follow, String company, String contact);
	
	public String queryFollowups(Integer applyId);
	
	public void confirmApplication(Integer id) throws Exception;
	
	public void followApplication(Integer id, String stateInfo, String username) throws Exception;
}
