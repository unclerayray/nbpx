package com.nb.nbpx.utils.deserializer;

import java.lang.reflect.Type;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.nb.nbpx.pojo.course.FollowUp;

public class UtilFollowUpDeserializer  implements
JsonDeserializer<com.nb.nbpx.pojo.course.FollowUp> {

	@Override
	public FollowUp deserialize(JsonElement arg0, Type arg1,
			JsonDeserializationContext arg2) throws JsonParseException {
		FollowUp followup = null;
		if(arg0!=null){
			String followupa = arg0.getAsJsonPrimitive().getAsString();
			followup = new FollowUp();
			followup.setFollowup(followupa);
		}
		return followup;
	}

}
