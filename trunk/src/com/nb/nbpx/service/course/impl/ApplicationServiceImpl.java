package com.nb.nbpx.service.course.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.course.IApplicationDao;
import com.nb.nbpx.pojo.course.Application;
import com.nb.nbpx.service.course.IApplicationService;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.utils.JsonUtil;

@Component("ApplicationService")
public class ApplicationServiceImpl  extends BaseServiceImpl implements IApplicationService{
	private IApplicationDao applicationDao;
	private JdbcTemplate jdbcTemplate;
	@Resource
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public IApplicationDao getApplicationDao() {
		return applicationDao;
	}

	@Resource
	public void setApplicationDao(IApplicationDao applicationDao) {
		this.applicationDao = applicationDao;
	}

	@Override
	public String queryApplications(Integer rows,
			Integer start, String sort, String order, Boolean confirmed, Boolean follow) {
		String json = "";
		List<Application> list= applicationDao.queryApplications(rows, start, sort, order, confirmed, follow);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = applicationDao.queryApplicationCount(confirmed, follow)
					.intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}

	@Override
	public void confirmApplication(Integer id)  throws Exception{
		Map<String, Object> propsMap = new HashMap<String, Object>();
		propsMap.put("confirmed", true);
		applicationDao.updateWithPK(Application.class, id, propsMap);
	}

	@Override
	public void followApplication(Integer id, String stateInfo)  throws Exception{

		Map<String, Object> propsMap = new HashMap<String, Object>();
		if (stateInfo != null) {
			propsMap.put("stateInfo", stateInfo);
		}
		applicationDao.updateWithPK(Application.class, id, propsMap);
	}
}
