package com.nb.nbpx.utils.deserializer;

import java.lang.reflect.Type;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.nb.nbpx.pojo.zixun.LiveImage;

public class UtilLIDeserializer implements
		JsonDeserializer<com.nb.nbpx.pojo.zixun.LiveImage> {

	@Override
	public LiveImage deserialize(JsonElement json, Type typeOfT,
			JsonDeserializationContext context) throws JsonParseException {
		LiveImage li = null;
		if(json!=null){
			String url = json.getAsJsonPrimitive().getAsString();
			li = new LiveImage();
			li.setUrl(url);
		}
		return li;
	}

}
