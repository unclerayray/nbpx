package com.nb.nbpx.service.zixun.impl;

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
	public String queryLiveScene(Map<String, Object> propsMap, Integer rows, Integer start,
			String sort, String order) {
		String json = "";
		List<LiveScene>  list = liveSceneDao.queryEntityListByProperties(LiveScene.class, rows, start, sort, order, propsMap);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithNoTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = liveSceneDao.queryTotalCount(LiveScene.class, propsMap).intValue();
			json = JsonUtil.formatToJsonWithNoTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}

}
