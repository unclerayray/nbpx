package com.nb.nbpx.server.course;

import java.sql.Date;
import java.util.Calendar;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;

@Component("SeePlaceAction")
@Scope("prototype")
public class SeePlaceAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	private ICourseService courseService;
	
	public String cityName;
	public String flag;
	


	//分页获取城市课程信息
	public String getCityCourse(){
		String json = courseService.queryCourseByCity(cityName,null, "1", rows,page);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	//获取最热的课程
	public String getHotCourse(){
		String json = "";
		cityName="广州";
		if("1".equals(flag)){//获取地点热门课程
			json = courseService.queryHotCourseByPlace(null, cityName, 5, 0);
		}else{//获取当月该地点的热门课程
			Calendar c = Calendar.getInstance();
			int currMonth = c.get(Calendar.MONTH)+1;
			json = courseService.selectTimeTopCourse(currMonth+"", cityName, 5, 0);
		}
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	
	public ICourseService getCourseService() {
		return courseService;
	}
	
	@Resource
	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
