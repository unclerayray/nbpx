package com.nb.nbpx.service.solr;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.utils.NbpxException;

public interface ISolrArticleService extends IBaseSolrService{
	public void addArticle2Solr(ArticleDetail artiDetail);
	public String queryRelatedArticles(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	public void updateArticleInfo2Solr(Integer articleId) throws IOException, SolrServerException ;
	public void removeArticleFromSolr(Integer articleId) throws SolrServerException, IOException;
}
