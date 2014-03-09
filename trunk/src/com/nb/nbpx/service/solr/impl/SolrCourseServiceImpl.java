package com.nb.nbpx.service.solr.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.lucene.analysis.charfilter.HTMLStripCharFilter;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.client.solrj.util.ClientUtils;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrCourseService;
import com.nb.nbpx.utils.SolrUtil;
@Component("SolrCourseService")
public class SolrCourseServiceImpl extends BaseServiceImpl implements ISolrCourseService{
    public static Logger logger = LogManager.getLogger(SolrCourseServiceImpl.class);
	@Resource
	private ICourseService courseService;
	@Override
	public void addCourse2Solr(CourseAllInfoDto cai) {
		String serverURL;
		try {
			serverURL = SolrUtil.getCourseServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("courseId", cai.getCourseId());
			sid.addField("title", cai.getTitle());
			sid.addField("price", cai.getPrice());
			sid.addField("teacherName", cai.getTeacherName());
			sid.addField("isInner", cai.isInner);
			String contents = cai.getContent();
			contents = stripHTMLX(contents);
			sid.addField("content", contents);
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
			logger.error("commit未成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}
	
	@Override
	public void updateCourseInfo2Solr(Integer courseId) throws IOException, SolrServerException {
		String serverURL = SolrUtil.getCourseServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		ModifiableSolrParams params = new ModifiableSolrParams();
		String q = "courseId:"+courseId;
		params.set("q", q);
		SolrQuery query = new SolrQuery();
		query.set("qt", "select");
		query.add(params);
		solrServer.ping();
		//TODO 判断连接 throw exception
		QueryResponse response = solrServer.query(query);
		System.out.println(response.getResponseHeader().get("pf"));
		SolrDocumentList list = response.getResults();
		SolrDocument doc = list.get(0);
		SolrInputDocument sid = ClientUtils.toSolrInputDocument(doc);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		List<CourseInfo> infolist = courseService.queryCourseInfoList(courseId);
		sid.removeField("courseInfo");
		for(CourseInfo info:infolist){
			String startDate = format.format(info.getStartDate());
			String endDate = format.format(info.getEndDate());
			sid.addField("courseInfo", startDate+"至"+endDate+"在"+info.getCityName());
		}
		
		solrServer.add(sid);
        solrServer.commit();
	}
	
	/**
	 * 清除课程内容中的HTML标签，并存入SOLR中
	 * @param value
	 * @return
	 */
	private String stripHTMLX(String value) { 
        StringBuilder out = new StringBuilder(); 
        StringReader strReader = new StringReader(value); 
        try { 
            HTMLStripCharFilter html = new HTMLStripCharFilter(new BufferedReader(strReader)); 
            char[] cbuf = new char[1024 * 10]; 
            while (true) { 
                int count = html.read(cbuf); 
                if (count == -1) 
                    break; // end of stream mark is -1 
                if (count > 0) 
                    out.append(cbuf, 0, count); 
            } 
            html.close(); 
        } catch (IOException e) { 
            e.printStackTrace(); 
            return null; 
            //  "Failed stripping HTML for column: " + column, e); 
        } finally{
        	strReader.close();
        }
        return out.toString(); 
    } 
	
	
	public static void main(String[] args) {
		//String content = "<p>hahahah</p>";
		//System.out.println(stripHTMLX(content));
	}

	@Override
	public void removeCourseFromSolr(Integer courseId) throws SolrServerException, IOException {
		String serverURL = SolrUtil.getCourseServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		solrServer.deleteById(courseId+"");
		solrServer.commit();
	}

}
