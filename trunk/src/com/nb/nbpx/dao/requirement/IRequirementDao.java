package com.nb.nbpx.dao.requirement;

import com.nb.nbpx.dao.IBaseDao;
import java.util.List;
import com.nb.nbpx.pojo.requirement.Requirement;

public interface IRequirementDao  extends IBaseDao<Requirement, Integer>{
	public List<Requirement> getRequirement();
}
