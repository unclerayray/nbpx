package com.nb.nbpx.utils.mapTool;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.service.system.IDictionaryService;

public class NbpxDicMap {
	
	public static String userTypeCode = "001";
	public static String courseTypeCode = "003";

	/**
	 * 用户种类字典 001
	 */
	public static Map<String,Object> userTypeMap;
	/**
	 * 课程种类字典 003
	 */
	public static Map<String,Object> courseTypeMap;

	public static IDictionaryService dictionaryService;

	public static IDictionaryService getDictionaryService() {
		return dictionaryService;
	}

	@Resource
	public static void setDictionaryService(IDictionaryService dictionaryService) {
		NbpxDicMap.dictionaryService = dictionaryService;
	}

	
	private static void initUserTypeMap(){
		List<Dictionary> userTypeList = dictionaryService.getDicListByType(NbpxDicMap.userTypeCode);
		NbpxDicMap.userTypeMap = new HashMap<String,Object>();
		NbpxDicMap.courseTypeMap = new HashMap<String,Object>();
		for(Dictionary dic:userTypeList){
			NbpxDicMap.userTypeMap.put(dic.getCodeName(), dic.getShowName());
		}
		
		List<Dictionary> courseTypeList = dictionaryService.getDicListByType(NbpxDicMap.courseTypeCode);
		for(Dictionary dic:courseTypeList){
			NbpxDicMap.courseTypeMap.put(dic.getCodeName(), dic.getShowName());
		}
	}
	
	private static void initCourseTypeMap(){
		NbpxDicMap.courseTypeMap = new HashMap<String,Object>();
		
		List<Dictionary> courseTypeList = dictionaryService.getDicListByType(NbpxDicMap.courseTypeCode);
		for(Dictionary dic:courseTypeList){
			NbpxDicMap.courseTypeMap.put(dic.getCodeName(), dic.getShowName());
		}
	}
	
	public static Map<String,Object> getUserTypeMap(){
		if(userTypeMap==null){
			initUserTypeMap();
		}
		return userTypeMap;
	}
	
	public static Map<String,Object> getCourseTypeMap(){
		if(courseTypeMap==null){
			initCourseTypeMap();
		}
		return courseTypeMap;
	}
}
