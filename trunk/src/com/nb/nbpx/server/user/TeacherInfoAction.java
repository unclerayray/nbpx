package com.nb.nbpx.server.user;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.ITeacherInfoDao;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.solr.ISolrTeacherService;
import com.nb.nbpx.service.user.ITeacherInfoService;
import com.nb.nbpx.utils.JsonUtil;

@Component("TeacherInfoAction")
@Scope("prototype")
public class TeacherInfoAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	public TeacherInfo teacherInfor;
	public Integer userId;
	public String q_userName;
	public String q_teacherName;
	public Integer teacherInfoId;
	public Boolean q_inner;
	public String teacherID;
	public String type;
	
	private ITeacherInfoService teacherInfoService;
	private ITeacherInfoDao teacherInfoDao;
	private ISolrTeacherService solrTeacherService;
	private ICourseService courseService;
	


	//获取培训讲师列表
	public String getPXTeacherList(){
		String json = "";
		json = teacherInfoService.getTeacherInfo(false, "1", rows, getStartPosi());
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	//获取内训讲师列表
	public String getNXTeacherList(){
		String json = "";
		json = teacherInfoService.getTeacherInfo(true, "1", rows, getStartPosi());
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String getCourseByTeacher(){
		Boolean isInner = false;
		if("2".equals(type))
			isInner = true;
		String json = courseService.queryCourseByTeacher(isInner, teacherID, rows, getStartPosi());
		
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	
	public String getTeacherInforByUserId(){
		String json = "";
		try {

			json = teacherInfoService.getTeacherInfoByUserId(userId);
			System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String saveTeacherInfor(){
		String json = "";
		try {
			TeacherInfo info = teacherInfoDao.get(teacherInfor.getTeacherId());
			info.setRealName(teacherInfor.getRealName());
			info.setTelephone(teacherInfor.getTelephone());
			info.setFax(teacherInfor.getFax());
			info.setCellphone(teacherInfor.getCellphone());
			info.setExpertIn(teacherInfor.getExpertIn());
			info.setBirthday(teacherInfor.getBirthday());
			info.setExternalPayment(teacherInfor.getExternalPayment());
			info.setInternalPayment(teacherInfor.getInternalPayment());
			info.setIntroduction(teacherInfor.getIntroduction());
			info.setMajorCatgory(teacherInfor.getMajorCatgory());
			json = teacherInfoService.saveTeacherInfor(info);
			// TODO 把category的字典换成字典值
			solrTeacherService.addTeacher2Solr(info);
			
			//System.out.println("json = " + json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String queryTeacherInfo(){
		String json = "";
		try {
			q_inner = false;
			json = teacherInfoService.queryTeacherInfo(q_userName, q_teacherName, q_inner,
					rows, getStartPosi(), sort, order);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String queryInnerTeacherInfo(){
		String json = "";
		try {
			q_inner = true;
			json = teacherInfoService.queryTeacherInfo(q_userName, q_teacherName, q_inner,
					rows, getStartPosi(), sort, order);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String auditTeacherInfo(){
		String msg = "已激活！";
		try {
			TeacherInfo teacherInfo = teacherInfoDao.get(teacherInfoId);
			Boolean state = teacherInfo.getState();
			teacherInfo.setState(!state);
			teacherInfoService.saveTeacherInfor(teacherInfo);
			solrTeacherService.audit(teacherInfoId,!state);
			if(teacherInfo.getState()){
				msg = "已锁定！";
			}
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"激活/锁定 失败！" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, msg));
		return SUCCESS;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public TeacherInfo getTeacherInfor() {
		return teacherInfor;
	}
	public String getTeacherID() {
		return teacherID;
	}

	public void setTeacherID(String teacherID) {
		this.teacherID = teacherID;
	}
	public void setTeacherInfor(TeacherInfo teacherInfor) {
		this.teacherInfor = teacherInfor;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getQ_userName() {
		return q_userName;
	}

	public void setQ_userName(String q_userName) {
		this.q_userName = q_userName;
	}

	public String getQ_teacherName() {
		return q_teacherName;
	}

	public void setQ_teacherName(String q_teacherName) {
		this.q_teacherName = q_teacherName;
	}

	public Integer getTeacherInfoId() {
		return teacherInfoId;
	}

	public void setTeacherInfoId(Integer teacherInfoId) {
		this.teacherInfoId = teacherInfoId;
	}

	public Boolean getQ_inner() {
		return q_inner;
	}

	public void setQ_inner(Boolean q_inner) {
		this.q_inner = q_inner;
	}

	public ITeacherInfoDao getTeacherInfoDao() {
		return teacherInfoDao;
	}

	@Resource
	public void setTeacherInfoDao(ITeacherInfoDao teacherInfoDao) {
		this.teacherInfoDao = teacherInfoDao;
	}

	public ITeacherInfoService getTeacherInfoService() {
		return teacherInfoService;
	}
	
	@Resource
	public void setTeacherInfoService(ITeacherInfoService teacherInfoService) {
		this.teacherInfoService = teacherInfoService;
	}

	public ISolrTeacherService getSolrTeacherService() {
		return solrTeacherService;
	}

	@Resource
	public void setSolrTeacherService(ISolrTeacherService solrTeacherService) {
		this.solrTeacherService = solrTeacherService;
	}

	public ICourseService getCourseService() {
		return courseService;
	}
	@Resource
	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}
	
	

}
