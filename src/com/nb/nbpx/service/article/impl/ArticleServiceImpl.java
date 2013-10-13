package com.nb.nbpx.service.article.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.article.IArticleDao;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.dao.subject.ISubjectDao;
import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.pojo.article.Article;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.service.article.IArticleService;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.solr.ISolrSubjectService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.daotool.Equality;

@Component("ArticleService")
public class ArticleServiceImpl extends BaseServiceImpl implements
		IArticleService {
	@Resource
	private IArticleDao articleDao;
	@Resource
	private IKeywordDao keywordDao;
	@Resource
	private ISubjectDao subjectDao;
	@Resource
	private ISolrKeywordService solrKeywordService;
	@Resource
	private ISolrSubjectService solrSubjectService;

	@Override
	public String queryArticles(String category, Integer rows, Integer start,
			String sort, String order) {
		String json = "";
		Map<String, Object> propsMap = this.createPropMap(new Equality(
				"category", category));
		List<Article> list = articleDao.getArticles(category, rows, start,
				sort, order);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = articleDao.queryTotalCount(Article.class, propsMap)
					.intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}

	public IArticleDao getArticleDao() {
		return articleDao;
	}

	public void setArticleDao(IArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	@Override
	public String queryComboArticleCode(String category) {
		List<Article> list = articleDao.getArticles(category, null, null, null,
				null);
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	@Override
	public Article saveArticle(Article article) throws Exception {
		Map<String, Object> propsMap = this.createPropMap(new Equality(
				"articleTitle", article.getArticleTitle()));
		if (article.getArticleId() != null) {
			article.setLastUpdateDate(new Date());
			articleDao.updateArticle(article);
		} else {
			Article result = articleDao.queryEntityByProperties(Article.class,
					propsMap);
			if (result != null) {
				// duplicate title
				throw new NbpxException("文章：《" + article.getArticleTitle()
						+ "》已存在在数据库中!请勿重复添加!");
			}
			article.setCreationDate(new Date());
			article.setHits(500);
			article.setLastUpdateDate(new Date());
			articleDao.save(article);
		}
		return article;
	}

	@Override
	public void deleteArticle(Article article) {
		articleDao.delete(article);
		articleDao.deleteArticleDetail(article.getArticleId());
	}

	@Override
	public void saveArticleDetail(ArticleDetail articleDetail,
			Boolean deleteBeforeInsert) {
		Map<Integer, String> keywordMap = new HashMap<Integer, String>();
		Map<Integer, String> subjectMap = new HashMap<Integer, String>();
		String[] articleKeywords = null;
		String[] articleSubjects = null;
		if (articleDetail.getKeywords() != null) {
			String keywordsStr = articleDetail.getKeywords().replaceAll("，",
					",");
			articleKeywords = keywordsStr.split(",");
		}
		if (articleDetail.getSubjects() != null) {
			String subjectStr = articleDetail.getSubjects()
					.replaceAll("，", ",");
			articleSubjects = subjectStr.split(",");
		}

		for (int i = 0; articleKeywords != null && i < articleKeywords.length; i++) {
			String keywordStr = StringUtils.trim(articleKeywords[i]);
			Keyword keyword = new Keyword();
			keyword.setCategory(articleDetail.getCategory());
			keyword.setKeyword(keywordStr);
			keyword.setHits(500);
			keyword.setSearchCnt(500);
			keyword = keywordDao.saveOrGetExistsKeyword(keyword);
			keywordMap.put(keyword.getKeyId(), keyword.getKeyword());
			// keywordsForLink.add(keyword);
			solrKeywordService.addKeyword2Solr(keyword); // index it to solr
		}
		// 保存专题
		for (int i = 0; articleSubjects != null && i < articleSubjects.length; i++) {
			String subjectStr = StringUtils.trim(articleSubjects[i]);
			Subject subject = new Subject();
			subject.setCategory(articleDetail.getCategory());
			subject.setSubject(subjectStr);
			subject.setHits(500);
			subject.setSearchCnt(500);
			subject = subjectDao.saveOrGetExistsSubject(subject);
			subjectMap.put(subject.getSubjectId(), subject.getSubject());
			solrSubjectService.addSubject2Solr(subject);
		}

		if (deleteBeforeInsert) {
			articleDao.deleteArticleDetail(articleDetail.getArticleId());
		}

		articleDao.addArticleDetail(articleDetail.getArticleId(), keywordMap,
				subjectMap);
	}

	@Override
	public String queryArticleDetail(Integer articleId) {
		Article article = articleDao.get(articleId);
		String keywords = "";
		String subjects = "";
		
		String keywordsHql = "select keyword from com.nb.nbpx.pojo.article.ArticleKeyword where articleId = "
				+ articleId;
		List keywordsList = articleDao.find(keywordsHql);
		
		String subjectsHql = "select subject from com.nb.nbpx.pojo.article.ArticleSubject where articleId = "
				+ articleId;
		List subjectsList = articleDao.find(subjectsHql);
		subjects = StringUtils.join(subjectsList, "，");
		keywords = StringUtils.join(keywordsList, "，");
		ArticleDetail detail = new ArticleDetail(article);
		detail.setSubjects(subjects);
		detail.setKeywords(keywords);
		return JsonUtil.getJsonString(detail);
	}

	public IKeywordDao getKeywordDao() {
		return keywordDao;
	}

	public void setKeywordDao(IKeywordDao keywordDao) {
		this.keywordDao = keywordDao;
	}

	public ISubjectDao getSubjectDao() {
		return subjectDao;
	}

	public void setSubjectDao(ISubjectDao subjectDao) {
		this.subjectDao = subjectDao;
	}

	public ISolrKeywordService getSolrKeywordService() {
		return solrKeywordService;
	}

	public void setSolrKeywordService(ISolrKeywordService solrKeywordService) {
		this.solrKeywordService = solrKeywordService;
	}

	public ISolrSubjectService getSolrSubjectService() {
		return solrSubjectService;
	}

	public void setSolrSubjectService(ISolrSubjectService solrSubjectService) {
		this.solrSubjectService = solrSubjectService;
	}

}
