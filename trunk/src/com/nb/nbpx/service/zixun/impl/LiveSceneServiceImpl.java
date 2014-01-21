package com.nb.nbpx.service.zixun.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.zixun.ILiveSceneDao;
import com.nb.nbpx.pojo.zixun.LiveScene;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.zixun.ILiveSceneService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

/**
 * @author Roger
 * @date 2014年1月4日
 */
@Component("LiveSceneService")
public class LiveSceneServiceImpl  extends BaseServiceImpl implements ILiveSceneService{

	public ILiveSceneDao liveSceneDao;
	
	public ILiveSceneDao getLiveSceneDao() {
		return liveSceneDao;
	}

	@Resource
	public void setLiveSceneDao(ILiveSceneDao liveSceneDao) {
		this.liveSceneDao = liveSceneDao;
	}

	@Override
	public String queryLiveScene(Map<String, Object> propsMap,String title, Integer rows, Integer start,
			String sort, String order, Boolean isLiveScene) {
		String json = "";
		if(isLiveScene){
			List<LiveScene>  list = liveSceneDao.queryLiveScence(propsMap,title, rows, start, sort, order);
			if (list.isEmpty()) {
				json = JsonUtil.formatToJsonWithNoTimeStamp(0,
						ResponseStatus.SUCCESS, "", list);
			} else {
				int count = liveSceneDao.queryLiveScenceTotalCount(propsMap,title).intValue();
				json = JsonUtil.formatToJsonWithNoTimeStamp(count,
						ResponseStatus.SUCCESS, "", list);
			}
		}else{
			List<LiveScene>  list = liveSceneDao.queryTuozhan(propsMap,title, rows, start, sort, order);
			if (list.isEmpty()) {
				json = JsonUtil.formatToJsonWithNoTimeStamp(0,
						ResponseStatus.SUCCESS, "", list);
			} else {
				int count = liveSceneDao.queryTuozhanTotalCount(propsMap,title).intValue();
				json = JsonUtil.formatToJsonWithNoTimeStamp(count,
						ResponseStatus.SUCCESS, "", list);
			}
		}
		

		return json;
	}

	@Override
	public LiveScene saveLiveScene(LiveScene liveScene) throws NbpxException {
		if(liveScene.getLiveSceneId()!=null){
			liveSceneDao.saveOrUpdate(liveScene);
		}else{
			Map<String, Object> propsMap = new HashMap<String, Object>();
			propsMap.put("title", liveScene.getTitle());
			LiveScene ls = liveSceneDao.queryEntityByProperties(LiveScene.class, propsMap);
			if(ls!=null) {
				throw new NbpxException("已存在相同标题！");
				//TODO potential bug，duplicate title may occur when edit a already saved entity with a existing title
			}
			liveSceneDao.save(liveScene);
		}
		return liveScene;
	}

	@Override
	public void deleteliveScene(Integer liveSceneId) {
		LiveScene liveScene = liveSceneDao.getById(LiveScene.class, liveSceneId);
		liveSceneDao.delete(liveScene);
	}

}
