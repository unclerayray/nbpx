package com.nb.nbpx.interceptor;

import java.util.HashMap;
import java.util.Iterator;
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

		if (paramMap.get("objectName") != null) {
			Map<String, Object> parameters = new HashMap<String, Object>();
			Map<String, Object> obj = new HashMap<String, Object>();
			Iterator iter = paramMap.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry entry = (Map.Entry) iter.next();
				entry.setValue(entry.getValue());
				if ("objectName".equals(entry.getKey())) {
					parameters.put(entry.getKey().toString(), entry.getValue());
				}else if("sync".equals(entry.getKey())){
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
}
