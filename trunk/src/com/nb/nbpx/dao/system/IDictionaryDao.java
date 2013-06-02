package com.nb.nbpx.dao.system;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.system.Dictionary;

/**
 * @author Roger
 * @date 2013-4-29
 */
@SuppressWarnings("rawtypes")
public interface IDictionaryDao extends IBaseDao<Dictionary, Integer> {
	public List<Dictionary> queryDictionary(String dicType,String showName,Integer rows, Integer start);
	public Long queryDictionaryCount(String dicType,String showName);
	public List queryDicTypes();
	public void addDic(Dictionary dictionary);
	public void deleteDic(Dictionary dictionary);
}
