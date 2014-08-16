package com.nb.nbpx.server.course;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.QueryCriteria;
import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.IApplicationService;
import com.nb.nbpx.utils.JsonUtil;

@Component("ApplicationAction")
@Scope("prototype")
public class ApplicationAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public IApplicationService applicationService;
	public Boolean confirmed;
	public Boolean follow;
	public Integer applicationId;
	public String stateInfo;
	public String q_company;
	public String q_contact;
	public String q_course;
	public String q_department;

	public String queryApplications() {
		Map<String, Object> equalParamMap = new HashMap<String, Object>();
		Map<String, String> likeParamMap = new HashMap<String, String>();
		
		QueryCriteria qc = new QueryCriteria(rows,getStartPosi(),sort,order);
		qc.setEqualParamMap(equalParamMap);
		equalParamMap.put("confirmed", confirmed);
		equalParamMap.put("follow", follow);
		
		qc.setLikeParamMap(likeParamMap);
		likeParamMap.put("company", q_company);
		likeParamMap.put("contact", q_contact);
		likeParamMap.put("course", q_course);
		likeParamMap.put("department", q_department);
		
		//String json = applicationService.queryApplications(rows,
		//		getStartPosi(), sort, order, confirmed, follow,q_company,q_contact);
		String json = applicationService.queryWithCriteria(qc);
		//json = "{'total':'0','rows':[]}";
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	

	public String queryFollowups() {
		String json = applicationService.queryFollowups(applicationId);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String confirmApplication() {
		try {
			applicationService.confirmApplication(applicationId);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"确认报名失败" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, "成功确认报名"));
		return SUCCESS;
	}
	
	public String followApplication() {
		try {
			applicationService.followApplication(applicationId, stateInfo,super.getSessionUserName());
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"更新跟进情况失败" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, "更新跟进情况成功"));
		return SUCCESS;
	}

	public IApplicationService getApplicationService() {
		return applicationService;
	}

	@Resource
	public void setApplicationService(IApplicationService applicationService) {
		this.applicationService = applicationService;
	}

	public Boolean getConfirmed() {
		return confirmed;
	}

	public void setConfirmed(Boolean confirmed) {
		this.confirmed = confirmed;
	}

	public Boolean getFollow() {
		return follow;
	}

	public void setFollow(Boolean follow) {
		this.follow = follow;
	}

	public Integer getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(Integer applicationId) {
		this.applicationId = applicationId;
	}

	public String getStateInfo() {
		return stateInfo;
	}

	public void setStateInfo(String stateInfo) {
		this.stateInfo = stateInfo;
	}


	public String getQ_company() {
		return q_company;
	}


	public void setQ_company(String q_company) {
		this.q_company = q_company;
	}


	public String getQ_contact() {
		return q_contact;
	}


	public void setQ_contact(String q_contact) {
		this.q_contact = q_contact;
	}


	public String getQ_course() {
		return q_course;
	}


	public void setQ_course(String q_course) {
		this.q_course = q_course;
	}


	public String getQ_department() {
		return q_department;
	}


	public void setQ_department(String q_department) {
		this.q_department = q_department;
	}

}
