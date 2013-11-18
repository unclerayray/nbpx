package com.nb.nbpx.service.zixun;

import com.nb.nbpx.pojo.zixun.Download;

/**
 * @author Roger
 * @date 2013年11月18日
 */
public interface IDownloadService {

	public String queryDownloads(String type,Integer rows,
			Integer start, String sort, String order);
	
	public Download saveDownload(Download download) throws Exception ;
	public void deleteDownload(Download download);
}
