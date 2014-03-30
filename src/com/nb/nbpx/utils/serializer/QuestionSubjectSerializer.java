package com.nb.nbpx.utils.serializer;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.nb.nbpx.pojo.wenda.QuestionSubject;

public class QuestionSubjectSerializer  implements JsonSerializer<com.nb.nbpx.pojo.wenda.QuestionSubject> {

	@Override
	public JsonElement serialize(QuestionSubject src, Type typeOfSrc,   
            JsonSerializationContext context) {
		return new JsonPrimitive(src.getSubject());   
	}

}
