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
	public String flag;//标记top Course的三种属性(1-推荐，2-精品，3-排行)
	public String isInner;//标记是内训还是培训
	public String type;//课程类别
	

	public String getCourseByCity(){
		String city = "";
		if("1".equals(flag))
			city = "北京";
		else if("2".equals(flag))
			city = "上海";
		else if("3".equals(flag))
			city = "深圳";
		else if("4".equals(flag))
			city = "广州";
		else
			city = "苏州";
		String result = courseService.getCoursesByCity(city, 8, 0);
		this.inputStream = castToInputStream(result);
	
		return SUCCESS;
	}
	//首页30行推荐
	public String getTopCourse(){
		String result = courseService.getTopCourse(Integer.parseInt(flag), null);
		//System.out.println(result);
		this.inputStream = castToInputStream(result);
	
		return SUCCESS;
	}
	
	//获得内训的课程
	public String getPeiXun(){
		String typeCode = "003_0"+type;//(01-财务管理,02-物流管理,03-人力资源,04-生产管理,05-营销培训,06-综合战略)
		
		String result = courseService.getNXCourse(typeCode, Integer.parseInt(flag));
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
