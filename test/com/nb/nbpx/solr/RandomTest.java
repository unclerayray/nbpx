package com.nb.nbpx.solr;

import java.util.HashMap;
import java.util.Map;

import com.nb.nbpx.utils.JsonUtil;

public class RandomTest {

	public static void main(String[] args) {
		Map map = new HashMap();
		map.put("haha", "haha");
		map.put("iiiii", "iiiii");
		String str = JsonUtil.formatMapToJson(map);
		System.out.println("str = " + str);
	}

}
