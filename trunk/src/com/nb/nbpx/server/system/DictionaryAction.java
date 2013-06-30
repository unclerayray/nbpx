package com.nb.nbpx.server.system;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.system.IDictionaryService;
import com.nb.nbpx.utils.JsonUtil;

@Component("DictionaryAction")
@Scope("prototype")
public class DictionaryAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public Dictionary dictionary;
	public IDictionaryService dictionaryService;
	public String p_dicType;
	public String p_codeName;

	public String queryDictionary() {
		String json = dictionaryService.queryDic(p_dicType, p_codeName, rows,
				getStartPosi());
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String queryDicType() {
		String json = dictionaryService.queryDicType(rows, getStartPosi());
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String saveDic() {
		try {
			if(dictionary.getDicType()==null||dictionary.getDicType().isEmpty()){
				dictionary.setDicType("998");
			}
			dictionaryService.saveDic(dictionary);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}

	public String deleteDic() {
		try {
			dictionaryService.deleteDic(dictionary);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.DELETE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}

	public String queryComboDicTypes() {
		String json = dictionaryService.queryComboDicTypes();
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String queryComboDics() {
		String json = dictionaryService.queryComboDics(p_dicType);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public Dictionary getDictionary() {
		return dictionary;
	}

	public void setDictionary(Dictionary dictionary) {
		this.dictionary = dictionary;
	}

	public IDictionaryService getDictionaryService() {
		return dictionaryService;
	}

	@Resource
	public void setDictionaryService(IDictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public String getP_dicType() {
		return p_dicType;
	}

	public void setP_dicType(String p_dicType) {
		this.p_dicType = p_dicType;
	}

	public String getP_codeName() {
		return p_codeName;
	}

	public void setP_codeName(String p_codeName) {
		this.p_codeName = p_codeName;
	}

}
