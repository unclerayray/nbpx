package com.nb.nbpx.course;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.dao.course.ICourseDao;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.utils.NbpxException;
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
		
		try {
			courseService.saveCourse(course);
			System.out.println("-------------courseId = "+course.getCourseId());
			Assert.assertNotNull(course.getCourseId());
		} catch (NbpxException e) {
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
}
