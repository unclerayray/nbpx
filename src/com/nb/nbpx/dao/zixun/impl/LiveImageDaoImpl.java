package com.nb.nbpx.dao.zixun.impl;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.zixun.ILiveImageDao;
import com.nb.nbpx.pojo.zixun.LiveImage;

@Component("LiveImageDao")
public class LiveImageDaoImpl extends BaseDaoImpl<LiveImage, Integer> implements
ILiveImageDao{

	@Override
	public boolean deleteByType(Integer liveSceneId, String imageName) {
		Object[] values = {liveSceneId,imageName};
		return this.bulkUpdate("delete from LiveImage where liveSceneId = ? and imageName = ?", values) > 0 ? true:false;
	}

	@Override
	public boolean deleteByKeyCode(String keyCode) {
		Object[] values = {keyCode};
		return this.bulkUpdate("delete from LiveImage where keyCode = ?", values) > 0 ? true:false;
	}

}
