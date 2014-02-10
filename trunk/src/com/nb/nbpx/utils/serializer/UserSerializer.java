package com.nb.nbpx.utils.serializer;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

public class UserSerializer  implements JsonSerializer<com.nb.nbpx.pojo.user.User> {


	@Override
	public JsonElement serialize(com.nb.nbpx.pojo.user.User src, Type typeOfSrc,
			JsonSerializationContext context) {
//		GsonBuilder gb = new GsonBuilder().registerTypeAdapter(
//				java.util.Date.class, new DateSerializer()).setDateFormat(
//				"yyyy-MM-dd");
//		gb.registerTypeAdapter(com.nb.nbpx.pojo.zixun.DownloadKeyword.class, new DownloadKeywordSerializer());
//		gb.registerTypeAdapter(com.nb.nbpx.pojo.zixun.DownloadSubject.class, new DownloadSubjectSerializer());
//		gb.registerTypeAdapter(com.nb.nbpx.pojo.zixun.LiveImage.class, new LiveImageSerializer());
//		//gb.registerTypeAdapter(com.nb.nbpx.pojo.user.CompInfo.class, new CompInfoSerializer());
//		gb.registerTypeAdapter(com.nb.nbpx.pojo.user.User.class, new UserSerializer());
//		Gson gson = gb.create();
//		String beanStr = gson.toJson(src);
//		StringBuffer sb = new StringBuffer("{\"username\":\"");
//		sb.append(src.getUserName());
//		sb.append("\",\"email\":\"");
//		sb.append(src.getEmail());
//		sb.append("\"}");
		JsonObject object = new JsonObject();
        String name = src.getUserName();
        object.addProperty("username", name);
        String email = src.getEmail();
        object.addProperty("email", email);
        // we create the json object for the dog and send it back to the
        // Gson serializer
        return object;
	}

}
