package com.nb.nbpx.interceptor;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class Rewriter extends org.tuckey.web.filters.urlrewrite.UrlRewriteFilter{
	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
		super.doFilter(arg0, arg1, arg2);
	}
}
