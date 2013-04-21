package com.nb.nbpx.service.system.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.system.IDictionaryService;
import com.nb.nbpx.utils.JsonUtil;

@Component("DictionaryService")
@SuppressWarnings({ "rawtypes" })
public class DictionaryServiceImpl extends BaseServiceImpl implements
		IDictionaryService {

	public IDictionaryDao dicDao;

	@Override
	public String queryDicTypes() {
		List list = dicDao.queryDicTypes();
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	@Override
	public String queryDic(String dicType, String showName, Integer rows,
			Integer start) {
		String json = "";
		List<Dictionary> list = dicDao.queryDictionary(dicType, showName, rows, start);
		if(list.isEmpty()){
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.FAIL, "", list);
		}else{
			int count = dicDao.queryDictionaryCount(dicType, showName).intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}
		
		return json;
	}

	@Override
	public void saveDic(Dictionary dictionary) {
		if(dictionary.getDicId()==null){
			dicDao.save(dictionary);
		}else{
			dicDao.saveOrUpdate(dictionary);
		}
	}

	@Override
	public void deleteDic(Dictionary dictionary) {
		dicDao.delete(dictionary);
	}

	public IDictionaryDao getDicDao() {
		return dicDao;
	}

	@Resource
	public void setDicDao(IDictionaryDao dicDao) {
		this.dicDao = dicDao;
	}

}
