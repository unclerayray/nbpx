package com.nb.nbpx.service.solr;

import java.util.List;

import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.service.IBaseService;

/**
 * 专题连接SORL索引的service
 * @author Roger
 * @date 2013年8月17日
 */
public interface ISolrSubjectService extends IBaseService {
	public void addSubject2Solr(Subject subject);
	public void addSubjects2Solr(List<Subject> subjectList);
}
