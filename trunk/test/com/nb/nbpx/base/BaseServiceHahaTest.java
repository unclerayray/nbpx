package com.nb.nbpx.base;

import javax.annotation.Resource;

import org.junit.Test;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.pojo.user.CompInfo;
import com.nb.nbpx.service.user.ICompInfoService;

public class BaseServiceHahaTest  extends BaseServiceTest {
	@Resource
	private ICompInfoService compInfoService;
	
	@Test
	public void testGetByPK(){
		//CompInfo compInfo = (CompInfo) compInfoService.getEntityByPK(1, CompInfo.class);
		//System.out.println(compInfo.getCompany());
	}
}
