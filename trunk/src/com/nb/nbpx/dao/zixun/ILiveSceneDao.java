package com.nb.nbpx.dao.zixun;

import java.util.List;
import java.util.Map;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.zixun.LiveScene;

/**
 * @author Roger
 * @date 2014年1月4日
 */
public interface ILiveSceneDao  extends IBaseDao<LiveScene, Integer> {

	public List<LiveScene> queryLiveScence(Map<String, Object> propsMap,String title, Integer rows, Integer start,
			String sort, String order);
	
	public List<LiveScene> queryTuozhan(Map<String, Object> propsMap,String title, Integer rows, Integer start,
			String sort, String order);
	
	public Long queryLiveScenceTotalCount(Map<String, Object> propsMap,String title);
	
	public Long queryTuozhanTotalCount(Map<String, Object> propsMap,String title);
}
