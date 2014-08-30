package com.nb.nbpx.service.solr.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
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
import com.nb.nbpx.pojo.article.Article;
import com.nb.nbpx.service.solr.ISolrArticleService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.SolrUtil;
import com.nb.nbpx.utils.mapTool.NbpxDicMap;
@Component("SolrArticleService")
public class SolrArticleServiceImpl extends BaseSolrServiceImpl implements
		ISolrArticleService {

    public static Logger logger = LogManager.getLogger(SolrArticleServiceImpl.class);
	
	@Override
	public void addArticle2Solr(ArticleDetail artiDetail) {
		try {
			serverURL = SolrUtil.getArticleServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("articleId", artiDetail.getArticleId());
			sid.addField("title", artiDetail.getArticleTitle());
			sid.addField("author", artiDetail.getAuthor());
			sid.addField("category", NbpxDicMap.getCourseTypeMap().get(artiDetail.category));
			sid.addField("lastUpdateDate", artiDetail.getLastUpdateDate());
			sid.addField("state", artiDetail.state);
			String contents = artiDetail.getContent();
			contents = stripHTMLX(contents);
			
			sid.addField("content", contents);
			if(artiDetail.getKeywords()!=null){
				String[] courseKeywords = artiDetail.getKeywords().split(",");
				for(String keyword:courseKeywords){
					sid.addField("keyword", keyword);
				}
			}
			
			if(artiDetail.getSubjects()!=null){
				String[] courseSubjects = artiDetail.getSubjects().split(",");
				for(String subject:courseSubjects){
					sid.addField("subject", subject);
				}
			}
			solrServer.add(sid);
            solrServer.commit();
            logger.debug("已成功为插入的文章创建索引");
		} catch (IOException e) {
			logger.error("未能取得文章的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit未成功。"+e.getMessage());
			e.printStackTrace();
		}
	}

	@Override
	public void updateArticleInfo2Solr(Integer articleId) throws IOException,
			SolrServerException {
		serverURL = SolrUtil.getCourseServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		ModifiableSolrParams params = new ModifiableSolrParams();
		String q = "articleId:"+articleId;
		params.set("q", q);
		SolrQuery query = new SolrQuery();
		query.set("qt", "select");
		query.add(params);
		QueryResponse response = solrServer.query(query);
		System.out.println(response.getResponseHeader().get("pf"));
		SolrDocumentList list = response.getResults();
		SolrDocument doc = list.get(0);
		SolrInputDocument sid = ClientUtils.toSolrInputDocument(doc);
				
		solrServer.add(sid);
        solrServer.commit();
	}

	
	
	
	/**
	 * 清除文章内容中的HTML标签，并存入SOLR中
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

	@Override
	public void removeArticleFromSolr(Integer articleId)
			throws SolrServerException, IOException {
		serverURL = SolrUtil.getArticleServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		solrServer.deleteById(articleId+"");
		solrServer.commit();
	}

	@SuppressWarnings("unchecked")
	@Override
	public String queryRelatedArticles(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		//TODO 判断审核与否才插入到搜索引擎
		if (q == null) {
			throw new NbpxException("查询关键词不能为空。");
		}
		// TODO 统计搜索次数 put that into Action, not here
		// TODO ping查看连接，连不上的话就throw相应的Exception
		serverURL = SolrUtil.getArticleServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		ModifiableSolrParams params = new ModifiableSolrParams();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);
		params.set("q", q);
		params.set("start", start);
		params.set("rows", rows);
		// params.set("df","text_general");
		// params.set("wt", "foo");
		// params.set("indent", true);
		// params.set("rows", rows);
		params.set("hl", true);
		params.set("hl.fl", "title,content");
		params.set("hl.snippets", 3);
		params.set("hl.simple.pre", "<em>");
		params.set("hl.simple.post", "</em>");

		SolrQuery query = new SolrQuery();
		query.set("qt", "search");
		query.set("echoParams", "explicit");
		//query.set("df", "title,keyword,content");
		query.set("mlt.qf", "title^10.0 keyword^10.0 content^1.0");
		query.set("defType", "edismax");
		query.set("pf", "title keyword content");
		query.set("qf", "title^10.0 keyword^10.0 content^1.0");
		params.set("fq", "state:true");
		// query.set("q","*.*");
		query.add(params);

		query.setRequestHandler("search");
		solrServer.ping();
		// TODO 判断连接 throw exception
		QueryResponse response = solrServer.query(query);
		SolrDocumentList list = response.getResults();

		Map<String, Map<String, List<String>>> hlMap = response
				.getHighlighting();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// numFound
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		List<Article> resultList = new ArrayList<Article>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object idobj = sd.getFieldValue("articleId");
			Map<String, List<String>> lst = hlMap.get(idobj.toString());
			Object contentObj = lst.get("content");
			Object titleObj = lst.get("title");
			Object authorObj = sd.getFieldValue("author");
			Object categoryObj = sd.getFieldValue("category");
			Object uploadDate = sd.getFieldValue("lastUpdateDate");
			String content = "";
			String title = "";
			if (contentObj != null) {
				content = ((List<String>) contentObj).get(0);
			} else {
				content = sd.getFieldValue("content").toString();
				if (content.length() > 50)
					content = content.substring(0, 50);
			}
			if (titleObj != null) {
				title = ((List<String>) titleObj).get(0);
			} else {
				title = sd.getFieldValue("title").toString();
			}
			Article article = new Article((Integer) idobj, title, authorObj.toString(),
					categoryObj.toString(), content, null, null,
					(Date) uploadDate, categoryObj.toString(), null);
			resultList.add(article);
		}
		int allPages = 0;
		if (numFound % rows == 0)
			allPages = (int) (numFound / rows);
		else
			allPages = (int) (numFound / rows) + 1;
		resultMap.put("rows", resultList);
		resultMap.put("pages", allPages);
		// return JsonUtil.formatListToJson(resultList);
		return JsonUtil.getJsonStringDate(resultMap);
	}
	@SuppressWarnings("unchecked")
	@Override
	public String queryRelatedArticlesForIndex(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		//TODO 判断审核与否才插入到搜索引擎
		if (q == null) {
			throw new NbpxException("查询关键词不能为空。");
		}
		// TODO 统计搜索次数 put that into Action, not here
		// TODO ping查看连接，连不上的话就throw相应的Exception
		serverURL = SolrUtil.getArticleServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		ModifiableSolrParams params = new ModifiableSolrParams();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);
		params.set("q", q);
		params.set("start", start);
		params.set("rows", rows);
		// params.set("df","text_general");
		// params.set("wt", "foo");
		// params.set("indent", true);
		// params.set("rows", rows);
		params.set("hl", true);
		params.set("hl.fl", "title,content");
		params.set("hl.snippets", 3);
		params.set("hl.simple.pre", "<em>");
		params.set("hl.simple.post", "</em>");

		SolrQuery query = new SolrQuery();
		query.set("qt", "search");
		query.set("echoParams", "explicit");
		//query.set("df", "title,keyword,content");
		query.set("mlt.qf", "title^10.0 keyword^10.0 content^1.0");
		query.set("defType", "edismax");
		query.set("pf", "title keyword content");
		query.set("qf", "title^10.0 keyword^10.0 content^1.0");
		params.set("fq", "state:true");
		// query.set("q","*.*");
		query.add(params);

		query.setRequestHandler("search");
		solrServer.ping();
		// TODO 判断连接 throw exception
		QueryResponse response = solrServer.query(query);
		SolrDocumentList list = response.getResults();

		Map<String, Map<String, List<String>>> hlMap = response
				.getHighlighting();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// numFound
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		List<Article> resultList = new ArrayList<Article>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object idobj = sd.getFieldValue("articleId");
			Map<String, List<String>> lst = hlMap.get(idobj.toString());
			Object contentObj = lst.get("content");
			Object titleObj = lst.get("title");
			Object authorObj = sd.getFieldValue("author");
			Object categoryObj = sd.getFieldValue("category");
			Object uploadDate = sd.getFieldValue("lastUpdateDate");
			String content = "";
			String title = "";
			if (contentObj != null) {
				content = ((List<String>) contentObj).get(0);
			} else {
				content = sd.getFieldValue("content").toString();
				if (content.length() > 50)
					content = content.substring(0, 50);
			}
			if (titleObj != null) {
				title = ((List<String>) titleObj).get(0);
			} else {
				title = sd.getFieldValue("title").toString();
			}
			Article article = new Article((Integer) idobj, title, authorObj.toString(),
					categoryObj.toString(), content, null, null,
					(Date) uploadDate, categoryObj.toString(), null);
			resultList.add(article);
		}
		int allPages = 0;
		if (numFound % rows == 0)
			allPages = (int) (numFound / rows);
		else
			allPages = (int) (numFound / rows) + 1;
		return JsonUtil.getJsonStringDate(resultList);
	}

	public void audit(Integer id, Boolean state) throws Exception {
		serverURL = SolrUtil.getArticleServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		ModifiableSolrParams params = new ModifiableSolrParams();
		String q = "articleId:"+id;
		params.set("q", q);
		SolrQuery query = new SolrQuery();
		query.set("qt", "select");
		query.add(params);
		QueryResponse response = solrServer.query(query);
		SolrDocumentList list = response.getResults();
		SolrDocument doc = list.get(0);
		SolrInputDocument sid = ClientUtils.toSolrInputDocument(doc);
		sid.removeField("state");
		sid.addField("state", state);
		solrServer.add(sid);
        solrServer.commit();
	} 
	
	public String setItsServerURL() throws Exception {
		serverURL = SolrUtil.getArticleServerUrl();
		return SolrUtil.getArticleServerUrl();
	}
}
