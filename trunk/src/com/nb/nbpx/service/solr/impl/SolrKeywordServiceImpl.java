package com.nb.nbpx.service.solr.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
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
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.PinYinUtil;
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
			if(keyword.getKeyword()!=null){
				List<String> pinyinList = PinYinUtil.getPinYinList(keyword.getKeyword());
				for(String str:pinyinList){
					sid.addField("pinyin", str);
				}
				sid.addField("kwfreq", 23);
			}
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
				if(keyword.getKeyword()!=null){
					List<String> pinyinList = PinYinUtil.getPinYinList(keyword.getKeyword());
					for(String str:pinyinList){
						sid.addField("pinyin", str);
					}
					sid.addField("kwfreq", 23);
				}
				
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

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String queryRelatedKeywords(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		if(q==null){
			throw new NbpxException("查询关键词不能为空。");
		}
		String json = "";
		String serverURL = SolrUtil.getKeywordServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);

		params.set("q", q);
		query.set("echoParams", "explicit");
		query.set("df", "keyword,pinyin");
		query.set("mlt.qf", "pinyin^10.0 keyword^10.0");
		query.set("defType", "edismax");
		query.set("pf", "keyword pinyin");
		query.set("qf", "keyword^10.0 pinyin^1.0");
		//q = "keyword:"+q;
		if(start!=null){
			params.set("start", start);
		}
		if(rows!=null){
			params.set("rows", rows);
		}
		query.set("qt", "select");
		query.add(params);
		QueryResponse response = solrServer.query(query);
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		SolrDocumentList list = response.getResults();
		List<Keyword> resultList = new ArrayList<Keyword>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object keywordobj = sd.getFieldValue("keyword");
			if(keywordobj==null){
				continue;
			}
			Keyword keyword = new Keyword();
			keyword.setKeyword(keywordobj.toString());
			resultList.add(keyword);
		}
		/**
		 * 以下为去重的代码
		 */
		HashSet hs = new HashSet();
		hs.addAll(resultList);
		resultList.clear();
		resultList.addAll(hs);
		json = JsonUtil.formatListToJson(resultList);
		return json;
	}

	@Override
	public void removeKeywordFromSolr(Integer keywordId)
			throws SolrServerException, IOException {
		String serverURL = SolrUtil.getKeywordServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		solrServer.deleteById(keywordId+"");
		solrServer.commit();
	}

	@Override
	public List<Keyword> queryRelatedKeywordsList(String q, Integer start,
			Integer rows) throws SolrServerException, IOException,
			NbpxException {
		if(q==null){
			throw new NbpxException("查询关键词不能为空。");
		}
		String json = "";
		String serverURL = SolrUtil.getKeywordServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);

		params.set("q", q);
		query.set("echoParams", "explicit");
		query.set("df", "keyword,pinyin");
		query.set("mlt.qf", "pinyin^10.0 keyword^10.0");
		query.set("defType", "edismax");
		query.set("pf", "keyword pinyin");
		query.set("qf", "keyword^10.0 pinyin^1.0");
		//q = "keyword:"+q;
		if(start!=null){
			params.set("start", start);
		}
		if(rows!=null){
			params.set("rows", rows);
		}
		query.set("qt", "select");
		query.add(params);
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
		/**
		 * 以下为去重的代码
		 */
		HashSet hs = new HashSet();
		hs.addAll(resultList);
		resultList.clear();
		resultList.addAll(hs);
		return resultList;
	}

	@Override
	public List<Keyword> queryTipKeywords(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		if(q==null){
			throw new NbpxException("查询关键词不能为空。");
		}
		String serverURL = SolrUtil.getKeywordServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);

		params.set("q", q);
		query.set("echoParams", "explicit");
		query.set("df", "keyword,pinyin");
		query.set("mlt.qf", "pinyin^10.0 keyword^10.0");
		query.set("defType", "edismax");
		query.set("pf", "keyword pinyin");
		query.set("qf", "keyword^10.0 pinyin^1.0");
		//q = "keyword:"+q;
		if(start!=null){
			params.set("start", start);
		}
		if(rows!=null){
			params.set("rows", rows);
		}
		query.set("qt", "select");
		query.add(params);
		QueryResponse response = solrServer.query(query);
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		SolrDocumentList list = response.getResults();
		List<Keyword> resultList = new ArrayList<Keyword>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object keywordobj = sd.getFieldValue("keyword");
			if(keywordobj==null){
				continue;
			}
			Keyword keyword = new Keyword();
			keyword.setKeyword(keywordobj.toString());
			resultList.add(keyword);
		}
		/**
		 * 以下为去重的代码
		 */
		HashSet hs = new HashSet();
		hs.addAll(resultList);
		resultList.clear();
		resultList.addAll(hs);
		return resultList;
	}

}
