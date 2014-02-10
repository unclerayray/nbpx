package com.nb.nbpx.utils.serializer;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.nb.nbpx.pojo.zixun.LiveImage;

public class LiveImageSerializer  implements JsonSerializer<com.nb.nbpx.pojo.zixun.LiveImage> {

	@Override
	public JsonElement serialize(LiveImage src, Type typeOfSrc,   
            JsonSerializationContext context) {
		return new JsonPrimitive(src.getUrl());   
	}

}
