package com.nb.nbpx.service.solr;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.user.TeacherInfo;

public interface ISolrTeacherService {
	public void addTeacher2Solr(TeacherInfo teacher);
	public void removeTeacherInfoFromSolr(Integer teacherId) throws SolrServerException, IOException;
	public String queryRelateTeacher(String q, Integer start, Integer rows);
}
