package com.nb.nbpx.system;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.dao.system.IDictionaryDao;

public class DictionaryTest   extends BaseServiceTest {
	@Resource
	private IDictionaryDao dictionaryDao;
	@Test
	public void test() {
		String code = dictionaryDao.getLatestCode("002");
		System.out.println(code);
		Assert.assertNotNull(code);
	}

}
