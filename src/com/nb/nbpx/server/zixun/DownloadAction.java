package com.nb.nbpx.server.zixun;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.zixun.Download;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.zixun.IDownloadService;
import com.nb.nbpx.utils.JsonUtil;

@Component("DownloadAction")
@Scope("prototype")
public class DownloadAction   extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public IDownloadService downloadService;
	public String filetype;
	public Download download;
	
	public String queryDownloads(){
		String json = downloadService.queryDownloads(filetype, rows, getStartPosi(), filetype, order);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String saveDownload(){
		try {
			downloadService.saveDownload(download);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}
	
	public String deleteDownload(){
		downloadService.deleteDownload(download);
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}

	public IDownloadService getDownloadService() {
		return downloadService;
	}

	@Resource
	public void setDownloadService(IDownloadService downloadService) {
		this.downloadService = downloadService;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public Download getDownload() {
		return download;
	}

	public void setDownload(Download download) {
		this.download = download;
	}

}
