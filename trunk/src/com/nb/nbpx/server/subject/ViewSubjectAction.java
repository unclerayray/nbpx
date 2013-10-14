package com.nb.nbpx.server.subject;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.subject.ISubjectService;
import com.nb.nbpx.utils.JsonUtil;
/**
 * @author Roger
 * @date 2013年8月18日
 */
@Component("ViewSubjectAction")
@Scope("prototype")
public class ViewSubjectAction extends BaseAction  {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public String category;
	public String isInner;


	@Resource
	public ISubjectService subjectService;
	
	public String getSubjectsByCategory(){
		Boolean isInnerFlag = false;
		if("1".equals(isInner))//
			isInnerFlag = true;
		String resultStr = subjectService.getSubjectsListByCategory(isInnerFlag, category, 0, 30);
		
		this.inputStream = castToInputStream(resultStr);
		return SUCCESS;
	}
	//根据行业-1、职位-2、产品-3、专业-4获取专题，type
	public String getSubjectsByOthers(){
		Boolean isInnerFlag = false;
		if("1".equals(isInner))//
			isInnerFlag = true;
		String resultStr = subjectService.getSubjectsListByOthers(isInnerFlag, category, 0, 30);
		
		this.inputStream = castToInputStream(resultStr);
		return SUCCESS;
	}
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getIsInner() {
		return isInner;
	}
	public void setIsInner(String isInner) {
		this.isInner = isInner;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public ISubjectService getSubjectService() {
		return subjectService;
	}
	public void setSubjectService(ISubjectService subjectService) {
		this.subjectService = subjectService;
	}
}
