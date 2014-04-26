package com.nb.nbpx.service.solr.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashSet;
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
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.solr.ISolrTeacherService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.PinYinUtil;
import com.nb.nbpx.utils.SolrUtil;
import com.nb.nbpx.utils.mapTool.NbpxDicMap;

@Component("SolrTeacherService")
public class SolrTeacherServiceImpl implements ISolrTeacherService {
    public static Logger logger = LogManager.getLogger(SolrTeacherServiceImpl.class);
	@Override
	public void addTeacher2Solr(TeacherInfo teacher) {
		String serverURL;
		try {
			serverURL = SolrUtil.getTeacherServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("teacherId", teacher.getTeacherId());
			sid.addField("realName", teacher.getRealName());
			sid.addField("expertIn", teacher.getExpertIn());
			sid.addField("majorCatgory", NbpxDicMap.getCourseTypeMap().get(teacher.getMajorCatgory()));
			String introduction = teacher.getIntroduction();
			introduction = stripHTMLX(introduction);
			sid.addField("introduction", introduction);
			if(teacher.getRealName()!=null){
				List<String> pinyinList = PinYinUtil.getPinYinList(teacher.getRealName());
				for(String str:pinyinList){
					sid.addField("pinyin", str);
				}
				//sid.addField("kwfreq", 23);
			}
			
			solrServer.add(sid);
            solrServer.commit();
            logger.debug("已成功为插入的讲师创建索引");
		} catch (IOException e) {
			logger.error("未能取得讲师的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit未成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}

	@Override
	public void removeTeacherInfoFromSolr(Integer teacherId)
			throws SolrServerException, IOException {
		String serverURL = SolrUtil.getTeacherServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		solrServer.deleteById(teacherId+"");
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
            HTMLStripCharFilter html = new HTMLStripCharFilter(new BufferedReader(strReader)); 
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
            return null; 
            //  "Failed stripping HTML for column: " + column, e); 
        } finally{
        	strReader.close();
        }
        return out.toString(); 
    }

	@Override
	public String queryRelateTeacher(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException {
		if(q==null){
			throw new NbpxException("查询人名不能为空。");
		}
		String json = "";
		String serverURL = SolrUtil.getTeacherServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);

		params.set("q", q);
		query.set("echoParams", "explicit");
		query.set("df", "realName,pinyin");
		query.set("mlt.qf", "pinyin^10.0 realName^10.0");
		query.set("defType", "edismax");
		query.set("pf", "realName pinyin");
		query.set("qf", "realName^10.0 pinyin^1.0");
		//q = "keyword:"+q;
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
		List<Keyword> resultList = new ArrayList<Keyword>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object realNameobj = sd.getFieldValue("realName");
			if(realNameobj==null){
				continue;
			}
			Keyword info = new Keyword();
			info.setKeyword(realNameobj.toString());
			resultList.add(info);
		}
		/**
		 * 以下为去重的代码
		 */
		HashSet hs = new HashSet();
		hs.addAll(resultList);
		resultList.clear();
		resultList.addAll(hs);
		json = JsonUtil.formatListToJson(resultList);
		return json;
	}

	@Override
	public void removeTeacherFromSolr(Integer teacherId)
			throws SolrServerException, IOException {
		String serverURL = SolrUtil.getTeacherServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		solrServer.deleteById(teacherId+"");
		solrServer.commit();
	}

	@Override
	public String queryTeacherBySolr(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		if(q==null){
			throw new NbpxException("查询人名不能为空。");
		}
		String json = "";
		String serverURL = SolrUtil.getTeacherServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);

		params.set("q", q);
		query.set("echoParams", "explicit");
		query.set("df", "realName,pinyin,introduction,expertIn");
		query.set("mlt.qf", "pinyin^1.0 realName^10.0 introduction^10 expertIn^5");
		query.set("defType", "edismax");
		query.set("pf", "realName pinyin introduction expertIn");
		query.set("qf", "realName^10.0 pinyin^1.0 introduction^10 expertIn^5");
		//q = "keyword:"+q;
		if(start!=null){
			params.set("start", start);
		}
		if(rows!=null){
			params.set("rows", rows);
		}
		params.set("hl", true);
		params.set("hl.fl", "realName,introduction");
		params.set("hl.snippets", 3);
		params.set("hl.simple.pre", "<em>");
		params.set("hl.simple.post", "</em>");
		query.set("qt", "select");
		query.add(params);
		QueryResponse response = solrServer.query(query);
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		Map<String, Map<String, List<String>>> hlMap = response
				.getHighlighting();
		SolrDocumentList list = response.getResults();
		List<TeacherInfo> resultList = new ArrayList<TeacherInfo>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object idobj = sd.getFieldValue("teacherId");
			Object expertInobj = sd.getFieldValue("expertIn");
			Object majorCatgoryobj = sd.getFieldValue("majorCatgory");
			Map<String, List<String>> lst = hlMap.get(idobj.toString());
			Object hlIntroObj = lst.get("introduction");
			Object nameObj = lst.get("realName");
			String intro = "";
			String name = "";
			if (hlIntroObj != null) {
				intro = ((List<String>) hlIntroObj).get(0);
			} else {
				intro = sd.getFieldValue("introduction").toString();
				if (intro.length() > 50)
					intro = intro.substring(0, 50);
			}
			if (nameObj != null) {
				name = ((List<String>) nameObj).get(0);
			} else {
				name = sd.getFieldValue("realName").toString();
			}
			TeacherInfo info = new TeacherInfo();
			info.setTeacherId((Integer) idobj);
			info.setRealName(name);
			info.setExpertIn(expertInobj.toString());
			info.setIntroduction(intro);
			info.setMajorCatgory(majorCatgoryobj.toString());
			resultList.add(info);
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

	@Override
	public List<TeacherInfo> queryRelateTeacherList(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		if(q==null){
			throw new NbpxException("查询人名不能为空。");
		}
		String json = "";
		String serverURL = SolrUtil.getTeacherServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);

		params.set("q", q);
		query.set("echoParams", "explicit");
		query.set("df", "realName,pinyin");
		query.set("mlt.qf", "pinyin^10.0 realName^10.0");
		query.set("defType", "edismax");
		query.set("pf", "realName pinyin");
		query.set("qf", "realName^10.0 pinyin^1.0");
		//q = "keyword:"+q;
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
		List<TeacherInfo> resultList = new ArrayList<TeacherInfo>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object Idobj = sd.getFieldValue("teacherId");
			Object realNameobj = sd.getFieldValue("realName");
			if(realNameobj==null){
				continue;
			}
			TeacherInfo info = new TeacherInfo();
			info.setTeacherId((Integer) Idobj);
			info.setRealName(realNameobj.toString());
			resultList.add(info);
		}
		/**
		 * 以下为去重的代码
		 */
		HashSet hs = new HashSet();
		hs.addAll(resultList);
		resultList.clear();
		resultList.addAll(hs);
		return resultList;
	}

	@Override
	public List<Keyword> queryTipTeacher(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		if(q==null){
			throw new NbpxException("查询人名不能为空。");
		}
		String serverURL = SolrUtil.getTeacherServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		// params.set("qt", "/select");
		// params.set("q", "content:"+q);
		q = SolrUtil.escapeQueryChars(q);

		params.set("q", q);
		query.set("echoParams", "explicit");
		query.set("df", "realName,pinyin");
		query.set("mlt.qf", "pinyin^10.0 realName^10.0");
		query.set("defType", "edismax");
		query.set("pf", "realName pinyin");
		query.set("qf", "realName^10.0 pinyin^1.0");
		//q = "keyword:"+q;
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
		List<Keyword> resultList = new ArrayList<Keyword>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object realNameobj = sd.getFieldValue("realName");
			if(realNameobj==null){
				continue;
			}
			Keyword info = new Keyword();
			info.setKeyword(realNameobj.toString());
			resultList.add(info);
		}
		/**
		 * 以下为去重的代码
		 */
		HashSet hs = new HashSet();
		hs.addAll(resultList);
		resultList.clear();
		resultList.addAll(hs);
		return resultList;
	} 
}
