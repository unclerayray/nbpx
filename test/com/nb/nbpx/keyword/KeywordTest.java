package com.nb.nbpx.keyword;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.test.annotation.Rollback;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.solr.ISolrKeywordService;

/**
 * 关键词模块的单元测试类
 * @author Roger
 * @date 2013年7月29日
 */
public class KeywordTest  extends BaseServiceTest {
	@Resource
	private IKeywordDao keywordDao;
	@Resource
	private ISolrKeywordService solrKeywordService;
	
	//@Test
	@Rollback(true)
	//@Transactional
	public void testBatchInsert(){
		String category = "003_01";
		String[] keywords = {"维护","和谐","企业"};
		keywordDao.importKeywords(category, keywords);
	}
	
	//@Test
	public void testReplace(){
		String str = "去符号标号！！当然。";
        str = str.replaceAll("\\pP", "");
        System.out.println(str);
	}
	
	@Test
	public void testAddHyperLink(){
		String originalStr = "我们都爱企业培训，这样的<a href=\"http://www.baidu.com\">企业培训</a>是我们的好朋友，大家都喜欢企业培训一二三";
		String reg = "";
		String keywordStr = "企业培训";
		reg = "[^(<a href=\".+\">)]?"+keywordStr+"[^(</a>)?]";
		reg = "(?!((<.*?)|(<a.*?)))("+keywordStr+")(?!(([^<>]*?)>)|([^>]*?</a>))";
//		reg = "[^"+keywordStr+"$]";
		System.out.println("reg = " + reg);
		String replacement = "<a href=\"http://www.baidu.com\">"+keywordStr+"</a>";
		String result = originalStr.replaceAll(reg, replacement);
		System.out.println("after Add HyperLink = " + result);
		
		String str = "正则表达式 Hello World,正则表达式 Hello World";
		Pattern pattern = Pattern.compile(reg);
		Matcher matcher = pattern.matcher(originalStr);
		//替换第一个符合正则的数据
		System.out.println(matcher.replaceAll(replacement));
	}
	
	@Test
	public void testAddKeyword2Solr(){
		Keyword keyword = new Keyword();
		keyword.setKeyId(777);
		keyword.setKeyword("从来没有");
		solrKeywordService.addKeyword2Solr(keyword);
		
		Keyword keyword1 = new Keyword();
		keyword1.setKeyId(96);
		keyword1.setKeyword("企业");
		solrKeywordService.addKeyword2Solr(keyword1);
	}
}
