package com.nb.nbpx.user;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.service.user.IUserService;


/**
 * @author Roger
 * @date 2013年8月31日
 */
public class UserServiceTest extends BaseServiceTest{
	@Resource
	private IUserService userService;
	
	@Test
	@Transactional(readOnly = true)
	public void testqueryUserByType(){
		String json = userService.queryUserByType("1", 10, 2);
		System.out.println("json = " + json);
		Assert.assertNotNull(json);
	}
	
	
}
