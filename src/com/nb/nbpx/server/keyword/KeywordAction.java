package com.nb.nbpx.server.keyword;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.system.IDictionaryService;
import com.nb.nbpx.utils.JsonUtil;

/**
 * @author Roger
 * @date 2013年7月26日
 */
@Component("KeywordAction")
@Scope("prototype")
public class KeywordAction extends BaseAction {

	public String category;
	public String keyCombValue;
	public String keyCombText;
	public Keyword keyword;
	public String keyIds;
	public String keywords;
	public String allKeywords;
	public Integer keyId;
	@Resource
	public IKeywordService keywordService;
	@Resource
	public ISolrKeywordService solrKeywordService;
	@Resource
	public IDictionaryService dictionaryService;

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	//获取前100个热搜关键词
	public String getTopKeyWords(){
		String json = "";
		json = keywordService.getHotKeyWords(0, 100);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String queryKeywords() {
		String json = "";
		try {
			if (keyCombText!=null&&!keyCombText.isEmpty()) {
				//模糊查询
				json = keywordService.queryKeywords(category, keyCombText,
						null, rows, getStartPosi(),sort,order);
			} else {
				json = keywordService.queryKeywords(category, null, null,
						rows, getStartPosi(),sort,order);
			}
		} catch (Exception e) {
			logger.debug(e.getStackTrace());
			this.inputStream = castToInputStream(JsonUtil.formatToJson(0, ResponseStatus.FAIL,
					ResponseStatus.QUERY_FAILED + e.getMessage(), null));
			return "failure";
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String saveKeywords(){
		String[] keyIdArr = keyIds.split(",");
		if(keywordService.saveRecommands(keyIdArr)){
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.SUCCESS, "推荐成功！"));
			return SUCCESS;
		}else{
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, "推荐失败！"));
			return "failure";
		}
	}
	
	public String importKeywords(){
		//String regEx="[`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]"; 
		String regEx1 = "[\\pP‘’“”]";
		keywords = keywords.replaceAll(regEx1, ",");
		keywords = keywords.replaceAll(" ", "");
		String[] keywordsArr = keywords.split(",");
		List<String> list = new ArrayList<String>();
		
		//Remove Null Value from String array
	    for(String s : keywordsArr) {
	       if(s != null && s.length() > 0) {
	    	  s = s.trim();
	          list.add(s);
	       }
	    }
	    keywordsArr = list.toArray(new String[list.size()]);
	    boolean flag = false;
	    try {
	    	flag = keywordService.importKeywords(category, keywordsArr);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.SUCCESS, "导入失败！"));
			return "failure";
		}
		if(flag){
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.SUCCESS, "导入成功,无重复！"));
			return SUCCESS;
		}else{
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.SUCCESS, "导入成功并去除重复！"));
			return "failure";
		}
	}
	
	public String deleteKeyword(){
		try {
			String[] keyIdArr = keyIds.split(",");
			for(String kid : keyIdArr){
				keywordService.removeKeyword(Integer.parseInt(kid));
			}
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, "删除失败！"));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, "删除成功！"));
		return SUCCESS;
	}

	/**
	 * 查询生成ComboBox的数据
	 * 
	 * @return
	 */
	public String queryComboKeywords() {
		String json = "";
		try {
			json = keywordService.queryComboKeywords(category);
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	
	/**
	 * 给课程或文章的多个关键词查找相关关键词
	 * @return
	 */
	public String queryRelatedKeywords() {
		String json = "";
		try {
			json = solrKeywordService.queryRelatedKeywords(keywords,null,null);
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	//取推荐的前30个关键词显示在列表中
	public String getKeyWordsByType(){
		String json = "";
		String type = "003_0"+category;//(01-财务管理,02-采购供应链仓储,03-人力资源,04-生产管理,05-市场营销,06-战略管理,07-项目管理,08-职业技能)
		System.out.println(type);
		json = keywordService.getKeyWordsList(false, 2, type, 0, 30);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getLastedKeyWords(){
		String json = "";
		json = keywordService.getLastedKeyWords(0, 80);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getMoreKeyWordsByType(){
		String json = "";
		String type = "003_0"+category;//(01-财务管理,02-采购供应链仓储,03-人力资源,04-生产管理,05-市场营销,06-战略管理,07-项目管理,08-职业技能)

		json = keywordService.getKeyWordsListByType(type, this.getStartPosi(), rows);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	//查询type名字
	public String getTypeName(){
		String json = "";
		String type = "003_0"+category;//(01-财务管理,02-采购供应链仓储,03-人力资源,04-生产管理,05-市场营销,06-战略管理,07-项目管理,08-职业技能)
		json = dictionaryService.getDic(type, null);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String saveKeyword() {
		return SUCCESS;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Keyword getKeyword() {
		return keyword;
	}

	public void setKeyword(Keyword keyword) {
		this.keyword = keyword;
	}

	public String getKeyCombValue() {
		return keyCombValue;
	}

	public void setKeyCombValue(String keyCombValue) {
		this.keyCombValue = keyCombValue;
	}

	public String getKeyCombText() {
		return keyCombText;
	}

	public void setKeyCombText(String keyCombText) {
		this.keyCombText = keyCombText;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getKeyIds() {
		return keyIds;
	}

	public void setKeyIds(String keyIds) {
		this.keyIds = keyIds;
	}

	public String getAllKeywords() {
		return allKeywords;
	}

	public void setAllKeywords(String allKeywords) {
		this.allKeywords = allKeywords;
	}

	public IKeywordService getKeywordService() {
		return keywordService;
	}

	public void setKeywordService(IKeywordService keywordService) {
		this.keywordService = keywordService;
	}

	public ISolrKeywordService getSolrKeywordService() {
		return solrKeywordService;
	}

	public void setSolrKeywordService(ISolrKeywordService solrKeywordService) {
		this.solrKeywordService = solrKeywordService;
	}
	public IDictionaryService getDictionaryService() {
		return dictionaryService;
	}

	public void setDictionaryService(IDictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public Integer getKeyId() {
		return keyId;
	}

	public void setKeyId(Integer keyId) {
		this.keyId = keyId;
	}


}
