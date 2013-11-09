package com.nb.nbpx.service.course.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.course.IRequirementDao;
import com.nb.nbpx.pojo.course.Requirement;
import com.nb.nbpx.service.course.IRequirementService;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.daotool.Equality;

@Component("RequirementService")
public class RequirementServiceImpl extends BaseServiceImpl implements IRequirementService{
	
	private IRequirementDao requirementDao;
	private JdbcTemplate jdbcTemplate;
	@Resource
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

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

	@Override
	public String queryRequirements(Integer hasReplied, Integer rows, Integer start,
			String sort, String order) {
		String json = "";
		Map<String, Object> propsMap = this.createPropMap(new Equality(
				"hasReplied", hasReplied));
		List<Requirement> list= requirementDao.queryEntityListByProperties(Requirement.class, rows, start, sort, order, propsMap);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = requirementDao.queryTotalCount(Requirement.class, propsMap)
					.intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}

	@Override
	public void replyRequirement(Integer requirementId, String reply) {
		jdbcTemplate.update("UPDATE requirements SET reply = ? and hasReplied = ? WHERE requirementId = ?", new Object[] {reply, true, requirementId}); 
	}
}
