package com.nb.nbpx.service.keyword.impl;

import com.chenlb.mmseg4j.Dictionary;
import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.SolrUtil;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

/**
 * @author Roger
 * @date 2013年7月27日
 */
@Component("keywordService")
public class KeywordServiceImpl extends BaseServiceImpl implements
		IKeywordService {

	private static final Logger log = Logger.getLogger(KeywordServiceImpl.class
			.getName());
	
	private static String KEYWORD_PREFIX = "seeKey.jsp?key=";

	@Resource
	private IKeywordDao keywordDao;
	@Resource
	private ISolrKeywordService solrKeywordService;
	//不关联课程，只读取关键词
	public String getKeyWordsListOnly(Integer flag,String type,Integer start,Integer rows){
		List<Keyword> list = keywordDao.getKeyWordsListOnly(flag, type,
				start, rows);
		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Keyword temp : list) {
			Map<String, String> result = new HashMap<String, String>();
			result.put("id", temp.getKeyId().toString());
			result.put("name", temp.getKeyword());
			if (flag == 1)// 1代表点击率，2代表推荐，3代表热搜
				result.put("count", temp.getHits().toString());
			if (flag == 3)
				result.put("count", temp.getSearchCnt().toString());

			results.add(result);
		}
		String json = JsonUtil.getJsonString(results);

		return json;
	}
	
	// 获取关键词列表
	public String getKeyWordsList(boolean isInner, Integer flag, String type,
			Integer start, Integer rows) {
		List<Keyword> list = keywordDao.getKeyWordsList(isInner, flag, type,
				start, rows);
		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Keyword temp : list) {
			Map<String, String> result = new HashMap<String, String>();
			result.put("id", temp.getKeyId().toString());
			result.put("name", temp.getKeyword());
			if (flag == 1)// 1代表点击率，2代表推荐，3代表热搜
				result.put("count", temp.getHits().toString());
			if (flag == 3)
				result.put("count", temp.getSearchCnt().toString());

			results.add(result);
		}
		String json = JsonUtil.getJsonString(results);

		return json;
	}
	
	public String getKeyWordsListByType(String type,Integer start,Integer rows){
		List<Keyword> list = keywordDao.getKeyWordsListByType(type, start, rows);
		int rowsCount = keywordDao.countKeyWordsListByType(type);
		int pages = rowsCount/rows+1;
		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Keyword temp : list) {
			Map<String, String> result = new HashMap<String, String>();
			result.put("id", temp.getKeyId().toString());
			result.put("name", temp.getKeyword());
			
			results.add(result);
		}
		Map<String,Object> resultWithPage = new HashMap<String,Object>();
		resultWithPage.put("rows", rowsCount);
		resultWithPage.put("pages", pages);
		resultWithPage.put("lines", results);
		
		String json = JsonUtil.getJsonString(resultWithPage);
		return json;
	}
	
	//获取最新的关键词
	public String getLastedKeyWords(Integer start,Integer rows){
		List<Keyword> list = keywordDao.getLastedKeyWords(start, rows);
		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Keyword temp : list) {
			Map<String, String> result = new HashMap<String, String>();
			result.put("id", temp.getKeyId().toString());
			result.put("name", temp.getKeyword());
			results.add(result);
		}
		String json = JsonUtil.getJsonString(results);

		return json;
	}
	@Override
	public String queryKeywords(String category, String keywordText,
			Integer keywordId, Integer rows, Integer start, String sort,
			String order) throws NbpxException {
		String json = "";
		Map<String, Object> propsMap = new HashMap<String, Object>();
		if (category != null) {
			propsMap.put("category", category);
		}
		// TODO combobox的取值验证
		// List<Keyword> list =
		// keywordDao.queryEntityListByProperties(Keyword.class, rows, start,
		// propsMap);
		List<Keyword> list = keywordDao.queryKeywords(rows, start, category,
				keywordText, keywordId, sort, order);
		if (list.isEmpty()) {
			// json = JsonUtil.formatToJsonWithTimeStamp(0,
			// ResponseStatus.SUCCESS, "", list);
			throw new NbpxException("未查询到结果");
		} else {
			int count = keywordDao.querykeywordsCount(rows, start, category,
					keywordText, keywordId).intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}
		return json;
	}

	@Override
	public String queryComboKeywords(String category) {
		Map<String, Object> propsMap = new HashMap<String, Object>();
		if (category != null) {
			propsMap.put("category", category);
		}
		List<Keyword> list = keywordDao.queryEntityListByProperties(
				Keyword.class, null, null, null, null, propsMap);
		return JsonUtil.formatListToJson(list);
	}

	@Override
	public Boolean importKeywords(String category, String[] keywordsArray) {
		boolean flag = keywordDao.importKeywords(category, keywordsArray);
		List<Keyword> keywordList = keywordDao.getNotIndexedKeyWordsList();
		solrKeywordService.addKeywords2Solr(keywordList);
		// TODO needs debug
		return flag;
	}

	@Override
	public Boolean saveRecommands(String[] keyIds) {
		return keywordDao.recommandKeywords(keyIds);
	}

	public IKeywordDao getKeywordDao() {
		return keywordDao;
	}

	public void setKeywordDao(IKeywordDao keywordDao) {
		this.keywordDao = keywordDao;
	}

	@Override
	public List<Keyword> saveKeywords(CourseAllInfoDto courseDto) {
		List<Keyword> list = new ArrayList<Keyword>();
		String[] keywordArr = null;
		if (courseDto.getKeywords() != null) {
			String keywordsStr = courseDto.getKeywords().replaceAll("，", ",");
			keywordArr = keywordsStr.split(",");
			for (String word : keywordArr) {
				Keyword keyword = new Keyword();
				keyword.setCategory(courseDto.getCategory());
				keyword.setKeyword(word);
				keyword.setSearchCnt(500);
				keyword.setHits(500);
				keyword.setIndexed(true);
				keyword = keywordDao.saveOrGetExistsKeyword(keyword);
				list.add(keyword);
			}
		}
		solrKeywordService.addKeywords2Solr(list);
		return list;
	}

	@Override
	public List<Keyword> saveKeywords(ArticleDetail articleDetail) {
		List<Keyword> list = new ArrayList<Keyword>();
		String[] keywordArr = null;
		if (articleDetail.getKeywords() != null) {
			String keywordsStr = articleDetail.getKeywords().replaceAll("，",
					",");
			keywordArr = keywordsStr.split(",");
			for (String word : keywordArr) {
				Keyword keyword = new Keyword();
				keyword.setCategory(articleDetail.getCategory());
				keyword.setKeyword(word);
				keyword.setSearchCnt(500);
				keyword.setHits(500);
				keyword.setIndexed(true);
				keyword = keywordDao.saveOrGetExistsKeyword(keyword);
				list.add(keyword);
			}
			try {
				saveKeywords2Dic(keywordArr);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		solrKeywordService.addKeywords2Solr(list);
		return list;
	}

	@Override
	public String setKeywordHyperLink(List<Keyword> keywords, String content) {
		for (int i = 0; i < keywords.size(); i++) {
			Keyword keyword = keywords.get(i);
			if (keyword.getKeyword() == null || keyword.getKeyword().isEmpty()) {
				continue;
			}
			//TODO set hyper link
			String reg = "(?!((<.*?)|(<a.*?)))(" + keyword.getKeyword()
					+ ")(?!(([^<>]*?)>)|([^>]*?</a>))";
			String replacement = "<a href=\"http://www.baidu.com\"  target=\"_blank\">"
					+ keyword.getKeyword() + "</a>";
			content = content.replaceAll(reg, replacement);
		}
		return content;
	}

	@Override
	public void saveKeyword2Dic(String keyword) throws IOException {
		String dicPath = SolrUtil.getDictionaryPath();
		File file = new File(dicPath);
		Dictionary dic = Dictionary.getInstance(file);
		if (dic != null) {
			if (keyword != null && !dic.match(keyword)) {
				log.info("save keyword to " + dicPath);
				String s = new String();
				String s1 = new String();
				String dicFileName = "words-my.dic";
				File dicfile = new File(dicPath+ File.separator+dicFileName);
				if(!dicfile.exists()){
					log.info("need to create a file");
				}
				BufferedReader input = new BufferedReader(new FileReader(
						dicfile));
				while ((s = input.readLine()) != null) {
					s1 += s + "\n";
				}
				input.close();
				s1 += keyword + "\n";
				BufferedWriter output = new BufferedWriter(new FileWriter(dicfile));
				output.write(s1);
				output.close();
			}else{
				log.info("keyword " + keyword + " is null or already existed");
			}
		}else{
			log.info("dictionary wasn't inited");
		}
	}
	
	@Override
	public void saveKeywords2Dic(String[] keywords) throws IOException {
		String dicPath = SolrUtil.getDictionaryPath();
		File file = new File(dicPath);
		Dictionary dic = Dictionary.getInstance(file);
		if (dic != null) {
				log.info("save keyword to " + dicPath);
				String s = new String();
				String s1 = new String();
				String dicFileName = "words-my.dic";
				File dicfile = new File(dicPath+ File.separator+dicFileName);
				if(!dicfile.exists()){
					log.info("need to create a file");
				}
				BufferedReader input = new BufferedReader(new FileReader(
						dicfile));
				while ((s = input.readLine()) != null) {
					s1 += s + "\n";
				}
				input.close();
				for(String word:keywords){
					if(!dic.match(word)){
						s1 += word + "\n";
					}else{
						log.info("keyword " + word + " already existed in dictionary");
					}
					
				}
				BufferedWriter output = new BufferedWriter(new FileWriter(dicfile));
				output.write(s1);
				output.close();
		}else{
			log.info("dictionary wasn't inited");
		}
	}

	@Override
	public String setHyperLink(String[] links, String content) {
		for (int i = 0; i < links.length; i++) {
			String word = links[i];
			if (word == null || word.isEmpty()) {
				continue;
			}
			String prefix = KEYWORD_PREFIX;
//			try {
//				prefix = SolrUtil.getKeywordHypeLinkPrefix() ;
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
			String reg = "(?!((<.*?)|(<a.*?)))(" + word
					+ ")(?!(([^<>]*?)>)|([^>]*?</a>))";
			String replacement = "<a href=\"" + prefix + word + "\"  target=\"_blank\">"
					+ word + "</a>";
			content = content.replaceAll(reg, replacement);
		}
		return content;
	}

	@Override
	public List<Keyword> saveKeywords(String category, String keywords) {
		List<Keyword> list = new ArrayList<Keyword>();
		String[] keywordArr = null;
		if (keywords != null) {
			String keywordsStr = keywords.replaceAll("，", ",");
			keywordArr = keywordsStr.split(",");
			for (String word : keywordArr) {
				Keyword keyword = new Keyword();
				keyword.setCategory(category);
				keyword.setKeyword(word);
				keyword.setSearchCnt(500);
				keyword.setHits(500);
				keyword.setIndexed(true);
				keyword = keywordDao.saveOrGetExistsKeyword(keyword);
				list.add(keyword);
			}
		}
		solrKeywordService.addKeywords2Solr(list);
		return list;
	}

	@Override
	public void removeKeyword(Integer keyId) throws Exception {
		keywordDao.deleteByKey(keyId);
		solrKeywordService.removeKeywordFromSolr(keyId);
	}

	@Override
	public List<Keyword> getKeywordsByKey(String key) {
		return keywordDao.getKeywordsByKey(key);
	}

}
