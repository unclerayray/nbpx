package com.nb.nbpx.service.zixun;

import java.util.Map;

import com.nb.nbpx.pojo.zixun.LiveScene;
import com.nb.nbpx.utils.NbpxException;

public interface ILiveSceneService {
	public String queryLiveScene(Map<String, Object> propsMap,String title, Integer rows, Integer start,
			String sort, String order, Boolean isLiveScene);
	
	public LiveScene saveLiveScene(LiveScene liveScene) throws NbpxException ;
	
	public void deleteliveScene(Integer liveSceneId);
}
