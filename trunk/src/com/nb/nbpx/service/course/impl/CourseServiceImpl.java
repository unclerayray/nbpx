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
import com.nb.nbpx.dao.course.ICourseIndustryDao;
import com.nb.nbpx.dao.course.ICourseInfoDao;
import com.nb.nbpx.dao.course.ICourseKeywordDao;
import com.nb.nbpx.dao.course.ICourseMajorDao;
import com.nb.nbpx.dao.course.ICourseSubjectDao;
import com.nb.nbpx.dao.course.ICourseTargetDao;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.dao.subject.ISubjectDao;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.dao.user.ITeacherInfoDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseIndustry;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.course.CourseKeyword;
import com.nb.nbpx.pojo.course.CourseMajor;
import com.nb.nbpx.pojo.course.CourseSubject;
import com.nb.nbpx.pojo.course.CourseTarget;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.solr.ISolrSubjectService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

@Component("CourseService")
@SuppressWarnings("rawtypes")
public class CourseServiceImpl extends BaseServiceImpl implements ICourseService {

	private ICourseDao courseDao;
	private ITeacherInfoDao teacherDao;
	private ICourseInfoDao courseInfoDao;
	private ICourseKeywordDao courseKeywordDao;
	private ICourseIndustryDao courseIndustryDao;
	private ICourseSubjectDao courseSubjectDao;
	private ICourseTargetDao courseTargetDao;
	private ICourseMajorDao courseMajorDao;

	private IDictionaryDao dictionaryDao;
	private IKeywordDao keywordDao;
	private ISubjectDao subjectDao;
	@Resource
	private ISolrKeywordService solrKeywordService;
	@Resource
	private ISolrSubjectService solrSubjectService;

	// private ICourseKeywordDao courseKeywordDao;
	// private ICourseKeywordDao courseKeywordDao;

