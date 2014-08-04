package com.nb.nbpx.server.zixun;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.zixun.LiveImage;
import com.nb.nbpx.pojo.zixun.LiveScene;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.zixun.ILiveSceneService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
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
	public String flag;
	public String keyCode;
	
	public String getKeyCode() {
		return keyCode;
	}
	public void setKeyCode(String keyCode) {
		this.keyCode = keyCode;
	}
	public String viewLiveScene(){
		String json = liveSceneService.viewLiveScene(liveSceneId);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	public String queryLiveSceneTopList(){
		Map<String, Object> propsMap = new HashMap<String, Object>();
		if("1".equals(flag))
			propsMap.put("category", "24_2");
		else if("2".equals(flag))
			propsMap.put("category", "24_3");
		String json = liveSceneService.getLiveScene(propsMap, 11, 0, true);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String queryTuoZhanTopList(){
		Map<String, Object> propsMap = new HashMap<String, Object>();
		if("1".equals(flag))
			propsMap.put("category", "24_0");
		else if("2".equals(flag))
			propsMap.put("category", "24_1");
		String json = liveSceneService.getLiveScene(propsMap, 11, 0, false);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	public String queryLiveScene() {

		Map<String, Object> propsMap = new HashMap<String, Object>();
		if("1".equals(flag))
			propsMap.put("category", "24_2");
		else if("2".equals(flag))
			propsMap.put("category", "24_3");
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
					LiveImage coverImg = new LiveImage();
					String realpath = SolrUtil.getLiveScenePhotoPath();
					realpath = realpath + File.separator
							+ liveScene.getLiveSceneId();

					String ext = FilenameUtils.getExtension(coverFileName);

					File savefile = new File(new File(realpath), "cover" + "."
							+ ext);
					if (!savefile.getParentFile().exists())
						savefile.getParentFile().mkdirs();
					FileUtils.copyFile(cover, savefile);
					coverImg.setImageName("cover");
					//coverImg.setUrl(realpath + File.separator + "cover" + "."+ ext);
					coverImg.setUrl(SolrUtil.getAbstractLiveScenePhotoPath() + "/"+ liveScene.getLiveSceneId() + "/" + "cover" + "."+ ext);
					coverImg.setLiveScene(liveScene);
					liveSceneService.saveImage(coverImg);
				}
				if (photo1 != null) {
					LiveImage phote1Img = new LiveImage();
					String realpath = SolrUtil.getLiveScenePhotoPath();
					realpath = realpath + File.separator
							+ liveScene.getLiveSceneId();

					String ext = FilenameUtils.getExtension(photo1FileName);

					File savefile = new File(new File(realpath), "photo1" + "."
							+ ext);
					if (!savefile.getParentFile().exists())
						savefile.getParentFile().mkdirs();
					FileUtils.copyFile(photo1, savefile);
					phote1Img.setImageName("photo1");
					phote1Img.setUrl(SolrUtil.getAbstractLiveScenePhotoPath() + "/"+ liveScene.getLiveSceneId() + "/" + "photo1" + "."+ ext);
					phote1Img.setLiveScene(liveScene);
					liveSceneService.saveImage(phote1Img);
					phote1Img.setLiveScene(liveScene);
					liveSceneService.saveImage(phote1Img);
				}
				if (photo2 != null) {
					LiveImage phote2Img = new LiveImage();
					String realpath = SolrUtil.getLiveScenePhotoPath();
					realpath = realpath + File.separator
							+ liveScene.getLiveSceneId();

					String ext = FilenameUtils.getExtension(photo2FileName);

					File savefile = new File(new File(realpath), "photo2" + "."
							+ ext);
					if (!savefile.getParentFile().exists())
						savefile.getParentFile().mkdirs();
					FileUtils.copyFile(photo2, savefile);
					phote2Img.setImageName("photo2");
					//phote2Img.setUrl(realpath + File.separator + "photo2" + "."+ ext);
					phote2Img.setUrl(SolrUtil.getAbstractLiveScenePhotoPath() + "/"+ liveScene.getLiveSceneId() + "/" + "photo2" + "."+ ext);
					phote2Img.setLiveScene(liveScene);
					liveSceneService.saveImage(phote2Img);
				}
				if (photo3 != null) {
					LiveImage phote3Img = new LiveImage();
					String realpath = SolrUtil.getLiveScenePhotoPath();
					realpath = realpath + File.separator
							+ liveScene.getLiveSceneId();

					String ext = FilenameUtils.getExtension(photo3FileName);

					File savefile = new File(new File(realpath), "photo3" + "."
							+ ext);
					if (!savefile.getParentFile().exists())
						savefile.getParentFile().mkdirs();
					FileUtils.copyFile(photo3, savefile);
					phote3Img.setImageName("photo3");
					//phote3Img.setUrl(realpath + File.separator + "photo3" + "."+ ext);
					phote3Img.setUrl(SolrUtil.getAbstractLiveScenePhotoPath() + "/"+ liveScene.getLiveSceneId() + "/" + "photo3" + "."+ ext);
					phote3Img.setLiveScene(liveScene);
					liveSceneService.saveImage(phote3Img);
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
	
	public String saveAd(){
		try {
			if (cover != null) {
				String ext = FilenameUtils.getExtension(coverFileName);
				if(!"jpg".equals(ext)){
					throw new NbpxException("请选择正确的图片格式！");
				}
				LiveImage coverImg = new LiveImage();
				String realpath = SolrUtil.getAdPicPath();
				realpath = realpath + File.separator;


				File savefile = new File(new File(realpath), keyCode + "."
						+ ext);
				if (!savefile.getParentFile().exists())
					savefile.getParentFile().mkdirs();
				FileUtils.copyFile(cover, savefile);
				coverImg.setImageName(keyCode);
				//coverImg.setUrl(realpath + File.separator + "cover" + "."+ ext);
				coverImg.setUrl(SolrUtil.getAbstractAdPicPath() + "/"+ keyCode + "."+ ext);
				coverImg.setLiveScene(null);
				coverImg.setKeyCode(keyCode);
				liveSceneService.saveAd(coverImg);
			}else{
				throw new NbpxException("请选择图片！");
			}
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"上传失败！" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, "上传成功"));
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
