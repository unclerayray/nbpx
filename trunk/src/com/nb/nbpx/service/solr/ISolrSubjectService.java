package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

/**
 * 专题连接SORL索引的service
 * @author Roger
 * @date 2013年8月17日
 */
public interface ISolrSubjectService extends IBaseService {
	public void addSubject2Solr(Subject subject);
	public void addSubjects2Solr(List<Subject> subjectList);
	public String queryRelatedSubject(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
}
