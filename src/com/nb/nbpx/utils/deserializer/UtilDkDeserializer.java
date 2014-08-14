package com.nb.nbpx.utils.deserializer;

import java.lang.reflect.Type;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.nb.nbpx.pojo.zixun.DownloadKeyword;

public class UtilDkDeserializer implements
		JsonDeserializer<com.nb.nbpx.pojo.zixun.DownloadKeyword> {

	@Override
	public DownloadKeyword deserialize(JsonElement json, Type typeOfT,
			JsonDeserializationContext context) throws JsonParseException {
		DownloadKeyword dk = null;
		if(json!=null){
			String keyword = json.getAsJsonPrimitive().getAsString();
			dk = new DownloadKeyword();
			dk.setKeyword(keyword);
		}
		return dk;
	}

}