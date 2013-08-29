package com.nb.nbpx.service.solr.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.SolrUtil;
@Component("SolrKeywordService")
public class SolrKeywordServiceImpl extends BaseServiceImpl implements ISolrKeywordService{

	@Override
	public void addKeyword2Solr(Keyword keyword) {
		String serverURL;
		try {
			serverURL = SolrUtil.getKeywordServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("keyId", keyword.getKeyId());
			sid.addField("keyword", keyword.getKeyword());
			//SolrQuery query = new SolrQuery();
			//query.addFilterQuery("keyId:"+keyword.getKeyId());
			//QueryResponse rsp = solrServer.query(query);
			//rsp.getResponse().get("numFound");
			solrServer.add(sid);
            solrServer.commit();
            logger.debug("已成功为插入的关键词创建索引");
		} catch (IOException e) {
			logger.error("未能取得关键词的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit为成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}

	@Override
	public void addKeywords2Solr(List<Keyword> keywordList) {
		List<SolrInputDocument> documents = new ArrayList<SolrInputDocument>();
		String serverURL;
		try {
			serverURL = SolrUtil.getKeywordServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			for(Keyword keyword:keywordList){
				SolrInputDocument sid = new SolrInputDocument();
				sid.addField("keyId", keyword.getKeyId());
				sid.addField("keyword", keyword.getKeyword());
				documents.add(sid);
			}
			solrServer.add(documents);
	        solrServer.commit();
	        logger.debug("已成功为插入的关键词创建索引");
		} catch (IOException e) {
			logger.error("未能取得关键词的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit未成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}

	@Override
	public String queryRelatedKeywords(String q, Integer start, Integer rows)
			throws SolrServerException, IOException {
		String json = "";
		String serverURL = SolrUtil.getKeywordServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);
		q = "keyword:"+q;
		params.set("q", q);
		if(start!=null){
			params.set("start", start);
		}
		if(rows!=null){
			params.set("rows", rows);
		}
		query.set("qt", "select");
		QueryResponse response = solrServer.query(query);
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		SolrDocumentList list = response.getResults();
		List<Keyword> resultList = new ArrayList<Keyword>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object keyIdobj = sd.getFieldValue("keyId");
			Object keywordobj = sd.getFieldValue("keyword");
			if(keywordobj==null){
				continue;
			}
			Keyword keyword = new Keyword();
			keyword.setKeyId((Integer) keyIdobj);
			keyword.setKeyword(keywordobj.toString());
			resultList.add(keyword);
		}
		json = JsonUtil.formatToJsonWithTimeStamp(numFound,
				ResponseStatus.SUCCESS, "", list);
		return json;
	}

}
