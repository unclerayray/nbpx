package com.nb.nbpx.service.zixun.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.common.Logger;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.zixun.ILiveImageDao;
import com.nb.nbpx.dao.zixun.ILiveSceneDao;
import com.nb.nbpx.pojo.zixun.LiveImage;
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
	
	public static Logger log = Logger.getLogger(LiveSceneServiceImpl.class);

	public ILiveSceneDao liveSceneDao;
	
	public ILiveSceneDao getLiveSceneDao() {
		return liveSceneDao;
	}

	@Resource
	public void setLiveSceneDao(ILiveSceneDao liveSceneDao) {
		this.liveSceneDao = liveSceneDao;
	}
	
	public ILiveImageDao liveImageDao;
	
	public ILiveImageDao getLiveImageDao() {
		return liveImageDao;
	}

	@Resource
	public void setLiveImageDao(ILiveImageDao liveImageDao) {
		this.liveImageDao = liveImageDao;
	}
	
	public String saveImage(LiveImage image){
		boolean isUpdate = liveImageDao.deleteByType(image.getLiveScene().getLiveSceneId(), image.getImageName());
		log.debug(isUpdate?"update image " + image.getImageName() +" of " + image.getLiveScene().getLiveSceneId():"insert image " + image.getImageName() +" of " + image.getLiveScene().getLiveSceneId());
		liveImageDao.save(image);
		return null;
	}

	public String getLiveScene(Map<String, Object> propsMap,Integer rows, Integer start,Boolean isLiveScene){
		String json = "[";
		List<LiveScene> list = new ArrayList<LiveScene>();
		if(isLiveScene){
			  list = liveSceneDao.queryLiveScence(propsMap,null, rows, start, null, null);
		}else{
			list = liveSceneDao.queryTuozhan(propsMap,null, rows, start, null, null);
		}
		if(list != null && list.size() != 0){
			for(int i=0;i<list.size();i++){
				LiveScene temp = list.get(i);
				json += "{\"name\":\""+temp.getTitle()+"\",\"id\":\""+temp.getLiveSceneId()+"\",\"images\":[";
				List<LiveImage> images = liveSceneDao.getImages(temp.getLiveSceneId().toString());
				if(images != null){
					for(int j=0;j<images.size();j++){
						LiveImage image = images.get(j);
						if(image != null)
							json +="{\"url\":\""+image.getUrl()+"\"}";
						if(j!= images.size()-1)
							json += ",";
					}
					json += "]}";
				}
				
				if(i != list.size() -1)
					json += ",";
				
			}
		}
		json += "]";
		return json;
	}
	public String viewLiveScene(String liveID){
		String result = "{";
		LiveScene temp = liveSceneDao.get(Integer.parseInt(liveID));
		if(temp != null){
			result += "\"name\":\""+temp.getTitle()+"\",\"images\":[";
			List<LiveImage> images = liveSceneDao.getImages(liveID);
			if(images != null){
				for(int i=0;i<images.size();i++){
					LiveImage image = images.get(i);
					if(image != null)
						result +="{\"url\":\""+image.getUrl()+"\"}";
					if(i!= images.size()-1)
						result += ",";
				}
			}
			result += "]}";
		}
		return result;
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

	@Override
	public String saveAd(LiveImage image) {
		boolean isUpdate = liveImageDao.deleteByKeyCode(image.getKeyCode());
		log.debug(isUpdate?"update add " + image.getKeyCode():"insert ad image " + image.getImageName());
		liveImageDao.save(image);
		return null;
	}

}
