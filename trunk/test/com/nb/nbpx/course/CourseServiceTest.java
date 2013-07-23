package com.nb.nbpx.course;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.dao.course.ICourseDao;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.course.ICourseService;
/**
 * Course模块的单元测试类
 * @author Roger
 * @date 2013年7月20日
 */
/**
 * Course模块的单元测试类
 * @author Roger
 * @date 2013年7月20日
 */
public class CourseServiceTest  extends BaseServiceTest{
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseDao courseDao;
	@Resource
	private IKeywordDao keywordDao;
	
	/**
	 * 测试保存后怎么获取ID
	 */
	@Test
	@Rollback(true)
	@Transactional
	public void testSaveCourse(){
		Course course = new Course(null, "hahah", "hdfdfahah",
				"hahah", "hahah", "hahah",
				"hahah",true, 2, 3.23,true,true);
		CourseAllInfoDto dto = new CourseAllInfoDto(course);
		
		try {
			course = courseService.saveCourse(dto);
			System.out.println("-------------courseId = "+dto.getCourseId());
			Assert.assertNotNull(course.getCourseId());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	@Rollback(true)
	@Transactional
	public void testSaveCourseInfo(){
		CourseInfo courseInfo = new CourseInfo(null,2,new Date(),new Date(),"003_01","深圳");
		courseService.saveCourseInfo(courseInfo);
		Assert.assertNotNull(courseInfo.getCourseInfoId());
	}
	
	@Test
	public void testStringJoin(){
		String hql = "select keyword from com.nb.nbpx.pojo.course.CourseKeyword where courseId = 10";
		List list = courseDao.find(hql);
		String sss = StringUtils.join(list, ",");
		System.out.println("sss = "+ sss);
		Assert.assertNotNull(sss);
	}
	
	/**
	 * 测试违反唯一索引限制后会不会返回主键，结论是不会
	 */
	@Test
	@Transactional
	public void testDumplicateKeyword(){
		Keyword keyword = new Keyword(null, "国家", true, null,
				null, null);
		try {
			keywordDao.save(keyword);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
		}
		System.out.println(keyword.getKeyId());
		Assert.assertNotNull(keyword.getKeyId());
	}
}
