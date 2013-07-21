package com.nb.nbpx.utils.converter;

import java.math.BigDecimal;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

/**
 * <p>
 * 工具类:在struts2自动填充model前碰到BigDecimal字段时,进行转换(配合xwork-conversion.properties文件使用)
 * </p>
 * 创建时间：2012-6-1 下午05:17:56
 * 
 * @author leilichao
 * @version V1.0
 */
public class BigDecimalConverter extends StrutsTypeConverter {
    @SuppressWarnings("rawtypes")
    @Override
    public Object convertFromString(Map arg0, String[] arg1, Class arg2) {
        if (BigDecimal.class == arg2 && arg1.length > 0) {
            String bigDecimalStr = arg1[0];
            BigDecimal decimal = new BigDecimal(bigDecimalStr);
            return decimal;
        }
        return new BigDecimal(0);
    }

    @SuppressWarnings("rawtypes")
	@Override
    public String convertToString(Map arg0, Object arg1) {
        return arg1.toString();
    }
}
