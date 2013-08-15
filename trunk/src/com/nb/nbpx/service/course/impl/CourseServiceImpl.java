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
import com.nb.nbpx.dao.subject.ISubjectDao;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.dao.user.ITeacherInfoDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.course.CourseKeyword;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

@Component("CourseService")
@SuppressWarnings("rawtypes")
public class CourseServiceImpl extends BaseServiceImpl implements ICourseService {

	private ICourseDao courseDao;
	private ITeacherInfoDao teacherDao;
	private ICourseInfoDao courseInfoDao;
	private ICourseKeywordDao courseKeywordDao;
	private IDictionaryDao dictionaryDao;
	private IKeywordDao keywordDao;
	private ISubjectDao subjectDao;

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
		String subjects = "";

		String keywordsHql = "select keyword from com.nb.nbpx.pojo.course.CourseKeyword where courseId = "
				+ courseId;
		List keywordsList = courseDao.find(keywordsHql);
		keywords = StringUtils.join(keywordsList, "，");
		
		String subjectsHql = "select subject from com.nb.nbpx.pojo.course.CourseSubject where courseId = "
				+ courseId;
		List subjectsList = courseDao.find(subjectsHql);
		subjects = StringUtils.join(subjectsList, "，");

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
		cdto.setSubject(subjects);
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
		List<Keyword> keywordsForLink = new ArrayList<Keyword>();
		Map<Integer, String> keywordMap = new HashMap<Integer, String>();
		Map<Integer, String> subjectMap = new HashMap<Integer, String>();
		Map<String, String> industryMap = new HashMap<String, String>();
		Map<String, String> tagetMap = new HashMap<String, String>();
		Map<String, String> majorMap = new HashMap<String, String>();

		String[] courseKeywords = null;
		String[] courseSubjects = null;
		String[] courseMajors = null;
		String[] courseTargets = null;
		String[] courseIndustry = null;
		if (courseDto.getKeywords() != null) {
			String keywordsStr = courseDto.getKeywords().replaceAll("，",
					",");
			courseKeywords = keywordsStr.split(",");
		}
		if (courseDto.getSubject() != null) {
			String subjectStr = courseDto.getSubject().replaceAll("，",
					",");
			courseSubjects = subjectStr.split(",");
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
			keywordsForLink.add(keyword);
		}
		
		for (int i = 0; courseSubjects != null && i < courseSubjects.length; i++) {
			String subjectStr = StringUtils.trim(courseSubjects[i]);
			Subject subject = new Subject();
			subject.setCategory(courseDto.getCategory());
			subject.setSubject(subjectStr);
			subject = subjectDao.saveOrGetExistsSubject(subject);
			subjectMap.put(subject.getSubjectId(), subject.getSubject());
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
			courseDao.deleteAllOtherInfosCourse(courseDto.getCourseId(),false);
		}
		
		courseDao.addAllOtherCourseInfo(courseDto.getCourseId(), industryMap,
				tagetMap, majorMap, keywordMap, subjectMap);
	}


	@Override
	public void deleteCourse(Course course) throws NbpxException {
		courseDao.delete(course);
		courseDao.deleteAllOtherInfosCourse(course.getCourseId(),true);
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
		
		return JsonUtil.formatListToJson(result);
	}

	//查看课程内容
	public String viewCourse(String courseId){
		if(courseId == null || "".equals(courseId))
			return "课程不存在";
		Course currCourse = courseDao.getCourseById(Integer.parseInt(courseId));
		if(currCourse == null)
			return "课程不存在";
		
		List<CourseInfo> courseInfos = courseInfoDao.queryCourseInfoByCourseId(courseId);

		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		DecimalFormat df = new DecimalFormat("0");
		Map<String,Object> classInfo = new HashMap<String,Object>();
			
		List<Map<String,String>> details = new ArrayList<Map<String,String>>();
		for(int i=0;i<courseInfos.size();i++){
			CourseInfo temp = courseInfos.get(i);
			Map<String,String> detail = new HashMap<String,String>();
			detail.put("from", format.format(temp.getStartDate()));
			detail.put("to", format.format(temp.getEndDate()));
			Dictionary cityD = dictionaryDao.getDictionary(temp.getCity(), "");
			detail.put("cityID", temp.getCity());
			detail.put("city", cityD.getShowName());
			details.add(detail);
		}
			
		classInfo.put("time", details);
		TeacherInfo teacher = teacherDao.getTeacherInfoById(Integer.parseInt(currCourse.getTeacherId()));
		classInfo.put("price", df.format(currCourse.getPrice())+"元/位");
		classInfo.put("teacher", teacher.getRealName());
		classInfo.put("teacherID",teacher.getTeacherId());
		classInfo.put("bloclContent", currCourse.getBlockedContent());
		classInfo.put("content", currCourse.getContent());
		classInfo.put("title", currCourse.getTitle());
		classInfo.put("classNum", currCourse.getCourseId());
			
		//培训对象
		List<Map<String,String>> trainObject = new ArrayList<Map<String,String>>();
		Map<String,String> object = new HashMap<String,String>();
		object.put("id", "1");
		object.put("name", "总经理");
		trainObject.add(object);
		classInfo.put("object", trainObject);
			
		//行业
		List<Map<String,String>> indestorys = new ArrayList<Map<String,String>>();
		Map<String,String> indestory = new HashMap<String,String>();
		indestory.put("id", "1");
		indestory.put("name", "电力行业");
		indestorys.add(indestory);
		classInfo.put("indestory", indestorys);
			
		//专业
		List<Map<String,String>> majors = new ArrayList<Map<String,String>>();
		Map<String,String> major = new HashMap<String,String>();
		major.put("id", "1");
		major.put("name", "电气工程");
		majors.add(major);
		classInfo.put("major", majors);
			
		//关键字
		List<Map<String,String>> keyWords = new ArrayList<Map<String,String>>();
		Map<String,String> keyWord = new HashMap<String,String>();
		keyWord.put("id", "1");
		keyWord.put("name", "电力");
		keyWords.add(keyWord);
		classInfo.put("keyWords", keyWords);
		
		//专题
		List<Map<String,String>> serieses = new ArrayList<Map<String,String>>();
		Map<String,String> series = new HashMap<String,String>();
		series.put("id", "1");
		series.put("name", "人力资源");
		serieses.add(series);
		classInfo.put("series", serieses);

		return JsonUtil.formatMapToJson(classInfo).toString();
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

	public ISubjectDao getSubjectDao() {
		return subjectDao;
	}
	
	@Resource
	public void setSubjectDao(ISubjectDao subjectDao) {
		this.subjectDao = subjectDao;
	}

}
