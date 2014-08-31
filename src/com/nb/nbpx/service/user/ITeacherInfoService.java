package com.nb.nbpx.service.user;

import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

public interface ITeacherInfoService extends IBaseService{

	public String getTeacherInfo(Boolean isInner,String state,Integer rows,Integer start);
	public String getTeacherInfoByUserId(Integer userID);
	public TeacherInfo getTeacherInfoEntityByUserId(Integer userID);
	public String getTeacherInfoByTeacherId(Integer teacherID);
	public void deleteTeacherInfo(Integer teacherInfoId);
	public String saveTeacherInfor(TeacherInfo teacherInfor);

	public String queryTeacherInfo(String userName,String teacherName,Boolean inner,Integer rows,
			Integer start, String sort, String order);
	
	public TeacherInfo saveTeacher(TeacherInfo teacherInfor) throws NbpxException;
	
	public void auditTeacherInfo(Integer teacherInfoId, boolean state) throws Exception ;
}
