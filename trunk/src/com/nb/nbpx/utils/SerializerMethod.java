package com.nb.nbpx.utils;

import java.lang.reflect.Type;
import java.text.DateFormat;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.nb.nbpx.utils.deserializer.UtilDateDeserializer;
import com.nb.nbpx.utils.serializer.DateSerializer;
import com.nb.nbpx.utils.serializer.DownloadKeywordSerializer;
import com.nb.nbpx.utils.serializer.DownloadSubjectSerializer;
import com.nb.nbpx.utils.serializer.FollowUpSerializer;
import com.nb.nbpx.utils.serializer.LiveImageSerializer;
import com.nb.nbpx.utils.serializer.QuestionKeywordSerializer;
import com.nb.nbpx.utils.serializer.QuestionSubjectSerializer;
import com.nb.nbpx.utils.serializer.UserSerializer;

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
				java.util.Date.class, new DateSerializer()).setDateFormat(
				format);
		gb.registerTypeAdapter(com.nb.nbpx.pojo.zixun.DownloadKeyword.class, new DownloadKeywordSerializer());
		gb.registerTypeAdapter(com.nb.nbpx.pojo.zixun.DownloadSubject.class, new DownloadSubjectSerializer());
		gb.registerTypeAdapter(com.nb.nbpx.pojo.wenda.QuestionKeyword.class, new QuestionKeywordSerializer());
		gb.registerTypeAdapter(com.nb.nbpx.pojo.wenda.QuestionSubject.class, new QuestionSubjectSerializer());
		gb.registerTypeAdapter(com.nb.nbpx.pojo.zixun.LiveImage.class, new LiveImageSerializer());
		//gb.registerTypeAdapter(com.nb.nbpx.pojo.user.CompInfo.class, new CompInfoSerializer());
		gb.registerTypeAdapter(com.nb.nbpx.pojo.user.User.class, new UserSerializer());
		gb.registerTypeAdapter(com.nb.nbpx.pojo.course.FollowUp.class, new FollowUpSerializer());
		gb.enableComplexMapKeySerialization();
		Gson gson = gb.create();
		return gson.toJson(bean);
	}
	
	/**
	 * 序列化方法，用于给有
	 */
	public static String bean2json4User(Object bean, Type type, String format) {

		GsonBuilder gb = new GsonBuilder().registerTypeAdapter(
				java.util.Date.class, new DateSerializer()).setDateFormat(
				format);
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
