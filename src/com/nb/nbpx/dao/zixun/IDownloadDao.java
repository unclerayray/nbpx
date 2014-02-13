package com.nb.nbpx.dao.zixun;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.zixun.Download;

/**
 * @author Roger
 * @date 2013年11月18日
 */
public interface IDownloadDao extends IBaseDao<Download, Integer> {
	
	public List<Download> getDownLoads(String type, Integer rows, Integer start,
			String sort, String order);
	
	public Integer getDownLoadsCount(String type, Integer rows, Integer start,
			String sort, String order);
}
