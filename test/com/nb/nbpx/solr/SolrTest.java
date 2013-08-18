package com.nb.nbpx.solr;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.apache.solr.client.solrj.SolrServerException;
import org.junit.Test;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.service.solr.ISolrCourseService;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.utils.SolrUtil;

/**
 * SOLR相关的测试类
 * @author Roger
 * @date 2013年8月2日
 */
public class SolrTest extends BaseServiceTest {
	@Resource
	private ISolrService solrService;
	
	@Resource
	private ISolrCourseService solrCourseService;
	
	//@Test
	public void testQuery() {
		try {
			String response = solrService.fullTextQueryForHl("领导", 0, 10);
			Assert.assertNotNull(response);
		} catch (SolrServerException e) {
			e.printStackTrace();
			Assert.fail();
		} catch (IOException e) {
			e.printStackTrace();
			Assert.fail();
		}
	}
	
	//@Test
	public void testImport() {
		try {
			solrService.fullImport();
		} catch (Exception e) {
			e.printStackTrace();
			Assert.fail();
		}
	}
	
	//@Test
	public void readFromProperty() throws IOException{
		SolrUtil.getCourseServerUrl();
	}
	
	@Test
	public void indexCourse2Solr(){
		CourseAllInfoDto cai = new CourseAllInfoDto();
		cai.setCourseId(10001);
		cai.setTitle("为共产主义青年团而奋斗");
		cai.setContent("好啊  怎样奋斗  你说了算");
		cai.setKeywords("共产,注意,主义");
		solrCourseService.addCourse2Solr(cai);
	}

	//@Test
	public void readUrlFromProperty() throws IOException{
		//SolrUtil.getCourseServerUrl();
		String loc = new File(".").getCanonicalPath();
		System.out.println("loc = "+loc);
		String path = getClass().getProtectionDomain().getClassLoader().getResource(".").getPath();
		System.out.println("path = "+path);
		InputStream stream = ClassLoader.getSystemResourceAsStream("/solr.properties"); 
		//loc = "/"+loc.replace("\\", "/");
		InputStream inxx = new BufferedInputStream(new FileInputStream(loc+"\\conf\\solr.properties"));
		//System.out.println("getName() = "+Main.class.getName());
		//System.out.println("stream = "+stream.);
		ClassLoader loader = Thread.currentThread().getContextClassLoader();  
		InputStream in = 
				 getClass().getResourceAsStream("solr.properties");
		//System.out.println(this.getClass().getResource("/../../"));
		Properties prop = new Properties();
		try {
			prop.load(inxx);
		} catch (IOException e) {
			e.printStackTrace();
		}
		String url = prop.getProperty("solr.core_course.url");
		System.out.println("url = " + url);
	}
}
