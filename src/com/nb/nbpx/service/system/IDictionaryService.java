package com.nb.nbpx.service.system;

import java.util.List;

import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

public interface IDictionaryService extends IBaseService {
	//获取职位导航字段
	public String queryWorkDic(String workDicType);
	//获取城市字段
	public String queryCity(String cityDicType);
	/**
	 * 获取【字典项DataGrid】的JSON
	 * @param dicType
	 * @param codeName
	 * @param rows
	 * @param start
	 * @return
	 */
	public String queryDic(String dicType,String codeName,Integer rows, Integer start, String sort, String order);
	
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
	
	/**
	 * 用于获取ComboBox的，最新  前500个
	 * @param dicType
	 * @return
	 */
	public String queryComboByType(String dicType);
	
	public void saveDic(Dictionary dictionary) throws NbpxException ;
	
	public void deleteDic(Dictionary dictionary) throws NbpxException ;
	
	public String getDic(String codeName,String showName);
	
	/**
	 * 通过code或value得到
	 * @param codeName
	 * @param showName
	 * @return
	 */
	public Dictionary getDictionary(String codeName,String showName);
	
	public List<Dictionary> getDicListByType(String typeCode);
}
