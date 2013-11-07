package com.nb.nbpx.service.solr.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.lucene.analysis.charfilter.HTMLStripCharFilter;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.client.solrj.util.ClientUtils;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrArticleService;
import com.nb.nbpx.utils.SolrUtil;
@Component("SolrArticleService")
public class SolrArticleServiceImpl extends BaseServiceImpl implements
		ISolrArticleService {

	@Override
	public void addArticle2Solr(ArticleDetail artiDetail) {
		String serverURL;
		try {
			serverURL = SolrUtil.getArticleServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("articleId", artiDetail.getArticleId());
			sid.addField("title", artiDetail.getArticleTitle());
			sid.addField("author", artiDetail.getAuthor());
			String contents = artiDetail.getContent();
			contents = stripHTMLX(contents);
			sid.addField("content", contents);
			String[] courseKeywords = artiDetail.getKeywords().split(",");
			String[] courseSubjects = artiDetail.getSubjects().split(",");
			for(String keyword:courseKeywords){
				sid.addField("keyword", keyword);
			}
			for(String subject:courseSubjects){
				sid.addField("subject", subject);
			}
			solrServer.add(sid);
            solrServer.commit();
            logger.debug("已成功为插入的课程创建索引");
		} catch (IOException e) {
			logger.error("未能取得课程的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit为成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}

	@Override
	public void updateArticleInfo2Solr(Integer articleId) throws IOException,
			SolrServerException {
		String serverURL = SolrUtil.getCourseServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		ModifiableSolrParams params = new ModifiableSolrParams();
		String q = "articleId:"+articleId;
		params.set("q", q);
		SolrQuery query = new SolrQuery();
		query.set("qt", "select");
		query.add(params);
		solrServer.ping();
		//TODO 判断连接 throw exception
		QueryResponse response = solrServer.query(query);
		System.out.println(response.getResponseHeader().get("pf"));
		SolrDocumentList list = response.getResults();
		SolrDocument doc = list.get(0);
		SolrInputDocument sid = ClientUtils.toSolrInputDocument(doc);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				
		solrServer.add(sid);
        solrServer.commit();
	}

	
	/**
	 * 清除课程内容中的HTML标签，并存入SOLR中
	 * @param value
	 * @return
	 */
	private String stripHTMLX(String value) { 
        StringBuilder out = new StringBuilder(); 
        StringReader strReader = new StringReader(value); 
        try { 
        	BufferedReader bfr = new BufferedReader(strReader);
            HTMLStripCharFilter html = new HTMLStripCharFilter(bfr);
            char[] cbuf = new char[1024 * 10]; 
            while (true) { 
                int count = html.read(cbuf); 
                if (count == -1) 
                    break; // end of stream mark is -1 
                if (count > 0) 
                    out.append(cbuf, 0, count); 
            } 
            html.close(); 
        } catch (IOException e) { 
            e.printStackTrace(); 
            System.out.println("Failed stripping HTML for column: ");
            return null; 
            //  "Failed stripping HTML for column: " + column, e); 
        } 
        return out.toString(); 
    } 
}
