package com.nb.nbpx.service.course.impl;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.common.SystemConstants;
import com.nb.nbpx.dao.course.*;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.dao.subject.ISubjectDao;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.dao.user.ITeacherInfoDao;
import com.nb.nbpx.dao.user.IUserDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.dto.course.CourseReport;
import com.nb.nbpx.dto.course.ReportDTO;
import com.nb.nbpx.pojo.course.*;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.service.solr.ISolrSubjectService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.SolrUtil;
import com.nb.nbpx.utils.mapTool.NbpxDicMap;

import net.sf.jxls.transformer.XLSTransformer;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.common.usermodel.Hyperlink;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.solr.client.solrj.SolrServerException;
import org.jsoup.helper.StringUtil;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Component("CourseService")
@SuppressWarnings("rawtypes")
public class CourseServiceImpl extends BaseServiceImpl implements
		ICourseService {

	private ICourseDao courseDao;
	private ITeacherInfoDao teacherDao;
	private ICourseInfoDao courseInfoDao;
	private IUserDao userDao;
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
	@Resource
	private ISolrService solrService;

	// private ICourseKeywordDao courseKeywordDao;
	// private ICourseKeywordDao courseKeywordDao;
	//获取内训视频
	public String queryVedioCourse(Boolean ifInner,Boolean isRecommend,Boolean byHit,String courseType,Integer rows,Integer start){
		String json = "";
		List<Course> list;
		list = courseDao.getVedioCourse(ifInner, isRecommend,byHit, courseType, rows, start);
		
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = 0;
			
			count = courseDao.queryCourseCount(ifInner,isRecommend,courseType,true)
						.intValue();
			List<Course> editList= new ArrayList();
			for(int i=0;i<list.size();i++){
				Course temp = list.get(i);
				if(temp.getContent() != null){
					String content = temp.getContent().replaceAll("</?[^<>]*>", "");
					if(content.length() > 200)
						content = content.substring(0, 200);
					temp.setContent(content);
				}
				editList.add(temp);
			}
			int pages = count/rows+1;
			
			json = JsonUtil.formatToJsonWithTimeStamp(pages,
					ResponseStatus.SUCCESS, "", editList);
		}

		return json;
	}

	private static String COURSE_PREFIX = "../viewClass.jsp?id=";
	@Override
	public String queryCourses(String category, Integer courseId, String title, String teachName,Boolean p_outside,
			Integer rows, Integer start, String sort, String order, Boolean isInner) {
		String json = "";
		List<Course> list;
		if (title != null && !title.isEmpty()) {
			list = courseDao.queryCoursesWithTitle(category, title,teachName,p_outside, rows,
					start, sort, order, isInner);
		} else {
			list = courseDao.queryCourses(category, courseId,teachName,p_outside, rows, start,
					sort, order, isInner);
		}

		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = 0;
			if (title != null && !title.isEmpty()) {
				count = courseDao.queryCourseCount(category, title,teachName, p_outside, isInner).intValue();
			} else {
				count = courseDao.queryCourseCount(category, courseId,teachName, p_outside, isInner)
						.intValue();
			}
			list = putHyperToTitle(list);
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}
	
	private List<Course> putHyperToTitle(List<Course> list){
		for(Course course:list){
			String hyper = "<a href=\"" + COURSE_PREFIX + course.getCourseId() + "\"  target=\"_blank\">"
					+ course.getTitle() + "</a>";
			course.setTitle(hyper);
		}
		return list;
	}

	// 获取最热的培训（可以按照地点）
	public String queryHotCourseByPlace(Boolean ifInner, String cityName,
			Integer rows, Integer start) {
		List<Course> courses = courseDao.getHotCourseByPlace(ifInner, cityName,
				rows, start);
		if (courses == null)
			return "";
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		for (Course course : courses) {
			if (course == null)
				continue;
			Map<String, Object> row = new HashMap<String, Object>();
			row.put("title", course.getTitle());
			row.put("id", course.getCourseId());
			result.add(row);
		}

		return JsonUtil.getJsonString(result);
	}
	//根据讲师ID获取讲师的课程
	public String queryCourseByTeacher(Boolean isInner,String teacherId,Integer rows,Integer start){
		List<Course> courses = courseDao.getCourseByTeacher(isInner, teacherId, start, rows);
		Map<String,Object> returnValue = new HashMap<String,Object>();
		if(!courses.isEmpty()){
			List<Map<String, Object>> result = getCourseDetailList(courses);
			Long rowsCount = courseDao.getCourseByTeacherRowsCount(isInner, teacherId, start, rows);

			int allPages = 0;
			if (rowsCount % rows == 0)
				allPages = (int) (rowsCount / rows);
			else
				allPages = (int) (rowsCount / rows) + 1;
			returnValue.put("pages", allPages);
			returnValue.put("rows", result);

			return JsonUtil.getJsonString(returnValue);
		}else
			return "";
	}
	
	// 分页获取地点下的课程（可以按照月份）
	public String queryCourseByCity(String cityName, String year, String month,
			String orderFlag, Integer rows, Integer start) {
		List<CourseInfo> courseInfos = courseDao.getCourseInfoByCity(cityName,
				year, month, orderFlag, rows, start);
		if (courseInfos == null)
			return "";
		Map<String, Object> returnValue = new HashMap<String, Object>();
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		for (CourseInfo courseInfo : courseInfos) {
			if (courseInfo == null)
				continue;
			Course course = courseDao.getCourseById(courseInfo.getCourseId());
			if (course == null)
				continue;
			Map<String, Object> row = new HashMap<String, Object>();
			row.put("title", course.getTitle());
			if (course.getContent() != null) {
				if (course.getContent().length() <= 200)
					row.put("content", course.getContent());
				else
					row.put("content", course.getContent().substring(0, 100));
			} else
				row.put("content", "暂无课程内容介绍");
			row.put("id", course.getCourseId());
			row.put("price", course.getPrice());
			SimpleDateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
			row.put("startDate", dateFormate.format(courseInfo.getStartDate()));
			row.put("endDate", dateFormate.format(courseInfo.getEndDate()));

			Dictionary city = dictionaryDao.getDictionary(courseInfo.getCity(),
					null);
			row.put("city", city.getShowName());

			result.add(row);
		}
		Integer rowsCount = courseDao.CountCourseByCity(cityName, year, month,
				orderFlag, rows, start);
		int allPages = 0;
		if (rowsCount % rows == 0)
			allPages = (int) (rowsCount / rows);
		else
			allPages = (int) (rowsCount / rows) + 1;
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
	public String queryComboCourseName(String category,Boolean isInner,Boolean p_outside) {
		List<Course> list = courseDao.queryCourses(category, null,null,p_outside, 10, null,
				null, null,isInner);
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

		String targetsHql = "select target from com.nb.nbpx.pojo.course.CourseTarget where courseId = "
				+ courseId;
		List targetsList = courseDao.find(targetsHql);
		targets = StringUtils.join(targetsList, ",");

		String industriesHql = "select industry from com.nb.nbpx.pojo.course.CourseIndustry where courseId = "
				+ courseId;
		List industriesList = courseDao.find(industriesHql);
		industries = StringUtils.join(industriesList, ",");

		String productsHql = "select product from com.nb.nbpx.pojo.course.CourseProduct where courseId = "
				+ courseId;
		List productsList = courseDao.find(productsHql);
		products = StringUtils.join(productsList, ",");

		String majorsHql = "select major from com.nb.nbpx.pojo.course.CourseMajor where courseId = "
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
		// 如果讲师不存在数据库中，则添加讲师
		// 当teacherId不是数字或者为空的时候，肯定是新增的
		if (!StringUtil.isNumeric(course.getTeacherId())) {
			TeacherInfo teacher = teacherDao.queryTeacherInfoByName(course.getTeacherName());
			if(teacher == null){
//				User user = new User();
//				user.setRegisterDate(new Date());
//				user.setUserType(SystemConstants.USER_TYPE_TEACHER);
//				user.setState(false);
//				userDao.save(user);
				teacher = new TeacherInfo();
				//teacher.setUser(user);
				teacher.setCreateBy(course.getLastUpdatedBy());
				teacher.setCreateDate(new Date());
				teacher.setRealName(course.getTeacherName());
				teacher.setState(false);
				teacherDao.merge(teacher);
			}
			course.setTeacherId(teacher.getTeacherId().toString());
		}else{
			//由于浏览器抽风，有时候Id和teacherName不对应，所以需要验证一下
			//已teacherName从数据库里拿出来的teacherId永远错不了
			TeacherInfo teacher = teacherDao.queryTeacherInfoByName(course.getTeacherName());
			if(teacher == null){
				teacher = new TeacherInfo();
				teacher.setCreateBy(course.getLastUpdatedBy());
				teacher.setCreateDate(new Date());
				teacher.setRealName(course.getTeacherName());
				teacher.setState(false);
				teacherDao.merge(teacher);//考虑是否在save teacherInfo的时候加入SOLR
			}
			course.setTeacherId(teacher.getTeacherId().toString());
		}
		if (course.getCourseId() == null) {
			if (courseDao.checkDuplicateProp(course)) {
				throw new NbpxException("由此教师讲解的《" + course.getTitle()
						+ "》课程已存在在数据库中，如需新增安排，请直接在列表中查出该课程，点击课程安排！");
			}
			// 新增课程
			course.setCreationDate(new Date());
			course.setHits(500);
			course.setLastUpdateDate(new Date());
			courseDao.save(course);
		} else {
			// 修改课程内容
			// courseDao.saveOrUpdate(course);
			Course existingCourse = courseDao.checkDuplicateCourse(course);
			if(existingCourse !=null && course !=null && course.getCourseId() == existingCourse.getCourseId()){
				throw new NbpxException("由此教师讲解的《" + course.getTitle()
						+ "》课程已存在在数据库中，如需新增安排，请直接在列表中查出该课程，点击课程安排！");
			}
			course.setLastUpdateDate(new Date());
			courseDao.updateCourse(course);
		}
		return course;
	}

	@Override
	public void saveOtherCourseInfo(CourseAllInfoDto courseDto,
			Boolean deleteBeforeInsert) {
		// List<Keyword> keywordsForLink = new ArrayList<Keyword>();
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
			String keywordsStr = courseDto.getKeywords().replaceAll("，", ",");
			courseKeywords = keywordsStr.split(",");
		}
		if (courseDto.getSubject() != null) {
			String subjectStr = courseDto.getSubject().replaceAll("，", ",");
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
			keyword.setFlag(true);
			keyword = keywordDao.saveOrGetExistsKeyword(keyword);
			keywordMap.put(keyword.getKeyId(), keyword.getKeyword());
			// keywordsForLink.add(keyword);
			solrKeywordService.addKeyword2Solr(keyword); // index it to solr
		}

		// 保存专题
		for (int i = 0; courseSubjects != null && i < courseSubjects.length; i++) {
			String subjectStr = StringUtils.trim(courseSubjects[i]);
			Subject subject = new Subject();
			subject.setCategory(courseDto.getCategory());
			subject.setSubject(subjectStr);
			subject.setHits(500);
			subject.setSearchCnt(500);
			subject.setFlag(true);
			subject = subjectDao.saveOrGetExistsSubject(subject);
			subjectMap.put(subject.getSubjectId(), subject.getSubject());
			solrSubjectService.addSubject2Solr(subject);
		}

		String regEx1 = "[\\pP‘’“”]";
		for (int i = 0; courseMajors != null && i < courseMajors.length; i++) {
			String majorCode = StringUtils.trim(courseMajors[i]);
			// numbic
			if (majorCode.isEmpty()) {
				continue;
			}
			if (majorCode.contains("_")&&StringUtil.isNumeric(majorCode.replace("_", ""))) {
				// it's code
				Dictionary dic = dictionaryDao.getDictionary(majorCode, null,
						SystemConstants.COURSE_MAJOR_TYPE_CODE);
				majorMap.put(dic.getCodeName(), dic.getShowName());
			} else {
				majorCode = majorCode.replace(" ", "").replace(regEx1, "");
				// it's text
				Dictionary dic = dictionaryDao.getDictionary(null, majorCode,
						SystemConstants.COURSE_MAJOR_TYPE_CODE);
				if (dic == null) {
					dic = new Dictionary();
					dic.setDicType(SystemConstants.COURSE_MAJOR_TYPE_CODE);
					dic.setShowName(majorCode);
					dic.setCodeName(dictionaryDao
							.getLatestCode(SystemConstants.COURSE_MAJOR_TYPE_CODE));
					dictionaryDao.save(dic);
				}
				majorMap.put(dic.getCodeName(), dic.getShowName());
			}
		}

		for (int i = 0; courseTargets != null && i < courseTargets.length; i++) {
			String targetCode = StringUtils.trim(courseTargets[i]);
			if (targetCode.isEmpty()) {
				continue;
			}
			// numbic
			if (targetCode.contains("_")&&StringUtil.isNumeric(targetCode.replace("_", ""))) {
				// it's code
				Dictionary dic = dictionaryDao.getDictionary(targetCode, null,
						SystemConstants.COURSE_TARGET_TYPE_CODE);
				tagetMap.put(dic.getCodeName(), dic.getShowName());
			} else {
				// it's text
				targetCode = targetCode.replace(" ", "").replace(regEx1, "");
				Dictionary dic = dictionaryDao.getDictionary(null, targetCode,
						SystemConstants.COURSE_TARGET_TYPE_CODE);
				if (dic == null) {
					dic = new Dictionary();
					dic.setDicType(SystemConstants.COURSE_TARGET_TYPE_CODE);
					dic.setShowName(targetCode);
					dic.setCodeName(dictionaryDao
							.getLatestCode(SystemConstants.COURSE_TARGET_TYPE_CODE));
					dictionaryDao.save(dic);
				}
				tagetMap.put(dic.getCodeName(), dic.getShowName());
			}
		}

		for (int i = 0; courseIndustry != null && i < courseIndustry.length; i++) {
			String industryCode = StringUtils.trim(courseIndustry[i]);// numbic
			if (industryCode.isEmpty()) {
				continue;
			}
			if (industryCode.contains("_")&&StringUtil.isNumeric(industryCode.replace("_", ""))) {
				// it's code
				Dictionary dic = dictionaryDao.getDictionary(industryCode,
						null, SystemConstants.COURSE_INDUSTRY_TYPE_CODE);
				industryMap.put(dic.getCodeName(), dic.getShowName());
			} else {
				// it's text
				industryCode = industryCode.replace(" ", "").replace(regEx1, "");
				Dictionary dic = dictionaryDao
						.getDictionary(null, industryCode,
								SystemConstants.COURSE_INDUSTRY_TYPE_CODE);
				if (dic == null) {
					dic = new Dictionary();
					dic.setDicType(SystemConstants.COURSE_INDUSTRY_TYPE_CODE);
					dic.setShowName(industryCode);
					dic.setCodeName(dictionaryDao
							.getLatestCode(SystemConstants.COURSE_INDUSTRY_TYPE_CODE));
					dictionaryDao.save(dic);
				}
				industryMap.put(dic.getCodeName(), dic.getShowName());
			}
		}

		for (int i = 0; courseProduct != null && i < courseProduct.length; i++) {
			String productCode = StringUtils.trim(courseProduct[i]);// numbic
			if (productCode.isEmpty()) {
				continue;
			}
			if (productCode.contains("_")&&StringUtil.isNumeric(productCode.replace("_", ""))) {
				// it's code
				Dictionary dic = dictionaryDao.getDictionary(productCode, null,
						SystemConstants.COURSE_PRODUCT_TYPE_CODE);
				productMap.put(dic.getCodeName(), dic.getShowName());
			} else {
				// it's text
				productCode = productCode.replace(" ", "").replace(regEx1, "");
				Dictionary dic = dictionaryDao.getDictionary(null, productCode,
						SystemConstants.COURSE_PRODUCT_TYPE_CODE);
				if (dic == null) {
					dic = new Dictionary();
					dic.setDicType(SystemConstants.COURSE_PRODUCT_TYPE_CODE);
					dic.setShowName(productCode);
					dic.setCodeName(dictionaryDao
							.getLatestCode(SystemConstants.COURSE_PRODUCT_TYPE_CODE));
					dictionaryDao.save(dic);
				}
				productMap.put(dic.getCodeName(), dic.getShowName());
			}
		}

		if (deleteBeforeInsert) {
			courseDao.deleteAllOtherInfosCourse(courseDto.getCourseId(), false);
		}

		courseDao.addAllOtherCourseInfo(courseDto.getCourseId(), industryMap,
				tagetMap, majorMap, keywordMap, subjectMap, productMap);
	}

	@Override
	public void deleteCourse(Course course) throws NbpxException {
		courseDao.delete(course);
		courseDao.deleteAllOtherInfosCourse(course.getCourseId(), true);
	}

	// 根据城市获取课程信息
	public String getCoursesByCity(String city, Integer rows, Integer start) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

		List<CourseInfo> courseInfoList = this.courseInfoDao
				.queryCourseInfoByCity(city, start, rows);
		if (courseInfoList == null || courseInfoList.size() == 0)
			return "[]";
		for (int i = 0; i < courseInfoList.size(); i++) {
			CourseInfo temp = courseInfoList.get(i);
			if (temp == null)
				continue;
			Course course = this.courseDao.getCourseById(temp.getCourseId());
			if (course == null)
				continue;
			Map<String, Object> row = new HashMap<String, Object>();
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
				.queryEntityListByProperties(CourseKeyword.class, null, null,
						null, null, propsMap);
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
		if (flag == 1) {// solr搜索

			Dictionary dic = dictionaryDao.getDictionary(type, null);
			if (dic == null)
				return "";
			else {
				try {
					List<CourseSearchResult> result = solrService
							.fullTextQueryForHlReturnList(dic.getShowName(), 0,
									10);
					if (result == null) {
						System.out.println("结果为0");
						return "";
					} else {
						System.out.println("结果" + result.size());

						return JsonUtil.formatListToJson(result);
					}
				} catch (SolrServerException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		if (flag == 2) {// 经典课程
			courseList = this.courseDao.getLastedCourse(false, type, false,
					true, 10, 0);
		}
		if (flag == 3) {// 按点击率排行
			courseList = this.courseDao.getHotCourse(false, type, 10, 0);
		}
		if (flag == 4) {// 推荐课程
			courseList = this.courseDao.getLastedCourse(false, type, true,
					false, 10, 0);
		}

		if (courseList == null)// 最新课程
			return "暂无课程信息";
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < courseList.size(); i++) {

			Course temp = courseList.get(i);
			if (temp == null)
				continue;
			Map<String, Object> row = new HashMap<String, Object>();
			row.put("courseId", temp.getCourseId());
			row.put("title", temp.getTitle());
			result.add(row);
		}
		return JsonUtil.formatListToJson(result);
	}

	// 得到内训的课程
	public String getNXCourse(String type, int flag) {
		List<Course> courseList = null;
		if (flag == 1)// 推荐课程
			courseList = this.courseDao.getLastedCourse(true, type, true,
					false, 11, 0);
		if (flag == 2)// 最新课程
			courseList = this.courseDao.getLastedCourse(true, null, false,
					false, 11, 0);
		if (flag == 3)// 精品课程
			courseList = this.courseDao.getLastedCourse(true, type, false,
					true, 11, 0);
		if (flag == 4)// 热门排行课程
			courseList = this.courseDao.getHotCourse(true, type, 11, 0);

		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < courseList.size(); i++) {

			Course temp = courseList.get(i);
			if (temp == null)
				continue;
			Map<String, Object> row = new HashMap<String, Object>();
			if (i == 0) {
				row.put("content", "我是一个测试内容长度为30，啊哈哈哈哈哈阿道夫京哈发借款方");
				row.put("img", "images/824.jpg");// 老师头像的照片地址，需要修改
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
		if (flag == 1)// 推荐课程
			courseInfoList = this.courseInfoDao.queryTop30CourseInfo(false,
					true, false);
		else if (flag == 2)// 精品课程
			courseInfoList = this.courseInfoDao.queryTop30CourseInfo(false,
					false, true);
		else
			courseInfoList = null;
		Map<String, String> existKey = new HashMap<String, String>();
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		int count = 0;
		if (courseInfoList == null)
			return "[]";
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 0; i < courseInfoList.size(); i++) {
			CourseInfo temp = courseInfoList.get(i);
			if (temp == null)
				continue;
			if (existKey.containsKey(temp.getCourseId().toString()))
				continue;
			if (count > 30)
				break;
			Map<String, Object> row = new HashMap<String, Object>();
			Course course = this.courseDao.getCourseById(temp.getCourseId());
			if (course == null)
				continue;
			TeacherInfo teacher = teacherDao.getTeacherInfoById(Integer
					.parseInt(course.getTeacherId()));
			String teacherName = "未知";
			if (teacher != null)
				teacherName = teacher.getRealName();
			row.put("city", "全国");
			row.put("title", course.getTitle());
			row.put("id", course.getCourseId());
			row.put("teacher", teacherName);
			row.put("date", format.format(temp.getStartDate()));
			result.add(row);
			existKey.put(course.getCourseId().toString(), course.getCourseId()
					.toString());
			count++;
		}

		return JsonUtil.formatListToJson(result);
	}

	// 查看课程内容
	public String viewCourse(String courseId) {
		if (courseId == null || "".equals(courseId))
			return "课程不存在";
		Course currCourse = courseDao.get(Integer.parseInt(courseId));
		if (currCourse == null)
			return "课程不存在";

		List<CourseInfo> courseInfos = courseInfoDao
				.queryCourseInfoByCourseId(courseId);

		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		DecimalFormat df = new DecimalFormat("0");
		Map<String, Object> classInfo = new HashMap<String, Object>();

		List<Map<String, String>> details = new ArrayList<Map<String, String>>();
		for (int i = 0; i < courseInfos.size(); i++) {
			CourseInfo temp = courseInfos.get(i);
			Map<String, String> detail = new HashMap<String, String>();
			detail.put("from", format.format(temp.getStartDate()));
			detail.put("to", format.format(temp.getEndDate()));
			Dictionary cityD = dictionaryDao.getDictionary(temp.getCity(), "");
			detail.put("cityID", temp.getCity());
			detail.put("city", cityD.getShowName());
			details.add(detail);
		}

		classInfo.put("time", details);
		TeacherInfo teacher = teacherDao.getTeacherInfoById(Integer
				.parseInt(currCourse.getTeacherId()));
		classInfo.put("price", df.format(currCourse.getPrice()) + "元/位");
		classInfo.put("teacher", teacher.getRealName());
		classInfo.put("teacherID", teacher.getTeacherId());
		classInfo.put("bloclContent", currCourse.getBlockedContent());
		classInfo.put("content", currCourse.getContent());
		classInfo.put("title", currCourse.getTitle());
		classInfo.put("classNum", currCourse.getCourseId());
		classInfo.put("isInner", currCourse.getIsInner());

		// path
		classInfo.put("categoryID", currCourse.getCategory());
		Dictionary catergory = dictionaryDao.getDictionary(
				currCourse.getCategory(), "");
		classInfo.put("categoryName", catergory.getShowName());

		// 培训对象
		List<Map<String, String>> trainObject = new ArrayList<Map<String, String>>();
		List<CourseTarget> targets = courseTargetDao
				.getCourseTargetsByCourseId(courseId);
		for (CourseTarget target : targets) {
			Map<String, String> object = new HashMap<String, String>();
			object.put("id", target.getTargetCode());
			object.put("name", target.getTarget());
			trainObject.add(object);
		}
		classInfo.put("object", trainObject);

		// 行业
		List<Map<String, String>> indestorys = new ArrayList<Map<String, String>>();
		List<CourseIndustry> industries = courseIndustryDao
				.getCourseIndustryByCourseId(courseId);
		for (CourseIndustry industry : industries) {
			Map<String, String> indestory = new HashMap<String, String>();
			indestory.put("id", industry.getIndustryCode());
			indestory.put("name", industry.getIndustry());
			indestorys.add(indestory);
		}
		classInfo.put("indestory", indestorys);

		// 专业
		List<Map<String, String>> majors = new ArrayList<Map<String, String>>();
		List<CourseMajor> majorList = courseMajorDao
				.getCourseMajorByCourseId(courseId);
		for (CourseMajor major : majorList) {
			Map<String, String> temp = new HashMap<String, String>();
			temp.put("id", major.getMajorCode());
			temp.put("name", major.getMajor());
			majors.add(temp);
		}
		classInfo.put("major", majors);

		// 关键字
		List<Map<String, String>> keyWords = new ArrayList<Map<String, String>>();
		List<CourseKeyword> courseKeyWords = courseKeywordDao
				.getCourseKeyWords(Integer.parseInt(courseId));
		for (CourseKeyword temp : courseKeyWords) {
			Map<String, String> keyWord = new HashMap<String, String>();
			keyWord.put("id", temp.getCourseKeywordId().toString());
			keyWord.put("name", temp.getKeyword());
			keyWords.add(keyWord);
		}
		classInfo.put("keyWords", keyWords);

		// 专题
		List<Map<String, String>> serieses = new ArrayList<Map<String, String>>();
		List<CourseSubject> subjects = courseSubjectDao
				.getCourseSubjectByCourseId(courseId);
		for (CourseSubject subject : subjects) {
			Map<String, String> series = new HashMap<String, String>();
			series.put("id", subject.getSubjectId().toString());
			series.put("name", subject.getSubject());
			serieses.add(series);
		}
		classInfo.put("series", serieses);

		return JsonUtil.getJsonString(classInfo).toString();
	}

	@Override
	public String selectTimeTopCourse(String flag, String cityName, int start,
			int rows) {
		List<Course> courses = courseDao.selectTimeTopCourse(flag, cityName,
				false, rows, start);
		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Course temp : courses) {
			Map<String, String> row = new HashMap<String, String>();
			row.put("id", temp.getCourseId().toString());
			row.put("title", temp.getTitle());
			results.add(row);
		}
		return JsonUtil.getJsonString(results);
	}

	@Override
	public String queryHotCourseByType(Boolean isInner, String flag,
			String type, Integer rows, Integer start) {
		List<Course> courses = courseDao.getHotCourseByType(isInner, type,
				flag, start, rows);
		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Course course : courses) {
			Map<String, String> row = new HashMap<String, String>();
			row.put("id", course.getCourseId().toString());
			row.put("title", course.getTitle());
			results.add(row);
		}

		return JsonUtil.getJsonString(results);
	}

	@Override
	public String queryCourseByPrice(Boolean isInner, String type,
			Integer rows, Integer start) {
		List<Course> courses = courseDao.getCourseByPrice(isInner, type, start,
				rows);
		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Course course : courses) {
			Map<String, String> row = new HashMap<String, String>();
			row.put("id", course.getCourseId().toString());
			row.put("title", course.getTitle());
			results.add(row);
		}

		return JsonUtil.getJsonString(results);
	}

	@Override
	public String queryHotCourse(Boolean isInner, Integer rows, Integer start) {
		List<Course> courses = courseDao.getHotCourse(isInner, null, rows,
				start);

		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Course course : courses) {
			Map<String, String> row = new HashMap<String, String>();
			row.put("id", course.getCourseId().toString());
			row.put("title", course.getTitle());
			results.add(row);
		}

		return JsonUtil.getJsonString(results);
	}

	@Override
	public String queryClassiscCourse(Boolean isInner, Integer rows,
			Integer start) {
		List<Course> courses = courseDao.getClassicCourse(isInner, null, start,
				rows);

		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Course course : courses) {
			Map<String, String> row = new HashMap<String, String>();
			row.put("id", course.getCourseId().toString());
			row.put("title", course.getTitle());
			results.add(row);
		}

		return JsonUtil.getJsonString(results);
	}

	// 获取行业、专业、职位、产品
	public String queryCourseType(String flag, Integer rows, Integer start) {
		String dicType = "";
		if ("1".equals(flag))// 行业
			dicType = SystemConstants.COURSE_INDUSTRY_TYPE_CODE;
		else if ("2".equals(flag))// 专业
			dicType = SystemConstants.COURSE_MAJOR_TYPE_CODE;
		else if ("3".equals(flag))// 职位
			dicType = SystemConstants.COURSE_TARGET_TYPE_CODE;
		else
			dicType = SystemConstants.COURSE_PRODUCT_TYPE_CODE;// 产品
		List<Dictionary> dictionarys = dictionaryDao.queryDictionary(dicType,
				null, rows, start, null, null);
		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (Dictionary temp : dictionarys) {
			Map<String, String> row = new HashMap<String, String>();
			row.put("id", temp.getCodeName());
			row.put("name", temp.getShowName());
			results.add(row);
		}
		return JsonUtil.getJsonString(results);
	}

	// 获取高端课程的培训师或者内训师
	public String getTeacherRecommand(Boolean isInner, String type,
			Integer rows, Integer start) {
		List<TeacherInfo> teachers = courseDao.getTeacherRecommand(isInner,
				type, start, rows);
		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		for (TeacherInfo teacher : teachers) {
			Map<String, String> row = new HashMap<String, String>();
			row.put("id", teacher.getTeacherId().toString());
			row.put("name", teacher.getRealName());
			row.put("best", teacher.getMajorCatgory());
			results.add(row);
		}
		return JsonUtil.getJsonString(results);
	}

	// 获取培训计划，默认一页是显示4个月的培训计划，
	public String getTranPlan(Integer rows, Integer start) {
		List<String> pageMonth = courseDao.getTrainPlanMonth(start, rows);
		if (pageMonth == null || pageMonth.size() == 0)
			return "";

		Map<String, Object> results = new HashMap<String, Object>();
		List<Map<String, Object>> monthInfo = new ArrayList<Map<String, Object>>();

		for (int i = 0; i < pageMonth.size(); i++) {
			String time = pageMonth.get(i);
			String[] times = time.split("-");
			List<Course> courses = courseDao.getTrainPlanByMonth(times[0],
					times[1], null, null);

			Map<String, Object> month = new HashMap<String, Object>();
			month.put("month", times[0] + "年" + times[1] + "月");

			List<Map<String, String>> tableRows = new ArrayList<Map<String, String>>();
			for (int j = 0; j < courses.size(); j++) {
				Course temp = courses.get(j);
				Map<String, String> row = new HashMap<String, String>();
				row.put("id", temp.getCourseId().toString());
				row.put("name", temp.getTitle());
				row.put("price", temp.getPrice().toString());
				// 得到老师的名字
				TeacherInfo teacher = teacherDao.getTeacherInfoById(Integer
						.parseInt(temp.getTeacherId()));
				String teacherName = "未知";
				if (teacher != null)
					teacherName = teacher.getRealName();
				row.put("teacherName", teacherName);
				row.put("teacherId", teacher.getTeacherId().toString());

				// 得到城市
				List<CourseInfo> courseInfo = courseInfoDao
						.queryCourseInfoWithTime(times[0], times[1], temp
								.getCourseId().toString());
				String city = "";
				if (courseInfo == null || courseInfo.size() == 0)
					city = "未知";
				else if (courseInfo.size() >= 3)
					city = "全国";
				else if (courseInfo.size() == 1)
					city = courseInfo.get(0).getCityName();
				else
					city = courseInfo.get(0).getCityName() + "|"
							+ courseInfo.get(1).getCityName();
				row.put("city", city);
				tableRows.add(row);
			}
			month.put("rows", tableRows);

			monthInfo.add(month);
		}
		results.put("monthInfo", monthInfo);
		List<String> monthCount = courseDao.getTrainPlanMonth(null, null);
		results.put("pageCount", monthCount.size());

		return JsonUtil.getJsonString(results);
	}

	// 获取热门培训（单页展示）
	public String queryHotPageCourse(Boolean ifInner, Integer rows,
			Integer start) {
		List<Course> courses = courseDao.getHotCourse(ifInner, null, rows,
				start);
		if (courses == null)
			return "";
		Map<String, Object> returnValue = new HashMap<String, Object>();
		List<Map<String, Object>> result = getCourseDetailList(courses);
		List totalRows = courseDao.getHotCourse(ifInner, null, null, null);
		int rowsCount = totalRows == null ? 0 : totalRows.size();
		int allPages = 0;
		if (rowsCount % rows == 0)
			allPages = (int) (rowsCount / rows);
		else
			allPages = (int) (rowsCount / rows) + 1;
		returnValue.put("pages", allPages);
		returnValue.put("rows", result);

		return JsonUtil.getJsonString(returnValue);
	}

	// 获取经典课程（单页展示）
	public String queryClassiscPageCourse(Boolean ifInner, Integer rows,
			Integer start) {
		List<Course> courses = courseDao.getClassicCourse(ifInner, null, rows,
				start);
		if (courses == null)
			return "";
		Map<String, Object> returnValue = new HashMap<String, Object>();
		List<Map<String, Object>> result = getCourseDetailList(courses);
		List totalRows = courseDao.getClassicCourse(ifInner, null, null, null);
		int rowsCount = totalRows == null ? 0 : totalRows.size();
		int allPages = 0;
		if (rowsCount % rows == 0)
			allPages = (int) (rowsCount / rows);
		else
			allPages = (int) (rowsCount / rows) + 1;
		returnValue.put("pages", allPages);
		returnValue.put("rows", result);

		return JsonUtil.getJsonString(returnValue);
	}

	// 获取金牌课程(单页展示)
	public String queryGoldPageCourse(Boolean ifInner, Integer rows,
			Integer start, Integer price) {
		List<Course> courses = courseDao.getGoldCourse(ifInner, null, rows,
				start, price);
		if (courses == null)
			return "";
		Map<String, Object> returnValue = new HashMap<String, Object>();
		List<Map<String, Object>> result = getCourseDetailList(courses);
		List totalRows = courseDao.getGoldCourse(ifInner, null, null, null,
				price);
		int rowsCount = totalRows == null ? 0 : totalRows.size();
		int allPages = 0;
		if (rowsCount % rows == 0)
			allPages = (int) (rowsCount / rows);
		else
			allPages = (int) (rowsCount / rows) + 1;
		returnValue.put("pages", allPages);
		returnValue.put("rows", result);

		return JsonUtil.getJsonString(returnValue);
	}

	private List<Map<String, Object>> getCourseDetailList(List<Course> courses) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

		for (int i = 0; i < courses.size(); i++) {
			Map<String, Object> row = new HashMap<String, Object>();
			Course currCourse = courses.get(i);
			row.put("id", currCourse.getCourseId());
			row.put("price", currCourse.getPrice());
			row.put("title", currCourse.getTitle());
			Course currCourseWithCount = courseDao.getCourseById(currCourse
					.getCourseId());
			if (currCourseWithCount.getContent() != null) {
				if (currCourseWithCount.getContent().length() <= 200)
					row.put("content", courseDao.getNoHtmlStr(currCourseWithCount.getContent()));
				else
					row.put("content", courseDao.getNoHtmlStr(currCourseWithCount.getContent()
							.substring(0, 100)));
			} else
				row.put("content", "暂无课程内容介绍");

			List<CourseInfo> courseInfors = courseInfoDao
					.queryCourseInfoWithTime(null, null, currCourse
							.getCourseId().toString());
			int cityCount = 0;
			String cityStr = "";
			Date startDate = null;
			Date endDate = null;
			if (courseInfors != null) {
				for (int j = 0; j < courseInfors.size(); j++) {
					CourseInfo courseInfo = courseInfors.get(j);
					if (j == 0)
						startDate = courseInfo.getStartDate();
					if (j == courseInfors.size() - 1)
						endDate = courseInfo.getEndDate();

					Dictionary cityTemp = dictionaryDao.getDictionary(
							courseInfo.getCity(), null);
					if (!cityStr.contains(cityTemp.getShowName())) {
						cityStr += cityTemp.getShowName();
						if (j != courseInfors.size() - 1)
							cityStr += "|";
						cityCount++;
					}
				}
			}

			SimpleDateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
			row.put("startDate", startDate == null ?"未知时间":dateFormate.format(startDate));
			row.put("endDate", endDate == null ? "未知时间":dateFormate.format(endDate));
			if (cityCount >= 3)
				cityStr = "全国";
			row.put("city", cityStr);
			result.add(row);
		}
		return result;
	}

	@Override
	public void exportExcel(String category, int year, int month, String city, boolean isInner,
			InputStream input, OutputStream output) throws Exception {
		List<String> sheetNames = new ArrayList<String>();
		sheetNames.add(NbpxDicMap.getCourseTypeMap().get(category)!=null?NbpxDicMap.getCourseTypeMap().get(category).toString():"全部类别");
		List<ReportDTO> records = new ArrayList<ReportDTO>();
		List<CourseReport> reports = new ArrayList<CourseReport>();
		/*
		CourseReport report = new CourseReport(11111, "测试的课程1", 12000.0, "雷理超",
				new Date(), new Date(), "广州");
		CourseReport report1 = new CourseReport(11111, "测试的课程1", 12000.0,
				"雷理超", new Date(), new Date(), "广州");
		CourseReport report2 = new CourseReport(11111, "测试的课程1", 12000.0,
				"雷理超", new Date(), new Date(), "广州");
		CourseReport report3 = new CourseReport(11111, "测试的课程2", 7000.0, "雷理超",
				new Date(), new Date(), "广州");
		CourseReport report4 = new CourseReport(11111, "测试的课程3", 8000.0, "雷理超",
				new Date(), new Date(), "广州");
		CourseReport report5 = new CourseReport(11111, "测试的课程3", 8000.0, "雷理超",
				new Date(), new Date(), "广州");
		CourseReport report6 = new CourseReport(11111, "测试的课程3", 8000.0, "雷理超",
				new Date(), new Date(), "广州");
		CourseReport report7 = new CourseReport(11111, "测试的课程1", 12000.0,
				"雷理超", new Date(), new Date(), "广州");
		reports.add(report);
		reports.add(report1);
		reports.add(report2);
		reports.add(report3);
		reports.add(report4);
		reports.add(report5);
		reports.add(report6);
		reports.add(report7);*/

		String prefix = SolrUtil.getHypeLinkPrefix();
		reports = courseDao.queryCoursePlan(category,year,month,isInner,city);
		ReportDTO dto = new ReportDTO(year, month, NbpxDicMap.getCourseTypeMap().get(category)!=null?NbpxDicMap.getCourseTypeMap().get(category).toString():"全部类别", reports,prefix);
		records.add(dto);
		

		XLSTransformer transformer = new XLSTransformer();
		Workbook resultWorkbook = transformer.transformMultipleSheetsList(
				input, records, sheetNames, "records",
				new HashMap<String, Object>(), 0);
		Sheet firstSheet = resultWorkbook.getSheetAt(0);
		org.apache.poi.ss.usermodel.CreationHelper createHelper = resultWorkbook.getCreationHelper();  
		for(int i=0;i<reports.size();i++){
			org.apache.poi.ss.usermodel.Row row = firstSheet.getRow(i+2);
			org.apache.poi.ss.usermodel.Cell cell = row.getCell(2);//课程标题永远在第二行
			org.apache.poi.ss.usermodel.Hyperlink link = createHelper.createHyperlink(Hyperlink.LINK_URL);
			link.setLabel(reports.get(i).getTitle());
			link.setAddress(prefix+reports.get(i).getCourseId());
			cell.setHyperlink(link);
		}
		resultWorkbook.write(output);
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
		List<CourseInfo> list = courseInfoDao.queryCourseInfo(courseId
				.toString());
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

	public IUserDao getUserDao() {
		return userDao;
	}

	@Resource
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public void auditCourse(Boolean state, Integer courseId) {
		String queryString = "update Course set state = ? where courseId = ? ";
		Object[] values = {state, courseId};
		courseDao.bulkUpdate(queryString, values);
	}

	@Override
	public void SaveCourseInfo(List<CourseInfo> list) {
		for(CourseInfo info:list){
			courseInfoDao.save(info);
		}
	}

	@Override
	public String queryCourseByType(Boolean ifInner, String courseType,
			Integer rows, Integer start) {
		return null;
	}

	@Override
	public void deleteCourseInfo(Integer courseId) {
		List<CourseInfo> list = courseInfoDao.queryCourseInfo(courseId.toString());
		for(CourseInfo info:list){
			courseInfoDao.delete(info);
		}
	}

	@Override
	public void updateGoldenPicPath(String path, Integer courseId) {
		String queryString = "update Course set goldenPic = ? where courseId = ? ";
		Object[] values = {path, courseId};
		courseDao.bulkUpdate(queryString, values);
	}

	@Override
	public Course getCourseById(Integer courseId) {
		return courseDao.get(courseId);
	}

}
