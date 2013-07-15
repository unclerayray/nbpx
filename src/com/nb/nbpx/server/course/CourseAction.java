/**
 * @author Roger
 */
package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;
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
	public String category;
	public String courseCode;
	public Integer courseId;
	public Course course;

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

	public String queryCourses() {
		String json = courseService.queryCourses(category, courseCode, rows,
				getStartPosi());
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
		String json = courseService.queryComboCourseName(category);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String queryComboTeacher() {
		String json = courseService.queryComboTeacher();
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String saveCourse() {
		try {
			courseService.saveCourse(course);
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

	public String deleteCourse() {
		try {
			courseService.deleteCourse(course);
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
}
