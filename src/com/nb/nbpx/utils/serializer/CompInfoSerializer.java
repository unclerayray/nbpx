package com.nb.nbpx.utils.serializer;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.nb.nbpx.pojo.user.CompInfo;

public class CompInfoSerializer  implements JsonSerializer<com.nb.nbpx.pojo.user.CompInfo> {

	@Override
	public JsonElement serialize(CompInfo src, Type typeOfSrc,
            JsonSerializationContext context) {
		return new JsonPrimitive(src.getCompInfoId());   
	}

}
