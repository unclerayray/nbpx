package com.nb.nbpx.filter;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.utils.JsonUtil;

/**
 * <p>
 * 判断session是否有效的filter(先可判断是否已登录)
 * </p>
 * 创建时间：2011-12-17 下午06:52:36
 * 
 * @author huangjinfang
 * @version V1.0
 */
public class SessionFilter implements Filter {
    protected Log  log       = LogFactory.getLog(getClass());
    private String loginPage = "";

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse reponse = (HttpServletResponse) (response);
        log.debug("用户请求URL：" + httpServletRequest.getServletPath() + "?"
                + httpServletRequest.getQueryString());
        log.debug("用户请求参数：" + httpServletRequest.getParameterMap());

        StringBuffer requestUrl = httpServletRequest.getRequestURL();
        int islocal = requestUrl.indexOf("127.0.0.1:8080");
        String url = httpServletRequest.getServletPath();
        if(url.indexOf("salaryQuery.jsp")>=0||url.indexOf("salaryQuery")>=0){
        	 chain.doFilter(request, response);
        	 System.out.println("到这里来了");
        }else if (url.indexOf("login.jsp") >= 0 || url.indexOf("login") >= 0||url.indexOf("error.jsp")>=0) {
            chain.doFilter(request, response);
        } else {
            url = url.toLowerCase();
            if (url.indexOf(".js") >= 0 || url.indexOf(".css") >= 0
                    || url.indexOf(".png") >= 0 || url.indexOf(".gif") >= 0
                    || url.indexOf(".jpg") >= 0 || url.indexOf(".swf") >= 0) {
                //不拦截静态资源
                chain.doFilter(request, response);
            } else {
                HttpSession session = httpServletRequest.getSession();
                // 判断用户session是否过期或是否登录
                if (session != null && session.getAttribute("userName") != null) {
                    chain.doFilter(request, response);
                } else {
                    // 转向登录页面
                    if (islocal == -1) {
                        SimpleDateFormat format = new SimpleDateFormat(
                                "yyyy-MM-dd HH:mm:ss");
                        Date date = new Date();
                        if (url.indexOf("struts/") >= 0
                                || url.indexOf("main/") >= 0) {
                            if (url.indexOf("query") >= 0
                                    || url.indexOf("login") >= 0) {
                                System.out.println("未登录，返回错误信息(查询):"
                                        + format.format(date));
                                response.setContentType("text/html;charset=UTF-8");
                                response.setCharacterEncoding("UTF-8");
                                response.getWriter().write(
                                        "{超时}");
                            } else {
                                System.out.println("未登录，返回错误信息(其他操作):"
                                        + format.format(date));
                                response.setContentType("text/html;charset=UTF-8");
                                response.setCharacterEncoding("UTF-8");
                                response.getWriter().write(
                                        JsonUtil.formatToJson(
                                                ResponseStatus.FAIL,
                                                "会话过期，需要重新登录！"));
                            }
                        } else {
                            System.out.println("未登录，正转向登录页面:"
                                    + format.format(date));
                            reponse.sendRedirect(loginPage);
                        }
                    } else {
                        reponse.sendRedirect("http://127.0.0.1:8080/nbpx/login.jsp");
                    }
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
