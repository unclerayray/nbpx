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
@Component("SubjectAction")
@Scope("prototype")
public class SubjectAction extends BaseAction  {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String category;
	public String subjectCombValue;
	public String subjectCombText;
	public Subject subject;
	public String subjectIds;
	public String subjects;
	public String allSubjects;
	@Resource
	public ISubjectService subjectService;
	
	public String querySubjects() {
		String json = "";
		try {
			if(subjectCombText!=null&&!subjectCombText.isEmpty()){
				json = subjectService.querySubjects(category, subjectCombText,
						null, rows, getStartPosi(),sort,order);
			}else{
				json = subjectService.querySubjects(category, null, null,
						rows, getStartPosi(),sort,order);
			}
			// TODO 模糊查询
		} catch (Exception e) {
			logger.debug(e.getStackTrace());
			this.inputStream = castToInputStream(JsonUtil.formatToJson(0, ResponseStatus.FAIL,
					ResponseStatus.QUERY_FAILED + e.getMessage(), null));
			return "failure";
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	

	public String saveSubjects(){
		String[] subjectIdArr = subjectIds.split(",");
		if(subjectService.saveRecommands(subjectIdArr)){
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.SUCCESS, "推荐成功！"));
			return SUCCESS;
		}else{
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, "推荐失败！"));
			return "failure";
		}
	}
	
	public String importSubjects(){
		String regEx="[`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]"; 
		String regEx1 = "[\\pP‘’“”]";
		subjects = subjects.replaceAll(regEx1, ",");
		String[] subjectsArr = subjects.split(",");
		List<String> list = new ArrayList<String>();
		
		//Remove Null Value from String array
	    for(String s : subjectsArr) {
	       if(s != null && s.length() > 0) {
	          list.add(s);
	       }
	    }
	    subjectsArr = list.toArray(new String[list.size()]);
		if(subjectService.importSubjects(category, subjectsArr)){
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.SUCCESS, "导入成功！"));
			return SUCCESS;
		}else{
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.SUCCESS, "导入成功！"));
			return "failure";
		}
	}

	/**
	 * 查询生成ComboBox的数据
	 * 
	 * @return
	 */
	public String queryComboSubjects() {
		String json = "";
		try {
			json = subjectService.queryComboSubjects(category);
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSubjectCombValue() {
		return subjectCombValue;
	}
	public void setSubjectCombValue(String subjectCombValue) {
		this.subjectCombValue = subjectCombValue;
	}
	public String getSubjectCombText() {
		return subjectCombText;
	}
	public void setSubjectCombText(String subjectCombText) {
		this.subjectCombText = subjectCombText;
	}
	public Subject getSubject() {
		return subject;
	}
	public void setSubject(Subject subject) {
		this.subject = subject;
	}
	public String getSubjectIds() {
		return subjectIds;
	}
	public void setSubjectIds(String subjectIds) {
		this.subjectIds = subjectIds;
	}
	public String getSubjects() {
		return subjects;
	}
	public void setSubjects(String subjects) {
		this.subjects = subjects;
	}
	public String getAllSubjects() {
		return allSubjects;
	}
	public void setAllSubjects(String allSubjects) {
		this.allSubjects = allSubjects;
	}
	public ISubjectService getSubjectService() {
		return subjectService;
	}
	public void setSubjectService(ISubjectService subjectService) {
		this.subjectService = subjectService;
	}
}
