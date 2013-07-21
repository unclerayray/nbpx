package com.nb.nbpx.utils;

import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;
/**
 * @author Roger
 * @date 2013年7月20日
 */
@SuppressWarnings("rawtypes")
public class IntegerConverter extends StrutsTypeConverter {

	
	@Override
	public Object convertFromString(Map arg0, String[] arg1, Class arg2) {
		if (Integer.class == arg2) {
            String integerStr = arg1[0];
            if(integerStr==null||integerStr.isEmpty()){
            	return null;
            }
            Integer d = Integer.parseInt(integerStr);
            return d;
        }
        return 0;
	}

	@Override
	public String convertToString(Map arg0, Object arg1) {
		return arg1.toString();
	}

}
