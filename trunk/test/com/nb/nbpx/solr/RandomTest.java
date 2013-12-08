package com.nb.nbpx.solr;

import java.util.HashMap;
import java.util.Map;

import org.jsoup.helper.StringUtil;
import org.junit.Assert;
import org.junit.Test;

import com.nb.nbpx.utils.JsonUtil;

public class RandomTest {

	public static void mains(String[] args) {
		Map map = new HashMap();
		map.put("haha", "haha");
		map.put("iiiii", "iiiii");
		String str = JsonUtil.formatMapToJson(map);
		System.out.println("str = " + str);
	}

	@Test
	public void testReg(){
		String regex = "[\\pP‘’“”]";
		String regex1 = "[\\W]";
		String targets = "法克，哈哈,hoho23，007_02";
		targets = targets.replaceAll(regex, ",");
		System.out.println(targets);
	}
	
	@Test
	public void testRegex(){
		String regex = "[\\pP‘’“”]";
		String targets = "法克，哈哈,hoho23，007_02";
		targets = targets.replaceAll(regex, "");
		System.out.println(targets);
		Assert.assertFalse(StringUtil.isNumeric(targets));
		
		String targets1 = "010_01, ,010_02";
		targets1 = targets1.replaceAll(" ", "");
		targets1 = targets1.replaceAll(regex, "");
		System.out.println(targets1);
		Assert.assertTrue(StringUtil.isNumeric(targets1));
	}
}
