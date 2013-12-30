package com.nb.nbpx.system;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.dao.system.IDictionaryDao;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.service.system.IDictionaryService;
import com.nb.nbpx.utils.NbpxException;

public class DictionaryTest   extends BaseServiceTest {
	@Resource
	private IDictionaryDao dictionaryDao;
	@Resource
	public IDictionaryService dictionaryService;
	@Test
	public void test() {
		String code = dictionaryDao.getLatestCode("998");
		System.out.println(code);
		Assert.assertNotNull(code);
	}
	
	@Test
	public void testlatest() {
		String code = dictionaryDao.getLatestCode("11");
		System.out.println(code);
		Assert.assertNotNull(code);
	}
	
	@Test
	public void testimport() {
		String dics = "第一次,和你,详见,第二次,和他,怀念";
		String p_dicType = "12";
		String regEx1 = "[\\pP‘’“”]";
		dics = dics.replaceAll(" ", "");
		dics = dics.replaceAll(regEx1, ",");
		String[] dicsArr = dics.split(",");
		Set<String> uniqueWords = new HashSet<String>(Arrays.asList(dicsArr));
		dicsArr = uniqueWords.toArray(new String[0]);
		String msg = "";
		int cnt = 0;
		for (String dic : dicsArr) {
			Dictionary di = new Dictionary();
			di.setDicType(p_dicType);
			di.setShowName(dic);
			di.setFlag(true);
			try {
				dictionaryService.saveDic(di);
			} catch (NbpxException e) {
				cnt++;
			}
		}
	}
}
