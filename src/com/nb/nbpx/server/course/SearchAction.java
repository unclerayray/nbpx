package com.nb.nbpx.server.course;

import java.io.IOException;

import javax.annotation.Resource;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.solr.ISolrOrganisationService;
import com.nb.nbpx.service.solr.ISolrQuestionService;
import com.nb.nbpx.service.solr.ISolrService;

/**
 * @author Roger
 * @date 2013年8月24日
 */
@Component("SearchAction")
@Scope("prototype")
public class SearchAction  extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ISolrService solrService;
	private ISolrQuestionService solrQuestionService;
	private ISolrOrganisationService solrOrganisationService;
	private String key;
	private String q;

	/**
	 * 【公开课】用solr全文搜索
	 * @return
	 */
	public String queryBySolr(){
		String json;
		try {
			json = solrService.fullTextQueryForHl(key, getStartPosi(), rows);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	/**
	 * 【内训课】用solr全文搜索
	 * @return
	 */
	public String queryInnerCourseBySolr(){
		String json;
		try {
			json = solrService.fullTextQueryForHlInnerCourse(key, getStartPosi(), rows);
			this.inputStream = castToInputStream(json);
		} catch (SolrServerException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 【提问】用solr全文搜索
	 * @return
	 */
	public String queryQuestionBySolr(){
		String json;
		try {
			json = solrQuestionService.queryRelatedQuestion(key, getStartPosi(), rows);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	/**
	 * 【机构】用solr全文搜索
	 * @return
	 */
	public String queryOrganisationBySolr(){
		String json;
		try {
			json = solrOrganisationService.queryRelatedOrganisation(key, getStartPosi(), rows);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	
	public String queryKeywordsByKeyword(){
		String json;
		try {
			json = solrService.queryKeywordsByKeyword(q, 0, 10);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public ISolrService getSolrService() {
		return solrService;
	}

	@Resource
	public void setSolrService(ISolrService solrService) {
		this.solrService = solrService;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}


	public String getQ() {
		return q;
	}


	public void setQ(String q) {
		this.q = q;
	}

	public ISolrQuestionService getSolrQuestionService() {
		return solrQuestionService;
	}

	@Resource
	public void setSolrQuestionService(ISolrQuestionService solrQuestionService) {
		this.solrQuestionService = solrQuestionService;
	}

	public ISolrOrganisationService getSolrOrganisationService() {
		return solrOrganisationService;
	}

	@Resource
	public void setSolrOrganisationService(
			ISolrOrganisationService solrOrganisationService) {
		this.solrOrganisationService = solrOrganisationService;
	}
}
