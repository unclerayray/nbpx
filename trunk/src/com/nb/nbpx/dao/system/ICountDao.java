package com.nb.nbpx.dao.system;

import java.util.List;
import java.util.Map;

import com.nb.nbpx.dao.IBaseDao;

@SuppressWarnings("rawtypes")
public interface ICountDao extends IBaseDao{
	public void updateArticlesHitsList(List<Map.Entry<Integer, Integer>> list);
	public void updateCoursesHitsList(List<Map.Entry<Integer, Integer>> list);
	public void updateKeywordsHitsList(List<Map.Entry<Integer, Integer>> list);
	public void updateSubjectsHitsList(List<Map.Entry<Integer, Integer>> list);
	public void updateKeywordsSearchCntList(List<Map.Entry<Integer, Integer>> list);
	public void updateSubjectsSearchCntList(List<Map.Entry<Integer, Integer>> list);
	public void updateDownloadCntList(List<Map.Entry<Integer, Integer>> list);

}
