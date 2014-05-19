package com.nb.nbpx.dao.user.impl;

import java.util.List;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.user.IAdminDao;
import com.nb.nbpx.pojo.user.Admin;


@Component("AdminDao")
public class AdminDaoImpl extends BaseDaoImpl<Admin, Integer> implements
		IAdminDao {


	@Override
	public List<Admin> queryAdmin(String userName, Integer rows, Integer start,
			String sort, String order) {
		
		return null;
	}

	@Override
	public boolean checkDuplicateProp(String username) {
		return false;
	}

}
