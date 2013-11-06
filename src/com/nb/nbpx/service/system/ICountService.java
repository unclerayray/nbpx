package com.nb.nbpx.service.system;

import java.util.Map;

import com.nb.nbpx.service.IBaseService;

public interface ICountService extends IBaseService {
	public void updateAllCnt(Map<Integer, Integer> articlesHitsMap,
			Map<Integer, Integer> coursesHitsMap,
			Map<Integer, Integer> keywordsHitsMap,
			Map<Integer, Integer> subjectsHitsMap,
			Map<Integer, Integer> keywordsSearchCntMap,
			Map<Integer, Integer> subjectsSearchCntMap,
			Map<Integer, Integer> downloadCntMap);
}
