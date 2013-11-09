package com.nb.nbpx.dao.course;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.Application;

public interface IApplicationDao extends IBaseDao<Application,Integer>{
	public List<Application> queryApplications(Integer limit,
			Integer start, String sort, String order,Boolean confirmed,Boolean follow);
	public Long queryApplicationCount(Boolean confirmed,Boolean follow);
}
