package com.nb.nbpx.service.solr.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.course.CourseSearchResult;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.zixun.Download;
import com.nb.nbpx.pojo.zixun.DownloadKeyword;
import com.nb.nbpx.pojo.zixun.DownloadSubject;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrDownloadService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.SolrUtil;

@Component("SolrDownloadService")
public class SolrDownloadServiceImpl extends BaseServiceImpl implements
		ISolrDownloadService {

	@Override
	public void addDownload2Solr(Download download) {
		String serverURL;
		try {
			serverURL = SolrUtil.getDownloadServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("downloadId", download.getDownloadId());
			sid.addField("author", download.getAuthor());
			sid.addField("title", download.getTitle());
			sid.addField("category", download.getCategory());
			sid.addField("description", download.getDescription());
			sid.addField("filetype", download.getFiletype());
			sid.addField("uploadDate", download.getUploadDate());
			sid.addField("size", download.getSize());
			for (DownloadKeyword dk : download.getDownloadKeywords()) {
				sid.addField("keyword", dk.getKeyword());
			}
			for (DownloadSubject dk : download.getDownloadSubjects()) {
				sid.addField("subject", dk.getSubject());
			}

			solrServer.add(sid);
			solrServer.commit();
			logger.debug("已成功为插入的关键词创建索引");
		} catch (IOException e) {
			logger.error("未能取得关键词的SolrServer URL。" + e.getMessage());
			;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit为成功。" + e.getMessage());
			;
			e.printStackTrace();
		}
	}

	@Override
	public String queryRelatedDownloads(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		if (q == null) {
			throw new NbpxException("查询关键词不能为空。");
		}
		// TODO 统计搜索次数 put that into Action, not here
		// TODO ping查看连接，连不上的话就throw相应的Exception
		String serverURL = SolrUtil.getDownloadServerUrl();
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
		params.set("hl.fl", "title,description");
		params.set("hl.snippets", 3);
		params.set("hl.simple.pre", "<em>");
		params.set("hl.simple.post", "</em>");

		SolrQuery query = new SolrQuery();
		query.set("qt", "search");
		query.set("echoParams", "explicit");
		query.set("df", "title,keyword,description");
		query.set("mlt.qf", "title^10.0 keyword^10.0 description^1.0");
		query.set("defType", "edismax");
		query.set("pf", "title keyword description");
		query.set("qf", "title^10.0 keyword^10.0 description^1.0");
		// query.set("q","*.*");
		query.add(params);

		query.setRequestHandler("search");
		System.out.println(query.getHighlightSnippets());
		System.out.println(query.get("pf"));
		// query.setc
		// query.addHighlightField("title");
		// query.addHighlightField("content");
		solrServer.ping();
		// TODO 判断连接 throw exception
		QueryResponse response = solrServer.query(query);
		System.out.println(response.getResponseHeader().get("pf"));
		SolrDocumentList list = response.getResults();

		// QueryResponse response = solrServer.query(params);
		Map<String, Map<String, List<String>>> hlMap = response
				.getHighlighting();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// numFound
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		List<Download> resultList = new ArrayList<Download>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object idobj = sd.getFieldValue("downloadId");
			Double size = Double.valueOf(sd.getFieldValue("size").toString());
			Map<String, List<String>> lst = hlMap.get(idobj.toString());
			Object descObj = lst.get("description");
			Object titleObj = lst.get("title");
			Object filetypeObj = sd.getFieldValue("filetype");
			Object authorObj = sd.getFieldValue("author");
			Object categoryObj = sd.getFieldValue("category");
			Object uploadDate = sd.getFieldValue("uploadDate");
			String description = "";
			String title = "";
			if (descObj != null) {
				description = ((List<String>) descObj).get(0);
			} else {
				description = sd.getFieldValue("description").toString();
				if (description.length() > 50)
					description = description.substring(0, 50);
			}
			if (titleObj != null) {
				title = ((List<String>) titleObj).get(0);
			} else {
				title = sd.getFieldValue("title").toString();
			}
			Download download = new Download((Integer)idobj, title, null,
					filetypeObj.toString(), description, authorObj.toString(),
					(Date) uploadDate, 100, 100, size,categoryObj.toString());
			resultList.add(download);
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

	@Override
	public void removeDownloadFromSolr(Integer downloadId)
			throws SolrServerException, IOException {
		String serverURL = SolrUtil.getDownloadServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		solrServer.deleteById(downloadId+"");
		solrServer.commit();
	}

	@Override
	public String queryDownloadsBySubject(String subject, Integer start,
			Integer rows) throws SolrServerException, IOException,
			NbpxException {
		if(subject==null){
			throw new NbpxException("查询的专题不能为空。");
		}
		String json = "";
		String serverURL = SolrUtil.getSubjectServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		subject = SolrUtil.escapeQueryChars(subject);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		subject = SolrUtil.escapeQueryChars(subject);
		subject = "subject:"+subject;
		params.set("q", subject);
		if(start!=null){
			params.set("start", start);
		}
		if(rows!=null){
			params.set("rows", rows);
		}
		query.set("qt", "select");
		query.add(params);
		QueryResponse response = solrServer.query(query);
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		SolrDocumentList list = response.getResults();
		List<Download> resultList = new ArrayList<Download>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object idobj = sd.getFieldValue("downloadId");
			Double size = Double.valueOf(sd.getFieldValue("size").toString());
			Object descObj = sd.getFieldValue("description");
			Object titleObj = sd.getFieldValue("title");
			Object filetypeObj = sd.getFieldValue("filetype");
			Object authorObj = sd.getFieldValue("author");
			Object categoryObj = sd.getFieldValue("category");
			Object uploadDate = sd.getFieldValue("uploadDate");
			Download download = new Download((Integer)idobj, titleObj.toString(), null,
					filetypeObj.toString(), descObj.toString(), authorObj.toString(),
					(Date) uploadDate, 100, 100, size,categoryObj.toString());
			resultList.add(download);
		}
		/**
		 * 以下为去重的代码
		 */
		HashSet hs = new HashSet();
		hs.addAll(resultList);
		resultList.clear();
		resultList.addAll(hs);
		json = JsonUtil.formatToJsonWithTimeStamp(numFound,
				ResponseStatus.SUCCESS, "", list);
		return json;
	}

}
