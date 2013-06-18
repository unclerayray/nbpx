package com.nb.nbpx.server.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.pojo.user.CompInfo;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.user.ICompInfoService;

@Component("CompInfoAction")
@Scope("prototype")
public class CompInfoAction  extends BaseAction {

	private static final long serialVersionUID = 1L;
	public CompInfo compInfo;
	public Integer userId;
	
	private ICompInfoService compInfoService;
	
	public String getCompInforByUserId(){
		String json = "";
		try {

			json = compInfoService.getCompInfoByUserId(userId);
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String saveCompInfor(){
		String json = "";
		try {

			json = compInfoService.saveCompInfor(compInfo);
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
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
}
