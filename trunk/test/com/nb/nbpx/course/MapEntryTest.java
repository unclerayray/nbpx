package com.nb.nbpx.course;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

public class MapEntryTest {
	@Test
	public void entryTest(){
		Map<Integer, Integer> map = new HashMap<Integer, Integer>();
		map.put(1, 100);
		map.put(2, 200);
		map.put(3, 300);
		List<Map.Entry<Integer, Integer>> list = 
			    new ArrayList<Map.Entry<Integer, Integer>>(map.entrySet());
		for(Map.Entry<Integer, Integer> entry:list){
			System.out.println(entry.getKey() + " : " + entry.getValue());
		}
	}
}
