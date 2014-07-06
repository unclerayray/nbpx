package com.nb.nbpx.dto.client;

import java.lang.reflect.Field;

import com.nb.nbpx.utils.mapTool.NbpxDicMap;

public class CommonClientDto {
	public Object object;
	public String categoryName;
	public String categoryCode;
	
	
	
	public CommonClientDto() {
		super();
	}



	public CommonClientDto(Object object, String categoryName,
			String categoryCode) {
		super();
		this.object = object;
		this.categoryName = categoryName;
		this.categoryCode = categoryCode;
	}



	public Object getObject() {
		return object;
	}



	public void setObject(Object object) {
		this.object = object;
	}



	public String getCategoryName() {
		return categoryName;
	}



	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}



	public String getCategoryCode() {
		return categoryCode;
	}



	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}



	public static CommonClientDto convertToCommonDto(Object object) throws IllegalArgumentException, IllegalAccessException{
		CommonClientDto  dto = new CommonClientDto();
		dto.setObject(object);
		String category = "";
		String categoryName = "";
		Class<?> clazz = object.getClass();
		for(Field field : clazz.getDeclaredFields()) {
			field.getName().equals("category");
			category = (String) field.get(object);
		}
		categoryName = NbpxDicMap.courseTypeMap.get(category).toString();
		dto.setCategoryCode(category);
		dto.setCategoryName(categoryName);
		return dto;
	}
}
