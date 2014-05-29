package com.drp.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class GsonTest {

	public static void main(String[] args) {
		test2();
	}
	public static void test1(){
		JsonObject jObject = new JsonObject();
		jObject.addProperty("result", "success");
		JsonArray jArray = new JsonArray();
		
		jArray.add(jObject);
		
		JsonObject jObject2 = new JsonObject();
		jObject2.addProperty("second", "yes");
		
		jArray.add(jObject);
		
		Gson gson = new Gson();
	}
	
	public static void test2(){
		JsonArray jArray  = new JsonArray();
		List<String> strList = new ArrayList<String>();
		strList.add("aaa");
		strList.add("bbb");
		
		Map map = new HashMap();
		map.put("result", "ok");
		map.put("success", "ok");
		
		//JsonObject jObject = new JsonObject(map);
		
		Gson gson = new Gson();
		System.out.println(gson.toJson(jArray));
		
	}
	
	
	
}

