package com.nb.nbpx.service.course.impl;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.course.ICourseDao;
import com.nb.nbpx.dao.course.ICourseInfoDao;
import com.nb.nbpx.dao.course.ICourseKeywordDao;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.dao.user.ITeacherInfoDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.course.CourseKeyword;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.system.Dictionary;
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
	private IDictionaryDao dictionaryDao;
	private IKeywordDao keywordDao;

	// private ICourseKeywordDao courseKeywordDao;
	// private ICourseKeywordDao courseKeywordDao;

	@Override
	public String queryCourses(String category, Integer courseId,
			Integer rows, Integer start) {
		String json = "";
		List<Course> list = courseDao.queryCourses(category, courseId, rows,
				start);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = courseDao.queryCourseCount(category, courseId)
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

		String keywordsHql = "select keyword from com.nb.nbpx.pojo.course.CourseKeyword where courseId = "
				+ courseId;
		List keywordsList = courseDao.find(keywordsHql);
		keywords = StringUtils.join(keywordsList, "，");

		String targetsHql = "select targetCode from com.nb.nbpx.pojo.course.CourseTarget where courseId = "
				+ courseId;
		List targetsList = courseDao.find(targetsHql);
		targets = StringUtils.join(targetsList, ",");

		String industriesHql = "select industryCode from com.nb.nbpx.pojo.course.CourseIndustry where courseId = "
				+ courseId;
		List industriesList = courseDao.find(industriesHql);
		industries = StringUtils.join(industriesList, ",");

		String majorsHql = "select majorCode from com.nb.nbpx.pojo.course.CourseMajor where courseId = "
				+ courseId;
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
	public Course saveCourse(Course course) throws Exception {
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
				throw new NbpxException("由此教师讲解的《"+course.getTitle()+"》课程已存在在数据库中，如需新增安排，请直接在列表中查出该课程，点击课程安排！");
			}
			// 新增课程
			course.setCreationDate(new Date());
			course.setHits(500);
			course.setLastUpdateDate(new Date());
			courseDao.save(course);
		} else {
			// 修改课程内容
			//courseDao.saveOrUpdate(course);
			course.setLastUpdateDate(new Date());
			courseDao.updateCourse(course);
		}
		return course;
	}
	

	@Override
	public void saveOtherCourseInfo(CourseAllInfoDto courseDto,Boolean deleteBeforeInsert) {
		Map<Integer, String> keywordMap = new HashMap<Integer, String>();
		Map<String, String> industryMap = new HashMap<String, String>();
		Map<String, String> tagetMap = new HashMap<String, String>();
		Map<String, String> majorMap = new HashMap<String, String>();

		String[] courseKeywords = null;
		String[] courseMajors = null;
		String[] courseTargets = null;
		String[] courseIndustry = null;
		if (courseDto.getKeywords() != null) {
			String keywordsStr = courseDto.getKeywords().replaceAll("，",
					",");
			courseKeywords = keywordsStr.split(",");
		}
		if (courseDto.getMajor() != null) {
			courseMajors = courseDto.getMajor().split(",");
		}
		if (courseDto.getTargets() != null) {
			courseTargets = courseDto.getTargets().split(",");
		}
		if (courseDto.getIndustry() != null) {
			courseIndustry = courseDto.getIndustry().split(",");
		}
		for (int i = 0; courseKeywords != null && i < courseKeywords.length; i++) {
			String keywordStr = StringUtils.trim(courseKeywords[i]);
			Keyword keyword = new Keyword();
			keyword.setCategory(courseDto.getCategory());
			keyword.setKeyword(keywordStr);
			keyword = keywordDao.saveOrGetExistsKeyword(keyword);
			keywordMap.put(keyword.getKeyId(), keyword.getKeyword());
		}

		for (int i = 0; courseMajors != null && i < courseMajors.length; i++) {
			String majorCode = StringUtils.trim(courseMajors[i]);
			Dictionary dic = dictionaryDao.getDictionary(majorCode, null);
			majorMap.put(dic.getCodeName(), dic.getShowName());
		}

		for (int i = 0; courseTargets != null && i < courseTargets.length; i++) {
			String targetCode = StringUtils.trim(courseTargets[i]);
			Dictionary dic = dictionaryDao.getDictionary(targetCode, null);
			tagetMap.put(dic.getCodeName(), dic.getShowName());
		}

		for (int i = 0; courseIndustry != null && i < courseIndustry.length; i++) {
			String industryCode = StringUtils.trim(courseIndustry[i]);
			Dictionary dic = dictionaryDao
					.getDictionary(industryCode, null);
			industryMap.put(dic.getCodeName(), dic.getShowName());
		}

		if(deleteBeforeInsert){
			courseDao.deleteAllOtherInfosCourse(courseDto.getCourseId());
		}
		
		courseDao.addAllOtherCourseInfo(courseDto.getCourseId(), industryMap,
				tagetMap, majorMap, keywordMap);
	}


	@Override
	public void deleteCourse(Course course) throws NbpxException {
		courseDao.delete(course);
		courseDao.deleteAllOtherInfosCourse(course.getCourseId());
	}

	// 根据城市获取课程信息
	public String getCoursesByCity(String city, Integer rows, Integer start) {
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		
		List<CourseInfo> courseInfoList = this.courseInfoDao.queryCourseInfoByCity(city,start,rows);
		if(courseInfoList == null || courseInfoList.size() == 0)
			return "[]";
		for(int i=0;i<courseInfoList.size();i++){
			CourseInfo temp = courseInfoList.get(i);
			if(temp == null)
				continue;
			Course course = this.courseDao.getCourseById(temp.getCourseId());
			if(course == null)
				continue;
			Map<String,Object> row = new HashMap<String,Object>();
			DateFormat format = new SimpleDateFormat("MM-dd");
			DecimalFormat df = new DecimalFormat("0");
			String startDate = format.format(temp.getStartDate());
			row.put("id", course.getCourseId());
			row.put("title", course.getTitle());
			row.put("date", startDate);
			row.put("price", df.format(course.getPrice()));
			result.add(row);
		}
		
		return JsonUtil.formatListToJson(result);
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

	// 得到培训的课程
	public String getNXCourse(String type, int flag) {
		
		List<Course> courseList = null;
		if (flag == 1)//推荐课程
			courseList = this.courseDao.getLastedCourse(false, type, true,
					false, 10, 0);
		if (flag == 2)//精品课程
			courseList = this.courseDao.getLastedCourse(false, type, false,
					true, 10, 0);
		if (flag == 3)//热门课程
			courseList = this.courseDao.getHotCourse(false, type, 10, 0);
		if (courseList == null)
			return "暂无课程信息";
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < courseList.size(); i++) {
			
			Course temp = courseList.get(i);
			if (temp == null)
				continue;
			Map<String,Object> row = new HashMap<String,Object>();
			row.put("id", temp.getCourseId());
			row.put("title", temp.getTitle());
			result.add(row);
		}
		return JsonUtil.formatListToJson(result);
	}
	
	// 获取首页推荐的 flag=1表示推荐，flag=2表示精品课程，flag=3表示热门课程
	public String getTopCourse(int flag, Boolean isInner) {
		List<CourseInfo> courseInfoList = null;
		if(flag == 1)//推荐课程
			courseInfoList = this.courseInfoDao.queryTop30CourseInfo(false,true,false);
		else if(flag == 2)//精品课程
			courseInfoList = this.courseInfoDao.queryTop30CourseInfo(false,false,true);
		else
			courseInfoList = null;
		Map<String,String> existKey = new HashMap<String,String>();
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int count = 0;
		if(courseInfoList == null)
			return "[]";
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		for(int i=0;i<courseInfoList.size();i++){
			CourseInfo temp = courseInfoList.get(i);
			if(temp == null)
				continue;
			if(existKey.containsKey(temp.getCourseId().toString()))
				continue;
			if(count >30)
				break;
			Map<String,Object> row = new HashMap<String,Object>();
			Course course = this.courseDao.getCourseById(temp.getCourseId());
			if(course == null)
				continue;
			TeacherInfo teacher = teacherDao.getTeacherInfoById(Integer.parseInt(course.getTeacherId()));
			String teacherName = "未知";
			if (teacher != null)
				teacherName = teacher.getRealName();
			row.put("city","全国");
			row.put("title", course.getTitle());
			row.put("id", course.getCourseId());
			row.put("teacher", teacherName);
			row.put("date", format.format(temp.getStartDate()));
			result.add(row);
			existKey.put(course.getCourseId().toString(), course.getCourseId().toString());
			count++;
		}
		
		/*List<Course> courseList = null;
		if (flag == 1)// 推荐
			courseList = this.courseDao.getLastedCourse(isInner, "", true,
					false, 30, 0);
		if (flag == 2)// 精品课程
			courseList = this.courseDao.getLastedCourse(isInner, "", false,
					true, 30, 0);
		if (flag == 3)// 热门，按照点击顺序
			courseList = this.courseDao.getHotCourse(isInner, "", 30, 0);

		if (courseList == null)
			return "暂无课程信息";
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < courseList.size(); i++) {
			Course temp = courseList.get(i);
			if (temp == null)
				continue;
			TeacherInfo teacher = teacherDao.getTeacherInfoById(Integer
					.parseInt(temp.getTeacherId()));
			String teacherName = "未知";
			if (teacher != null)
				teacherName = teacher.getRealName();

			List<CourseInfo> courseInfos = courseDao.getCourseInfoByCity("",
					temp.getCourseId(), 1);
			if (courseInfos == null)
				continue;
			for (int j = 0; j < courseInfos.size(); j++) {
				if(j >= 1)//只取最近的那条
					break;
				CourseInfo courseInfo = courseInfos.get(j);
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Dictionary cityD = dictionaryDao.getDictionary(
						courseInfo.getCity(), "");
				String cityName = "未知";
				if (cityD != null)
					cityName = cityD.getShowName();
				Map<String,Object> tempMap = new HashMap<String,Object>();
				tempMap.put("city",cityName);
				tempMap.put("title", temp.getTitle());
				tempMap.put("id", temp.getCourseId());
				tempMap.put("teacher", teacherName);
				tempMap.put("date", format.format(courseInfo.getStartDate()));
		
				result.add(tempMap);
			}
			
		}*/

		return JsonUtil.formatListToJson(result);
	}

	//查看课程内容
	public String viewCourse(String courseId,String flag){
		if(courseId == null || "".equals(courseId))
			return "课程不存在";
		Course currCourse = courseDao.getCourseById(Integer.parseInt(courseId));
		if(currCourse == null)
			return "课程不存在";
		StringBuffer result = new StringBuffer("");
		if("1".equals(flag)){//返回课程属性
			//result.append("<h1>"+currCourse.getTitle()+"</h1><div class=classNum>课程编号："+currCourse.getCourseCode()+"</div>");
			//result.append("<div class='detail'>");
			//result.append("<div class='classLeftPart'>");
			List<CourseInfo> courseInfos = courseInfoDao.queryCourseInfoByCourseId(courseId);
			String timeStr = "";
			String cityStr = "";
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			DecimalFormat df = new DecimalFormat("0");
			for(int i=0;i<courseInfos.size();i++){
				CourseInfo temp = courseInfos.get(i);
				timeStr += format.format(temp.getStartDate())+" 至 "+ format.format(temp.getEndDate());
				Dictionary cityD = dictionaryDao.getDictionary(temp.getCity(), "");
				cityStr += "<a href='#'>"+cityD.getShowName()+"</a>";
				if(i < courseInfos.size()-1){
					timeStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
					cityStr += "&nbsp;&nbsp;|&nbsp;&nbsp;";
				}
			}
			TeacherInfo teacher = teacherDao.getTeacherInfoById(Integer
					.parseInt(currCourse.getTeacherId()));
			result.append("<div class='time'><span>举办时间：</span>"+timeStr+"</div>");
			result.append("<div class='time'><span>上课地点：</span>"+cityStr+"</div>");
			result.append("<div class='time'><span>课程费用：</span>"+df.format(currCourse.getPrice())+"元/位</div>");
			result.append("<div class='time'><span>培训师：</span>"+teacher.getRealName()+"</div>");
			result.append("<div class='time'><span>培训对象：</span><a href='#'>总经理</a>、<a href='#'>CEO</a>、<a href='#'>高级管理人员</a></div>");
			result.append("<div class='time'><span>适用行业：</span><a href='#'>电力行业</a>、<a href='#'>生产行业</a></div>");
			result.append("<div class='time'><span>适用专业：</span><a href='#'>工商管理</a>、<a href='#'>行政管理</a>、<a href='#'>人力资源</a></div>");
			result.append("<div class='time'><span>关键词：</span><a href='#'>管理</a>、<a href='#'>团队建设</a></div>");
			result.append("<div class='time'><span>专题：</span><a href='#'>企业管理</a></div>");
			//result.append("</div>");
			//result.append("<div class='classRightPart'><dd><a href='#'>打印课程提纲</a></dd><dd><a href='#'>打印报名表格</a></dd>"+
			//		 	  "<dd><a href='#'>先加入收藏夹</a></dd><dd><a href='#'>引入内训申请</a></dd>"+
			//		 	  "<dd><a href='#'>先发送至邮箱</a></dd><dd><a href='#'>保存电脑桌面</a></dd>"+
			//		 	  "<dd><a href='#'>下载课程提纲</a></dd></div><div class='clear'></div>");
			//result.append("</div>");
		}
		if("2".equals(flag)){//返回课程内容
			result.append("<div class='intro'>推荐理由</div>"+
						  "<p>"+currCourse.getBlockedContent()+"</p>"+
						  "<div class='intro'>课程内容</div>"+
						  "<p>"+currCourse.getContent()+"</p><div class='clear'></div>");
		}
		if("3".equals(flag)){
			result.append("<h1>"+currCourse.getTitle()+"</h1><div class=classNum>课程编号："+currCourse.getCourseId()+"</div>");
		}
		
		return result.toString();
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

	public IDictionaryDao getDictionaryDao() {
		return dictionaryDao;
	}

	@Resource
	public void setDictionaryDao(IDictionaryDao dictionaryDao) {
		this.dictionaryDao = dictionaryDao;
	}

	@Resource
	public void setCourseKeywordDao(ICourseKeywordDao courseKeywordDao) {
		this.courseKeywordDao = courseKeywordDao;
	}

	public IKeywordDao getKeywordDao() {
		return keywordDao;
	}

	@Resource
	public void setKeywordDao(IKeywordDao keywordDao) {
		this.keywordDao = keywordDao;
	}

}
