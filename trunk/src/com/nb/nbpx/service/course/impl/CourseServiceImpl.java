package com.nb.nbpx.service.course.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.ListUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.course.ICourseDao;
import com.nb.nbpx.dao.course.ICourseInfoDao;
import com.nb.nbpx.dao.course.ICourseKeywordDao;
import com.nb.nbpx.dao.user.ITeacherInfoDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.course.CourseKeyword;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

@Component("CourseService")
@SuppressWarnings("rawtypes")
public class CourseServiceImpl extends BaseServiceImpl implements
		ICourseService {

	private ICourseDao courseDao;
	private ITeacherInfoDao teacherDao;
	private ICourseInfoDao courseInfoDao;
	private ICourseKeywordDao courseKeywordDao;

	// private ICourseKeywordDao courseKeywordDao;
	// private ICourseKeywordDao courseKeywordDao;

	@Override
	public String queryCourses(String category, String courseCode,
			Integer rows, Integer start) {
		String json = "";
		List<Course> list = courseDao.queryCourses(category, courseCode, rows,
				start);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = courseDao.queryCourseCount(category, courseCode)
					.intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}

	@Override
	public String queryComboCourseType() {
		List list = courseDao.queryCourseType();
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	@Override
	public String queryComboCourseName(String category) {
		List<Course> list = courseDao.queryCourses(category, null, null, null);
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	@Override
	public String queryCourseById(Integer courseId) {
		Course course = courseDao.get(courseId);
		String keywords = "";
		String targets = "";
		String industries = "";
		String majors = "";
		
		String keywordsHql = "select keyword from com.nb.nbpx.pojo.course.CourseKeyword where courseId = " + courseId;
		List keywordsList = courseDao.find(keywordsHql);
		keywords = StringUtils.join(keywordsList, ",");
		
		String targetsHql = "select target from com.nb.nbpx.pojo.course.CourseTarget where courseId = " + courseId;
		List targetsList = courseDao.find(targetsHql);
		targets = StringUtils.join(targetsList, ",");
		
		String industriesHql = "select industry from com.nb.nbpx.pojo.course.CourseIndustry where courseId = " + courseId;
		List industriesList = courseDao.find(industriesHql);
		industries = StringUtils.join(industriesList, ",");
		
		String majorsHql = "select major from com.nb.nbpx.pojo.course.CourseMajor where courseId = " + courseId;
		List majorsList = courseDao.find(majorsHql);
		majors = StringUtils.join(majorsList, ",");
		
		CourseAllInfoDto cdto = new CourseAllInfoDto(course);
		cdto.setKeywords(keywords);
		cdto.setTargets(targets);
		cdto.setIndustry(industries);
		cdto.setMajor(majors);
		String json = JsonUtil.getJsonString(cdto);
		return json;
	}

	@Override
	public String queryComboTeacher() {
		List<TeacherInfo> list = courseDao.queryTeachers();
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	@Override
	public Course saveCourse(Course course) throws NbpxException {
		/*
		 * 2013年7月19日 在课程修改和增加的地方添加了增加教师的功能 if (course.getTeacherId() != null &&
		 * !course.getTeacherId().isEmpty()) { Integer id = null; try { id =
		 * Integer.parseInt(course.getTeacherId()); } catch
		 * (NumberFormatException e) { e.printStackTrace(); } TeacherInfo
		 * teacher = null; if (id == null) {
		 * course.setTeacherName(course.getTeacherId());
		 * course.setTeacherId(null); } else { teacher = teacherDao.get(id); if
		 * (teacher == null) { course.setTeacherName(course.getTeacherId());
		 * course.setTeacherId(null); }else{
		 * course.setTeacherName(course.getTeacherId());
		 * course.setTeacherId(null); } } }
		 */
		if (course.getCourseId() == null) {
			if (courseDao.checkDuplicateProp(course)) {
				throw new NbpxException("已存在此课程编号");
			}
			courseDao.save(course);
		} else {
			courseDao.saveOrUpdate(course);
		}
		return course;
	}

	@Override
	public void deleteCourse(Course course) throws NbpxException {
		courseDao.delete(course);
	}

	// 根据城市获取课程信息
	public String getCoursesByCity(String city, Integer rows, Integer start) {
		String result = "";
		List<Course> courseList = this.courseDao.getCourseByCity(city, rows,
				start);
		if (courseList == null || courseList.size() == 0)
			return "<p style='font-size:12px'>暂无课程信息</p>";
		for (int i = 0; i < courseList.size(); i++) {
			Course temp = courseList.get(i);
			List<CourseInfo> infos = this.courseDao.getCourseInfoByCity(city,
					temp.getCourseId(), 1);
			if (infos == null)
				continue;
			for (int j = 0; j < infos.size(); j++) {
				CourseInfo infoTemp = infos.get(j);
				DateFormat format = new SimpleDateFormat("mm-dd");
				String startDate = format.format(infoTemp.getStartDate());
				result += "<li><a href='#'>" + temp.getTitle() + "</a><div>"
						+ startDate + "/<span class='money'>￥</span>"
						+ temp.getPrice() + "</div></li>";
			}
		}
		return result;
	}

	@Override
	public String queryCourseInfo(String courseInfoId) {
		List<CourseInfo> list = courseInfoDao.queryCourseInfo(courseInfoId);
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	@Override
	public void saveCourseInfo(CourseInfo courseInfo) {
		if (courseInfo.getCourseInfoId() != null) {
			courseInfoDao.saveOrUpdate(courseInfo);
		} else {
			courseInfoDao.save(courseInfo);
		}
	}

	@Override
	public void deleteCourseInfo(CourseInfo courseInfo) {
		courseInfoDao.delete(courseInfo);
	}

	@Override
	public String queryKeywords(Integer courseId) {
		Map<String, Object> propsMap = new HashMap<String, Object>();
		propsMap.put("courseId", courseId);
		List<CourseKeyword> list = courseKeywordDao
				.queryEntityListByProperties(CourseKeyword.class, null, null,
						propsMap);
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	// ||||getter和setter

	@Resource
	public void setCourseDao(ICourseDao courseDao) {
		this.courseDao = courseDao;
	}

	public ICourseDao getCourseDao() {
		return courseDao;
	}

	public ITeacherInfoDao getTeacherDao() {
		return teacherDao;
	}

	@Resource
	public void setTeacherDao(ITeacherInfoDao teacherDao) {
		this.teacherDao = teacherDao;
	}

	public ICourseInfoDao getCourseInfoDao() {
		return courseInfoDao;
	}

	@Resource
	public void setCourseInfoDao(ICourseInfoDao courseInfoDao) {
		this.courseInfoDao = courseInfoDao;
	}

	public ICourseKeywordDao getCourseKeywordDao() {
		return courseKeywordDao;
	}

	@Resource
	public void setCourseKeywordDao(ICourseKeywordDao courseKeywordDao) {
		this.courseKeywordDao = courseKeywordDao;
	}

}
