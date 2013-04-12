package com.nb.nbpx.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;

public class PropertyUtil {

	private Properties prop;
	private String filePath;
	public String propFileName;
	public PropertyUtil(String propfilename) {
		this.propFileName = propfilename;
		this.prop = new Properties();
		this.filePath = PropertyUtil.class.getResource("/").toString();
		filePath = filePath.substring(0, filePath.length() - 8);
		filePath = filePath.substring(6, filePath.length());
		filePath = filePath.replaceAll("%20", " ");
	}
	
	
	public String getProp(String key){
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(filePath + this.propFileName);
			prop.loadFromXML(fis);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (InvalidPropertiesFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String value = prop.getProperty(key);
		return value;
	}
	
	
	public boolean setProp(String key,String value){
		try {
			prop.setProperty(key, value);
			java.io.OutputStream os = new java.io.FileOutputStream(filePath
					+ this.propFileName);
			prop.storeToXML(os,"");
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public boolean setProp(String key,String value,String comment){
		try {
			prop.setProperty(key, value);
			java.io.OutputStream os = new java.io.FileOutputStream(filePath
					+ this.propFileName);
			prop.storeToXML(os,comment);
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}


	public static void main(String[] args) {
		PropertyUtil pu = new PropertyUtil("ParamProp.xml");
		System.out.println("before: "+pu.getProp("testProperty"));
		pu.setProp("testProperty", "btg!");
		pu.setProp("statues", "ok");
		System.out.println("after: "+pu.getProp("testProperty"));
	}
	
	public String getAndAddBatchNum(){
		PropertyUtil pu = new PropertyUtil("Properties.xml");
		String BatchNum = pu.getProp("BatchNum");
		int num = 0;
		try {
			num = Integer.parseInt(BatchNum);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		num +=1;
		pu.setProp("BatchNum", ""+num);
		return ""+num;
	}
}
