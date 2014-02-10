package com.nb.nbpx.utils.serializer;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.nb.nbpx.pojo.zixun.DownloadSubject;

public class DownloadSubjectSerializer  implements JsonSerializer<com.nb.nbpx.pojo.zixun.DownloadSubject> {

	@Override
	public JsonElement serialize(DownloadSubject src, Type typeOfSrc,   
            JsonSerializationContext context) {
		return new JsonPrimitive(src.getSubject());   
	}

}
