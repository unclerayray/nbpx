package com.nb.nbpx.server.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.IOrgInfoDao;
import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.solr.ISolrOrganisationService;
import com.nb.nbpx.service.user.IOrgInfoService;
import com.nb.nbpx.utils.JsonUtil;

@Component("OrgInfoAction")
@Scope("prototype")
public class OrgInfoAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	public OrgInfo orgInfor;
	public Integer userId;
	public String q_userName;
	public String q_orgName;
	public Integer orgId;
	public boolean state;
	
	private IOrgInfoService orgInfoService;
	private IOrgInfoDao orgInfoDao;
	private ISolrOrganisationService orgSolrService;
	
	public String getOrgInforByID(){
		String json = "";	 
		json = orgInfoService.getOrgInfoById(orgId);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	//获取培训机构列表
	public String getOrgList(){
		String json = "";
		json = orgInfoService.getOrgInfo("1", rows, getStartPosi());

		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
		
	public String getOrgInforByUserId(){
		String json = "";
		try {
			json = orgInfoService.getOrgInfoByUserId(userId);
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	

	public String saveOrgInfor(){
		try {
			if(orgInfor.getOrgId()==null){
				orgInfor.setCreateBy(getSessionUserName());
			}
			if(orgInfor.getState()==null){
				orgInfor.setState(false);
			}
			orgInfoService.saveOrgInfor(orgInfor);
			orgSolrService.addOrganisation2Solr(orgInfor);
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
	
	
	public String saveOrgInfor_bak(){
		String json = "";
		try {
			OrgInfo oi = orgInfoDao.get(orgInfor.getOrgId());
			oi.setAddress(orgInfor.getAddress());
			oi.setCategory(orgInfor.getCategory());
			oi.setCellphone(orgInfor.getCellphone());
			oi.setContact(orgInfor.getContact());
			oi.setFax(orgInfor.getFax());
			oi.setIntroduction(orgInfor.getIntroduction());
			oi.setOrgName(orgInfor.getOrgName());
			oi.setPostCode(orgInfor.getPostCode());
			oi.setTelephone(orgInfor.getTelephone());
			oi.setWebsite(orgInfor.getWebsite());
			json = orgInfoService.saveOrgInfor(oi);
			orgSolrService.addOrganisation2Solr(oi);
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String queryOrgInfo(){
		String json = "";
		try {
			json = orgInfoService.queryOrgInfo(q_userName, q_orgName,
					rows, getStartPosi(), sort, order);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String auditOrgInfo(){
		String msg = "已激活！";
		try {
			orgInfoService.auditOrgInfo(orgId, state);;
			orgSolrService.audit(orgId,!state);
			if(state){
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
	

	public String deleteOrgInfor(){
		try {
			orgInfoService.deleteOrgInfo(orgId);
			orgSolrService.removeOrganisationFromSolr(orgId);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.DELETE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}

	
	public OrgInfo getOrgInfor() {
		return orgInfor;
	}

	public void setOrgInfor(OrgInfo orgInfor) {
		this.orgInfor = orgInfor;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getQ_userName() {
		return q_userName;
	}

	public void setQ_userName(String q_userName) {
		this.q_userName = q_userName;
	}

	public Integer getOrgId() {
		return orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}

	public String getQ_orgName() {
		return q_orgName;
	}

	public void setQ_orgName(String q_orgName) {
		this.q_orgName = q_orgName;
	}

	public IOrgInfoService getOrgInfoService() {
		return orgInfoService;
	}
	
	@Resource
	public void setOrgInfoService(IOrgInfoService orgInfoService) {
		this.orgInfoService = orgInfoService;
	}

	public IOrgInfoDao getOrgInfoDao() {
		return orgInfoDao;
	}

	@Resource
	public void setOrgInfoDao(IOrgInfoDao orgInfoDao) {
		this.orgInfoDao = orgInfoDao;
	}

	public ISolrOrganisationService getOrgSolrService() {
		return orgSolrService;
	}

	@Resource
	public void setOrgSolrService(ISolrOrganisationService orgSolrService) {
		this.orgSolrService = orgSolrService;
	}


	public boolean isState() {
		return state;
	}


	public void setState(boolean state) {
		this.state = state;
	}

	
}
