/**
 * Json转换工具
 */
package com.nb.nbpx.utils;

import java.io.IOException;
import java.io.StringWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
@SuppressWarnings({ "rawtypes" })
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
		}else{
			jsonObject.put("rows", "[]");
			jsonObject.put("total", 0);
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

	public static String formatToOpResJsonWithParam(boolean success,
			String message, Map<String, String> map) {
		JSONObject json = new JSONObject();
		json.put("success", success);
		json.put("message", message);
		Iterator iter = map.entrySet().iterator();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			Object key = entry.getKey();
			Object val = entry.getValue();
			json.put(key.toString(), val.toString());
		}

		return json.toString();
	}

	/**
	 * 将List和用于分页的总记录数封装成JSON对象(注意:javaBean中必须要用一个total变量,并且调用这方法list.get(0
	 * ).setTotalCount(总记录数);)
	 * 
	 * @param total
	 *            记录总数
	 * @param tempList
	 *            list对象
	 * @return
	 */
	public static String formatToJsonWithTotalCount(Integer total, List list) {
		JSONObject jsonObject = new JSONObject();
		if (list != null && list.size() > 0) {
			java.lang.reflect.Type type = new com.google.gson.reflect.TypeToken<List>() {
			}.getType();
			String json = SerializerMethod.bean2json(list, type, "yyyy-MM-dd");
			jsonObject.put("rows", json);
			jsonObject.put("total", total);
			return jsonObject.toString();
		} else {
			return "{\"total\":0,\"rows\":[]}";
		}
	}

	/**
	 * 将List转换为一个json字符串，不包括头，只含数据
	 * 
	 * @param tempList
	 * @return
	 */
	
	public static String formatListToJson(List tempList) {
		String json = "";
		if (tempList != null && tempList.size() > 0) {
			java.lang.reflect.Type type = new com.google.gson.reflect.TypeToken<List>() {
			}.getType();
			json = SerializerMethod.bean2json(tempList, type, "yyyy-MM-dd");
		} else {
			return "[]";
		}
		return json;
	}
	
	public static String formatMapToJson(Map map){
		JSONObject json = new JSONObject();
		Iterator iter = map.entrySet().iterator();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			Object key = entry.getKey();
			Object val = entry.getValue();
			json.put(key.toString(), val.toString());
		}

		return json.toString();
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
	public static String formatToJsonWithTimeStamp(Integer total,
			boolean success, String message, List tempList) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("success", success);
		jsonObject.put("message", message);
		if (tempList != null && tempList.size() > 0) {
			java.lang.reflect.Type type = new com.google.gson.reflect.TypeToken<List>() {
			}.getType();

			String json = SerializerMethod.bean2json(tempList, type,
					"yyyy-MM-dd HH:mm:ss");
			jsonObject.put("rows", json);
			jsonObject.put("total", total);
			return jsonObject.toString();
		} else {
			return "{\"success\":true,\"message\":\"\",\"total\":0,\"rows\":[]}";
		}
	}
	/**
	 * 将List和参数封装成JSON对象(如果有Date\TimeStamp类型的，默认不带上时分秒)
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
	public static String formatToJsonWithNoTimeStamp(Integer total,
			boolean success, String message, List tempList) {
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
			return jsonObject.toString();
		} else {
			return "{\"success\":true,\"message\":\"\",\"total\":0,\"rows\":[]}";
		}
	}
	/**
	 * 将List和参数封装成JSON对象(如果有Date\TimeStamp类型的，默认不带上时分秒) User 专用
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
	public static String formatToJsonWithNoTimeStamp4User(Integer total,
			boolean success, String message, List tempList) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("success", success);
		jsonObject.put("message", message);
		if (tempList != null && tempList.size() > 0) {
			java.lang.reflect.Type type = new com.google.gson.reflect.TypeToken<List>() {
			}.getType();

			String json = SerializerMethod.bean2json4User(tempList, type,
					"yyyy-MM-dd");
			jsonObject.put("rows", json);
			jsonObject.put("total", total);
			return jsonObject.toString();
		} else {
			return "{\"success\":true,\"message\":\"\",\"total\":0,\"rows\":[]}";
		}
	}

	/**
	 * 将一个对象，写成json格式字符串 含日期但日期也需要有时间的
	 * 
	 * @param o
	 * @return[{ "id":1, "text":"Java" } ]
	 */
	public static String getJsonString(Object o) {
		ObjectMapper om = new ObjectMapper();
		StringWriter sw = new StringWriter();
		DateFormat myDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		om.setDateFormat(myDateFormat);
		try {
			JsonGenerator jg = new JsonFactory().createJsonGenerator(sw);
			om.writeValue(jg, o);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sw.toString();
	}

	/**
	 * 将一个对象，写成json格式字符串 含日期但日期不包括时间的
	 * 
	 * @param o
	 * @return[{ "id":1, "text":"Java" } ]
	 */
	public static String getJsonStringWithTime(Object objectWithDateAndTime) {
		ObjectMapper om = new ObjectMapper();
		StringWriter sw = new StringWriter();
		DateFormat myDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		om.setDateFormat(myDateFormat);
		try {
			JsonGenerator jg = new JsonFactory().createJsonGenerator(sw);
			om.writeValue(jg, objectWithDateAndTime);
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