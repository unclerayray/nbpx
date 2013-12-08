package com.nb.nbpx.service.solr;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.service.IBaseService;

/**
 * 课程连接SORL索引的service
 * @author Roger
 * @date 2013年8月17日
 */
public interface ISolrCourseService extends IBaseService {
	public void addCourse2Solr(CourseAllInfoDto cai);
	public void updateCourseInfo2Solr(Integer courseId) throws IOException, SolrServerException ;
	public void removeCourseFromSolr(Integer courseId) throws SolrServerException, IOException;
}