	@Override
	public String queryCourses(String category, Integer courseId,
			Integer rows, Integer start,String sort, String order) {
		String json = "";
		List<Course> list = courseDao.queryCourses(category, courseId, rows,
				start,sort,order);
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
	//获取最热的培训（可以按照地点）
	public String queryHotCourseByPlace(Boolean ifInner, String cityName,Integer rows,Integer start){
		List<Course> courses = courseDao.getHotCourseByPlace(ifInner, cityName, rows, start);
		if(courses == null)
			return "";
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		for(Course course : courses){
			if(course == null)
				continue;
			Map<String,Object> row = new HashMap<String,Object>();
			row.put("title", course.getTitle());
			row.put("id", course.getCourseId());
			result.add(row);
		}
		
		return JsonUtil.getJsonString(result);
	}
	
	//分页获取地点下的课程（可以按照月份）
	public String queryCourseByCity(String cityName,String year,String month,String orderFlag,Integer rows,Integer start){
		List<CourseInfo> courseInfos = courseDao.getCourseInfoByCity(cityName, year,month, orderFlag, rows, start);
		if(courseInfos == null)
			return "";
		Map<String,Object> returnValue = new HashMap<String,Object>();
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		for(CourseInfo courseInfo : courseInfos){
			if(courseInfo == null)
				continue;
			Course course = courseDao.getCourseById(courseInfo.getCourseId());
			if(course == null)
				continue;
			Map<String,Object> row = new HashMap<String,Object>();
			row.put("title", course.getTitle());
			if(course.getContent() != null ){
				if(course.getContent().length() <= 200)
					row.put("content",course.getContent());
				else
					row.put("content", course.getContent().substring(0,100));
			}
			else
				row.put("content", "暂无课程内容介绍");
			row.put("id", course.getCourseId());
			row.put("price", course.getPrice());
			SimpleDateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
			row.put("startDate", dateFormate.format(courseInfo.getStartDate()));
			row.put("endDate", dateFormate.format(courseInfo.getEndDate()));
			
			Dictionary city = dictionaryDao.getDictionary(courseInfo.getCity(), null);
			row.put("city", city.getShowName());
			
			result.add(row);
		}
		Integer rowsCount = courseDao.CountCourseByCity(cityName,year, month, orderFlag, rows, start);
		int allPages = 0;
		if(rowsCount%rows == 0)
			allPages = (int)(rowsCount/rows);
		else
			allPages = (int)(rowsCount/rows) +1;
		returnValue.put("pages", allPages);
		returnValue.put("rows", result);
		
		return JsonUtil.getJsonString(returnValue);
	}

	@Override
	public String queryComboCourseType() {
		List list = courseDao.queryCourseType();
		String json = JsonUtil.formatListToJson(list);
		return json;
	}

	@Override
	public String queryComboCourseName(String category) {
		List<Course> list = courseDao.queryCourses(category, null, null, null,null,null);
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
		String products = "";

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
		
		String productsHql = "select productCode from com.nb.nbpx.pojo.course.CourseProduct where courseId = "
				+ courseId;
		List productsList = courseDao.find(productsHql);
		products = StringUtils.join(productsList, ",");

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
		cdto.setProduct(products);
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
		//List<Keyword> keywordsForLink = new ArrayList<Keyword>();
		Map<Integer, String> keywordMap = new HashMap<Integer, String>();
		Map<Integer, String> subjectMap = new HashMap<Integer, String>();
		Map<String, String> industryMap = new HashMap<String, String>();
		Map<String, String> tagetMap = new HashMap<String, String>();
		Map<String, String> majorMap = new HashMap<String, String>();
		Map<String, String> productMap = new HashMap<String, String>();

		String[] courseKeywords = null;
		String[] courseSubjects = null;
		String[] courseMajors = null;
		String[] courseTargets = null;
		String[] courseIndustry = null;
		String[] courseProduct = null;
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
		if (courseDto.getProduct() != null) {
			courseProduct = courseDto.getProduct().split(",");
		}
		for (int i = 0; courseKeywords != null && i < courseKeywords.length; i++) {
			String keywordStr = StringUtils.trim(courseKeywords[i]);
			Keyword keyword = new Keyword();
			keyword.setCategory(courseDto.getCategory());
			keyword.setKeyword(keywordStr);
			keyword.setHits(500);
			keyword.setSearchCnt(500);
			keyword = keywordDao.saveOrGetExistsKeyword(keyword);
			keywordMap.put(keyword.getKeyId(), keyword.getKeyword());
			//keywordsForLink.add(keyword);
			solrKeywordService.addKeyword2Solr(keyword); // index it to solr
		}
		
		//保存专题
		for (int i = 0; courseSubjects != null && i < courseSubjects.length; i++) {
			String subjectStr = StringUtils.trim(courseSubjects[i]);
			Subject subject = new Subject();
			subject.setCategory(courseDto.getCategory());
			subject.setSubject(subjectStr);
			subject.setHits(500);
			subject.setSearchCnt(500);
			subject = subjectDao.saveOrGetExistsSubject(subject);
			subjectMap.put(subject.getSubjectId(), subject.getSubject());
			solrSubjectService.addSubject2Solr(subject);
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
		
		for (int i = 0; courseProduct != null && i < courseProduct.length; i++) {
			String productCode = StringUtils.trim(courseProduct[i]);
			Dictionary dic = dictionaryDao.getDictionary(productCode, null);
			productMap.put(dic.getCodeName(), dic.getShowName());
		}

		if(deleteBeforeInsert){
			courseDao.deleteAllOtherInfosCourse(courseDto.getCourseId(),false);
		}
		
		courseDao.addAllOtherCourseInfo(courseDto.getCourseId(), industryMap,
				tagetMap, majorMap, keywordMap, subjectMap, productMap);
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
	public String queryCourseInfo(String courseId) {
		List<CourseInfo> list = courseInfoDao.queryCourseInfo(courseId);
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
				.queryEntityListByProperties(CourseKeyword.class, null, null,null,null,
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
	public String getPXCourse(String type, int flag) {
		
		List<Course> courseList = null;
		if (flag == 1)//推荐课程
			courseList = this.courseDao.getLastedCourse(false, type, true,
					false, 10, 0);
		if (flag == 2)//精品课程
			courseList = this.courseDao.getLastedCourse(false, type, false,
					true, 10, 0);
		if (flag == 3)//热门课程
			courseList = this.courseDao.getHotCourse(false, type, 10, 0);
		if (courseList == null)//最新课程
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
	
	//得到内训的课程
	public String getNXCourse(String type,int flag){
		List<Course> courseList = null;
		if (flag == 1)//推荐课程
			courseList = this.courseDao.getLastedCourse(true, type, true,false, 11, 0);
		if(flag == 2)//最新课程
			courseList = this.courseDao.getLastedCourse(true, null, false, false, 11, 0);
		if (flag == 3)//精品课程
			courseList = this.courseDao.getLastedCourse(true, type, false,true, 11, 0);
		if (flag == 4)//热门排行课程
			courseList = this.courseDao.getHotCourse(true, type, 11, 0);

		
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < courseList.size(); i++) {
			
			Course temp = courseList.get(i);
			if (temp == null)
				continue;
			Map<String,Object> row = new HashMap<String,Object>();
			if(i==0){
				row.put("content","我是一个测试内容长度为30，啊哈哈哈哈哈阿道夫京哈发借款方");
				row.put("img", "images/824.jpg");//老师头像的照片地址，需要修改
			}
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
		classInfo.put("isInner", currCourse.getIsInner());
		
		//path
		classInfo.put("categoryID", currCourse.getCategory());
		Dictionary catergory = dictionaryDao.getDictionary(currCourse.getCategory(), "");
		classInfo.put("categoryName", catergory.getShowName());
		
		//培训对象
		List<Map<String,String>> trainObject = new ArrayList<Map<String,String>>();
		List<CourseTarget> targets = courseTargetDao.getCourseTargetsByCourseId(courseId);
		for(CourseTarget target : targets){
			Map<String,String> object = new HashMap<String,String>();
			object.put("id", target.getTargetCode());
			object.put("name", target.getTarget());
			trainObject.add(object);
		}
		classInfo.put("object", trainObject);
			
		//行业
		List<Map<String,String>> indestorys = new ArrayList<Map<String,String>>();
		List<CourseIndustry> industries = courseIndustryDao.getCourseIndustryByCourseId(courseId);	
		for(CourseIndustry industry : industries){
			Map<String,String> indestory = new HashMap<String,String>();
			indestory.put("id", industry.getIndustryCode());
			indestory.put("name", industry.getIndustry());
			indestorys.add(indestory);
		}
		classInfo.put("indestory", indestorys);
		
		//专业
		List<Map<String,String>> majors = new ArrayList<Map<String,String>>();
		List<CourseMajor> majorList = courseMajorDao.getCourseMajorByCourseId(courseId);
		for(CourseMajor major :majorList){
			Map<String,String> temp = new HashMap<String,String>();
			temp.put("id", major.getMajorCode());
			temp.put("name", major.getMajor());
			majors.add(temp);
		}
		classInfo.put("major", majors);
			
		//关键字
		List<Map<String,String>> keyWords = new ArrayList<Map<String,String>>();
		List<CourseKeyword> courseKeyWords = courseKeywordDao.getCourseKeyWords(Integer.parseInt(courseId));
		for(CourseKeyword temp : courseKeyWords){
			Map<String,String> keyWord = new HashMap<String,String>();
			keyWord.put("id", temp.getCourseKeywordId().toString());
			keyWord.put("name", temp.getKeyword());
			keyWords.add(keyWord);
		}
		classInfo.put("keyWords", keyWords);
		
		//专题
		List<Map<String,String>> serieses = new ArrayList<Map<String,String>>();
		List<CourseSubject> subjects = courseSubjectDao.getCourseSubjectByCourseId(courseId);
		for(CourseSubject subject : subjects){
			Map<String,String> series = new HashMap<String,String>();
			series.put("id", subject.getSubjectId().toString());
			series.put("name", subject.getSubject());
			serieses.add(series);
		}
		classInfo.put("series", serieses);

		return JsonUtil.getJsonString(classInfo).toString();
	}
	
	@Override
	public String selectTimeTopCourse(String flag,String cityName,int start,int rows) {
		List<Course> courses = courseDao.selectTimeTopCourse(flag,cityName,false,rows,start);
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Course temp : courses){
			Map<String,String> row = new HashMap<String,String>();
			row.put("id", temp.getCourseId().toString());
			row.put("title", temp.getTitle());
			results.add(row);
		}
		return JsonUtil.getJsonString(results);
	}
	
	@Override
	public String queryHotCourseByType(Boolean isInner, String flag,
			String type, Integer rows, Integer start) {
		List<Course> courses = courseDao.getHotCourseByType(isInner, type, flag, start, rows);
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Course course : courses){
			Map<String,String> row = new HashMap<String,String>();
			row.put("id", course.getCourseId().toString());
			row.put("title", course.getTitle());
			results.add(row);
		}

		return JsonUtil.getJsonString(results);
	}
	
	@Override
	public String queryCourseByPrice(Boolean isInner, String type, Integer rows, Integer start) {
		List<Course> courses = courseDao.getCourseByPrice(isInner, type, start, rows);
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Course course : courses){
			Map<String,String> row = new HashMap<String,String>();
			row.put("id", course.getCourseId().toString());
			row.put("title", course.getTitle());
			results.add(row);
		}

		return JsonUtil.getJsonString(results);
	}

	@Override
	public String queryHotCourse(Boolean isInner, Integer rows, Integer start) {
		List<Course> courses = courseDao.getHotCourse(isInner, null, rows, start);
		
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Course course : courses){
			Map<String,String> row = new HashMap<String,String>();
			row.put("id", course.getCourseId().toString());
			row.put("title", course.getTitle());
			results.add(row);
		}

		return JsonUtil.getJsonString(results);
	}
	
	@Override
	public String queryClassiscCourse(Boolean isInner, Integer rows,
			Integer start) {
		List<Course> courses = courseDao.getClassicCourse(isInner,null, start, rows);
		
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Course course : courses){
			Map<String,String> row = new HashMap<String,String>();
			row.put("id", course.getCourseId().toString());
			row.put("title", course.getTitle());
			results.add(row);
		}

		return JsonUtil.getJsonString(results);
	}
	
	//获取行业、专业、职位、产品
	public String queryCourseType(String flag,Integer rows,Integer start){
		String dicType = "";
		if("1".equals(flag))//行业
			dicType = "008";
		else if("2".equals(flag))//专业
			dicType = "009";
		else if("3".equals(flag))//职位
			dicType = "010";
		else
			dicType = "011";//产品
		List<Dictionary> dictionarys = dictionaryDao.queryDictionary(dicType, null, rows, start);
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Dictionary temp : dictionarys){
			Map<String,String> row = new HashMap<String,String>();
			row.put("id", temp.getCodeName());
			row.put("name", temp.getShowName());
			results.add(row);
		}
		return JsonUtil.getJsonString(results);
	}
	
