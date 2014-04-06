package com.nb.nbpx.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <p>
 * 判断session是否有效的filter(先可判断是否已登录)
 * </p>
 * 创建时间：2011-12-17 下午06:52:36
 * 
 * @author Roger
 * @version V1.0
 */
public class SessionFilter implements Filter {
	protected Log log = LogFactory.getLog(getClass());
	private String loginPage = "";

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse reponse = (HttpServletResponse) (response);
		log.debug("用户请求URL：" + httpServletRequest.getServletPath() + "?"
				+ httpServletRequest.getQueryString());
		log.debug("用户请求参数：" + httpServletRequest.getParameterMap());

		String url = httpServletRequest.getServletPath();
		System.out.println("url: "+url);
		if (url.indexOf("login.jsp") >= 0 || url.indexOf("login") >= 0
				|| url.indexOf("error.jsp") >= 0) {
			chain.doFilter(request, response);
		} else {
			url = url.toLowerCase();
			if (url.indexOf(".js") >= 0 || url.indexOf(".css") >= 0
					|| url.indexOf(".png") >= 0 || url.indexOf(".gif") >= 0
					|| url.indexOf(".jpg") >= 0 || url.indexOf(".swf") >= 0) {
				// 不拦截静态资源
				chain.doFilter(request, response);
			} else {
				HttpSession session = httpServletRequest.getSession();
				// 判断用户session是否过期或是否登录
				if (session != null && session.getAttribute("userName") != null) {
					chain.doFilter(request, response);
				} else {
					reponse.sendRedirect(loginPage);
				}
			}
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.loginPage = filterConfig.getInitParameter("loginPage");
	}

	public void destroy() {
	}
}
