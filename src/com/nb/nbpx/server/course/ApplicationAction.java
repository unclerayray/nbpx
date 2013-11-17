package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

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

	public String queryApplications() {
		String json = applicationService.queryApplications(rows,
				getStartPosi(), sort, order, confirmed, follow);
		//json = "{'total':'0','rows':[]}";
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
			applicationService.followApplication(applicationId, stateInfo);
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

}