	//获取高端课程的培训师或者内训师
	public String getTeacherRecommand(Boolean isInner,String type,Integer rows,Integer start){
		List<TeacherInfo> teachers = courseDao.getTeacherRecommand(isInner, type, start, rows);
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(TeacherInfo teacher : teachers){
			Map<String,String> row = new HashMap<String,String>();
			row.put("id", teacher.getTeacherId().toString());
			row.put("name", teacher.getRealName());
			row.put("best", teacher.getMajorCatgory());
			results.add(row);
		}
		return JsonUtil.getJsonString(results);
	}
	
	//获取培训计划，默认一页是显示4个月的培训计划，
	public String getTranPlan(Integer rows,Integer start){
		List<String> pageMonth = courseDao.getTrainPlanMonth(start, rows);
		if(pageMonth == null || pageMonth.size() == 0)
			return "";
		
		Map<String,Object> results = new HashMap<String,Object>();
		List<Map<String,Object>> monthInfo = new ArrayList<Map<String,Object>>();
		
		for(int i=0;i<pageMonth.size();i++){
			String time = pageMonth.get(i);
			String[] times = time.split("-");
			List<Course> courses = courseDao.getTrainPlanByMonth(times[0], times[1], null, null);
			
			Map<String,Object> month = new HashMap<String,Object>();
			month.put("month", times[0]+"年"+times[1]+"月");
			
			List<Map<String,String>> tableRows = new ArrayList<Map<String,String>>();
			for(int j=0;j<courses.size();j++){
				Course temp = courses.get(j);
				Map<String,String> row = new HashMap<String,String>();
				row.put("id", temp.getCourseId().toString());
				row.put("name", temp.getTitle());
				row.put("price", temp.getPrice().toString());
				//得到老师的名字
				TeacherInfo teacher = teacherDao.getTeacherInfoById(Integer.parseInt(temp.getTeacherId()));
				String teacherName = "未知";
				if (teacher != null)
					teacherName = teacher.getRealName();
				row.put("teacherName", teacherName);
				row.put("teacherId",teacher.getTeacherId().toString());
				
				//得到城市
				List<CourseInfo> courseInfo = courseInfoDao.queryCourseInfoWithTime(times[0], times[1], temp.getCourseId().toString());
				String city = "";
				if(courseInfo == null || courseInfo.size() == 0)
					city = "未知";
				else if(courseInfo.size() >= 3)
					city = "全国";
				else if(courseInfo.size() == 1)
					city =courseInfo.get(0).getCityName();
				else
					city = courseInfo.get(0).getCityName() +"|"+courseInfo.get(1).getCityName();
				row.put("city", city);
				tableRows.add(row);
			}
			month.put("rows",tableRows);
			
			monthInfo.add(month);
		}
		results.put("monthInfo", monthInfo);
		List<String> monthCount = courseDao.getTrainPlanMonth(null, null);
		results.put("pageCount", monthCount.size());
		
		return JsonUtil.getJsonString(results);
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

	@Override
	public List<CourseInfo> queryCourseInfoList(Integer courseId) {
		List<CourseInfo> list = courseInfoDao.queryCourseInfo(courseId.toString());
		return list;
	}
	
	public ICourseIndustryDao getCourseIndustryDao() {
		return courseIndustryDao;
	}
	@Resource
	public void setCourseIndustryDao(ICourseIndustryDao courseIndustryDao) {
		this.courseIndustryDao = courseIndustryDao;
	}
	public ICourseMajorDao getCourseMajorDao() {
		return courseMajorDao;
	}
	@Resource
	public void setCourseMajorDao(ICourseMajorDao courseMajorDao) {
		this.courseMajorDao = courseMajorDao;
	}
	public ICourseSubjectDao getCourseSubjectDao() {
		return courseSubjectDao;
	}
	@Resource
	public void setCourseSubjectDao(ICourseSubjectDao courseSubjectDao) {
		this.courseSubjectDao = courseSubjectDao;
	}
	public ICourseTargetDao getCourseTargetDao() {
		return courseTargetDao;
	}
	@Resource
	public void setCourseTargetDao(ICourseTargetDao courseTargetDao) {
		this.courseTargetDao = courseTargetDao;
	}
	


}
