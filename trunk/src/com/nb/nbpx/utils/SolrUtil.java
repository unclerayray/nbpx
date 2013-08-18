package com.nb.nbpx.utils;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * SOLR相关的工具类
 * @author Roger
 * @date 2013年8月4日
 */
public class SolrUtil {	
	public static String classpath = Thread.currentThread().getContextClassLoader().getResource("").getPath();
	/**
	 * 获取课程模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getCourseServerUrl() throws IOException{
		InputStream inxx = new BufferedInputStream(new FileInputStream(classpath+"solr.properties"));
		Properties prop = new Properties();
		try {
			prop.load(inxx);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return prop.getProperty("solr.core_course.url");
	}
	
	/**
	 * 获取文章模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getArticleServerUrl() throws IOException{
		InputStream inxx = new BufferedInputStream(new FileInputStream(classpath+"solr.properties"));
		Properties prop = new Properties();
		try {
			prop.load(inxx);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return prop.getProperty("solr.core_article.url");
	}
	
	/**
	 * 获取关键词模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getKeywordServerUrl() throws IOException{
		InputStream inxx = new BufferedInputStream(new FileInputStream(classpath+"solr.properties"));
		Properties prop = new Properties();
		try {
			prop.load(inxx);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return prop.getProperty("solr.core_keyword.url");
	}
	
	/**
	 * 获取专题模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getSubjectServerUrl() throws IOException{
		InputStream inxx = new BufferedInputStream(new FileInputStream(classpath+"solr.properties"));
		Properties prop = new Properties();
		try {
			prop.load(inxx);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return prop.getProperty("solr.core_subject.url");
	}
}
