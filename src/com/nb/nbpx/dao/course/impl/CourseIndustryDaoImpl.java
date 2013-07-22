package com.nb.nbpx.dao.course.impl;

import javax.annotation.Resource;

import com.nb.nbpx.dao.course.ICourseIndustryDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.pojo.course.CourseIndustry;
import com.nb.nbpx.pojo.system.Dictionary;

public class CourseIndustryDaoImpl extends BaseDaoImpl<CourseIndustry, Integer> implements ICourseIndustryDao{

	private IDictionaryDao dicDao;
	
	@Override
	public CourseIndustry saveCourseIndustry(CourseIndustry courseIndustry) {
		if(courseIndustry.getIndustry()==null){
			Dictionary dic = dicDao.getDictionary(courseIndustry.industryCode,null);
			courseIndustry.setIndustry(dic.getShowName());
		}
		save(courseIndustry);
		return courseIndustry;
	}

	public IDictionaryDao getDicDao() {
		return dicDao;
	}

	@Resource
	public void setDicDao(IDictionaryDao dicDao) {
		this.dicDao = dicDao;
	}

}
