package com.nb.nbpx.server.course;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.StringBufferInputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.w3c.dom.Document;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.solr.ISolrSubjectService;
import com.nb.nbpx.utils.mapTool.NbpxDicMap;

@Component("TrainPlanAction")
@Scope("prototype")
public class TrainPlanAction extends BaseAction{
	public static Logger log = LogManager.getLogger(TrainPlanAction.class);
	private static final long serialVersionUID = 1L;
	private ICourseService courseService;
	private ISolrKeywordService solrKeywordService;
	private ISolrSubjectService solrSubjectService;
	
	public String cate;
	public String city;
	public int month;
	public int year;
	public boolean isInner = false;
	
	//获取培训计划的内容
	public String getTrainPlanInfo(){
		String resultStr = courseService.getTranPlan(rows, this.getStartPosi());
		this.inputStream = castToInputStream(resultStr);
		
		return SUCCESS;
	}
	//获取培训计划相关关键词
	public String getPlanRelatedKeyWords(){
		try {
			String result = solrKeywordService.queryRelatedKeywords("培训计划", 0, 30);
			this.inputStream = castToInputStream(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	//获取培训计划相关专题
	public String getPlanRelatedSubjects(){
		try {
			String result = solrSubjectService.queryRelatedSubject("企业计划", 0, 30);
			this.inputStream = castToInputStream(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	

	/**
	 * 根据条件报表<br />
	 * 使用Jxls导出，模板放于XLSTemplate文件夹下
	 */
	public String exportCoursePlan() {
		OutputStream output = null; // 响应报文输出流
		FileInputStream input = null; // 文件输入流
		try {
			StringBuilder src = new StringBuilder();
			HttpServletResponse response = null; // 响应报文
			String templateSrc = null; // 模板路径

			templateSrc = ServletActionContext.getServletContext().getRealPath(
					"/XLSTemplate");
			src.append(templateSrc);
			src.append("/template-coursePlan.xls");
			response = setResponseInfo("application/x-download;charset=utf-8",
					+year + "年" + month + "月份" + NbpxDicMap.getCourseTypeMap().get(cate).toString() + "培训计划.xls");
			output = response.getOutputStream();
			input = new FileInputStream(src.toString());
			courseService.exportExcel(cate, year, month, city, isInner, input, output);
			output.flush();
		} catch (Exception e) {
			log.info("系统发生异常：", e);
			e.printStackTrace();
		} finally {
			try {
				if (null != input) {
					input.close();
				}

				if (null != output) {
					output.close();
				}
			} catch (IOException e) {
				log.error("导出excel报表错误 IOException:", e);
				e.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String exportKegang(){
		String outputFile = "firstdoc.pdf";
		OutputStream output = null;
		try {
			/*String templateSrc = null; // 模板路径

			HttpServletResponse response = null; // 响应报文
			StringBuilder src = new StringBuilder();
			templateSrc = ServletActionContext.getServletContext().getRealPath(
					"/XLSTemplate");
			src.append(templateSrc);
			src.append("\\viewClassTemplate.html");
			String url = new File(src.toString()).toURI().toURL().toString();
			output = new FileOutputStream(outputFile);;
			ITextRenderer renderer = new ITextRenderer();
			renderer.setDocument(url);
			renderer.layout();
			renderer.createPDF(output);
			response = setResponseInfo("application/x-download;charset=utf-8","课纲.xls");
			output = response.getOutputStream();
			output.flush();*/

			HttpServletResponse response = null; // 响应报文
			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		    Document doc = builder.parse(new StringBufferInputStream(generateHtml()));

		    ITextRenderer renderer = new ITextRenderer();
		    renderer.setDocument(doc, null);
		    renderer.layout();
		    
		    response = setResponseInfo("application/x-download;charset=utf-8","课纲.pdf");
			output = response.getOutputStream();
		    renderer.createPDF(output);
		    
			output.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if (null != output) {
					output.close();
				}
			} catch (IOException e) {
				log.error("IOException:", e);
			}
		}
		return null;
	}
	
	private String generateHtml(){
		StringBuffer buf = new StringBuffer();
	    buf.append("<!DOCTYPE html>");
	    buf.append("<html>");
	    
	    // put in some style
	    buf.append("<head>");
	    buf.append("<meta charset=\"UTF-8\"></meta>");
	    buf.append("<title>Insert title here</title>");
	    buf.append("</head>");
	    
	    // generate the body
	    buf.append("<body>");
	    buf.append("Go to the store and buy some more, 99 bottles of beer on the wall.");
	    buf.append("</body>");
	    buf.append("</html>");
		return buf.toString();
	}
	
	public static void main(String args[]){
		//generateHtml();
	}
	
	public ICourseService getCourseService() {
		return courseService;
	}
	
	@Resource
	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}

	public ISolrKeywordService getSolrKeywordService() {
		return solrKeywordService;
	}
	@Resource
	public void setSolrKeywordService(ISolrKeywordService solrKeywordService) {
		this.solrKeywordService = solrKeywordService;
	}
	public ISolrSubjectService getSolrSubjectService() {
		return solrSubjectService;
	}
	@Resource
	public void setSolrSubjectService(ISolrSubjectService solrSubjectService) {
		this.solrSubjectService = solrSubjectService;
	}
	public String getCate() {
		return cate;
	}
	public void setCate(String cate) {
		this.cate = cate;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public boolean isInner() {
		return isInner;
	}
	public void setInner(boolean isInner) {
		this.isInner = isInner;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}

}
