/**
 * Json转换工具
 */
package com.nb.nbpx.utils;

import java.io.IOException;
import java.io.StringWriter;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.ObjectMapper;


/**
 * 
 * <p>
 * 将数据转换成json字符串的工具类
 * </p>
 * 创建时间：2013-4-9 22:09:26
 * 
 * @author leilichao
 * @version V1.0
 */
public class JsonUtil {

    /**
     * 将List和参数封装成JSON对象
     * 
     * @param total
     *            记录总数
     * @param state
     *            状态
     * @param message
     *            提示信息
     * @param tempList
     *            list对象
     * @return
     */
    @SuppressWarnings("rawtypes")
	public static String formatToJson(Integer total, boolean success,
            String message, List tempList) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("success", success);
        jsonObject.put("message", message);
        if (tempList != null && tempList.size() > 0) {
            java.lang.reflect.Type type = new com.google.gson.reflect.TypeToken<List>() {
            }.getType();

            String json = SerializerMethod.bean2json(tempList, type,
                    "yyyy-MM-dd");
            jsonObject.put("rows", json);
            jsonObject.put("total", total);
        }
        return jsonObject.toString();
    }

    /**
     * 返回带状态和消息的JSON
     * 
     * @param state
     *            状态
     * @param message
     *            消息
     * @return
     */
    public static String formatToJson(boolean success, String message) {

        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        jsonObject.put("success", success);
        jsonObject.put("message", message);
        jsonArray.add(jsonObject);
        JSONObject json = new JSONObject();
        json.put("rows", jsonArray);

        return json.toString();
    }
    

    /**
     * 返回带状态和消息的JSON
     * 
     * @param state
     *            状态
     * @param message
     *            消息
     * @return
     */
    public static String formatToSuccessJson(boolean success, String message) {

        JSONObject json = new JSONObject();
        json.put("success", success);
        json.put("message", message);

        return json.toString();
    }
    
    /**
     * 返回带状态和消息的JSON
     * 
     * @param state
     *            状态
     * @param message
     *            消息
     * @return
     */
    public static String formatToOpResJson(boolean success, String message) {

        JSONObject json = new JSONObject();
        json.put("success", success);
        json.put("message", message);

        return json.toString();
    }
    
    /**
     * 将List和用于分页的总记录数封装成JSON对象(注意:javaBean中必须要用一个total变量,并且调用这方法list.get(0
     * ).setTotalCount(总记录数);)
     * 
     * @author huangjinfang
     * @param total
     *            记录总数
     * @param tempList
     *            list对象
     * @return
     */
    @SuppressWarnings("rawtypes")
	public static String formatToJsonWithTotalCount(Integer total,
            List list) {
        JSONObject jsonObject = new JSONObject();
        if (list != null && list.size() > 0) {
            java.lang.reflect.Type type = new com.google.gson.reflect.TypeToken<List>() {
            }.getType();
            String json = SerializerMethod.bean2json(list, type,
                    "yyyy-MM-dd");
            jsonObject.put("rows", json);
            jsonObject.put("total", total);
            return jsonObject.toString();
        }else{
            return "{'total':0,'rows':[]}";
        }
    }

    /**
     * 将List转换为一个json字符串，不包括头，只含数据
     * 
     * @param tempList
     * @return
     */
    @SuppressWarnings({ "rawtypes"})
	public static String formatListToJson(List tempList) {
        String json = null;
        if (tempList != null && tempList.size() > 0) {
            java.lang.reflect.Type type = new com.google.gson.reflect.TypeToken<List>() {
            }.getType();
            json = SerializerMethod.bean2json(tempList, type, "yyyy-MM-dd");
        }
        return json;
    }

    /**
     * 将字典中的每一类合成一个json总的字符串
     * 
     * @param head
     * @param json
     * @param total
     * @param state
     * @param message
     * @return
     */
    public static String formatDictionaryListToJson(String[] head,
            String[] json, Integer total, boolean success, String message) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("success", success);
        jsonObject.put("message", message);
        jsonObject.put("total", total);
        for (int i = 0; i < head.length; i++) {
            jsonObject.put(head[i], json[i]);
        }
        return jsonObject.toString();
    }
    /**
     * 将List和参数封装成JSON对象(如果有Date\TimeStamp类型的，默认带上时分秒)
     * 
     * @param total
     *            记录总数
     * @param state
     *            状态
     * @param message
     *            提示信息
     * @param tempList
     *            list对象
     * @return
     */
    @SuppressWarnings("rawtypes")
	public static String formatToJsonWithTimeStamp(Integer total, boolean success,
            String message, List tempList) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("success", success);
        jsonObject.put("message", message);
        if (tempList != null && tempList.size() > 0) {
            java.lang.reflect.Type type = new com.google.gson.reflect.TypeToken<List>() {
            }.getType();

            String json = SerializerMethod.bean2json(tempList, type,
                    "yyyy-MM-dd hh:mm:ss");
            jsonObject.put("rows", json);
            jsonObject.put("total", total);
            return jsonObject.toString();
        }else{
            return "{'success':false,'message':'','total':0,'rows':[]}";
        }
    }
    /**
     * 将一个对象，写成json格式字符串
     * @param o
     * @return[{
			"id":1,
			"text":"Java"
			}
			]
     */
    public static String getJsonString(Object o) {
		ObjectMapper om = new ObjectMapper();
		StringWriter sw = new StringWriter();
		try {
			JsonGenerator jg = new JsonFactory().createJsonGenerator(sw);
			om.writeValue(jg, o);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sw.toString();
	}
    /**
     * 返回带状态和消息的JSON
     * 
     * @param state
     *            状态
     * @param message
     *            消息
     * @return
     */
    public static String format2Json(boolean success, String message) {

        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        jsonObject.put("success", success);
        jsonObject.put("message", message);
        jsonArray.add(jsonObject);
        return jsonObject.toString();
    }
}