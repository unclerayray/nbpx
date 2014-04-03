package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

/**
 * 关键词连接SORL索引的service
 * @author Roger
 * @date 2013年8月17日
 */
public interface ISolrKeywordService extends IBaseService {
	public void addKeyword2Solr(Keyword keyword);
	public void addKeywords2Solr(List<Keyword> keywordList);
	/**
	 * 以关键词搜索关键词，主要用于下拉框提醒
	 * @param q 拼音缩写或者关键词的部分
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public String queryRelatedKeywords(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	
	/**
	 * 以关键词搜索关键词，主要用于下拉框提醒
	 * @param q 拼音缩写或者关键词的部分
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public List<Keyword> queryTipKeywords(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	
	
	
	/**
	 * 以关键词搜索关键词，主要用于相关关键词查找[List]
	 * @param q 拼音缩写或者关键词的部分
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public List<Keyword> queryRelatedKeywordsList(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	public void removeKeywordFromSolr(Integer keywordId) throws SolrServerException, IOException;
}
