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
	public String flag;//标记top Course的三种属性(1-推荐，2-精品，3-排行)
	public String isInner;//标记是内训还是培训
	public String type;//课程类别
	

	public String getCourseByCity(){
		String result = courseService.getCoursesByCity(city, 8, 0);
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	//首页30行推荐
	public String getTopCourse(){
		String result = courseService.getTopCourse(Integer.parseInt(flag), null);
		System.out.println(result);
		this.inputStream = castToInputStream(result);
	
		return SUCCESS;
	}
	
	public String getPeiXun(){
		String typeCode = "";
		if("1".equals(type))//财务管理
			typeCode = "003_01";
		
		String result = courseService.getNXCourse(typeCode, Integer.parseInt(flag));
		
		System.out.println(result);
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getIsInner() {
		return isInner;
	}
	public void setIsInner(String isInner) {
		this.isInner = isInner;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
