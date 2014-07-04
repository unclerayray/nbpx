package com.nb.nbpx.interceptor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class JsonBuilderInterceptor extends AbstractInterceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String intercept(ActionInvocation ai) throws Exception {
		Map<String, Object> paramMap = ai.getInvocationContext()
				.getParameters();

//		Map<String, Object> excludedParams = new HashMap<String, Object>();
		if (paramMap.get("objectName") != null) {
			Map<String, Object> parameters = new HashMap<String, Object>();
			Map<String, Object> obj = new HashMap<String, Object>();
			Iterator iter = paramMap.entrySet().iterator();
			Object excludedFieldObj = paramMap.get("excluded_fields");
			boolean hasExcluded = (excludedFieldObj != null);
			String[] excludedFields = null;
			List<String> excludedList = new ArrayList<String>();
			if(hasExcluded){
				excludedFields = ((String []) excludedFieldObj)[0].toString().split(",");
				excludedList.addAll(Arrays.asList(excludedFields));
			}
			excludedList.add("excluded_fields");
			excludedList.add("objectName");
			while (iter.hasNext()) {
				Map.Entry entry = (Map.Entry) iter.next();
				entry.setValue(entry.getValue());
				if (hasExcluded&& excludedList.contains(entry.getKey().toString())||entry.getKey().toString().equals("excluded_fields")) {
					parameters.put(entry.getKey().toString(), entry.getValue());
				}else {
					String key = ((String[]) paramMap.get("objectName"))[0]
							+ "." + entry.getKey();
					obj.put(key, entry.getValue());
				}
			}
			obj.keySet().removeAll(parameters.keySet());
			parameters.putAll(obj);
			ai.getInvocationContext().setParameters(parameters);
		}
		return ai.invoke();
	}
	
	public static void main(String[] args){
		System.out.println("file_excluded".substring(0,"file_excluded".length()-9));
	}
}
