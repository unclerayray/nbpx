package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.utils.NbpxException;

public interface ISolrTeacherService {
	public void addTeacher2Solr(TeacherInfo teacher);
	public void removeTeacherInfoFromSolr(Integer teacherId) throws SolrServerException, IOException;
	/**
	 * 查找相关的老师，用于提示与小模块
	 * @param q 拼音，人名或者关键词
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public String queryRelateTeacher(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException ;
	
	/**
	 * 查找相关的老师，用于提示与小模块
	 * @param q 拼音，人名或者关键词
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public List<Keyword> queryTipTeacher(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException ;
	
	/**
	 * 查找相关的老师，用于提示与小模块
	 * @param q 拼音，人名或者关键词
	 * @param start
	 * @param rows
	 * @return [List of teacher]
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public List<TeacherInfo> queryRelateTeacherList(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException ;
	public String queryTeacherBySolr(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException ;
	public void removeTeacherFromSolr(Integer teacherId) throws SolrServerException, IOException;
}
