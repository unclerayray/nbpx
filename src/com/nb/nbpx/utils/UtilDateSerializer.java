package com.nb.nbpx.utils;
/**
 * <p>Date类型转换(bean2json)/p>
 * 创建时间：2011-11-14 下午05:34:06 
 * @author chenxiaoqiang
 * @version V1.0
 */
import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

public class UtilDateSerializer implements JsonSerializer<java.util.Date> {

    @Override
    public JsonElement serialize(java.util.Date src, Type typeOfSrc,   
            JsonSerializationContext context) {   
        return new JsonPrimitive(src.getTime());   
    }   


}
