package com.nb.nbpx.utils.deserializer;

import java.lang.reflect.Type;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.nb.nbpx.pojo.zixun.DownloadSubject;

public class UtilQsDeserializer implements
		JsonDeserializer<com.nb.nbpx.pojo.zixun.DownloadSubject> {

	@Override
	public DownloadSubject deserialize(JsonElement json, Type typeOfT,
			JsonDeserializationContext context) throws JsonParseException {
		DownloadSubject dk = null;
		if(json!=null){
			String subject = json.getAsJsonPrimitive().getAsString();
			dk = new DownloadSubject();
			dk.setSubject(subject);
		}
		return dk;
	}

}
