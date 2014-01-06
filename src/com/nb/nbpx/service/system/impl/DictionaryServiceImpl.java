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
import com.nb.nbpx.utils.NbpxException;

@Component("DictionaryService")
@SuppressWarnings({ "rawtypes" })
public class DictionaryServiceImpl extends BaseServiceImpl implements
		IDictionaryService {

	public IDictionaryDao dicDao;

	@Override
	public String queryComboDicTypes() {
		List list = dicDao.queryDicTypes(null,null);
		String json = JsonUtil.formatListToJson(list);
		return json;
	}
	
	@Override
	public String queryComboDics(String dicType) {
		List list = dicDao.queryDictionary(dicType, null, 100, 0 , null, null);
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	@Override
	public String queryDic(String dicType, String showName, Integer rows,
			Integer start, String sort, String order) {
		String json = "";
		List<Dictionary> list = dicDao.queryDictionary(dicType, showName, rows, start, sort, order);
		if(list.isEmpty()){
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		}else{
			int count = dicDao.queryDictionaryCount(dicType, showName).intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}
		
		return json;
	}
	

	@Override
	public String queryDicType(Integer rows, Integer start) {
		String json = "";
		List<Dictionary> list = dicDao.queryDicTypes(rows, start);
		if(list.isEmpty()){
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		}else{
			int count = dicDao.queryDicTypesCount().intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}
		
		return json;
	}


	@Override
	public void saveDic(Dictionary dictionary) throws NbpxException {
		if(dictionary.getDicId()==null){
			if(dicDao.checkDuplicateProp(dictionary)){
				throw new NbpxException("字典项重复，请检查！");
			}
			dictionary.setCodeName(dicDao.getLatestCode(dictionary.getDicType()));
			dicDao.save(dictionary);
		}else{
			dicDao.saveOrUpdate(dictionary);
		}
	}

	@Override
	public void deleteDic(Dictionary dictionary) throws NbpxException {
		if("998".equals(dictionary.getDicType())||dictionary.getDicType()==null||dictionary.getDicType().isEmpty()){
			if(dicDao.checkShouldDelete(dictionary)){
				dicDao.delete(dictionary);
			}else{
				throw new NbpxException("此字典类下含有字典项，不建议删除！");
			}
		}
		dicDao.delete(dictionary);
	}
	
	@Override
	public String getDic(String codeName,String showName){
		Dictionary dic = dicDao.getDictionary(codeName, showName);
		return JsonUtil.getJsonString(dic);
	}

	public IDictionaryDao getDicDao() {
		return dicDao;
	}

	@Resource
	public void setDicDao(IDictionaryDao dicDao) {
		this.dicDao = dicDao;
	}

	@Override
	public String queryComboByType(String dicType) {
		List list = dicDao.getDicForCombo(dicType);
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	

}
