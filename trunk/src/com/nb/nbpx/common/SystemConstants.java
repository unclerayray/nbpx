package com.nb.nbpx.common;

public class SystemConstants {
	public static String CLASS_PATH = Thread.currentThread().getContextClassLoader()
			.getResource("").getPath();
}
