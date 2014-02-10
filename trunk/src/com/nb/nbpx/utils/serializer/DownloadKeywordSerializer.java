package com.nb.nbpx.utils.serializer;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.nb.nbpx.pojo.zixun.DownloadKeyword;

public class DownloadKeywordSerializer  implements JsonSerializer<com.nb.nbpx.pojo.zixun.DownloadKeyword> {

	@Override
	public JsonElement serialize(DownloadKeyword src, Type typeOfSrc,   
            JsonSerializationContext context) {
		return new JsonPrimitive(src.getKeyword());   
	}

}
