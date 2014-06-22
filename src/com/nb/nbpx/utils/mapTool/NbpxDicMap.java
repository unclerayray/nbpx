package com.nb.nbpx.utils.mapTool;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.service.system.IDictionaryService;

@Component
public class NbpxDicMap {
    public static Logger logger = LogManager.getLogger(NbpxDicMap.class);
	
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
	
	@Autowired
	private IDictionaryService tmpService;

	@PostConstruct
	public void init() {
		dictionaryService = tmpService;
		logger.info("dictionaryService initilazed...");
	}

	public static IDictionaryService dictionaryService;

	public static IDictionaryService getDictionaryService() {
		return dictionaryService;
	}

	public static void setDictionaryService(IDictionaryService dictionaryService) {
		NbpxDicMap.dictionaryService = dictionaryService;
	}

	
	private static void initUserTypeMap(){
		List<Dictionary> userTypeList = dictionaryService.getDicListByType(NbpxDicMap.userTypeCode);
		NbpxDicMap.userTypeMap = new HashMap<String,Object>();
		for(Dictionary dic:userTypeList){
			NbpxDicMap.userTypeMap.put(dic.getCodeName(), dic.getShowName());
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
