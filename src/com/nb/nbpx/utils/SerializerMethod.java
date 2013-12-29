package com.nb.nbpx.utils;

import java.lang.reflect.Type;
import java.text.DateFormat;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.nb.nbpx.utils.deserializer.UtilDateDeserializer;
import com.nb.nbpx.utils.serializer.UtilDateSerializer;
import com.nb.nbpx.utils.serializer.UtilDkSerializer;
import com.nb.nbpx.utils.serializer.UtilDsSerializer;

/**
 * <p>
 * 序列化方法
 * </p>
 * 创建时间：2013-4-9 22:31:05
 * 
 * @author leilichao
 * @version V1.0
 */
public class SerializerMethod {

	/**
	 * 序列化方法
	 */
	public static String bean2json(Object bean, Type type, String format) {

		GsonBuilder gb = new GsonBuilder().registerTypeAdapter(
				java.util.Date.class, new UtilDateSerializer()).setDateFormat(
				format);
		gb.registerTypeAdapter(com.nb.nbpx.pojo.zixun.DownloadKeyword.class, new UtilDkSerializer());
		gb.registerTypeAdapter(com.nb.nbpx.pojo.zixun.DownloadSubject.class, new UtilDsSerializer());
		Gson gson = gb.create();
		return gson.toJson(bean);
	}

	/**
	 * 反序列化方法
	 */

	@SuppressWarnings("unchecked")
	public static <T> T json2bean(String json, Type type) {
		Gson gson = new GsonBuilder()
				.registerTypeAdapter(java.util.Date.class,
						new UtilDateDeserializer())
				.setDateFormat(DateFormat.LONG).create();
		return (T) gson.fromJson(json, type);
	}

}
