package com.nb.nbpx.service.solr.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
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
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.service.solr.IBaseSolrService;
import com.nb.nbpx.service.solr.ISolrSubjectService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.SolrUtil;
@Component("SolrSubjectService")
public class SolrSubjectServiceImpl implements ISolrSubjectService{


	public static Logger log = LogManager.getLogger(SolrSubjectServiceImpl.class);
	
	@Override
	public void addSubject2Solr(Subject subject) {
		String serverURL;
		try {
			serverURL = SolrUtil.getSubjectServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("subjectId", subject.getSubjectId());
			sid.addField("subject", subject.getSubject());
			//SolrQuery query = new SolrQuery();
			//query.addFilterQuery("keyId:"+keyword.getKeyId());
			//QueryResponse rsp = solrServer.query(query);
			//rsp.getResponse().get("numFound");
			solrServer.add(sid);
            solrServer.commit();
            log.debug("已成功为插入的专题创建索引");
		} catch (IOException e) {
			log.error("未能取得专题的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			log.error("commit为成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}

	@Override
	public void addSubjects2Solr(List<Subject> subjectList) {
		List<SolrInputDocument> documents = new ArrayList<SolrInputDocument>();
		String serverURL;
		try {
			serverURL = SolrUtil.getSubjectServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			for(Subject subject:subjectList){
				SolrInputDocument sid = new SolrInputDocument();
				sid.addField("subjectId", subject.getSubjectId());
				sid.addField("subject", subject.getSubject());
				documents.add(sid);
			}
			solrServer.add(documents);
	        solrServer.commit();
	        log.debug("已成功为插入的专题创建索引");
		} catch (IOException e) {
			log.error("未能取得专题的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			log.error("commit未成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}

	@Override
	public String queryRelatedSubject(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		if(q==null){
			throw new NbpxException("查询专题不能为空。");
		}
		String json = "";
		String serverURL = SolrUtil.getSubjectServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);
		q = "subject:"+q;
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
		List<Subject> resultList = new ArrayList<Subject>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object subjectIdobj = sd.getFieldValue("subjectId");
			Object subjectobj = sd.getFieldValue("subject");
			if(subjectIdobj==null){
				continue;
			}
			Subject subject = new Subject();
			subject.setSubjectId((Integer)subjectIdobj);
			subject.setSubject(subjectobj.toString());
			resultList.add(subject);
		}
		json = JsonUtil.formatToJsonWithTimeStamp(numFound,
				ResponseStatus.SUCCESS, "", list);
		return json;
	}

	@Override
	public void removeSubjectFromSolr(Integer subjectId)
			throws SolrServerException, IOException {
		String serverURL = SolrUtil.getSubjectServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		solrServer.deleteById(subjectId+"");
		solrServer.commit();
	}

}
