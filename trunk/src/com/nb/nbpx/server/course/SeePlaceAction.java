package com.nb.nbpx.server.course;

import java.io.UnsupportedEncodingException;
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
	
	public String city;
	public String flag;
	public String month;
	


	//分页获取城市课程信息
	public String getCityCourse(){
		String json = courseService.queryCourseByCity(city,null,null, "1", rows,page);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	//分页获取城市的月度课程信息
	public String getCityMonthCourse(){
		Calendar date = Calendar.getInstance();
		String currYear = date.YEAR+"";
		String json = courseService.queryCourseByCity(city,currYear,month, "1", rows,page);
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	//获取最热的课程
	public String getHotCourse(){
		String json = "";
		if("1".equals(flag)){//获取地点热门课程
			json = courseService.queryHotCourseByPlace(null, city, 5, 0);
		}else{//获取当月该地点的热门课程
			Calendar c = Calendar.getInstance();
			int currMonth = c.get(Calendar.MONTH)+1;
			json = courseService.selectTimeTopCourse(currMonth+"", city, 5, 0);
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
	public String getCity() {
		return city;
	}

	public void setCity(String city) throws UnsupportedEncodingException {
		if(city != null)
			city =  new String(city.getBytes("iso-8859-1"),"utf-8");
		this.city = city;
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
