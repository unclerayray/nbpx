package com.nb.nbpx.service.keyword.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.keyword.IKeywordService;
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
}
