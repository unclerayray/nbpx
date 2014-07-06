package com.nb.nbpx.server.system;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.system.IDictionaryService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

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
	//show name for like
	public String p_codeName;
	public String dics;
	
	//查询职位导航
	public String queryWork(){
		String json = dictionaryService.queryWorkDic("29");
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	//查询城市字典
	public String queryCity(){
		String json = dictionaryService.queryCity("007");
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String queryDictionary() {
		String json = dictionaryService.queryDic(p_dicType, p_codeName, rows,
				getStartPosi(), sort, order);
		//TODO 字典查询 codeName Or showName
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
			if (dictionary.getDicType() == null
					|| dictionary.getDicType().isEmpty()) {
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

	public String batchImport() {
		String regEx = "[`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";
		String regEx1 = "[\\pP‘’“”]";
		dics = dics.replaceAll(" ", "");
		dics = dics.replaceAll(regEx1, ",");
		String[] dicsArr = dics.split(",");
		int init_length = dicsArr.length;
		Set<String> uniqueWords = new HashSet<String>(Arrays.asList(dicsArr));
		dicsArr = uniqueWords.toArray(new String[0]);
		String msg = "";
		int cnt = 0;
		for (String dic : dicsArr) {
			Dictionary di = new Dictionary();
			di.setDicType(p_dicType);
			dic = dic.trim();
			di.setShowName(dic);
			System.out.println("dic ="+dic);
			di.setFlag(true);
			try {
				dictionaryService.saveDic(di);
				cnt++;
			} catch (NbpxException e) {
			}
		}
		if(init_length - cnt>0){
			msg = init_length - cnt+"项重复，已忽略！";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS+msg));
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
	
	/**
	 * 用这个函数获取字典相关的下拉菜单
	 * @return
	 */
	public String getComboDicByType(){
		String json = dictionaryService.queryComboByType(p_dicType);
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

	public String getDics() {
		return dics;
	}

	public void setDics(String dics) {
		this.dics = dics;
	}

}
