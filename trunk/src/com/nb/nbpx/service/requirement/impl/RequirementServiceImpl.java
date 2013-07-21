package com.nb.nbpx.service.requirement.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.requirement.IRequirementDao;
import com.nb.nbpx.pojo.requirement.Requirement;
import com.nb.nbpx.service.impl.*;
import com.nb.nbpx.service.requirement.IRequirementService;

@Component("RequirementService")
public class RequirementServiceImpl extends BaseServiceImpl implements IRequirementService{
	
	private IRequirementDao requirementDao;


	@Override
	public void saveRequirement(Requirement requirement){
		if(requirement.getRequirementId()==null){
			requirementDao.save(requirement);//新增用户
		}else{
			requirementDao.saveOrUpdate(requirement);//修改用户
		}
	}
	
	public IRequirementDao getRequirementDao() {
		return requirementDao;
	}
	
	@Resource
	public void setRequirementDao(IRequirementDao requirementDao) {
		this.requirementDao = requirementDao;
	}
}
