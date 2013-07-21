package com.nb.nbpx.server.solr;

import java.io.IOException;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.utils.JsonUtil;

/**
 * @author Roger
 * @date 2013年7月21日
 */
@Component("SolrAction")
@Scope("prototype")
public class SolrAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public String textToCut;
	public ISolrService solrservice;
	
	public String cutText(){
		String json = "";
		try {
			json = solrservice.cutText(textToCut);
		} catch (IOException e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.QUERY_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String getTextToCut() {
		return textToCut;
	}

	public void setTextToCut(String textToCut) {
		this.textToCut = textToCut;
	}

	public ISolrService getSolrservice() {
		return solrservice;
	}

	@Resource
	public void setSolrservice(ISolrService solrservice) {
		this.solrservice = solrservice;
	}
}
