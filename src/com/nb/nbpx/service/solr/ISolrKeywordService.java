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
	public String queryRelatedKeywords(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	public void removeKeywordFromSolr(Integer keywordId) throws SolrServerException, IOException;
}
