package com.nb.nbpx.dao.user;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.user.TeacherInfo;

public interface ITeacherInfoDao extends IBaseDao<TeacherInfo, Integer>{
	public Long getTeacherListRows(Boolean isInner,String state,Integer rows,Integer start);
	//获取培训或者内训讲师
	public List<TeacherInfo> getTeacherList(Boolean isInner,String state,Integer rows,Integer start);
	public List<TeacherInfo> getTeacherInforByUserId(Integer userId);
	public Boolean saveTeacherInfor(TeacherInfo teacherInfor);
	public TeacherInfo getTeacherInfoById(Integer teacherId);
	/**外部发布
	 * @param userName
	 * @param teacherName
	 * @param rows
	 * @param start
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<TeacherInfo> queryOutTeacherInfo(String userName,String teacherName,Integer rows,
			Integer start, String sort, String order);
	/**外部发布
	 * @param userName
	 * @param teacherName
	 * @return
	 */
	public Long queryOutTeacherInfoCount(String userName,String teacherName);
	
	/**
	 * 内部发布的
	 * @param teacherName
	 * @param rows
	 * @param start
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<TeacherInfo> queryInnerTeacherInfo(String teacherName,Integer rows,
			Integer start, String sort, String order);
	/**
	 * 内部发布
	 * @param teacherName
	 * @return
	 */
	public Long queryInnerTeacherInfoCount(String teacherName);
	
	/**
	 * 以teacherName搜索TeacherInfo
	 * @param teacherName
	 * @return
	 */
	public TeacherInfo queryTeacherInfoByName(String teacherName);
}
