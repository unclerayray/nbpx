package com.nb.nbpx.server.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.user.IOrgInfoService;

@Component("OrgInfoAction")
@Scope("prototype")
public class OrgInfoAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	public OrgInfo orgInfor;
	public Integer userId;
	
	private IOrgInfoService orgInfoService;
	
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
		String json = "";
		try {

			json = orgInfoService.saveOrgInfor(orgInfor);
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
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

	public IOrgInfoService getOrgInfoService() {
		return orgInfoService;
	}
	
	@Resource
	public void setOrgInfoService(IOrgInfoService orgInfoService) {
		this.orgInfoService = orgInfoService;
	}

	
}
