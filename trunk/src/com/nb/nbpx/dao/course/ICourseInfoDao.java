package com.nb.nbpx.dao.course;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.CourseInfo;

/**
 * CourseInfo数据库处理类
 * @author Roger
 * @date 2013年7月20日
 */
public interface ICourseInfoDao  extends IBaseDao<CourseInfo, Integer>{
	public List<CourseInfo> queryCourseInfo(String courseInfoId);
}
