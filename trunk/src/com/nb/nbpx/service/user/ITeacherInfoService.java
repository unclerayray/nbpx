package com.nb.nbpx.service.user;

import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.IBaseService;

public interface ITeacherInfoService extends IBaseService{

	public String getTeacherInfoByUserId(Integer userID);
	public String saveTeacherInfor(TeacherInfo teacherInfor);

}
