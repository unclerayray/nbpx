package com.nb.nbpx.service.course.impl;
import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import com.nb.nbpx.dao.course.ICourseApplyDao;
import com.nb.nbpx.pojo.course.CourseApply;
import com.nb.nbpx.service.course.ICourseApplyService;
import com.nb.nbpx.service.impl.BaseServiceImpl;

@Component("CourseApplyService")
public class CourseApplyServiceImpl extends BaseServiceImpl implements ICourseApplyService{
	
	private ICourseApplyDao courseApplyDao;
	private JdbcTemplate jdbcTemplate;

	@Resource
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	@Override
	public void saveCourseApply(CourseApply courseApply){
		if(courseApply.getApplyID()==null){
			courseApplyDao.save(courseApply);//新增用户
		}else{
			courseApplyDao.saveOrUpdate(courseApply);//修改用户
		}
	}
	public ICourseApplyDao getCourseApplyDao() {
		return courseApplyDao;
	}
	
	@Resource
	public void setCourseApplyDao(ICourseApplyDao courseApplyDao) {
		this.courseApplyDao = courseApplyDao;
	}

	
}
