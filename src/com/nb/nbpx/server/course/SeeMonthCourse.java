package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;

@Component("SeeMonthCourseAction")
@Scope("prototype")
public class SeeMonthCourse extends BaseAction{
	
	private ICourseService courseService;
	public String month;
	public String year;
	public String cityName;
	
	public String getCourseByMonth(){
		String json = courseService.queryCourseByCity(null,year, month, "1", rows, page);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public ICourseService getCourseService() {
		return courseService;
	}	
	@Resource
	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}
	
	
}
