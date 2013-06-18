package com.nb.nbpx.dao.user;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.user.TeacherInfo;

public interface ITeacherInfoDao extends IBaseDao<TeacherInfo, Integer>{
	public List<TeacherInfo> getTeacherInforByUserId(Integer userId);
	public Boolean saveTeacherInfor(TeacherInfo teacherInfor);
}
