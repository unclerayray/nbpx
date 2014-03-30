/**
 * 
 */
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
import com.nb.nbpx.pojo.wenda.Question;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrQuestionService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.SolrUtil;
/**
 * @author Roger
 * @date 2014年3月9日
 */
@Component("SolrQuestionService")
public class SolrQuestionServiceImpl extends BaseServiceImpl implements
		ISolrQuestionService {

	@Override
	public void addQuestion2Solr(Question question) {
		String serverURL;
		try {
			serverURL = SolrUtil.getQuestionServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("questionId", question.getQuestionId());
			sid.addField("title", question.getTitle());
			sid.addField("content", question.getContent());
			solrServer.add(sid);
            solrServer.commit();
            logger.debug("已成功为插入的提问创建索引");
		} catch (IOException e) {
			logger.error("未能取得提问的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit为成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}

	@Override
	public void addQuestions2Solr(List<Question> questionList) {

	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String queryRelatedQuestion(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		if(q==null){
			throw new NbpxException("查询关键词不能为空。");
		}
		String json = "";
		String serverURL = SolrUtil.getQuestionServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		q = SolrUtil.escapeQueryChars(q);
		q = "title_content:"+q;
		params.set("q", q);
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
		json = JsonUtil.formatToJsonWithTimeStamp(numFound,
				ResponseStatus.SUCCESS, "", list);
		return json;
	}

	@Override
	public void removeQuestionFromSolr(Integer questionId)
			throws SolrServerException, IOException {
		String serverURL = SolrUtil.getQuestionServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		solrServer.deleteById(questionId+"");
		solrServer.commit();		
	}

}
