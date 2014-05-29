package com.drp.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ResultJsonModel {

	
	private  Map<String,Object> resultMap = null;//用于添加子对象的Map
	private List resultList = null;
	private Map<String,Object> result;
	//获取对象
	public  ResultJsonModel(){
		resultMap = new HashMap<String,Object>();
		resultList = new ArrayList();
		result = new HashMap<String,Object>();
	}
		
	
	//添加成功状态
	public  ResultJsonModel addSuccessStatus(){
		this.put(Constants.status, Constants.success);
		return this;
	}
	
	//添加失败状态
	public ResultJsonModel addErrorStatus(){
		this.put(Constants.status, Constants.fail);
		return this;
	}
	
	//添加普通类型
	public ResultJsonModel put(String key,String value){
		Map map = new HashMap();
		map.put(key, value);
		resultList.add(map);
		return this;
	}
	
	
	//添加对象
	public ResultJsonModel addObject(Object obj){
		resultList.add(obj);
		return this;
	}
	
	//add Object with specified key
	public ResultJsonModel addObject(String key,Object obj){
		Map map = new HashMap();
		map.put(key, obj);
		resultList.add(map);
		return this;
	}
	
	
	//获取完整格式的最后对象
	public Map getFullFormatResult(){
		
		String key = Constants.result_out;
		return getFullFormatResult(key);
	}
	//获取完整格式的最后对象
	public Map getFullFormatResult(String key){
		result.put(key, resultList);
		return result;
	}
	
	//添加为简单输出,需要自己制定key类型
	public Map addAsSimpleFormatResult(String key,Object obj){
		resultMap.put(key, obj);
		return resultMap;
	}
	//获取简单输出类型
	public Map getSimpleFormatResult(){
		return resultMap;
	}
	
	public static void main(String[] args) {
		ResultJsonModel m = new ResultJsonModel();
		m.addAsSimpleFormatResult("aa", "aa1");
		m.addAsSimpleFormatResult("bb", "bb");
		System.out.println(JsonUtil.toJsonStr(m));
	}
}
