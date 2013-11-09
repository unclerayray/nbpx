package com.nb.nbpx.utils.converter;

import java.sql.Timestamp;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

/**
 * easyui的checkbox转换成Boolean
 * @author roger
 * @version 1.0
 * @date 2013年6月27日 
 *
 */
@SuppressWarnings("rawtypes")
public class CheckboxValueConverter  extends StrutsTypeConverter {

	@Override
	public Object convertFromString(Map arg0, String[] arg1, Class arg2) {
		if (Boolean.class == arg2) {
            String boolStr = arg1[0];
            // System.out.println("获取到的字符串" + doubleStr);
            if(boolStr!=null&&!boolStr.isEmpty()){
            	if("on".equals(boolStr)||"true".equals(boolStr)){
                	return true;
                }else{
                	return false;
                }
            }else{
            	return null;
            }
        }
        return false;
	}

	
	@Override
	public String convertToString(Map arg0, Object object) {
		if(object instanceof Boolean){
			Boolean bo = (Boolean)object;
			if(bo){
				return "on";
			}else{
				return "off";
			}
		}
		return "";
	}

}
