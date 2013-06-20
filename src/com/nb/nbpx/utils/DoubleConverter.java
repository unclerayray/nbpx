package com.nb.nbpx.utils;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.struts2.util.StrutsTypeConverter;

/**
 * <p>
 * 工具类:在struts2自动填充model前碰到double字段时,进行转换(配合xwork-conversion.properties文件使用)
 * </p>
 * 
 * @author leilichao
 * @version V1.0
 */
public class DoubleConverter extends StrutsTypeConverter {

    @SuppressWarnings("rawtypes")
	@Override
    public Object convertFromString(Map arg0, String[] arg1, Class arg2) {
        if (Double.class == arg2) {
            String doubleStr = arg1[0];
            // System.out.println("获取到的字符串" + doubleStr);
            Double d = Double.parseDouble(doubleStr);
            return d;
        }
        return 0;
    }

    @SuppressWarnings("rawtypes")
	@Override
    public String convertToString(Map arg0, Object arg1) {
        return arg1.toString();
    }
    /**
     * 验证是否是数字
     */
 	public static boolean checkIsNumber(String str) 
     {   
         if(str.charAt(0) == '-')
         {   
             str = str.substring(1,str.length());   
         }   
         Pattern pattern = Pattern.compile("[0-9.]*");   
         Matcher isNumFlag = pattern.matcher(str);   
         if (!isNumFlag.matches()) 
         {   
             return false;
             
         } 
         return true;   
     } 
}
