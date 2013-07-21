package com.nb.nbpx.dao.requirement.impl;

import java.util.List;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.requirement.IRequirementDao;
import com.nb.nbpx.pojo.requirement.Requirement;;

@Component("RequirementDao")
public class RequirementDaoImpl extends BaseDaoImpl<Requirement, Integer> implements IRequirementDao{

	@Override
	public List<Requirement> getRequirement() {
		
		// TODO Auto-generated method stub
		return null;
	}
	
}
