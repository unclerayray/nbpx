package com.nb.nbpx.common;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * Context监听器：在系统启动时候保存Spring的ApplicationContext对象
 * 
 * @author leilichao
 */
public class MyContextLoaderListener extends ContextLoaderListener {
	public static Logger logger = LogManager
			.getLogger(MyContextLoaderListener.class);

	@Override
	public void contextInitialized(ServletContextEvent event) {
		ServletContext context = event.getServletContext();
		super.contextInitialized(event);
		ApplicationContext ctx = WebApplicationContextUtils
				.getRequiredWebApplicationContext(context);
		//保存系统的ApplicationContext对象
		SystemApplicationContext.setContext(ctx);

	}
}
