package com.nb.nbpx.dao.zixun;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.zixun.LiveImage;

public interface ILiveImageDao extends IBaseDao<LiveImage, Integer> {
	public boolean deleteByType(Integer liveSceneId,String imageName);
}
