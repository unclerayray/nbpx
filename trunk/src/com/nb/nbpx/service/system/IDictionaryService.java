package com.nb.nbpx.service.system;

import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.service.IBaseService;

public interface IDictionaryService extends IBaseService {
	public String queryDic(String dicType,String showName,Integer rows, Integer start);
	
	public String queryDicTypes();
	
	public void saveDic(Dictionary dictionary);
	
	public void deleteDic(Dictionary dictionary);
}
