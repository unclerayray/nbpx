package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;

@Component("HotCourseAction")
@Scope("prototype")
public class HotCourseAction extends BaseAction{
	
	private ICourseService courseService;
	
	public String getHotPXCourse(){
		String json = courseService.queryHotPageCourse(null, rows, this.getStartPosi());//内训也是培训
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getClassiscNXCourse(){
		String json = courseService.queryClassiscPageCourse(true, rows, this.getStartPosi());
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getGoldNXCourse(){
		String json = courseService.queryGoldPageCourse(true, rows, this.getStartPosi(),1000);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getVedioNXCourse(){
		String json = courseService.queryVedioCourse(true, null, null,null, rows, this.getStartPosi());
		
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
	
	
}
