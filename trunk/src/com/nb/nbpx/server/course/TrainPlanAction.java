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

@Component("TrainPlanAction")
@Scope("prototype")
public class TrainPlanAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	private ICourseService courseService;
	private ISolrKeywordService solrKeywordService;
	private ISolrSubjectService solrSubjectService;
	
	//获取培训计划的内容
	public String getTrainPlanInfo(){
		String resultStr = courseService.getTranPlan(rows, this.getStartPosi());
		this.inputStream = castToInputStream(resultStr);
		
		return SUCCESS;
	}
	//获取培训计划相关关键词
	public String getPlanRelatedKeyWords(){
		try {
			String result = solrKeywordService.queryRelatedKeywords("培训计划", 0, 30);
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
	
	//获取培训计划相关专题
	public String getPlanRelatedSubjects(){
		try {
			String result = solrSubjectService.queryRelatedSubject("企业计划", 0, 30);
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
