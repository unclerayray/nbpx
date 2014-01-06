package com.nb.nbpx.server.zixun;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.zixun.ILiveSceneService;
import com.nb.nbpx.utils.JsonUtil;


@Component("LiveSceneAction")
@Scope("prototype")
public class LiveSceneAction  extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public File file;
	public String filename;
	public ILiveSceneService liveSceneService;

	
	public File getFile() {
		return file;
	}


	public void setFile(File file) {
		this.file = file;
	}

	public String queryLiveScene() {
		Map<String, Object> propsMap = new HashMap<String, Object>();
		String json = liveSceneService.queryLiveScene(propsMap, rows,
				getStartPosi(), sort, order);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String saveImages(){
		if(file!=null){
			System.out.println("Yeah bitch!");
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public ILiveSceneService getLiveSceneService() {
		return liveSceneService;
	}

	@Resource
	public void setLiveSceneService(ILiveSceneService liveSceneService) {
		this.liveSceneService = liveSceneService;
	}
}
