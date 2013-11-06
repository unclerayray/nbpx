package com.nb.nbpx.task;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;

import com.nb.nbpx.service.system.ICountService;
import com.nb.nbpx.utils.mapTool.MapTool;

/**
 * <p>
 * 定时执行计划类，用于定时的更新点击量等数据
 * </p>
 * 创建时间：2012-10-21 11:44:56
 * 
 * @author Roger
 * @date 2013年11月6日
 */
@Scope("prototype")
public class UpdateTask {
	public static Logger log = Logger.getLogger(UpdateTask.class);

	public ICountService countService;

	public ICountService getCountService() {
		return countService;
	}

	@Resource
	public void setCountService(ICountService countService) {
		this.countService = countService;
	}

	/**
	 * 关联到timedTaskConf.xml，定时执行函数。
	 */
	public void callUpdate() {
		countService.updateAllCnt(MapTool.articlesHitsMap,
				MapTool.coursesHitsMap, MapTool.keywordsHitsMap,
				MapTool.subjectsHitsMap, MapTool.keywordsSearchCntMap,
				MapTool.subjectsSearchCntMap, MapTool.downloadCntMap);
		MapTool.articlesHitsMap.clear();
		MapTool.coursesHitsMap.clear();
		MapTool.keywordsHitsMap.clear();
		MapTool.subjectsHitsMap.clear();
		MapTool.keywordsSearchCntMap.clear();
		MapTool.subjectsSearchCntMap.clear();
		MapTool.downloadCntMap.clear();
		log.info("Daliy update count of hits and counts");
	}

}
