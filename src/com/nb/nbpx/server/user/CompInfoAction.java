package com.nb.nbpx.server.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.ICompInfoDao;
import com.nb.nbpx.pojo.user.CompInfo;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.user.ICompInfoService;
import com.nb.nbpx.utils.JsonUtil;

@Component("CompInfoAction")
@Scope("prototype")
public class CompInfoAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	public CompInfo compInfo;
	public Integer userId;
	public String q_userName;
	public String q_company;
	public Integer compInfoId;
	public String state;

	private ICompInfoService compInfoService;
	private ICompInfoDao compInfoDao;

	public String getCompInforByUserId() {
		String json = "";
		try {

			json = compInfoService.getCompInfoByUserId(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String saveCompInfor() {
		try {
			CompInfo info = compInfoDao.get(compInfo.getCompInfoId());
			info.setCompany(compInfo.getCompany());
			info.setContact(compInfo.getContact());
			info.setDepartment(compInfo.getDepartment());
			info.setTelephone(compInfo.getTelephone());
			info.setFax(compInfo.getFax());
			info.setCellphone(compInfo.getCellphone());
			compInfoService.saveCompInfor(info);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}

	public String queryCompInfo() {
		String json = "";
		try {
			json = compInfoService.queryCompInfo(q_userName, q_company,
					rows, getStartPosi(), sort, order);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String auditCompInfo(){
		String msg = "已激活！";
		try {
			CompInfo compinfo = compInfoDao.get(compInfoId);
			compinfo.setState(!compinfo.getState());
			compInfoService.saveCompInfor(compinfo);
			if(compinfo.getState()){
				msg = "已锁定！";
			}
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"激活/锁定 失败！" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, msg));
		return SUCCESS;
	}

	public CompInfo getCompInfo() {
		return compInfo;
	}

	public void setCompInfo(CompInfo compInfo) {
		this.compInfo = compInfo;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public ICompInfoService getCompInfoService() {
		return compInfoService;
	}

	@Resource
	public void setCompInfoService(ICompInfoService compInfoService) {
		this.compInfoService = compInfoService;
	}

	public ICompInfoDao getCompInfoDao() {
		return compInfoDao;
	}
	@Resource
	public void setCompInfoDao(ICompInfoDao compInfoDao) {
		this.compInfoDao = compInfoDao;
	}

	public String getQ_userName() {
		return q_userName;
	}

	public void setQ_userName(String q_userName) {
		this.q_userName = q_userName;
	}

	public String getQ_company() {
		return q_company;
	}

	public void setQ_company(String q_company) {
		this.q_company = q_company;
	}

	public Integer getCompInfoId() {
		return compInfoId;
	}

	public void setCompInfoId(Integer compInfoId) {
		this.compInfoId = compInfoId;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
}