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
		String json = courseService.queryHotCourse(false, rows, this.getStartPosi());
		
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
