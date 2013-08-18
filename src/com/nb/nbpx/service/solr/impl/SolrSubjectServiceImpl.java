package com.nb.nbpx.service.solr.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.common.SolrInputDocument;
import org.springframework.stereotype.Component;

import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrSubjectService;
import com.nb.nbpx.utils.SolrUtil;
@Component("SolrSubjectService")
public class SolrSubjectServiceImpl extends BaseServiceImpl implements ISolrSubjectService{

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
            logger.debug("已成功为插入的专题创建索引");
		} catch (IOException e) {
			logger.error("未能取得专题的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit为成功。"+e.getMessage());;
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
	        logger.debug("已成功为插入的专题创建索引");
		} catch (IOException e) {
			logger.error("未能取得专题的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit未成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}

}
