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

/**
 * <p>
 * 用于拦截请求，设置缓存时间，主要是拦截cache.html，设置为不缓存
 * </p>
 * 创建时间：2012-6-20 上午01:26:37
 * 
 * @author huangjinfang
 * @version V1.0
 */
public class CacheFilter implements Filter {
    private FilterConfig filterConfig;

    @Override
    public void destroy() {
        this.filterConfig = null;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
        final HttpServletRequest httpRequest = (HttpServletRequest) request;
        final String requestUri = httpRequest.getRequestURI();

        final HttpServletResponse httpResponse = (HttpServletResponse) response;
        String flag = filterConfig.getInitParameter("flag");
        if (flag != null) {
            if (flag.trim().equals("true")) {
                // 执行拦截并设置缓存
                if (requestUri.contains(".nocache.")
                        || requestUri.contains(".cache.html")) {
                    httpResponse.addHeader("Cache-Control", "no-cache");
                    httpResponse.addHeader("Cache-Control", "no-store");
                }
            }
        }
        chain.doFilter(request, httpResponse);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

}
