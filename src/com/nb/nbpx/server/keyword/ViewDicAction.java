package com.nb.nbpx.server.keyword;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.system.IDictionaryService;
import com.nb.nbpx.utils.JsonUtil;

/**
 * @author Roger
 * @date 2013年7月26日
 */
@Component("ViewDicAction")
@Scope("prototype")
public class ViewDicAction extends BaseAction {

	public String codeName;
	@Resource
	public IKeywordService keywordService;
	@Resource
	public ISolrKeywordService solrKeywordService;
	@Resource
	public IDictionaryService dictionaryService;

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	public String getMoreDicItems(){
		String json = "";
		json = dictionaryService.queryDic(codeName, null, rows, this.getStartPosi(), null, null);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	//查询type名字
	public String getDicName(){
		String json = "";
		json = dictionaryService.getDic(codeName, null);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
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
	public IDictionaryService getDictionaryService() {
		return dictionaryService;
	}

	public void setDictionaryService(IDictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}


}
