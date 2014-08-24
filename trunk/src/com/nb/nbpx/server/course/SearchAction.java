package com.nb.nbpx.server.course;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrArticleService;
import com.nb.nbpx.service.solr.ISolrDownloadService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.solr.ISolrOrganisationService;
import com.nb.nbpx.service.solr.ISolrQuestionService;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.service.solr.ISolrSubjectService;
import com.nb.nbpx.service.solr.ISolrTeacherService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.mapTool.MapTool;

/**
 * @author Roger
 * @date 2013年8月24日
 */
@Component("SearchAction")
@Scope("prototype")
public class SearchAction  extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ISolrService solrService;
	private ISolrQuestionService solrQuestionService;
	private ISolrOrganisationService solrOrganisationService;
	private ISolrDownloadService solrDownloadService;
	private ISolrTeacherService solrTeacherService;
	private ISolrKeywordService solrKeywordService;
	private ISolrArticleService solrArticleService;
	private ISolrSubjectService solrSubjectService;
	private String key;
	private String q;
	private String term;
	public IKeywordService keywordService;

	private void addkeywordsSearchCnt(String keywor){
		List<Keyword> list = keywordService.getKeywordsByKey(keywor);
		if(list!=null && list.size()>0){
			for(Keyword keyword:list){
				MapTool.addkeywordsSearchCnt(keyword.getKeyId());
			}
		}
	}
	
	/**
	 * 【公开课】用solr全文搜索
	 * @return
	 */
	public String queryBySolr(){
		String json;
		try {
			json = solrService.fullTextQueryForHl(key, getStartPosi(), rows);
			addkeywordsSearchCnt(key);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	/**
	 * 【内训课】用solr全文搜索
	 * @return
	 */
	public String queryInnerCourseBySolr(){
		String json;
		try {
			json = solrService.fullTextQueryForHlInnerCourse(key, getStartPosi(), rows);
			addkeywordsSearchCnt(key);
			this.inputStream = castToInputStream(json);
		} catch (SolrServerException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	

	/**
	 * 【内训视频】用solr全文搜索
	 * @return
	 */
	public String queryInnerVideoCourseBySolr(){
		String json;
		try {
			json = solrService.fullTextQueryForHlInnerVideoCourse(key, getStartPosi(), rows);
			addkeywordsSearchCnt(key);
			this.inputStream = castToInputStream(json);
		} catch (SolrServerException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	/**
	 * 【培训】以【专题】用solr全文搜索
	 * @return
	 */
	public String queryBySolrWithSubject(){
		String json;
		try {
			json = solrService.queryCoursesBySubject(key, getStartPosi(), rows);
			this.inputStream = castToInputStream(json);
		} catch (SolrServerException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	/**
	 * 【内训课】以【专题】用solr全文搜索
	 * @return
	 */
	public String queryInnerCourseBySolrWithSubject(){
		String json;
		try {
			json = solrService.queryInnerCoursesBySubject(key, getStartPosi(), rows);
			this.inputStream = castToInputStream(json);
		} catch (SolrServerException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 【提问】用solr全文搜索
	 * @return
	 */
	public String queryQuestionBySolr(){
		String json;
		try {
			json = solrQuestionService.queryRelatedQuestion(key, getStartPosi(), rows);
			addkeywordsSearchCnt(key);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	/**
	 * 【机构】用solr全文搜索
	 * @return
	 */
	public String queryDownloadBySolr(){
		String json;
		try {
			json = solrDownloadService.queryRelatedDownloads(key, getStartPosi(), rows);
			addkeywordsSearchCnt(key);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	/**
	 * 【机构】用solr全文搜索
	 * @return
	 */
	public String queryOrganisationBySolr(){
		String json;
		try {
			json = solrOrganisationService.queryRelatedOrganisation(key, getStartPosi(), rows);
			addkeywordsSearchCnt(key);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	
	public String queryKeywordsByKeyword(){
		String json;
		try {
			//json = solrKeywordService.queryRelatedKeywords(q, 0, 10);
			List<Keyword> keywords = solrKeywordService.queryTipKeywords(q, 0, 10);
			List<Keyword> subjects = solrSubjectService.queryTipSubject(q, 0, 10);
			keywords.addAll(subjects);
			json = JsonUtil.formatListToJson(keywords);
			addkeywordsSearchCnt(key);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String queryTeacherTip(){
		String json;
		try {
			List<Keyword> teachers = solrTeacherService.queryTipTeacher(q, 0, 10);
			List<Keyword> keywords = solrKeywordService.queryTipKeywords(q, 0, 10);
			teachers.addAll(keywords);
			json = JsonUtil.formatListToJson(teachers);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			this.inputStream = castToInputStream("[]");
		}
		return SUCCESS;
	}
	
	public String queryOrgTip(){
		String json;
		try {
			List<Keyword> orgs = solrOrganisationService.queryTipOrg(q, 0, 10);
			List<Keyword> keywords = solrKeywordService.queryTipKeywords(q, 0, 10);
			orgs.addAll(keywords);
			json = JsonUtil.formatListToJson(orgs);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			this.inputStream = castToInputStream("[]");
		}
		return SUCCESS;
	}
	

	public String queryTeacherBySolr(){
		String json;
		try {
			json = solrTeacherService.queryTeacherBySolr(key, getStartPosi(), rows);
			addkeywordsSearchCnt(key);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String queryArticleBySolr(){
		String json;
		try {
			json = solrArticleService.queryRelatedArticles(key, getStartPosi(), rows);
			addkeywordsSearchCnt(key);
			this.inputStream = castToInputStream(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public ISolrService getSolrService() {
		return solrService;
	}

	@Resource
	public void setSolrService(ISolrService solrService) {
		this.solrService = solrService;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}


	public String getQ() {
		return q;
	}


	public void setQ(String q) {
		this.q = q;
		if(term !=null && !term.isEmpty()){
			q = term;
		}
	}

	public ISolrQuestionService getSolrQuestionService() {
		return solrQuestionService;
	}

	@Resource
	public void setSolrQuestionService(ISolrQuestionService solrQuestionService) {
		this.solrQuestionService = solrQuestionService;
	}

	public ISolrOrganisationService getSolrOrganisationService() {
		return solrOrganisationService;
	}

	@Resource
	public void setSolrOrganisationService(
			ISolrOrganisationService solrOrganisationService) {
		this.solrOrganisationService = solrOrganisationService;
	}

	public ISolrDownloadService getSolrDownloadService() {
		return solrDownloadService;
	}

	@Resource
	public void setSolrDownloadService(ISolrDownloadService solrDownloadService) {
		this.solrDownloadService = solrDownloadService;
	}

	public ISolrTeacherService getSolrTeacherService() {
		return solrTeacherService;
	}

	@Resource
	public void setSolrTeacherService(ISolrTeacherService solrTeacherService) {
		this.solrTeacherService = solrTeacherService;
	}

	public ISolrKeywordService getSolrKeywordService() {
		return solrKeywordService;
	}

	@Resource
	public void setSolrKeywordService(ISolrKeywordService solrKeywordService) {
		this.solrKeywordService = solrKeywordService;
	}

	public ISolrArticleService getSolrArticleService() {
		return solrArticleService;
	}

	@Resource
	public void setSolrArticleService(ISolrArticleService solrArticleService) {
		this.solrArticleService = solrArticleService;
	}

	public IKeywordService getKeywordService() {
		return keywordService;
	}

	@Resource
	public void setKeywordService(IKeywordService keywordService) {
		this.keywordService = keywordService;
	}

	public ISolrSubjectService getSolrSubjectService() {
		return solrSubjectService;
	}

	@Resource
	public void setSolrSubjectService(ISolrSubjectService solrSubjectService) {
		this.solrSubjectService = solrSubjectService;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}
}
