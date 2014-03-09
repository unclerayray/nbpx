package com.nb.nbpx.solr;

import static org.junit.Assert.fail;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.apache.solr.client.solrj.SolrServerException;
import org.junit.Ignore;
import org.junit.Test;

import com.chenlb.mmseg4j.Dictionary;
import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.common.SystemConstants;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.service.solr.ISolrCourseService;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.service.solr.impl.SolrServiceImpl;
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
	
	@Test
	//@Ignore
	public void testQuery() {
		try {
			String response = solrService.fullTextQueryForHl("我去", 0, 10);
			System.out.println(response);
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
	public void getUserDic(){
		String relativelyPath=System.getProperty("user.dir");
		System.out.println(relativelyPath);
		String sss = System.getProperty("java.class.path");
		System.out.println(sss);
	}
	

	@Test
	@Ignore
	public void testWriteToDicFile() throws IOException{
		String dicPath = SolrUtil.getDictionaryPath();
		String s = new String();
		String s1 = new String();
		String [] words = {"干什么","法克鱿","企业培训"};
		String classPath = SolrServiceImpl.class.getResource("/").getPath();
		File file = new File(dicPath);
		System.out.println("classpath = " + classPath);
		BufferedReader input = new BufferedReader(new FileReader(file));
	       while ((s = input.readLine()) != null) {
	        s1 += s + "\n";
	       }
	       System.out.println("文件内容：" + s1);
	       input.close();
	       for(String word:words){
		       s1 += word+"\n";
	       }
	       BufferedWriter output = new BufferedWriter(new FileWriter(file));
	       output.write(s1);
	       output.close();
	}
	
	@Test
	public void testCutTextWithDefinedDic(){
		String text = "我从那里来，要到三的那边去。企业培训，你懂吗，法克鱿";
		try {
			String result = solrService.cutText(text);
			System.out.println(result);
		} catch (IOException e) {
			e.printStackTrace();
			fail();
		}
	}
	
	@Test
	@Ignore
	public void testGetDefinedDic() throws IOException{
		String dicPath = SolrUtil.getDictionaryPath();
		File file = new File(dicPath);
		Dictionary dic = Dictionary.getInstance(file);
		Assert.assertTrue(dic.getDicPath().exists());
		System.out.println("what is it then " + dic.getDicPath().getAbsolutePath());
		Assert.assertTrue(dic.match("还是他"));
	}
	
	
	//@Test
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
