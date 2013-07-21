package com.nb.nbpx.utils.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

/**
 * <p>
 * 工具类:在struts2自动填充model前碰到Date字段时,进行转换(配合xwork-conversion.properties文件使用)
 * </p>
 * 
 * @date 2013-6-20
 * 
 * @author Roger
 * @version V1.0
 */
public class DateConverter extends StrutsTypeConverter {

	private static String DATE_TIME_FOMART = "yyyy-MM-dd HH:mm:ss";

	private static String DATE_FOMART = "yyyy-MM-dd";

	@SuppressWarnings("rawtypes")
	@Override
	public Object convertFromString(Map context, String[] values, Class toClass) {
		Date date = null;
		String dateString = null;
		if (values != null && values.length > 0) {
			dateString = values[0];
			if (dateString != null) {
				SimpleDateFormat format = new SimpleDateFormat(DATE_TIME_FOMART);
				try {
					date = format.parse(dateString);
				} catch (ParseException e) {
					date = null;
				}
				if (date == null) {
					format = new SimpleDateFormat(DATE_FOMART);
					try {
						date = format.parse(dateString);
					} catch (ParseException e) {
						date = null;
					}
				}
			}
		}
		return date;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String convertToString(Map arg0, Object arg1) {
		Date date = (Date) arg1;
		String dataStr = null;
		SimpleDateFormat format = new SimpleDateFormat(DATE_TIME_FOMART);
		try {
			dataStr = format.format(date);
		} catch (Exception e) {
			dataStr = null;
		}
		if(dataStr == null){
			format = new SimpleDateFormat(DATE_FOMART);
			dataStr = format.format(date);
		}
		return dataStr;
	}
}
