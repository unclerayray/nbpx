/**
 * @author Roger
 */
package com.nb.nbpx.service.solr.impl;

import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Component;

import com.chenlb.mmseg4j.Dictionary;
import com.chenlb.mmseg4j.MMSeg;
import com.chenlb.mmseg4j.Seg;
import com.chenlb.mmseg4j.SimpleSeg;
import com.chenlb.mmseg4j.Word;
import com.nb.nbpx.dao.course.ICourseKeywordDao;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.pojo.course.CourseSearchResult;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.SolrUtil;

/**
 * @author Roger
 * @date 2013-6-15
 */
@Component("SolrService")
@SuppressWarnings({ "rawtypes", "unchecked" })
public class SolrServiceImpl extends BaseServiceImpl implements ISolrService {

	private ICourseKeywordDao courseKeywordDao;
	private IKeywordDao keywordDao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.nb.nbpx.service.solr.IDataImportService#fullImport()
	 */
	@Override
	public void fullImport() throws Exception {
		SolrServer solrServer = new HttpSolrServer("http://localhost:8080/solr");
		ModifiableSolrParams params = new ModifiableSolrParams();
		params.set("qt", "/dataimport");
		params.set("command", "full-import");
		params.set("commit", true);
		// params.set("command", "full-import");
		params.set("clean", true);
		solrServer.ping();
		QueryResponse response = solrServer.query(params);
		if (response.getStatus() == 0) {
			System.out.println("------------------全量导入成功！");
		} else {
			throw new NbpxException("全量导入失败！");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.nb.nbpx.service.solr.IDataImportService#deltaImport()
	 */
	@Override
	public void deltaImport() throws Exception {
		// TODO
	}

	@Override
	public String cutText(String text) throws IOException {
		String dicPath = SolrUtil.getDictionaryPath();
		File file = new File(dicPath);
		Dictionary dic = Dictionary.getInstance(file);
		StringReader input = new StringReader(text);
		Seg seg = new SimpleSeg(dic); // 取得不同的分词具体算法
		MMSeg mmSeg = new MMSeg(input, seg);
		Word word = null;
		List<String> list = new ArrayList<String>();
		while ((word = mmSeg.next()) != null) {
			String w = word.getString();
			if (w.length() > 1) {
				list.add(w);
			}
		}
		HashSet hs = new HashSet();
		hs.addAll(list);
		list.clear();
		list.addAll(hs);
		String json = StringUtils.join(list, "，");
		return json;
	}

	@Override
	public String fullTextQueryForHl(String q, Integer start, Integer rows)
			throws SolrServerException, IOException {
		// TODO 统计搜索次数 put that into Action, not here
		// TODO ping查看连接，连不上的话就throw相应的Exception
		String serverURL = SolrUtil.getCourseServerUrl();
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
		query.set("df", "title,keyword,content");
		query.set("mlt.qf", "title^10.0 keyword^10.0 content^1.0");
		query.set("defType", "edismax");
		query.set("pf", "title keyword content");
		query.set("qf", "title^10.0 keyword^10.0 content^1.0");
		params.set("fq", "isInner:false");
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
		List<CourseSearchResult> resultList = new ArrayList<CourseSearchResult>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Map<String, Object> valueMap = sd.getFieldValueMap();
			// String[] courseInfo = null;
			List<String> courseInfo = (List<String>) sd
					.getFieldValue("courseInfo");
			Object obj = sd.getFieldValue("courseInfo");
			Object idobj = sd.getFieldValue("courseId");
			Double price = Double.valueOf(sd.getFieldValue("price").toString());
			Map<String, List<String>> lst = hlMap.get(idobj.toString());
			Object conObj = lst.get("content");
			Object titleObj = lst.get("title");
			String content = "";
			String title = "";
			if (conObj != null) {
				content = ((List<String>) conObj).get(0);
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
			// lst.g
			CourseSearchResult csr = new CourseSearchResult((Integer) idobj,
					title, price, sd.getFieldValue("teacherName").toString(),
					content, courseInfo);
			resultList.add(csr);
		}
		int allPages = 0;
		if (numFound % rows == 0)
			allPages = (int) (numFound / rows);
		else
			allPages = (int) (numFound / rows) + 1;
		resultMap.put("rows", resultList);
		resultMap.put("pages", allPages);
		// return JsonUtil.formatListToJson(resultList);
		return JsonUtil.getJsonString(resultMap);
	}

	public List<CourseSearchResult> fullTextQueryForHlReturnList(String q,
			Integer start, Integer rows) throws SolrServerException,
			IOException {
		// TODO 统计搜索次数 put that into Action, not here
		// TODO ping查看连接，连不上的话就throw相应的Exception
		String serverURL = SolrUtil.getCourseServerUrl();
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
		query.set("df", "title,keyword,content");
		query.set("mlt.qf", "title^10.0 keyword^10.0 content^1.0");
		query.set("defType", "edismax");
		query.set("pf", "title keyword content");
		query.set("qf", "title^10.0 keyword^10.0 content^1.0");
		params.set("fq", "isInner:false");
		// query.set("q","*.*");
		query.add(params);

		query.setRequestHandler("search");
		//System.out.println(query.getHighlightSnippets());
		//System.out.println(query.get("pf"));
		// query.setc
		// query.addHighlightField("title");
		// query.addHighlightField("content");
		solrServer.ping();
		// TODO 判断连接 throw exception
		QueryResponse response = solrServer.query(query);
		//System.out.println(response.getResponseHeader().get("pf"));
		SolrDocumentList list = response.getResults();

		// QueryResponse response = solrServer.query(params);
		Map<String, Map<String, List<String>>> hlMap = response
				.getHighlighting();
		// numFound
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		List<CourseSearchResult> resultList = new ArrayList<CourseSearchResult>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Map<String, Object> valueMap = sd.getFieldValueMap();
			// String[] courseInfo = null;
			List<String> courseInfo = (List<String>) sd
					.getFieldValue("courseInfo");
			Object obj = sd.getFieldValue("courseInfo");
			Object idobj = sd.getFieldValue("courseId");
			Double price = Double.valueOf(sd.getFieldValue("price").toString());
			Map<String, List<String>> lst = hlMap.get(idobj.toString());
			Object conObj = lst.get("content");
			Object titleObj = lst.get("title");
			String content = "";
			String title = "";
			if (conObj != null) {
				content = ((List<String>) conObj).get(0);
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
			// lst.g
			CourseSearchResult csr = new CourseSearchResult((Integer) idobj,
					title, price, sd.getFieldValue("teacherName").toString(),
					content, courseInfo);
			resultList.add(csr);
		}

		// return JsonUtil.formatListToJson(resultList);
		return resultList;
	}

	@Override
	public String queryKeywordsByKeyword(String q, Integer start, Integer rows)
			throws SolrServerException, IOException {
		// TODO 统计搜索次数 put that into Action, not here
		// TODO ping查看连接，连不上的话就throw相应的Exception
		String serverURL = SolrUtil.getKeywordServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		ModifiableSolrParams params = new ModifiableSolrParams();
		// q = SolrUtil.escapeQueryChars(q);
		params.set("q", q);
		params.set("start", start);
		params.set("rows", rows);

		SolrQuery query = new SolrQuery();
		query.set("qt", "select");
		query.add(params);
		// query.setFacet(true);
		// query.setParam("facet.field", "keyword");
		solrServer.ping();
		// TODO 判断连接 throw exception
		QueryResponse response = solrServer.query(query);
		SolrDocumentList docList = response.getResults();
		ArrayList al = new ArrayList();
		for (SolrDocument singleDoc : docList) {
			String keyword = singleDoc.getFieldValue("keyword").toString();
			Keyword key = new Keyword();
			key.setKeyword(keyword);
			al.add(key);
		}
		HashSet hs = new HashSet();
		hs.addAll(al);
		al.clear();
		al.addAll(hs);
		return JsonUtil.formatListToJson(al);
	}

	public ICourseKeywordDao getCourseKeywordDao() {
		return courseKeywordDao;
	}

	@Resource
	public void setCourseKeywordDao(ICourseKeywordDao courseKeywordDao) {
		this.courseKeywordDao = courseKeywordDao;
	}

	public IKeywordDao getKeywordDao() {
		return keywordDao;
	}

	@Resource
	public void setKeywordDao(IKeywordDao keywordDao) {
		this.keywordDao = keywordDao;
	}

	@Override
	public String fullTextQueryForHlInnerCourse(String q, Integer start,
			Integer rows) throws SolrServerException, IOException {
		// TODO 统计搜索次数 put that into Action, not here
				// TODO ping查看连接，连不上的话就throw相应的Exception
				String serverURL = SolrUtil.getCourseServerUrl();
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
				query.set("df", "title,keyword,content");
				query.set("mlt.qf", "title^10.0 keyword^10.0 content^1.0");
				query.set("defType", "edismax");
				query.set("pf", "title keyword content");
				query.set("qf", "title^10.0 keyword^10.0 content^1.0");
				params.set("fq", "isInner:true");
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
				List<CourseSearchResult> resultList = new ArrayList<CourseSearchResult>();
				for (int i = 0; i < count; i++) {
					SolrDocument sd = list.get(i);
					Map<String, Object> valueMap = sd.getFieldValueMap();
					// String[] courseInfo = null;
					List<String> courseInfo = (List<String>) sd
							.getFieldValue("courseInfo");
					Object obj = sd.getFieldValue("courseInfo");
					Object idobj = sd.getFieldValue("courseId");
					Double price = Double.valueOf(sd.getFieldValue("price").toString());
					Map<String, List<String>> lst = hlMap.get(idobj.toString());
					Object conObj = lst.get("content");
					Object titleObj = lst.get("title");
					String content = "";
					String title = "";
					if (conObj != null) {
						content = ((List<String>) conObj).get(0);
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
					// lst.g
					CourseSearchResult csr = new CourseSearchResult((Integer) idobj,
							title, price, sd.getFieldValue("teacherName").toString(),
							content, courseInfo);
					resultList.add(csr);
				}
				int allPages = 0;
				if (numFound % rows == 0)
					allPages = (int) (numFound / rows);
				else
					allPages = (int) (numFound / rows) + 1;
				resultMap.put("rows", resultList);
				resultMap.put("pages", allPages);
				// return JsonUtil.formatListToJson(resultList);
				return JsonUtil.getJsonString(resultMap);
	}

	@Override
	public List<CourseSearchResult> fullTextQueryForHlReturnInnerCourseList(
			String q, Integer start, Integer rows) throws SolrServerException,
			IOException {
		// TODO 统计搜索次数 put that into Action, not here
				// TODO ping查看连接，连不上的话就throw相应的Exception
				String serverURL = SolrUtil.getCourseServerUrl();
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
				query.set("df", "title,keyword,content");
				query.set("mlt.qf", "title^10.0 keyword^10.0 content^1.0");
				query.set("defType", "edismax");
				query.set("pf", "title keyword content");
				query.set("qf", "title^10.0 keyword^10.0 content^1.0");
				params.set("fq", "isInner:true");
				// query.set("q","*.*");
				query.add(params);

				query.setRequestHandler("search");
				//System.out.println(query.getHighlightSnippets());
				//System.out.println(query.get("pf"));
				// query.setc
				// query.addHighlightField("title");
				// query.addHighlightField("content");
				solrServer.ping();
				// TODO 判断连接 throw exception
				QueryResponse response = solrServer.query(query);
				//System.out.println(response.getResponseHeader().get("pf"));
				SolrDocumentList list = response.getResults();

				// QueryResponse response = solrServer.query(params);
				Map<String, Map<String, List<String>>> hlMap = response
						.getHighlighting();
				// numFound
				int numFound = (int) response.getResults().getNumFound();
				int count = response.getResults().size();
				List<CourseSearchResult> resultList = new ArrayList<CourseSearchResult>();
				for (int i = 0; i < count; i++) {
					SolrDocument sd = list.get(i);
					Map<String, Object> valueMap = sd.getFieldValueMap();
					// String[] courseInfo = null;
					List<String> courseInfo = (List<String>) sd
							.getFieldValue("courseInfo");
					Object obj = sd.getFieldValue("courseInfo");
					Object idobj = sd.getFieldValue("courseId");
					Double price = Double.valueOf(sd.getFieldValue("price").toString());
					Map<String, List<String>> lst = hlMap.get(idobj.toString());
					Object conObj = lst.get("content");
					Object titleObj = lst.get("title");
					String content = "";
					String title = "";
					if (conObj != null) {
						content = ((List<String>) conObj).get(0);
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
					// lst.g
					CourseSearchResult csr = new CourseSearchResult((Integer) idobj,
							title, price, sd.getFieldValue("teacherName").toString(),
							content, courseInfo);
					resultList.add(csr);
				}

				// return JsonUtil.formatListToJson(resultList);
				return resultList;
	}

}
