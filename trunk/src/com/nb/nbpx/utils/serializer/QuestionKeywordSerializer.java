package com.nb.nbpx.utils.serializer;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.nb.nbpx.pojo.wenda.QuestionKeyword;

public class QuestionKeywordSerializer  implements JsonSerializer<com.nb.nbpx.pojo.wenda.QuestionKeyword> {

	@Override
	public JsonElement serialize(QuestionKeyword src, Type typeOfSrc,   
            JsonSerializationContext context) {
		return new JsonPrimitive(src.getKeyword());   
	}

}
