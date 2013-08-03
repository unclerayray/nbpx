package com.nb.nbpx.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class SolrUtil {
	public static String getCourseServiceUrl(){
		Properties props = new Properties();
        FileInputStream fis;
		try {
			fis = new FileInputStream("/conf/jdbc.properties");
	        //loading properites from properties file
	        props.load(fis);
	        //reading property

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
      
        String username = props.getProperty("jdbc.username");
        String driver = props.getProperty("jdbc.driver");
		return "";
	}
	
	public static String getCourseServerUrl(){
		Properties prop = new Properties();
		ClassLoader loader = Thread.currentThread().getContextClassLoader();
		InputStream stream = loader.getResourceAsStream("../../../../../conf/jdbc.properties");
		try {
			prop.load(stream);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//String url = prop.getProperty("solr.core_course.url");
		String url = prop.getProperty("jdbc.url");
		System.out.println("url = " + url);
		return "";
	}
}
