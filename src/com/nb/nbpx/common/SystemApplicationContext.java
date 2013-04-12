package com.nb.nbpx.common;

import org.springframework.context.ApplicationContext;
/**
 * 项目启动的时候就把系统启动时的创建的那个ApplicationContext的实例保存起来，用一个静态变量保存，方便以后使用
 * 需要使用ApplicationContext对象的时候只要使用SystemApplicationContext.getContext();方法即可
 * @author leilichao
 *
 */

public class SystemApplicationContext {
	private static ApplicationContext context;

	public static ApplicationContext getContext() {
		return context;
	}

	public static void setContext(ApplicationContext context) {
		SystemApplicationContext.context = context;
	}

}
