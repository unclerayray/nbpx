package com.nb.nbpx.server;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.stereotype.Component;

import com.opensymphony.xwork2.ActionSupport;

/**
 * <p>
 * Action的基类
 * </p>
 * 创建时间：2013-3-23 下午 11:08:38
 * 
 * @author leilichao
 * @version V1.0
 */
/**
 * @author Roger
 * @date 2013年8月3日
 */
@Component("BaseAction")
public class BaseAction extends ActionSupport implements ServletRequestAware {
    /**
     * 
     */
    private static final long    serialVersionUID = 1L;
    public static Logger         logger           = LogManager
                                                          .getLogger(BaseAction.class);
    protected Integer            page;
    protected Integer            rows;
    protected InputStream        inputStream;
    protected HttpServletRequest request;
    protected HttpSession        session;
    protected String			 sort;
    protected String			 order;

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

    public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public InputStream castToInputStream(String str) {
        logger.debug("---------------------------------------------------------");
        logger.debug("服务器返回的数据---->:" + str);
        logger.debug("---------------------------------------------------------");
        return new ByteArrayInputStream(str.getBytes(Charset.forName("UTF-8")));
    }

    public void sendMsg(String content) throws IOException {
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(content);
    }
    
    

    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.request = request;
        this.session = request.getSession();
    }

    /**
     * 获取当前用户的用户名
     * @return
     */
    public String getSessionUserName() {
        String userName = new String();
        if (session != null) {
            userName = (String) session.getAttribute("userName");
        } else {
            logger.debug("---->:session missing");
            //FIXME there maybe an admin problem coming up 
            userName = "admin";
        }
        logger.debug("---->:userName = " + userName);
        return userName;
    }
    
    /**
     * @return
     */
    public String getMeCode() {
        String code = new String();
        if (session != null) {
        	code = (String) session.getAttribute("code");
        } else {
            logger.debug("---->:session missing");
            code = "missing";
        }
        logger.debug("---->:code = " + code);
        return code;
    }
    
    public Integer getStartPosi(){
    	if(page==null||rows==null) return null;
    	return (page-1)*rows;
    }
    

    /**
     * 将前台post过来的数据，从request Body中转为String
     * 
     * @return
     * @throws IOException
     */
    public String getInputStreamDataFromRequest() throws IOException {
        BufferedReader reader = null;
        reader = request.getReader();// 获得字符流
        StringBuffer content = new StringBuffer();
        String line;
        while ((line = reader.readLine()) != null) {
            content.append(line + "\r\n");
        }
        String contentString = content.toString();
        System.out.println("从流中读取的数据为" + contentString);
        return contentString;
    }
    
	/**
	 * 设置返回信息，主要用于导出报表
	 * 
	 * @param contentType
	 *            文件返回类型
	 * @param fileName
	 *            返回的文件名，含文件类型后缀
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public HttpServletResponse setResponseInfo(String contentType,
			String fileName) throws UnsupportedEncodingException {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.reset();
		response.setContentType(contentType);
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ new String(fileName.getBytes("gb2312"), "iso-8859-1") + "\"");
		return response;
	}
	
}
