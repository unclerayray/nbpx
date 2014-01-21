package com.nb.nbpx.server.zixun;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.zixun.LiveScene;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.zixun.ILiveSceneService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.SolrUtil;

@Component("LiveSceneAction")
@Scope("prototype")
public class LiveSceneAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String liveSceneId;
	public File cover;
	public String coverFileName;
	public File photo1;
	public String photo1FileName;
	public File photo2;
	public String photo2FileName;
	public File photo3;
	public String photo3FileName;
	public String title;
	public String teacher;
	public Date liveDate;
	public String category;
	public String site;
	public LiveScene liveScene;
	public ILiveSceneService liveSceneService;

	public String queryLiveScene() {
		Map<String, Object> propsMap = new HashMap<String, Object>();
		if (category != null&&!category.isEmpty()) {
			propsMap.put("category", category);
		}
		String json = liveSceneService.queryLiveScene(propsMap, title, rows,
				getStartPosi(), sort, order, true);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String queryTuozhan() {
		Map<String, Object> propsMap = new HashMap<String, Object>();
		String json = liveSceneService.queryLiveScene(propsMap, title, rows,
				getStartPosi(), sort, order, false);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String deleteLiveScene() {
		try {
			liveSceneService.deleteliveScene(Integer.parseInt(liveSceneId));
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.DELETE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}

	public String saveLiveSceneInfo() {
		try {
			liveScene = new LiveScene();
			liveScene.setCategory(category);
			liveScene.setLiveDate(liveDate);
			liveScene.setSite(site);
			liveScene.setTeacher(teacher);
			liveScene.setTitle(title);
			if (liveSceneId != null && !liveSceneId.isEmpty()) {
				liveScene.setLiveSceneId(Integer.parseInt(liveSceneId));
			}
			liveScene = liveSceneService.saveLiveScene(liveScene);
			if (liveScene.getLiveSceneId() != null) {
				if (cover != null) {
					String realpath = SolrUtil.getLiveScenePhotoPath();
					realpath = realpath + File.separator
							+ liveScene.getLiveSceneId();

					String ext = FilenameUtils.getExtension(coverFileName);

					File savefile = new File(new File(realpath), "cover" + "."
							+ ext);
					if (!savefile.getParentFile().exists())
						savefile.getParentFile().mkdirs();
					FileUtils.copyFile(cover, savefile);
				}
				if (photo1 != null) {
					String realpath = SolrUtil.getLiveScenePhotoPath();
					realpath = realpath + File.separator
							+ liveScene.getLiveSceneId();

					String ext = FilenameUtils.getExtension(photo1FileName);

					File savefile = new File(new File(realpath), "photo1" + "."
							+ ext);
					if (!savefile.getParentFile().exists())
						savefile.getParentFile().mkdirs();
					FileUtils.copyFile(photo1, savefile);
				}
				if (photo2 != null) {
					String realpath = SolrUtil.getLiveScenePhotoPath();
					realpath = realpath + File.separator
							+ liveScene.getLiveSceneId();

					String ext = FilenameUtils.getExtension(photo2FileName);

					File savefile = new File(new File(realpath), "photo2" + "."
							+ ext);
					if (!savefile.getParentFile().exists())
						savefile.getParentFile().mkdirs();
					FileUtils.copyFile(photo2, savefile);
				}
				if (photo3 != null) {
					String realpath = SolrUtil.getLiveScenePhotoPath();
					realpath = realpath + File.separator
							+ liveScene.getLiveSceneId();

					String ext = FilenameUtils.getExtension(photo3FileName);

					File savefile = new File(new File(realpath), "photo3" + "."
							+ ext);
					if (!savefile.getParentFile().exists())
						savefile.getParentFile().mkdirs();
					FileUtils.copyFile(photo3, savefile);
				}
			}
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

	public ILiveSceneService getLiveSceneService() {
		return liveSceneService;
	}

	@Resource
	public void setLiveSceneService(ILiveSceneService liveSceneService) {
		this.liveSceneService = liveSceneService;
	}

	public LiveScene getLiveScene() {
		return liveScene;
	}

	public void setLiveScene(LiveScene liveScene) {
		this.liveScene = liveScene;
	}
}
