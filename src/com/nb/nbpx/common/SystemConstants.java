package com.nb.nbpx.common;

public class SystemConstants {
	public static String CLASS_PATH = Thread.currentThread().getContextClassLoader()
			.getResource("").getPath();
	public static String USER_TYPE_TEACHER = "001_02";
	public static String COURSE_MAJOR_TYPE_CODE = "009";
	public static String COURSE_TARGET_TYPE_CODE = "010";
	public static String COURSE_PRODUCT_TYPE_CODE = "011";
	public static String COURSE_INDUSTRY_TYPE_CODE = "008";
}
