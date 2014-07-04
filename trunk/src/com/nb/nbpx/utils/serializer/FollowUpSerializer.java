package com.nb.nbpx.utils.serializer;

import java.lang.reflect.Type;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.nb.nbpx.pojo.course.FollowUp;

public class FollowUpSerializer  implements JsonSerializer<com.nb.nbpx.pojo.course.FollowUp>  {

	@Override
	public JsonElement serialize(FollowUp followup, Type arg1,
			JsonSerializationContext arg2) {
		//Gson gson = new Gson();
		 
		// convert java object to JSON format,
		// and returned as JSON formatted string
		//String json = gson.toJson(arg0);
		GsonBuilder gb = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().registerTypeAdapter(
				java.util.Date.class, new DateSerializer()).setDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		Gson gson = gb.create();
		//String json =  gson.toJson(followup);
		JsonElement je = gson.toJsonTree(followup);
		return je;
	}

}
