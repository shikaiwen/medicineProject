package com.drp.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ResultJsonModel {

	
	private  Map<String,Object> resultMap = null;//��������Ӷ����Map
	private List resultList = null;
	private Map<String,Object> result;
	//��ȡ����
	public  ResultJsonModel(){
		resultMap = new HashMap<String,Object>();
		resultList = new ArrayList();
		result = new HashMap<String,Object>();
	}
		
	
	//��ӳɹ�״̬
	public  ResultJsonModel addSuccessStatus(){
		this.put(Constants.status, Constants.success);
		return this;
	}
	
	//���ʧ��״̬
	public ResultJsonModel addErrorStatus(){
		this.put(Constants.status, Constants.fail);
		return this;
	}
	
	//�����ͨ����
	public ResultJsonModel put(String key,String value){
		Map map = new HashMap();
		map.put(key, value);
		resultList.add(map);
		return this;
	}
	
	
	//��Ӷ���
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
	
	
	//��ȡ������ʽ��������
	public Map getFullFormatResult(){
		
		String key = Constants.result_out;
		return getFullFormatResult(key);
	}
	//��ȡ������ʽ��������
	public Map getFullFormatResult(String key){
		result.put(key, resultList);
		return result;
	}
	
	//���Ϊ�����,��Ҫ�Լ��ƶ�key����
	public Map addAsSimpleFormatResult(String key,Object obj){
		resultMap.put(key, obj);
		return resultMap;
	}
	//��ȡ���������
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
