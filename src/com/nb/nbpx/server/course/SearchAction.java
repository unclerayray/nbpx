package com.nb.nbpx.server.course;

import java.io.IOException;

import javax.annotation.Resource;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
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
	private String key;

	public String queryBySolr(){
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
}
