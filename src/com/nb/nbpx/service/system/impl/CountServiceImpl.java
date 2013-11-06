package com.nb.nbpx.service.system.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.system.ICountDao;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.system.ICountService;

@Component("CountService")
public class CountServiceImpl  extends BaseServiceImpl implements
ICountService{
	public ICountDao countDao;
	public ICountDao getCountDao() {
		return countDao;
	}
	@Resource
	public void setCountDao(ICountDao countDao) {
		this.countDao = countDao;
	}
	@Override
	public void updateAllCnt(Map<Integer, Integer> articlesHitsMap,
			Map<Integer, Integer> coursesHitsMap,
			Map<Integer, Integer> keywordsHitsMap,
			Map<Integer, Integer> subjectsHitsMap,
			Map<Integer, Integer> keywordsSearchCntMap,
			Map<Integer, Integer> subjectsSearchCntMap,
			Map<Integer, Integer> downloadCntMap) {

		List<Map.Entry<Integer, Integer>> articlesHitsList = 
			    new ArrayList<Map.Entry<Integer, Integer>>(articlesHitsMap.entrySet());
		countDao.updateArticlesHitsList(articlesHitsList);
		
		List<Map.Entry<Integer, Integer>> coursesHitsList = 
			    new ArrayList<Map.Entry<Integer, Integer>>(coursesHitsMap.entrySet());
		countDao.updateCoursesHitsList(coursesHitsList);
		
		//TODO keyword和subject可以放到一个SQL语句中去更新
		List<Map.Entry<Integer, Integer>> keywordsHitsList = 
			    new ArrayList<Map.Entry<Integer, Integer>>(keywordsHitsMap.entrySet());
		countDao.updateKeywordsHitsList(keywordsHitsList);
		
		List<Map.Entry<Integer, Integer>> subjectsHitsList = 
			    new ArrayList<Map.Entry<Integer, Integer>>(subjectsHitsMap.entrySet());
		countDao.updateSubjectsHitsList(subjectsHitsList);
		
		List<Map.Entry<Integer, Integer>> keywordsSearchCntList = 
			    new ArrayList<Map.Entry<Integer, Integer>>(keywordsSearchCntMap.entrySet());
		countDao.updateKeywordsSearchCntList(keywordsSearchCntList);
		
		List<Map.Entry<Integer, Integer>> subjectsSearchCntList = 
			    new ArrayList<Map.Entry<Integer, Integer>>(subjectsSearchCntMap.entrySet());
		countDao.updateSubjectsSearchCntList(subjectsSearchCntList);
		
		List<Map.Entry<Integer, Integer>> downloadCntList = 
			    new ArrayList<Map.Entry<Integer, Integer>>(downloadCntMap.entrySet());
		countDao.updateDownloadCntList(downloadCntList);
	}

}
