package com.nb.nbpx.keyword;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.dao.keyword.IKeywordDao;

/**
 * 关键词模块的单元测试类
 * @author Roger
 * @date 2013年7月29日
 */
public class KeywordTest  extends BaseServiceTest {
	@Resource
	private IKeywordDao keywordDao;
	
	@Test
	@Rollback(true)
	//@Transactional
	public void testBatchInsert(){
		String category = "003_01";
		String[] keywords = {"维护","和谐","企业"};
		keywordDao.importKeywords(category, keywords);
	}
	
	@Test
	public void testReplace(){
		String str = "去符号标号！！当然。";
        str = str.replaceAll("\\pP", "");
        System.out.println(str);
	}
}
