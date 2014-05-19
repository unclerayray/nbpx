package com.nb.nbpx.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.user.IAdminDao;
import com.nb.nbpx.pojo.user.Admin;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.user.IAdminService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

@Component("AdminService")
public class AdminServiceImpl extends BaseServiceImpl implements IAdminService {

	private IAdminDao adminDao;
	public IAdminDao getAdminDao() {
		return adminDao;
	}

	@Resource
	public void setAdminDao(IAdminDao adminDao) {
		this.adminDao = adminDao;
	}

	@Override
	public String queryAdmins(String userName, Integer rows, Integer start,
			String sort, String order) {
		Map<String,Object> propsMap = new HashMap<String,Object>();
		propsMap.put("userName",userName);
		List<Admin> adminList = adminDao.queryEntityListByProperties(Admin.class, rows, start, sort, order, propsMap);
		String json = JsonUtil.formatToJsonWithNoTimeStamp4User(adminList.size(),
				ResponseStatus.SUCCESS, "", adminList);
		return json;
	}

	@Override
	public void saveAdmin(Admin admin) throws NbpxException {
		adminDao.saveOrUpdate(admin);
	}

	@Override
	public void deleteAdmin(Admin admin) {
		adminDao.delete(admin);
	}

	@Override
	public boolean checkLogin(String username, String password) {
		Map<String,Object> propsMap = new HashMap<String,Object>();
		propsMap.put("userName",username);
		List<Admin> adminList = adminDao.queryEntityListByProperties(Admin.class, null, null, null, null, propsMap);
		if(adminList.size()>0){
			if(adminList.get(0).getFlag()){
				return true;
			}
		}
		return false;
	}

	@Override
	public Admin searchAdmin(String username) {
		Map<String,Object> propsMap = new HashMap<String,Object>();
		propsMap.put("userName",username);
		List<Admin> adminList = adminDao.queryEntityListByProperties(Admin.class, null, null, null, null, propsMap);
		if(adminList.size()>0){
			return adminList.get(0);
		}else{
			return null;
		}
	}

}
