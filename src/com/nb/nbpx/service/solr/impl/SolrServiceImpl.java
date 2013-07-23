/**
 * @author Roger
 */
package com.nb.nbpx.service.solr.impl;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Component;

import com.chenlb.mmseg4j.ComplexSeg;
import com.chenlb.mmseg4j.Dictionary;
import com.chenlb.mmseg4j.MMSeg;
import com.chenlb.mmseg4j.Seg;
import com.chenlb.mmseg4j.Word;
import com.nb.nbpx.dao.course.ICourseKeywordDao;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.utils.NbpxException;

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
		params.set("command", "full-import");
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

	}

	
	@Override
	public String cutText(String text) throws IOException {
		//List<CourseKeyword> list = new ArrayList<CourseKeyword>();
		Dictionary dic = Dictionary.getInstance();;
		StringReader input = new StringReader(text);
		Seg seg =  new ComplexSeg(dic);	//取得不同的分词具体算法
		MMSeg mmSeg = new MMSeg(input, seg);
		Word word = null;
		List<String> list = new ArrayList<String>();
		while((word=mmSeg.next())!=null) {
			String w = word.getString();
			list.add(w);
			HashSet hs = new HashSet();
			hs.addAll(list);
			list.clear();
			list.addAll(hs);
		}
		String json = StringUtils.join(list, "，");
		return json;
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

}
