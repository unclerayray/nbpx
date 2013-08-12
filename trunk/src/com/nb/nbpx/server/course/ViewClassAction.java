package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;

@Component("ViewClassAction")
@Scope("prototype")
public class ViewClassAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	private ICourseService courseService;
	public String id;//课程ID
	
	//查看课程信息
	public String ViewClass(){
		String result = courseService.viewCourse(id);
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	
	public ICourseService getCourseService() {
		return courseService;
	}
	@Resource
	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
