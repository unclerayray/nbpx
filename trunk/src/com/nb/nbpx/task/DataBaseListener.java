package com.nb.nbpx.task;

import java.util.Calendar;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

public class DataBaseListener extends HttpServlet implements
		ServletContextListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 设置启动时间为2点;
	private static final int hours = 23;
	private static final int minutes = 0;
	private static final int seconds = 0;

	// 设置间隔时间为1天;
	// private static final long interval = 24 * 60 * 60 * 1000;
	private static final long interval = 60 * 1000;
	private static final long delay = 2 * 1000;
	// 定时器;
	private static Timer timer;

	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("DataBaseListener>>stop");
		timer.cancel();
	}

	public void contextInitialized(ServletContextEvent sce) {
		if (timer == null) {
			System.out.println("DataBaseListener>>start");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.HOUR_OF_DAY, hours);
			calendar.set(Calendar.MINUTE, minutes);
			calendar.set(Calendar.SECOND, seconds);
			timer = new Timer("DataBaseListener");
			// timer.schedule(new DataBaseTask(), calendar.getTime(), interval);
			timer.schedule(new DataBaseTask(), delay, interval);
		}
	}
}
