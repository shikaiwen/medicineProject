package com.drp.util;

import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

public class JsonUtil {

	private static Gson gson  = new Gson();
	static Gson gson2 = new GsonBuilder().registerTypeAdapter(Date.class,new DateTypeAdapter()).setDateFormat("yyyy-MM-dd HH:mm:ss").create();
	
	
	public static String toJsonStr(Object obj){
		return gson2.toJson(obj);
	}
	
	
	public static void main(String[] args) {
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String jsonString = gson.toJson(new Date(System.currentTimeMillis()),Date.class);
		System.out.println(jsonString);
	}
	
	
	public static Gson getGson() {
		return gson;
	}

	public static void setGson(Gson gson) {
		JsonUtil.gson = gson;
	}
}


class DateTypeAdapter implements JsonSerializer<Date>,JsonDeserializer<Date>{

	
	 private final DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	@Override
	public Date deserialize(JsonElement json, Type arg1,
			JsonDeserializationContext arg2) throws JsonParseException {
        if (!(json instanceof JsonPrimitive)) {  
            throw new JsonParseException("The date should be a string value");  
        }  
  
        try {  
            Date date = format.parse(json.getAsString());  
            return new Date(date.getTime());  
        } catch (ParseException e) {  
            throw new JsonParseException(e);  
        }  
	}

	@Override
	public JsonElement serialize(Date src, Type arg1,
			JsonSerializationContext arg2) {
	       String dateFormatAsString = format.format(new Date(src.getTime()));  
	        return new JsonPrimitive(dateFormatAsString);  
	}
	
}
