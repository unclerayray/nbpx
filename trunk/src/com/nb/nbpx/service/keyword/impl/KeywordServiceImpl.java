package com.nb.nbpx.service.keyword.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

/**
 * @author Roger
 * @date 2013年7月27日
 */
@Component("keywordService")
public class KeywordServiceImpl extends BaseServiceImpl implements IKeywordService{

	@Resource
	private IKeywordDao keywordDao;
	@Resource
	private ISolrKeywordService solrKeywordService;
	
	//获取关键词列表
	public String getKeyWordsList(boolean isInner,Integer flag,String type,Integer start,Integer rows){
		List<Keyword> list  = keywordDao.getKeyWordsList(isInner, flag, type, start, rows);
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Keyword temp : list){
			Map<String,String> result = new HashMap<String,String>();
			result.put("id", temp.getKeyId().toString());
			result.put("name", temp.getKeyword());
			if(flag == 1)//1代表点击率，2代表推荐，3代表热搜
				result.put("count", temp.getHits().toString());
			if(flag == 3)
				result.put("count", temp.getSearchCnt().toString());
			
			results.add(result);
		}
		String json = JsonUtil.getJsonString(results);
		
		return json;
	}
	
	@Override
	public String queryKeywords(String category, String keywordText,Integer keywordId,
			Integer rows, Integer start, String sort, String order) throws NbpxException {
		String json = "";
		Map<String,Object> propsMap = new HashMap<String,Object>();
		if(category!=null&&category.isEmpty()){
			propsMap.put("category",category);
		}
		//TODO combobox的取值验证
		//List<Keyword> list = keywordDao.queryEntityListByProperties(Keyword.class, rows, start, propsMap);
		List<Keyword> list = keywordDao.queryKeywords(rows, start, category, keywordText, keywordId,sort,order);
		if(list.isEmpty()){
//			json = JsonUtil.formatToJsonWithTimeStamp(0,
//					ResponseStatus.SUCCESS, "", list);
			throw new NbpxException("未查询到结果");
		}else{
			int count = keywordDao.querykeywordsCount(rows, start, category, keywordText, keywordId).intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}
		return json;
	}
	@Override
	public String queryComboKeywords(String category) {
		Map<String,Object> propsMap = new HashMap<String,Object>();
		if(category!=null&&category.isEmpty()){
			propsMap.put("category",category);
		}
		List<Keyword> list = keywordDao.queryEntityListByProperties(Keyword.class, null, null, propsMap);
		return JsonUtil.formatListToJson(list);
	}
	@Override
	public Boolean importKeywords(String category, String[] keywordsArray) {
		keywordDao.importKeywords(category, keywordsArray);
		List<Keyword> keywordList =  keywordDao.getNotIndexedKeyWordsList();
		solrKeywordService.addKeywords2Solr(keywordList);
		return true;
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
			String keywordsStr = courseDto.getKeywords().replaceAll("，",
					",");
			keywordArr = keywordsStr.split(",");
			for(String word:keywordArr){
				Keyword keyword = new Keyword();
				keyword.setCategory(courseDto.getCategory());
				keyword.setKeyword(word);
				keyword.setIndexed(true);
				keyword = keywordDao.saveOrGetExistsKeyword(keyword);
				list.add(keyword);
			}
		}
		solrKeywordService.addKeywords2Solr(list);
		return list;
	}
	@Override
	public String setKeywordHyperLink(List<Keyword> keywords, String content) {
		for(int i = 0;i<keywords.size();i++){
			Keyword keyword = keywords.get(i);
			if(keyword.getKeyword()==null||keyword.getKeyword().isEmpty()){
				continue;
			}
			String reg = "(?!((<.*?)|(<a.*?)))("+keyword.getKeyword()+")(?!(([^<>]*?)>)|([^>]*?</a>))";
			String replacement = "<a href=\"http://www.baidu.com\">"+keyword.getKeyword()+"</a>";
			content = content.replaceAll(reg, replacement);
		}
		return content;
	}
}
