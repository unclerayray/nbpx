package com.nb.nbpx.utils.deserializer;

import java.lang.reflect.Type;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.nb.nbpx.pojo.wenda.QuestionKeyword;

public class UtilQkDeserializer implements
		JsonDeserializer<com.nb.nbpx.pojo.wenda.QuestionKeyword> {

	@Override
	public QuestionKeyword deserialize(JsonElement json, Type typeOfT,
			JsonDeserializationContext context) throws JsonParseException {
		QuestionKeyword qk = null;
		if(json!=null){
			String keyword = json.getAsJsonPrimitive().getAsString();
			qk = new QuestionKeyword();
			qk.setKeyword(keyword);
		}
		return qk;
	}

}
