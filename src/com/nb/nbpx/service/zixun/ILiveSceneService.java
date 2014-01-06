package com.nb.nbpx.service.zixun;

import java.util.Map;

public interface ILiveSceneService {
	public String queryLiveScene(Map<String, Object> propsMap, Integer rows, Integer start,
			String sort, String order);
}
