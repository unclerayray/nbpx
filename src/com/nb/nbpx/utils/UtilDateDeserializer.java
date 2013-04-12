package com.nb.nbpx.utils;
/**
 * <p>Data类型转换(josn2bean)</p>
 * 创建时间：2011-11-14 下午05:12:07 
 * @author chenxiaoqiang
 * @version V1.0
 */
import java.lang.reflect.Type;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;

public class UtilDateDeserializer implements JsonDeserializer<java.util.Date> {

    @Override
    public java.util.Date deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
            throws JsonParseException {
        SimpleDateFormat format= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date dd=null;
        try {
            dd=format.parse(json.getAsJsonPrimitive().getAsString());
        } catch (ParseException e) {
            dd = null;
        }
        if (dd == null) {
            format = new SimpleDateFormat("yyyy-MM-dd");
            try {
               dd = format.parse(json.getAsJsonPrimitive().getAsString());
            } catch (ParseException e) {
               dd = null;
            }
        }
        return dd;
    }
}