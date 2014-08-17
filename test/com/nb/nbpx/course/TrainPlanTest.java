package com.nb.nbpx.course;

import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.service.course.ICourseService;

public class TrainPlanTest  extends BaseServiceTest {

	@Resource
	private ICourseService courseService;

	@Test
	public void testExport(){
		Calendar toCal = Calendar.getInstance();
		toCal.set(Calendar.YEAR, 2014);
		toCal.set(Calendar.MONTH, 11);//12月
		toCal.set(Calendar.DAY_OF_MONTH, toCal.getActualMaximum(Calendar.DAY_OF_MONTH));//month end
		String xx = courseService.getTranPlans(null, new Date(), toCal.getTime(), false, null, 100);
		System.out.println(xx);
	}
}
