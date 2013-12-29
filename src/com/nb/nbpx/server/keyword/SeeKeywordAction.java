package com.nb.nbpx.server.keyword;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.service.solr.ISolrSubjectService;
import com.nb.nbpx.service.system.IDictionaryService;
import com.nb.nbpx.utils.JsonUtil;

/**
 * @author Roger
 * @date 2013年7月26日
 */
@Component("SeeKeywordAction")
@Scope("prototype")
public class SeeKeywordAction extends BaseAction {

    public String key;
	@Resource
	public IKeywordService keywordService;
	@Resource
	public ISolrKeywordService solrKeywordService;
	@Resource
	public ISolrSubjectService solrSubjectService;
	@Resource
	public ISolrService solrService;
	@Resource
	public IDictionaryService dictionaryService;


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	//solr查询相关关键词
	public String getRelatedKeys(){
		try {
			String result = solrKeywordService.queryRelatedKeywords(key, 0, 12);
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
	
	//solr查询相关专题
	public String getRelatedSubejcts(){
		try {
			String result = solrSubjectService.queryRelatedSubject(key, 0, 12);
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
	
	//solr查询相关培训课程
	public String getRelatedCourses(){
		String json;
		try {
			json = solrService.fullTextQueryForHl(key, getStartPosi(), rows);
			this.inputStream = castToInputStream(json);
		} catch (SolrServerException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) throws UnsupportedEncodingException {
		if(key != null)
			key = new String(key.getBytes("iso-8859-1"),"utf-8");
		this.key = key;
	}

	public IKeywordService getKeywordService() {
		return keywordService;
	}

	public void setKeywordService(IKeywordService keywordService) {
		this.keywordService = keywordService;
	}

	public ISolrKeywordService getSolrKeywordService() {
		return solrKeywordService;
	}

	public void setSolrKeywordService(ISolrKeywordService solrKeywordService) {
		this.solrKeywordService = solrKeywordService;
	}
	
	public ISolrSubjectService getSolrSubjectService() {
		return solrSubjectService;
	}
	public void setSolrSubjectService(ISolrSubjectService solrSubjectService) {
		this.solrSubjectService = solrSubjectService;
	}
	
	public ISolrService getSolrService() {
		return solrService;
	}

	public void setSolrService(ISolrService solrService) {
		this.solrService = solrService;
	}


	public IDictionaryService getDictionaryService() {
		return dictionaryService;
	}

	public void setDictionaryService(IDictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}
}
