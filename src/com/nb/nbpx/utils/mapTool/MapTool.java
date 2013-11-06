package com.nb.nbpx.utils.mapTool;

import java.util.HashMap;
import java.util.Map;

public class MapTool {
	public static Map<Integer, Integer> articlesHitsMap = new HashMap<Integer, Integer>();
	public static Map<Integer, Integer> coursesHitsMap = new HashMap<Integer, Integer>();
	public static Map<Integer, Integer> keywordsHitsMap = new HashMap<Integer, Integer>();
	public static Map<Integer, Integer> subjectsHitsMap = new HashMap<Integer, Integer>();
	public static Map<Integer, Integer> keywordsSearchCntMap = new HashMap<Integer, Integer>();
	public static Map<Integer, Integer> subjectsSearchCntMap = new HashMap<Integer, Integer>();
	public static Map<Integer, Integer> downloadCntMap = new HashMap<Integer, Integer>();

	/**
	 * 返回true则表示map中已存在记录，返回false则表示无记录，新增了记录。
	 * 
	 * @param articleId
	 * @return
	 */
	public static boolean addArticleHit(Integer articleId) {
		Integer count = articlesHitsMap.get(articleId);
		if (count == null) {
			count = 1;
			articlesHitsMap.put(articleId, count);
			return false;
		} else {
			articlesHitsMap.put(articleId, ++count);
			return true;
		}
	}

	/**
	 * 返回true则表示map中已存在记录，返回false则表示无记录，新增了记录。
	 * 
	 * @param keywordsId
	 * @return
	 */
	public static boolean addkeywordsHit(Integer keywordsId) {
		Integer count = keywordsHitsMap.get(keywordsId);
		if (count == null) {
			count = 1;
			keywordsHitsMap.put(keywordsId, count);
			return false;
		} else {
			keywordsHitsMap.put(keywordsId, ++count);
			return true;
		}
	}

	/**
	 * 返回true则表示map中已存在记录，返回false则表示无记录，新增了记录。
	 * 
	 * @param subjectId
	 * @return
	 */
	public static boolean addsubjectsHit(Integer subjectId) {
		Integer count = subjectsHitsMap.get(subjectId);
		if (count == null) {
			count = 1;
			subjectsHitsMap.put(subjectId, count);
			return false;
		} else {
			subjectsHitsMap.put(subjectId, ++count);
			return true;
		}
	}

	/**
	 * 返回true则表示map中已存在记录，返回false则表示无记录，新增了记录。
	 * 
	 * @param keywordId
	 * @return
	 */
	public static boolean addkeywordsSearchCnt(Integer keywordId) {
		Integer count = keywordsSearchCntMap.get(keywordId);
		if (count == null) {
			count = 1;
			keywordsSearchCntMap.put(keywordId, count);
			return false;
		} else {
			keywordsSearchCntMap.put(keywordId, ++count);
			return true;
		}
	}

	/**
	 * 返回true则表示map中已存在记录，返回false则表示无记录，新增了记录。
	 * 
	 * @param subjectId
	 * @return
	 */
	public static boolean addsubjectsSearchCnt(Integer subjectId) {
		Integer count = subjectsSearchCntMap.get(subjectId);
		if (count == null) {
			count = 1;
			subjectsSearchCntMap.put(subjectId, count);
			return false;
		} else {
			subjectsSearchCntMap.put(subjectId, ++count);
			return true;
		}
	}

	/**
	 * 返回true则表示map中已存在记录，返回false则表示无记录，新增了记录。
	 * 
	 * @param courseId
	 * @return
	 */
	public static boolean addcoursesHit(Integer courseId) {
		Integer count = coursesHitsMap.get(courseId);
		if (count == null) {
			count = 1;
			coursesHitsMap.put(courseId, count);
			return false;
		} else {
			coursesHitsMap.put(courseId, ++count);
			return true;
		}
	}
	
	/**
	 * 返回true则表示map中已存在记录，返回false则表示无记录，新增了记录。
	 * 
	 * @param docId
	 * @return
	 */
	public static boolean addDownloadCnt(Integer docId) {
		Integer count = downloadCntMap.get(docId);
		if (count == null) {
			count = 1;
			downloadCntMap.put(docId, count);
			return false;
		} else {
			downloadCntMap.put(docId, ++count);
			return true;
		}
	}
}
