package com.nb.nbpx.service.zixun.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.zixun.IDownloadDao;
import com.nb.nbpx.pojo.zixun.Download;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.zixun.IDownloadService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.daotool.Equality;

/**
 * @author Roger
 * @date 2013年11月18日
 */
@Component("DownloadService")
public class DownloadServiceImpl extends BaseServiceImpl implements IDownloadService{

	public IDownloadDao downloadDao;
	
	public IDownloadDao getDownloadDao() {
		return downloadDao;
	}

	@Resource
	public void setDownloadDao(IDownloadDao downloadDao) {
		this.downloadDao = downloadDao;
	}

	@Override
	public String queryDownloads(String type, Integer rows, Integer start,
			String sort, String order, String title, String category) {
		String json = "";
		Map<String, Object> propsMap = new HashMap<String, Object>();
		if(!"".equals(type)){
			propsMap = this.createPropMap(new Equality(
					"filetype", type));
		}
		if(category != null && !"".equals(category)){
			propsMap.put("category", category);
		}
		Map<String, Object> likeMap = new HashMap<String, Object>();
		if(title != null && !"".equals(title)){
			likeMap.put("title", title);
		}
		List<Download>  list = downloadDao.queryListByPropAndLike(Download.class, rows, start, sort, order, propsMap, likeMap);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = downloadDao.queryLikeTotalCount(Download.class, propsMap, likeMap).intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}

	@Override
	public Download saveDownload(Download download) throws Exception {
		if(download.getDownloadId()!=null){
			downloadDao.saveOrUpdate(download);
			//TODO 更新文件
		}else{
			Map<String, Object> propsMap = this.createPropMap(new Equality(
					"title", download.title));
			//TODO 存储文件
			if(downloadDao.queryEntityByProperties(Download.class, propsMap)!=null){
				throw new Exception("已有同名的下载存在，请不要重复上传!");
			}
			download.setDownloadCnt(200);
			download.setHits(200);
			download.setUploadDate(new Date());
			downloadDao.save(download);
		}
		return download;
	}

	@Override
	public void deleteDownload(Download download) {
		downloadDao.delete(download);
		//TODO 删除硬盘下的文件
	}

	@Override
	public Download getById(Integer Id) {
		return downloadDao.get(Id);
	}
	
	//获取所有下载
	public String getDownloads(String type,Integer rows,
			Integer start, String sort, String order){
		
		List<Download> downloads = downloadDao.getDownLoads(type, rows, start, sort, order);
		Integer totalRows = downloadDao.getDownLoadsCount(type, rows, start, sort, order);
		String json = JsonUtil.formatToJsonWithTimeStamp(totalRows,
				ResponseStatus.SUCCESS, "", downloads);
		
		return json;
	}

}
