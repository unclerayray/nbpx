package com.nb.nbpx.service.solr;

import java.util.List;

import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.IBaseService;

/**
 * 关键词连接SORL索引的service
 * @author Roger
 * @date 2013年8月17日
 */
public interface ISolrKeywordService extends IBaseService {
	public void addKeyword2Solr(Keyword keyword);
	public void addKeywords2Solr(List<Keyword> keywordList);
}
