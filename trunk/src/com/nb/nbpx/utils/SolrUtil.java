package com.nb.nbpx.utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

/**
 * SOLR相关的工具类
 * @author Roger
 * @date 2013年8月4日
 */
public class SolrUtil {	
	public static String classpath = Thread.currentThread().getContextClassLoader().getResource("").getPath();

    public static Logger         logger           = LogManager
            .getLogger(SolrUtil.class);
	/**
	 * 获取课程模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getCourseServerUrl() throws IOException{
		Properties prop = new Properties();
		try {
			logger.debug("before");
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
			logger.debug("solr.core_course.url = " + prop.getProperty("solr.core_course.url"));
		} catch (Exception e) {
			logger.debug("exception");
			prop.load(new FileInputStream(classpath+"solr.properties"));
			logger.debug("solr.core_course.url = " + prop.getProperty("solr.core_course.url"));
		}
		logger.debug("solr.core_course.url = " + prop.getProperty("solr.core_course.url"));
		return prop.getProperty("solr.core_course.url");
	}
	
	/**
	 * 获取文章模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getArticleServerUrl() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.debug("solr.core_article.url = " + prop.getProperty("solr.core_article.url"));
		return prop.getProperty("solr.core_article.url");
	}
	
	/**
	 * 获取关键词模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getKeywordServerUrl() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.info("solr.core_keyword.url = " + prop.getProperty("solr.core_keyword.url"));
		return prop.getProperty("solr.core_keyword.url");
	}
	
	/**
	 * 获取专题模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getSubjectServerUrl() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.debug("solr.core_subject.url = " + prop.getProperty("solr.core_subject.url"));
		return prop.getProperty("solr.core_subject.url");
	}
	
	/**
	 * 获得自定义词典路径
	 * @return
	 */
	public static String getDictionaryPath() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.debug("solr.dictionary.path = " + prop.getProperty("solr.dictionary.path"));
		return prop.getProperty("solr.dictionary.path");
	}
	
	/**
	 * 获得自定义词典文件路径
	 * @return
	 */
	public static String getDictionaryFilePath() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.debug("solr.dictionary.file.path = " + prop.getProperty("solr.dictionary.file.path"));
		return prop.getProperty("solr.dictionary.path");
	}
	
	/**
	 * 过滤solr query 非法字符串的方法
	 * @param s
	 * @return
	 */
	public static String escapeQueryChars(String s) {
	    StringBuilder sb = new StringBuilder();
	    for (int i = 0; i < s.length(); i++) {
	      char c = s.charAt(i);
	      // These characters are part of the query syntax and must be escaped
	      if (c == '\\' || c == '+' || c == '-' || c == '!'  || c == '(' || c == ')' || c == ':'
	        || c == '^' || c == '[' || c == ']' || c == '\"' || c == '{' || c == '}' || c == '~'
	        || c == '*' || c == '?' || c == '|' || c == '&'  || c == ';' || c == '/'
	        || Character.isWhitespace(c)) {
	        sb.append('\\');
	      }
	      sb.append(c);
	    }
	    return sb.toString();
	  }
}
