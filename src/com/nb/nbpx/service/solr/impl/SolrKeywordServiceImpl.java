package com.nb.nbpx.service.solr.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.common.SolrInputDocument;
import org.springframework.stereotype.Component;

import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrKeywordService;
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

}
