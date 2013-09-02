package com.nb.nbpx.server.course;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.solr.ISolrSubjectService;

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
		
		return SUCCESS;
	}
	
	public String getRelatedKeyWords(){
		try {
			String result = solrKeywordService.queryRelatedKeywords(condition, 0, 10);
			this.inputStream = castToInputStream(result);
		} catch (SolrServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return SUCCESS;
	}
	
	public String getRelatedSubjects(){
		try {
			String result = solrSubjectService.queryRelatedSubject(condition, 0, 10);
			this.inputStream = castToInputStream(result);
		} catch (SolrServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

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
