package com.nb.nbpx.server.course;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.lowagie.text.pdf.BaseFont;
import com.nb.nbpx.pojo.course.Course;
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
	public Integer month;
	public int year;
	public boolean isInner = false;
	public String flag;
	public Integer courseId;
	
	public String getPlanCourse(){
		Boolean ifInner = false;
		if("2".equals(flag))
			ifInner = true;
		String resultStr = courseService.getTranPlans(ifInner, rows, this.getStartPosi());
		this.inputStream = castToInputStream(resultStr);
		
		return SUCCESS;
	}
	
	//获取培训计划的内容
	public String getTrainPlanInfo(){
		//String resultStr = courseService.getTranPlan(rows, this.getStartPosi());
		if(NbpxDicMap.getCourseTypeMap().get(cate)==null){
			cate = null;
		}
		if(city!=null && !city.contains("_")){
			city = null;
		}
		Calendar fromCal = Calendar.getInstance();
		fromCal.set(Calendar.YEAR, year);
		//month = 13 for all year
		//month = null for this month
		if(month == null){
			//starts from next day
			fromCal.add(Calendar.DAY_OF_MONTH, 1);
		}else if(month<1 || month > 12){
			fromCal.set(Calendar.MONTH, 0);
			fromCal.set(Calendar.DAY_OF_MONTH, 1);//first day of the year
		}else{
			fromCal.set(Calendar.MONTH, month-1);
			fromCal.set(Calendar.DAY_OF_MONTH, 1);//first day of the month
		}
		Date fromDate = fromCal.getTime();
		Calendar toCal = Calendar.getInstance();
		if(month == null){
			toCal.set(Calendar.DAY_OF_MONTH, toCal.getActualMaximum(Calendar.DAY_OF_MONTH));//month end
		}else if(month<1 || month > 12){
			toCal.set(Calendar.YEAR, year+1);
			toCal.set(Calendar.MONTH, 11);//12月
			toCal.set(Calendar.DAY_OF_MONTH, toCal.getActualMaximum(Calendar.DAY_OF_MONTH));//month end
		}else{
			toCal.set(Calendar.YEAR, year);
			toCal.set(Calendar.MONTH, month-1);
			toCal.set(Calendar.DAY_OF_MONTH, toCal.getActualMaximum(Calendar.DAY_OF_MONTH));
		}
		Date toDate = toCal.getTime();
		String resultStr = courseService.getTranPlans(cate, fromDate, toDate, isInner, city, 100);
		this.inputStream = castToInputStream(resultStr);
		
		return SUCCESS;
	}
	//获取内训计划的内容
	public String getInnerTrainPlanInfo(){
		String resultStr = courseService.getTranPlans(cate, null, null, isInner, city, 100);
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
	//获取培训计划相关关键词
	public String getInnerPlanRelatedKeyWords(){
		try {
			String result = solrKeywordService.queryRelatedKeywords("内训计划", 0, 30);
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
	//获取培训计划相关专题
	public String getInnerPlanRelatedSubjects(){
		try {
			String result = solrSubjectService.queryRelatedSubject("内训计划", 0, 30);
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
	public String exportInnerCoursePlan() {
		OutputStream output = null; // 响应报文输出流
		FileInputStream input = null; // 文件输入流
		try {
			StringBuilder src = new StringBuilder();
			HttpServletResponse response = null; // 响应报文
			String templateSrc = null; // 模板路径

			templateSrc = ServletActionContext.getServletContext().getRealPath(
					"/XLSTemplate");
			src.append(templateSrc);
			src.append("/template-innerCoursePlan.xls");
			String categoryName = "";
			if(NbpxDicMap.getCourseTypeMap().get(cate)!=null){
				categoryName = NbpxDicMap.getCourseTypeMap().get(cate).toString();
			}else{
				cate = null;
				categoryName = "";
			}
			if(city!=null && !city.contains("_")){
				city = null;
			}
			response = setResponseInfo("application/x-download;charset=utf-8",categoryName + "内训计划.xls");
			output = response.getOutputStream();
			input = new FileInputStream(src.toString());
			courseService.exportInnerExcel(cate,input, output);
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
			String categoryName = "";
			if(NbpxDicMap.getCourseTypeMap().get(cate)!=null){
				categoryName = NbpxDicMap.getCourseTypeMap().get(cate).toString();
			}else{
				cate = null;
				categoryName = "";
			}
			if(city!=null && !city.contains("_")){
				city = null;
			}
			response = setResponseInfo("application/x-download;charset=utf-8",
					+year + "年" + ((month==null || month<1 || month > 12)?"":month+"月份") + categoryName + (isInner?"内训计划.xls":"培训计划.xls"));
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
	public String exportKegang(){
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
			Course course = courseService.getCourseById(courseId);
		    //Document doc = builder.parse(new ByteArrayInputStream(generateHtml(course.getTitle(),course.getContent()).getBytes("UTF-8")));
			//Document doc = builder.parse(new StringBufferInputStream(generateHtml(course.getTitle(),course.getContent())));

		    ITextRenderer renderer = new ITextRenderer();
		    String path = Thread.currentThread().getContextClassLoader().getResource("").getPath();
		    path += "ARIALUNI.TTF";
		    
		    //path = "D:\\test\\ARIALUNI.TTF";
		    org.xhtmlrenderer.pdf.ITextFontResolver fontResolver = renderer  
	                .getFontResolver();  
	        fontResolver.addFont(path, BaseFont.IDENTITY_H,     
	                BaseFont.NOT_EMBEDDED);
		    //renderer.setDocument(doc, null);
		    renderer.setDocumentFromString(generateHtml(course.getTitle(),course.getContent()));
		    renderer.layout();

		    
	        
		    response = setResponseInfo("application/x-download;charset=utf-8","《"+course.getTitle()+"》课纲.pdf");
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
	
	private String generateHtml(String title,String content){
		StringBuffer html = new StringBuffer();
	    //html.append("<!DOCTYPE math PUBLIC \"-//W3C//DTD MathML 3.0//EN\" \"http://www.w3.org/Math/DTD/mathml3/mathml3.dtd\">");
	    //html.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">");
	    
	    html.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");  
	    html.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">");
	    
	    // put in some style
	    html.append("<head>");
	    html.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"></meta>");
	    html.append("<title>Insert title here</title>");
	    html.append("<style type=\"text/css\">");
	    html.append("body {font-family:\"Arial Unicode MS\";}");
	    html.append("</style>");
	    html.append("</head>");
	    
	    // generate the body
	    html.append("<body>");
	    html.append("<h1 align=\"center\">");
	    html.append(title);
	    html.append("</h1>");
	    html.append(content);
	    html.append("</body>");
	    html.append("</html>");
		return html.toString();
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
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
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
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}

}
