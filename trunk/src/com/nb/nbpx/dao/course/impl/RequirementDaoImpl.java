package com.nb.nbpx.dao.course.impl;

import java.util.List;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.IRequirementDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.pojo.course.Requirement;

@Component("RequirementDao")
public class RequirementDaoImpl extends BaseDaoImpl<Requirement, Integer> implements IRequirementDao{

	@Override
	public List<Requirement> getRequirement() {
		
		return null;
	}
	
}
