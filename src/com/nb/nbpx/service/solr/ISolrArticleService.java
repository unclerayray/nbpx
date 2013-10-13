package com.nb.nbpx.service.solr;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.service.IBaseService;

public interface ISolrArticleService extends IBaseService  {
	public void addArticle2Solr(ArticleDetail artiDetail);
	public void updateArticleInfo2Solr(Integer articleId) throws IOException, SolrServerException ;
}
