package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;

@Component("MainAction")
@Scope("prototype")
public class MainAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	private ICourseService courseService;
	public String city;
	
	public String getCourseByCity(){
		String result = courseService.getCoursesByCity(city, 8, 0);
		System.out.println(city+"-"+result);
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
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	
}
