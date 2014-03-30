package com.nb.nbpx.utils.deserializer;

import java.lang.reflect.Type;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.nb.nbpx.pojo.wenda.QuestionSubject;

public class UtilDsDeserializer implements
		JsonDeserializer<com.nb.nbpx.pojo.wenda.QuestionSubject> {

	@Override
	public QuestionSubject deserialize(JsonElement json, Type typeOfT,
			JsonDeserializationContext context) throws JsonParseException {
		QuestionSubject qs = null;
		if(json!=null){
			String subject = json.getAsJsonPrimitive().getAsString();
			qs = new QuestionSubject();
			qs.setSubject(subject);
		}
		return qs;
	}

}
