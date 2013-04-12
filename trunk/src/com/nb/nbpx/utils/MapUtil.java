package com.nb.nbpx.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Map工具类
 * 
 * 创建时间：2012-2-13 15:59
 * @author zhutianjie
 * @version v1.0
 *
 */
public class MapUtil {

	/**
	 * 过滤NULL值
	 * @param targetMap
	 * @return
	 */
	public static Map<String, Object> removeNullValue(Map<String, Object> targetMap) {
		Set<String> propsKeies = targetMap.keySet();
		Object[] propsArray = propsKeies.toArray();
		for (int i = 0; i < propsArray.length; i++) {
			if (targetMap.get(propsArray[i]) == null)
				targetMap.remove(propsArray[i]);
		}
		return targetMap;
	}
	
	/**
	 * 因为Struts2会自动将请求发送过后台的Map转型为Map<String,String[]> <br />
	 * 所以可以调用此方法将其转换为Map<String,String>
	 * @param targetMap 目标Map
	 * @return
	 */
	public static Map<String, String> string2String(Map<String,String[]> targetMap) {
		Map<String, String> string2StringMap = new HashMap<String, String>();
		Set<String> keies = targetMap.keySet();
		for(String s : keies) {
			String[] array = (String[])targetMap.get(s);
			string2StringMap.put(s, array[0]);
		}
		return string2StringMap;
	}
	
}
