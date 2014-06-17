package com.nb.nbpx.server.course;

import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.solr.ISolrSubjectService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.mapTool.MapTool;

/**
 * @author Roger
 * @date 2013年11月6日
 */
@Component("ViewClassAction")
@Scope("prototype")
public class ViewClassAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	private ICourseService courseService;
	private ISolrKeywordService solrKeywordService;
	private ISolrSubjectService solrSubjectService;
	public String id;//课程ID
	public String condition;//查询条件
	

	//查看课程信息
	public String ViewClass(){
		String result = courseService.viewCourse(id);
		this.inputStream = castToInputStream(result);
		try{
			Integer intId = Integer.parseInt(id);
			MapTool.addcoursesHit(intId);
		}catch (Exception e){
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String getRelatedKeyWords(){
		try {
			String result = solrKeywordService.queryRelatedKeywords(condition, 0, 10);
			//TODO 貌似这个地方有个编码问题导致查询不到
			//这是因为传进来的值是编码有问题
			this.inputStream = castToInputStream(result);
		} catch (Exception e) {
			e.printStackTrace();
		} 

		return SUCCESS;
	}
	

	//这种地方你要注意一下，如果拿不到result在异常里面返回失败就行了
	public String getRelatedSubjects(){
//		try {
//			String result = solrSubjectService.queryRelatedSubject(condition, 0, 10);
//			this.inputStream = castToInputStream(result);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return SUCCESS;
		
		String result = null;
		try {
			result = solrSubjectService.queryRelatedSubject(condition, 0, 10);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.QUERY_FAILED + e.getMessage()));
			return "failure";
		}

		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	public ICourseService getCourseService() {
		return courseService;
	}
	
	@Resource
	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) throws UnsupportedEncodingException {
		if(condition != null)
			condition = new String(condition.getBytes("iso-8859-1"),"utf-8");
		this.condition = condition;
	}
	public ISolrKeywordService getSolrKeywordService() {
		return solrKeywordService;
	}
	@Resource
	public void setSolrKeywordService(ISolrKeywordService solrKeywordService) {
		this.solrKeywordService = solrKeywordService;
	}
	public ISolrSubjectService getSolrSubjectService() {
		return solrSubjectService;
	}
	@Resource
	public void setSolrSubjectService(ISolrSubjectService solrSubjectService) {
		this.solrSubjectService = solrSubjectService;
	}

}
