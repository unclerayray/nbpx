package com.nb.nbpx.dao.zixun.impl;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.zixun.ILiveSceneDao;
import com.nb.nbpx.pojo.zixun.LiveScene;

@Component("LiveSceneDao")
public class LiveSceneDaoImpl  extends BaseDaoImpl<LiveScene, Integer> implements
ILiveSceneDao {

}
