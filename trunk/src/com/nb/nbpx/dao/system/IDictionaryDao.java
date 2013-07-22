package com.nb.nbpx.dao.system;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.system.Dictionary;

/**
 * @author Roger
 * @date 2013-4-29
 */
public interface IDictionaryDao extends IBaseDao<Dictionary, Integer> {
	public List<Dictionary> queryDictionary(String dicType,String codeName,Integer rows, Integer start);
	public Long queryDictionaryCount(String dicType,String showName);
	public List<Dictionary> queryDicTypes(Integer rows, Integer start);
	public Long queryDicTypesCount();
	public void addDic(Dictionary dictionary);
	public void deleteDic(Dictionary dictionary);
	/**
	 * 通过字典值或字典码获取字典
	 * @param codeName
	 * @param showName
	 * @return
	 */
	public Dictionary getDictionary(String codeName,String showName);
	/**
	 * 检查重复字典项
	 * @param dictionary
	 * @return true表示有重复，false表示无重复
	 */
	public boolean checkDuplicateProp(Dictionary dictionary);
	/**
	 * 检查字典类是否可删除，类下有字典项的不允许删除
	 * @param dictionary
	 * @return true表示可删除，false表示不可删除
	 */
	public boolean checkShouldDelete(Dictionary dictionary);
}
