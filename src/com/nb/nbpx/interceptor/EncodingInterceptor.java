package com.nb.nbpx.interceptor;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.StrutsStatics;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * @author Roger
 * @date 2013年7月21日
 */
public class EncodingInterceptor extends AbstractInterceptor {

 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

/**
  * Struts2编码拦截器
  */
 
 @Override
 public String intercept(ActionInvocation arg0) throws Exception {
  
   ActionContext actionContext = arg0.getInvocationContext();   
   HttpServletRequest request= (HttpServletRequest) actionContext.get(StrutsStatics.HTTP_REQUEST); 
  //System.out.println("Encoding Intercept...");
  /**
   * 此方法体对GET 和 POST方法均可
   */
  //String methodName = request.getMethod();
  //StringBuffer requestURL = request.getRequestURL();
  //String queryString = request.getQueryString();
  //System.out.println("methodName = "+methodName);
  //System.out.println("requestURL = "+requestURL);
  //System.out.println("queryString = "+queryString);
  if( request.getMethod().compareToIgnoreCase("post")>=0){
      try {
       request.setCharacterEncoding("UTF-8");
      } catch (UnsupportedEncodingException e) {
       e.printStackTrace();
      }
     }else{
            
      Iterator iter=request.getParameterMap().values().iterator();
      while(iter.hasNext())
      {
       String[] parames=(String[])iter.next();
       for (int i = 0; i < parames.length; i++) {
        try {
         parames[i]=new String(parames[i].getBytes("iso8859-1"),"UTF-8");//此处GBK与页面编码一样
        } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
        }
       }   
      }   
       }
         return arg0.invoke();
 }

}