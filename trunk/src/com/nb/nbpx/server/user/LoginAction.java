package com.nb.nbpx.server.user;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.user.*;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.user.*;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

@Component("LoginAction")
@Scope("prototype")
public class LoginAction  extends BaseAction {
	
	private static final long serialVersionUID = 1L;
	
	private String username;
	private String password;
	private String city;
	private String email;
	private String company;
	private String contact;
	private String department;
	private String cellphone;
	private String telephone;
	private String fax;
	private String orgName;
	private String address;
	private String category;
	private String postCode;
	private String website;
	private String introduction;
	private String realName;
	private String majorCatgory;
	private String internalPayment;
	private String externalPayment;
	private String expertIn;
	private String birthday;


	private ICompInfoService CompService;
	private IOrgInfoService OrgService;
	private ITeacherInfoService TeacherService;
	private IUserService UserService;
	
	//添加培训机构
	public String saveOrg(){
		String json = "";
		//先添加用户
		User user = new User();
		user.setEmail(email);
		user.setCity(city);
		user.setUserName(orgName);
		user.setPassWord(password);
		user.setRegisterDate(new Date());
		user.setUserType("001_03");
		user.setState(false);
		try {
			UserService.saveUser(user);
		} catch (NbpxException e) {//有重复用户名
			e.printStackTrace();
			json = JsonUtil.format2Json(false, "用户名已存在!");
			this.inputStream = castToInputStream(json);
			return SUCCESS;
		}
		
		OrgInfo orgInfo = new OrgInfo(null,user.getUserId(), orgName,address,Integer.parseInt(postCode),contact,cellphone,telephone,fax, website,category,introduction);
		json = OrgService.saveOrgInfor(orgInfo);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	//添加讲师
	public String saveTeacher(){
		String json = "";
		//先添加用户
		User user = new User();
		user.setEmail(email);
		user.setCity(city);
		user.setUserName(realName);
		user.setPassWord(password);
		user.setRegisterDate(new Date());
		user.setUserType("001_02");
		user.setState(false);
		try {
			UserService.saveUser(user);
		} catch (NbpxException e) {//有重复用户名
			e.printStackTrace();
			json = JsonUtil.format2Json(false, "用户名已存在!");
			this.inputStream = castToInputStream(json);
			return SUCCESS;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date teacherBirthday = null;
		try {
			teacherBirthday = sdf.parse(birthday);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		TeacherInfo teacher = new TeacherInfo(null,user.getUserId(),realName,teacherBirthday,majorCatgory,Double.parseDouble(externalPayment),Double.parseDouble(internalPayment),fax,telephone, cellphone, introduction,expertIn);

		if(teacher.getTeacherId()==null){
			teacher.setCreateBy(getSessionUserName());
		}
		if(teacher.getState()==null){
			teacher.setState(false);
		}
		try {
			TeacherService.saveTeacher(teacher);
		} catch (NbpxException e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}
	
	//添加公司用户
	public String saveCompany(){
		String json = "";
		//先添加用户
		User user = new User();
		user.setEmail(email);
		user.setCity(city);
		user.setUserName(company);
		user.setPassWord(password);
		user.setRegisterDate(new Date());
		user.setUserType("001_01");
		user.setState(false);
		try {
			UserService.saveUser(user);
		} catch (NbpxException e) {//有重复用户名
			e.printStackTrace();
			json = JsonUtil.format2Json(false, "用户名已存在!");
			this.inputStream = castToInputStream(json);
			return SUCCESS;
		}
		System.out.println("id:"+user.getUserId());
		//再添加公司信息
		User use = UserService.queryById(user.getUserId());
		//CompInfo compInfo = new CompInfo(null,user.getUserId(),contact,company,telephone, cellphone,fax,department);
		CompInfo compInfo = new CompInfo(null, use, contact,company,telephone, cellphone,fax,department,false,new Date(),username);
		json = CompService.saveCompInfor(compInfo);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	//验证登陆
	public String checkUser(){
		String json = "";
		
		json = UserService.checkLogin(username, password);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getMajorCatgory() {
		return majorCatgory;
	}
	public void setMajorCatgory(String majorCatgory) {
		this.majorCatgory = majorCatgory;
	}
	public String getInternalPayment() {
		return internalPayment;
	}
	public void setInternalPayment(String internalPayment) {
		this.internalPayment = internalPayment;
	}
	public String getExternalPayment() {
		return externalPayment;
	}
	public void setExternalPayment(String externalPayment) {
		this.externalPayment = externalPayment;
	}
	public String getExpertIn() {
		return expertIn;
	}
	public void setExpertIn(String expertIn) {
		this.expertIn = expertIn;
	}
	
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public ICompInfoService getCompService() {
		return CompService;
	}
	@Resource
	public void setCompService(ICompInfoService compService) {
		CompService = compService;
	}
	public IOrgInfoService getOrgService() {
		return OrgService;
	}
	@Resource
	public void setOrgService(IOrgInfoService orgService) {
		OrgService = orgService;
	}
	
	public ITeacherInfoService getTeacherService() {
		return TeacherService;
	}
	@Resource
	public void setTeacherService(ITeacherInfoService teacherService) {
		TeacherService = teacherService;
	}
	public IUserService getUserService() {
		return UserService;
	}
	@Resource
	public void setUserService(IUserService userService) {
		UserService = userService;
	}

}
