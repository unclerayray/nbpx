package com.nb.nbpx.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

import com.opensymphony.xwork2.conversion.TypeConversionException;

/**
 * <p>
 * 工具类:在struts2自动填充model前碰到TimeStamp字段时,进行转换(配合xwork-conversion.properties文件使用)
 * </p>
 * 
 * @author leilichao
 * @version V1.0
 */
public class TimeStampConverter extends StrutsTypeConverter {
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @SuppressWarnings("rawtypes")
	@Override
    public Object convertFromString(Map context, String[] values, Class toClass) throws TypeConversionException {
        try{
               if (values == null || values.length == 0) {
                    return null;
                }
               return new java.sql.Timestamp(sdf.parse(values[0]).getTime());
        }catch(Exception e){        
            throw new TypeConversionException(e);
        }
    }

    @SuppressWarnings("rawtypes")
	@Override
    public String convertToString(Map context, Object object)  throws TypeConversionException  {
        try{
            if(object instanceof Timestamp){
                return sdf.format(new Date(((Timestamp)object).getTime()));
            }
            return "";
        }catch(Exception e){
            throw new TypeConversionException(e);
        }
    }

}
