/**
 * @author Roger
 */
package com.nb.nbpx.server.course;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.struts2.ServletActionContext;
import org.jsoup.helper.StringUtil;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrCourseService;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.utils.JsonUtil;

/**
 * @author Roger
 * @date 2013-6-18
 */
@Component("CourseAction")
@Scope("prototype")
public class CourseAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ISolrService dataImportor;
	private ICourseService courseService;
	private IKeywordService keywordService;
	private ISolrCourseService solrCourseService;
	public String category;
	public String courseCode;
	public String q_title;
	public Integer courseId;
	public Boolean state;
	public Boolean sync;
	public Course course;
	public Boolean isInner;
	public String selected_courseId;
	public CourseInfo courseInfo;
	public CourseAllInfoDto courseAllInfo;
	public static Logger log = LogManager.getLogger(CourseAction.class);

	public String fullImport() {
		try {
			dataImportor.fullImport();
		} catch (SolrServerException ce) {
			ce.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, ResponseStatus.IMPORT_FAILED
							+ "Solr服务器连接失败！请检查服务器！"));
			return "failure";
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.IMPORT_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.IMPORT_SUCCESS));
		return SUCCESS;
	}
	
	public String AuditCourse() {
		try {
			courseService.auditCourse(!state, courseId);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.DELETE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}

	public String queryCourses() {
		String json = courseService.queryCourses(category, courseId,	q_title, rows,
				getStartPosi(), sort, order,isInner);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String queryCourseById() {
		String json = courseService.queryCourseById(courseId);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String queryComboCourseTypes() {
		String json = courseService.queryComboCourseType();
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String queryComboCourseCode() {
		String json = courseService.queryComboCourseName(category,isInner);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String queryComboTeacher() {
		String json = courseService.queryComboTeacher();
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String saveCourse() {
		//TODO save with created by
		validateCourseInfo();
		String[] links = courseAllInfo.getLinks().split(",");
		// List<Keyword> keywords = keywordService.saveKeywords(courseAllInfo);
		// 让Keyword提前保存，生成超链接的时候才有ID可以对应
		Course cou = new Course(courseAllInfo);
		cou.setContent(keywordService.setHyperLink(links,
				cou.getContent()));// 生成超链接
		try {
			Boolean deleteBeforeInsert = false;
			if (courseAllInfo.getCourseId() != null) {
				deleteBeforeInsert = true;
			}
			cou = courseService.saveCourse(cou);
			courseAllInfo.setCourseId(cou.getCourseId());
			courseService
					.saveOtherCourseInfo(courseAllInfo, deleteBeforeInsert);
			solrCourseService.addCourse2Solr(courseAllInfo);
			if(sync!=null&&sync&&!deleteBeforeInsert){
				//同步到内训
				Course innerCou = cou;
				innerCou.setCourseId(null);
				innerCou.setIsInner(true);
				innerCou = courseService.saveCourse(innerCou);
				courseAllInfo.setCourseId(innerCou.getCourseId());
				courseService
						.saveOtherCourseInfo(courseAllInfo, deleteBeforeInsert);
				solrCourseService.addCourse2Solr(courseAllInfo);
			}
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("dlg_courseId", cou.getCourseId().toString());
		this.inputStream = castToInputStream(JsonUtil
				.formatToOpResJsonWithParam(ResponseStatus.SUCCESS,
						ResponseStatus.SAVE_SUCCESS, map));
		return SUCCESS;
	}
	
	/**
	 * 处理课程的详细信息，更正各种不合法的输入
	 */
	private void validateCourseInfo(){
		// String
		// regEx="[`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";
		String regEx1 = "[\\pP‘’“”_]";
		if (courseAllInfo.getLinks() != null) {
			courseAllInfo.setLinks(courseAllInfo.getLinks().replace(" ", ""));
			courseAllInfo.setLinks(courseAllInfo.getLinks().replaceAll(
					regEx1, ","));
		}
		if (courseAllInfo.getKeywords() != null) {
			courseAllInfo.setKeywords(courseAllInfo.getKeywords().replace(" ", ""));
			courseAllInfo.setKeywords(courseAllInfo.getKeywords().replaceAll(
					regEx1, ","));
		}
		if (courseAllInfo.getSubject() != null) {
			courseAllInfo.setSubject(courseAllInfo.getSubject().replace(" ", ""));
			courseAllInfo.setSubject(courseAllInfo.getSubject().replaceAll(
					regEx1, ","));
		}
		if (courseAllInfo.getTargets() != null) {
			courseAllInfo.setTargets(courseAllInfo.getTargets().replace(" ", ""));
			if(StringUtil.isNumeric(courseAllInfo.getTargets().replaceAll(regEx1, ""))){
				courseAllInfo.setTargets(courseAllInfo.getTargets().replaceAll(
						"，", ","));
			}else{
				courseAllInfo.setTargets(courseAllInfo.getTargets().replaceAll(
						regEx1, ","));
			}
		}
		if (courseAllInfo.getMajor() != null) {
			courseAllInfo.setMajor(courseAllInfo.getMajor().replace(" ", ""));
			if(StringUtil.isNumeric(courseAllInfo.getMajor().replaceAll(regEx1, ""))){
				courseAllInfo.setMajor(courseAllInfo.getMajor().replaceAll(
						"，", ","));
			}else{
				courseAllInfo.setMajor(courseAllInfo.getMajor().replaceAll(
						regEx1, ","));
			}
		}
		if (courseAllInfo.getProduct() != null) {
			courseAllInfo.setProduct(courseAllInfo.getProduct().replace(" ", ""));
			if(StringUtil.isNumeric(courseAllInfo.getProduct().replaceAll(regEx1, ""))){
				courseAllInfo.setProduct(courseAllInfo.getProduct().replaceAll(
						"，", ","));
			}else{
				courseAllInfo.setProduct(courseAllInfo.getProduct().replaceAll(
						regEx1, ","));
			}
		}
		if (courseAllInfo.getIndustry() != null) {
			courseAllInfo.setIndustry(courseAllInfo.getIndustry().replace(" ", ""));
			if(StringUtil.isNumeric(courseAllInfo.getIndustry().replaceAll(regEx1, ""))){
				courseAllInfo.setIndustry(courseAllInfo.getIndustry().replaceAll(
						"，", ","));
			}else{
				courseAllInfo.setIndustry(courseAllInfo.getIndustry().replaceAll(
						regEx1, ","));
			}
		}
	}

	public String deleteCourse() {
		try {
			courseService.deleteCourse(course);
			solrCourseService.removeCourseFromSolr(course.getCourseId());
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.DELETE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}

	/**
	 * <p>
	 * 通过courseId查找课程安排
	 * </p>
	 * 
	 * @return
	 */
	public String queryCourseInfo() {
		String json = courseService.queryCourseInfo(selected_courseId);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	/**
	 * 保存课程安排
	 * 
	 * @return
	 */
	public String saveCourseInfo() {
		try {
			courseService.saveCourseInfo(courseInfo);
			solrCourseService.updateCourseInfo2Solr(courseInfo.getCourseId());
			// TODO SOLR update

		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}

	/**
	 * 删除课程安排
	 * 
	 * @return
	 */
	public String deleteCourseInfo() {
		try {
			courseService.deleteCourseInfo(courseInfo);
			solrCourseService.updateCourseInfo2Solr(courseInfo.getCourseId());
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.DELETE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}

	public String queryKeywords() {
		String json = "";
		try {
			json = courseService.queryKeywords(courseId);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.QUERY_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	/**
	 * 根据条件报表<br />
	 * 使用Jxls导出，模板放于XLSTemplate文件夹下
	 */
	public String exportAttendance() {
		int year = 2013;
		int month = 12;
		String cate = "财务管理";
		OutputStream output = null; // 响应报文输出流
		FileInputStream input = null; // 文件输入流
		try {
			StringBuilder src = new StringBuilder();
			HttpServletResponse response = null; // 响应报文
			String templateSrc = null; // 模板路径

			templateSrc = ServletActionContext.getServletContext().getRealPath(
					"/XLSTemplate");
			src.append(templateSrc);
			src.append("/template-attendance.xls");
			response = setResponseInfo("application/x-download;charset=utf-8",
					+year + "年" + month + "月份" + cate + "培训计划.xls");
			output = response.getOutputStream();
			input = new FileInputStream(src.toString());
			courseService.exportExcel(cate, year, month, input, output);
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
				log.error("导出工资excel报表IOException:", e);
				e.printStackTrace();
			}
		}
		return null;
	}

	/**
	 * @param dataImportor
	 *            the dataImportor to set
	 */
	@Resource
	public void setDataImportor(ISolrService dataImportor) {
		this.dataImportor = dataImportor;
	}

	/**
	 * @return the dataImportor
	 */
	public ISolrService getDataImportor() {
		return dataImportor;
	}

	@Resource
	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}

	public ICourseService getCourseService() {
		return courseService;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	public Integer getCourseId() {
		return courseId;
	}

	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public String getSelected_courseId() {
		return selected_courseId;
	}

	public void setSelected_courseId(String selected_courseId) {
		this.selected_courseId = selected_courseId;
	}

	public CourseInfo getCourseInfo() {
		return courseInfo;
	}

	public void setCourseInfo(CourseInfo courseInfo) {
		this.courseInfo = courseInfo;
	}

	public CourseAllInfoDto getCourseAllInfo() {
		return courseAllInfo;
	}

	public void setCourseAllInfo(CourseAllInfoDto courseAllInfo) {
		// String
		// regEx="[`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";
		// String regEx1 = "[\\pP‘’“”]";
		// courseAllInfo.setKeywords(courseAllInfo.getKeywords().replaceAll(regEx1,
		// ","));
		// courseAllInfo.setSubject(courseAllInfo.getSubject().replaceAll(regEx1,
		// ","));
		this.courseAllInfo = courseAllInfo;
	}

	public IKeywordService getKeywordService() {
		return keywordService;
	}

	@Resource
	public void setKeywordService(IKeywordService keywordService) {
		this.keywordService = keywordService;
	}

	public ISolrCourseService getSolrCourseService() {
		return solrCourseService;
	}

	@Resource
	public void setSolrCourseService(ISolrCourseService solrCourseService) {
		this.solrCourseService = solrCourseService;
	}

	public String getQ_title() {
		return q_title;
	}

	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}

	public Boolean getIsInner() {
		return isInner;
	}

	public void setIsInner(Boolean isInner) {
		this.isInner = isInner;
	}

	public Boolean getState() {
		return state;
	}

	public void setState(Boolean state) {
		this.state = state;
	}

	public Boolean getSync() {
		return sync;
	}

	public void setSync(Boolean sync) {
		this.sync = sync;
	}
}
