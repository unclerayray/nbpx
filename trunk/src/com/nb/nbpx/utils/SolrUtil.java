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
	 * 获取讲师模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getTeacherServerUrl() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.debug("solr.core_teacher.url = " + prop.getProperty("solr.core_teacher.url"));
		return prop.getProperty("solr.core_teacher.url");
	}
	/**
	 * 获取问题模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getQuestionServerUrl() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.debug("solr.core_question.url = " + prop.getProperty("solr.core_question.url"));
		return prop.getProperty("solr.core_question.url");
	}
	/**
	 * 获取机构模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getOraganisationServerUrl() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.debug("solr.core_organization.url = " + prop.getProperty("solr.core_organization.url"));
		return prop.getProperty("solr.core_organization.url");
	}
	
	/**
	 * 获取下载模块的Server URL
	 * @return
	 * @throws IOException
	 */
	public static String getDownloadServerUrl() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.debug("solr.core_download.url = " + prop.getProperty("solr.core_download.url"));
		return prop.getProperty("solr.core_download.url");
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
	 * 获取Download Path
	 * @return
	 * @throws IOException
	 */
	public static String getDownloadPath() throws IOException{
		Properties prop = new Properties();
		try {
			logger.debug("before");
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
			logger.debug("download.file.path = " + prop.getProperty("download.file.path"));
		} catch (Exception e) {
			logger.debug("exception");
			prop.load(new FileInputStream(classpath+"solr.properties"));
			logger.debug("download.file.path = " + prop.getProperty("download.file.path"));
		}
		logger.debug("download.file.path = " + prop.getProperty("download.file.path"));
		return prop.getProperty("download.file.path");
	}
	
	/**
	 * 获取Teacher Photo Path
	 * @return
	 * @throws IOException
	 */
	public static String getTeacherPhotoPath() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		logger.debug("teacher.photo.path = " + prop.getProperty("teacher.photo.path"));
		return prop.getProperty("teacher.photo.path");
	}
	
	/**
	 * 获取LiveScenePhoto Path
	 * @return
	 * @throws IOException
	 */
	public static String getLiveScenePhotoPath() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
			//logger.debug("image.livescene.path = " + prop.getProperty("image.livescene.path"));
		} catch (Exception e) {
			logger.debug("exception");
			prop.load(new FileInputStream(classpath+"solr.properties"));
			logger.debug("image.livescene.path = " + prop.getProperty("image.livescene.path"));
		}
		//logger.debug("image.livescene.path = " + prop.getProperty("image.livescene.path"));
		return prop.getProperty("image.livescene.path");
	}
	
	/**
	 * 获取金牌内训图片 Path
	 * @return
	 * @throws IOException
	 */
	public static String getGoldenPicPath() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
			//logger.debug("image.livescene.path = " + prop.getProperty("image.livescene.path"));
		} catch (Exception e) {
			logger.debug("exception");
			prop.load(new FileInputStream(classpath+"solr.properties"));
			logger.debug("course.goldenPic.path = " + prop.getProperty("course.goldenPic.path"));
		}
		//logger.debug("image.livescene.path = " + prop.getProperty("image.livescene.path"));
		return prop.getProperty("course.goldenPic.path");
	}
	
	/**
	 * 获取课程链接的前缀
	 * @return
	 * @throws IOException
	 */
	public static String getHypeLinkPrefix() throws IOException{
		Properties prop = new Properties();
		try {
			prop.load(SolrUtil.class.getClassLoader().getResourceAsStream("solr.properties"));
		} catch (Exception e) {
			logger.debug("exception");
			prop.load(new FileInputStream(classpath+"solr.properties"));
		}
		return prop.getProperty("course.hypeLink.prefix");
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
