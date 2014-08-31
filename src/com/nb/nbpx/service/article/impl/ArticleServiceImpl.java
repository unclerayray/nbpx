package com.nb.nbpx.service.article.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.article.IArticleDao;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.dao.subject.ISubjectDao;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.dao.system.impl.DictionaryDaoImpl;
import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.pojo.article.Article;
import com.nb.nbpx.pojo.article.ArticleKeyword;
import com.nb.nbpx.pojo.article.ArticleSubject;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.pojo.system.Dictionary;
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
	private IDictionaryDao dictionaryDao;
	@Resource
	private ISolrKeywordService solrKeywordService;
	@Resource
	private ISolrSubjectService solrSubjectService;

	@Override
	public String queryArticles(String category, String articleTitle, Integer articleId, Boolean p_outside, Integer rows, Integer start,
			String sort, String order) {
		String json = "";
		List<Article> list = articleDao.getArticles(category , articleTitle , articleId, p_outside, rows, start,
				sort, order);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = articleDao.getArticlesCount(category , articleTitle , articleId, p_outside, rows, start,
					sort, order).intValue();
			//TODO 计数函数也需加上参数
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
		List<Article> list = articleDao.getArticles(category,null,null,null, 10, null, null,
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

	//根据分类获取文章列表
	public String getArticleList(String category,Integer rows, Integer start){
		List<Article> list = articleDao.getArticleList(category, rows, start);
		
		return JsonUtil.getJsonString(list);
	}
	
	//根据分类查询新闻包括分页
	public String viewArticleType(String category,Integer rows, Integer start){
		Map<String,Object> returnValue = new HashMap<String,Object>();
		List<Article> list = articleDao.getArticleList(category, rows, start);
		
		Dictionary type = dictionaryDao.getDictionary(category, null);
		returnValue.put("categoryName", type.getShowName());
		
		long count = articleDao.queryArticleCount(category);
		int allPages = 0;
		if(count%rows == 0)
			allPages = (int)(count/rows);
		else
			allPages = (int)(count/rows) +1;
		returnValue.put("pages", allPages);
		returnValue.put("rows", list);
		
		return JsonUtil.getJsonString(returnValue);
	}
	
	
	//根据文章的ID，获取文章的详情
	public String getArticleDetail(String id){
		Article article = articleDao.getById(Article.class, Integer.parseInt(id));
		Map<String,Object> resultMap = new HashMap<String,Object>();
		if(article == null)
			return "";
		resultMap.put("title", article.getArticleTitle());//文章标题	
		resultMap.put("id", article.getArticleId());//文章ID
		resultMap.put("hot", article.hits);//阅读次数
		resultMap.put("author", article.author);//阅读次数
		SimpleDateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
		resultMap.put("createdate",dateFormate.format(article.getLastUpdateDate()));//创建日期
		resultMap.put("content", article.getContent());
		resultMap.put("categoryID", article.getCategory());
		
		Dictionary category = dictionaryDao.getDictionary(article.getCategory(), null);
		if(category != null)
			resultMap.put("categoryName", category.getShowName());
		else
			resultMap.put("categoryName", "字典中不存在该分类");
		
		List<ArticleKeyword> keys = articleDao.getArticleKeywordsById(id);
		List<Map<String,Object>> keyList = new ArrayList<Map<String,Object>>();
		for(ArticleKeyword key : keys){
			Map<String,Object> temp = new HashMap<String,Object>();
			temp.put("name", key.getKeyword());
			temp.put("id", key.getKeywordId());
			keyList.add(temp);
		}
		resultMap.put("keyWords", keyList);//关键词
		
		List<ArticleSubject> subjects = articleDao.getArticleSubjectById(id);
		List<Map<String,Object>> subjectList = new ArrayList<Map<String,Object>>();
		for(ArticleSubject subject : subjects){
			Map<String,Object> temp = new HashMap<String,Object>();
			temp.put("name", subject.getSubject());
			temp.put("id", subject.getSubjectId());
			subjectList.add(temp);
		}
		resultMap.put("series", subjectList);//主题
		
		return JsonUtil.getJsonString(resultMap);
	}
	
	//获得最热文章
	public String getHotArticle(Integer rows,Integer start){
		List<Article> hotArticles = articleDao.getHotArticleList(rows, start);
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		for(Article temp : hotArticles){
			Map<String,Object> article = new HashMap<String,Object>();
			article.put("id", temp.getArticleId());
			article.put("title", temp.getArticleTitle());
			article.put("hot", temp.getHits());
			resultList.add(article);
		}

		return JsonUtil.getJsonString(resultList);
	}
	
	//获得推荐文章
	public String getRecommandArticle(Integer rows,Integer start){
		List<Article> recommandArticles = articleDao.getRecommendArticleList(rows, start);
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		for(Article temp : recommandArticles){
			Map<String,Object> article = new HashMap<String,Object>();
			article.put("id", temp.getArticleId());
			article.put("title", temp.getArticleTitle());
			String tempContent = getNoHtmlStr(temp.getContent());
			if(tempContent != null){
				tempContent = tempContent.length()>50?tempContent.substring(0, 50):tempContent;
			}
			article.put("content", tempContent);
			resultList.add(article);
		}

		return JsonUtil.getJsonString(resultList);
	}
	
	public String getNoHtmlStr(String htmlStr){
		String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>"; // 定义script的正则表达式
	    String regEx_style = "<style[^>]*?>[\\s\\S]*?<\\/style>"; // 定义style的正则表达式
	    String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式
	    String regEx_space = "\\s*|\t|\r|\n";//定义空格回车换行符
	    
	    Pattern p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
        Matcher m_script = p_script.matcher(htmlStr);
        htmlStr = m_script.replaceAll(""); // 过滤script标签

        Pattern p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
        Matcher m_style = p_style.matcher(htmlStr);
        htmlStr = m_style.replaceAll(""); // 过滤style标签

        Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
        Matcher m_html = p_html.matcher(htmlStr);
        htmlStr = m_html.replaceAll(""); // 过滤html标签

        Pattern p_space = Pattern.compile(regEx_space, Pattern.CASE_INSENSITIVE);
        Matcher m_space = p_space.matcher(htmlStr);
        htmlStr = m_space.replaceAll(""); // 过滤空格回车标签
        
        return htmlStr.trim(); // 返回文本字符串
	}
	//更新阅读次数
	public void addReadTime(String articleID){
		Article article = articleDao.getById(Article.class, Integer.parseInt(articleID));
		if(article == null)
			return;
		article.setHits(article.getHits()+1);
		articleDao.update(article);
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
	public IDictionaryDao getDictionaryDao() {
		return dictionaryDao;
	}

	public void setDictionaryDao(IDictionaryDao dictionaryDao) {
		this.dictionaryDao = dictionaryDao;
	}

	@Override
	public void auditArticle(Boolean state, Integer articleId) {
		String queryString = "update Article set state = ? where articleId = ? ";
		Object[] values = {state, articleId};
		subjectDao.bulkUpdate(queryString, values);
	}


}
