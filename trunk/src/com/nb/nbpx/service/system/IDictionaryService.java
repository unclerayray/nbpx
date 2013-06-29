package com.nb.nbpx.service.system;

import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

public interface IDictionaryService extends IBaseService {
	/**
	 * 获取【字典项DataGrid】的JSON
	 * @param dicType
	 * @param codeName
	 * @param rows
	 * @param start
	 * @return
	 */
	public String queryDic(String dicType,String codeName,Integer rows, Integer start);
	
	/**
	 * 获取【字典类别DataGrid】的JSON
	 * @param rows
	 * @param start
	 * @return
	 */
	public String queryDicType(Integer rows, Integer start);
	
	/**
	 * 用于获取【字典类别ComboBox】的JSON
	 * @return
	 */
	public String queryComboDicTypes();
	
	/**
	 * 用于获取【字典值ComboBox】的JSON
	 * @return
	 */
	public String queryComboDics(String dicType);
	
	public void saveDic(Dictionary dictionary) throws NbpxException ;
	
	public void deleteDic(Dictionary dictionary) throws NbpxException ;
}
