package com.nb.nbpx.utils;

import java.lang.reflect.Type;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

/**
 * <p>
 * gson转换日期时的适应器，用于按特定要求转换日期
 * </p>
 * 创建时间：2013-4-9 22:32:01
 * 
 * @author leilichao
 * @version V1.0
 */
public class DateAdapter implements JsonSerializer<Date>, JsonDeserializer<Date> {
    private static final String REGEX_SHORT         = "^((19[7-9][0-9])||([2][0-9]{3}))-((0?[1-9])||(1[0-2]))-((0?[1-9])||([1-2][0-9])||(3[0-1]))";
    private static final String REGEX_MEDIUM_HOUR   = REGEX_SHORT + "\\s((0?[0-9])||(1[0-9])||(2[0-3]))";
    private static final String REGEX_MEDIUM_SECOND = REGEX_MEDIUM_HOUR + ":((0?[0-9])||([1-5][0-9]))";
    private static final String REGEX_LONG          = REGEX_MEDIUM_SECOND + ":((0?[0-9])||([1-5][0-9]))";

    private SimpleDateFormat    df;
    private int                 patternFlag;

    public DateAdapter(String pattern) {
        df = new SimpleDateFormat(pattern);

        if (pattern.equals(GsonUtil.SHORT)) {
            patternFlag = 1;
        } else if (pattern.equals(GsonUtil.MEDIUM_WITH_HOUR)) {
            patternFlag = 2;
        } else if (pattern.equals(GsonUtil.MEDIUM_WITHOUT_SECOND)) {
            patternFlag = 3;
        } else if (pattern.equals(GsonUtil.LONG)) {
            patternFlag = 4;
        }
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.google.gson.JsonDeserializer#deserialize(com.google.gson.JsonElement,
     * java.lang.reflect.Type, com.google.gson.JsonDeserializationContext)
     */
    @Override
    public Date deserialize(JsonElement je, Type type, JsonDeserializationContext context) throws JsonParseException {
        String dateStr = null;
        try {
            dateStr = je.getAsJsonPrimitive().getAsString();
            if (null != dateStr && !"".equals(dateStr)) {
                int flag = 0;
                boolean isMatchRegex = false;
                if (Pattern.compile(REGEX_SHORT + "$").matcher(dateStr).matches()) {
                    flag = 1;
                    isMatchRegex = true;
                } else if (Pattern.compile(REGEX_MEDIUM_HOUR + "$").matcher(dateStr).matches()) {
                    flag = 2;
                    isMatchRegex = true;
                } else if (Pattern.compile(REGEX_MEDIUM_SECOND + "$").matcher(dateStr).matches()) {
                    flag = 3;
                    isMatchRegex = true;
                } else if (Pattern.compile(REGEX_LONG + "$").matcher(dateStr).matches()) {
                    flag = 4;
                    isMatchRegex = true;
                }

                if (isMatchRegex) {
                    if (flag < patternFlag) {
                        // 当要日期格式由短格式转换成长格式时要补全日期字符串的长度，长格式转短格式时不需要这个操作
                        switch (flag) {
                        case 1:// yyyy-MM-dd转其它格式
                            switch (patternFlag) {
                            case 2:// 转yyyy-MM-dd HH
                                dateStr += " 00";
                                break;
                            case 3:// 转yyyy-MM-dd HH:mm
                                dateStr += " 00:00";
                                break;
                            case 4:// 转yyyy-MM-dd HH:mm:ss
                                dateStr += " 00:00:00";
                                break;
                            }
                            break;
                        case 2:// yyyy-MM-dd HH转其它格式
                            switch (patternFlag) {
                            case 3:// 转yyyy-MM-dd HH:mm
                                dateStr += ":00";
                                break;
                            case 4:// 转yyyy-MM-dd HH:mm:ss
                                dateStr += ":00:00";
                                break;
                            }
                            break;
                        case 3:// yyyy-MM-dd HH:mm转其它格式
                            switch (patternFlag) {
                            case 4:// 转yyyy-MM-dd HH:mm:ss
                                dateStr += ":00";
                                break;
                            }
                            break;
                        }
                    }
                } else {
                    throw new ParseException("", 0);
                }
            } else {
                // 如果日期字符串是空字符串，则返回的属性值为null，避免此种情况下反序列化报错
                return null;
            }
            return df.parse(dateStr);
        } catch (ParseException e) {
            throw new JsonParseException("日期字符串" + dateStr + "不能按格式" + df.toPattern() + "转换成Date对象");
        }
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.google.gson.JsonSerializer#serialize(java.lang.Object,
     * java.lang.reflect.Type, com.google.gson.JsonSerializationContext)
     */
    @Override
    public JsonElement serialize(Date date, Type type, JsonSerializationContext context) {
        return new JsonPrimitive(df.format(date));
    }
}