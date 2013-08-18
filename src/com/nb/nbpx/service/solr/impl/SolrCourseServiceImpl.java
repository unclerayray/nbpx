package com.nb.nbpx.service.solr.impl;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;

import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.common.SolrInputDocument;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrCourseService;
import com.nb.nbpx.utils.SolrUtil;
@Component("SolrCourseService")
public class SolrCourseServiceImpl extends BaseServiceImpl implements ISolrCourseService{
	@Resource
	private ICourseService courseService;
	@Override
	public void addCourse2Solr(CourseAllInfoDto cai) {
		String serverURL;
		try {
			serverURL = SolrUtil.getCourseServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("courseID", cai.getCourseId());
			sid.addField("title", cai.getTitle());
			sid.addField("content", cai.getContent());
			String[] courseKeywords = cai.getKeywords().split(",");
			String[] courseSubjects = cai.getSubject().split(",");
			for(String keyword:courseKeywords){
				sid.addField("keyword", keyword);
			}
			for(String subject:courseSubjects){
				sid.addField("subject", subject);
			}
			List<CourseInfo> list = courseService.queryCourseInfoList(cai.getCourseId());
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			for(CourseInfo info:list){
				String startDate = format.format(info.getStartDate());
				String endDate = format.format(info.getEndDate());
				sid.addField("courseInfo", startDate+"至"+endDate+"在"+info.getCityName());
			}
			solrServer.add(sid);
            solrServer.commit();
            logger.debug("已成功为插入的课程创建索引");
		} catch (IOException e) {
			logger.error("未能取得课程的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit为成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}
}
