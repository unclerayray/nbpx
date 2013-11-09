package com.nb.nbpx.dao.course;

import com.nb.nbpx.dao.IBaseDao;

import java.util.List;

import com.nb.nbpx.pojo.course.Requirement;

public interface IRequirementDao  extends IBaseDao<Requirement, Integer>{
	public List<Requirement> getRequirement();
}
