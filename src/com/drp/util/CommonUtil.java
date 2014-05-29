package com.drp.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.struts2.ServletActionContext;

import com.drp.domain.Agent;
import com.drp.domain.User;

public class CommonUtil {

	//计算字典最大值
	public static String computeNextValue(String currentValue){
		//如果不存在，则说明字典为空
		if("".equals(currentValue)||currentValue==null){
			return "A";
		}
		
		//如果只有一位
		if(currentValue.length()==1&&!"Z".equals(currentValue)){
			String s = (char)((byte)currentValue.charAt(0)+1) + "";
			return s;
		}else{
			//大于一位
			String prefix  = currentValue.charAt(0) + "";
			int suffix = Integer.parseInt(currentValue.substring(1, currentValue.length()))+1;
			return prefix + suffix;
		}
	}
	
	
	//将对象为空的字段设置为空字符串
	public static boolean replaceNullWithStr(Object obj) throws Exception{
		Class clazz = obj.getClass();
		List<Method> toInvokeMethod = new ArrayList<Method>();
		Method[] methods = clazz.getDeclaredMethods();
		for(int i=0;i<methods.length;i++){
			String methodName = methods[i].getName();
			
			
//			if(methodName.startsWith("set")){
//				toInvokeMethod.add(methods[i]);
//			}
			
			if("test".equals(methodName)){
				Object[] objs = {"aaa",123,55,new Date()};
				methods[i].invoke(obj, objs);
				Class<?>[] aa = methods[i].getParameterTypes();
				for(int j=0;j<aa.length;j++){
					System.out.println();
					//这里接下来要根据参数的Class验证参数类型
				}
			}
		}
		
		
//		Field [] fields = clazz.getDeclaredFields();
//		for(int i=0;i<fields.length;i++){
//			System.out.println(fields[i].getName());
//		}
		return true;
	}
	
	public static Object getDefaultValByType(Class c){
		String className = c.getName();
		Object obj = null;
		try {
			obj = c.newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}

		if("java.lang.String".equals(className)){
			return "";
		}else if("java.lang.Integer".equals(className)||"int".equals(className)){
			return 0;
		}else if(obj instanceof Date){
			return new MyDate();
		}else if("java.lang.Float".equals(className)||"float".equals(className)){
			return 0.0f;
		}else if("java.lang.Double".equals(className)||"double".equals(className)){
			return 0.0;
		}else if("java.lang.Boolean".equals(className)||"boolean".equals(className)){
			return false;
		}
		return "";
	}
	
	
	//获取为空的字段
	public static void setNullPropertyWithDefaultVal(Object obj)throws Exception{
		Class clazz = obj.getClass();
		Method[] m = clazz.getDeclaredMethods();
		Map<String,Method> getMethodMap = new HashMap<String,Method>();
		Map<String,Method> setMethodMap = new HashMap<String,Method>();
		for(int i=0;i<m.length;i++){
			String methodName = m[i].getName();
			if(methodName.startsWith("get")){
				getMethodMap.put(m[i].getName(), m[i]);
			}else if(methodName.startsWith("set")){
				setMethodMap.put(m[i].getName(), m[i]);
			}
		}
		
		Field [] fields = clazz.getDeclaredFields();
		
		for(int i=0;i<fields.length;i++){
			String fName = fields[i].getName();
			String name = "get"+fName.substring(0, 1).toUpperCase()+fName.substring(1, fName.length());
			String name2 = "set"+fName.substring(0,1).toUpperCase() + fName.substring(1,fName.length());
			Method getMethod = getMethodMap.get(name);
			//获得了get的方法
			Object oo = getMethod.invoke(obj, null);
			if(null == oo){
				System.out.println("this property is null");
			//	Object value = getDefaultValByType(fields[i].getClass());
				Method setMethod = setMethodMap.get(name2);
				Class parameterType = setMethod.getParameterTypes()[0];
				Object value = getDefaultValByType(parameterType);
				setMethod.invoke(obj, value);
			}
			//int float,等有默认值
		}
		

		Set<String> keySet = getMethodMap.keySet();

		Iterator iter = keySet.iterator();
		for(;iter.hasNext();){
			Method a = getMethodMap.get(iter.next());
			System.out.println(a.invoke(obj, null));
		}
	}
	
	public static void main(String[] args) throws Throwable{
		class A {
			String a1 ;
			String a2;
			int b1;
			public String getA1() {
				return a1;
			}
			public void setA1(String a1) {
				this.a1 = a1;
			}
			public String getA2() {
				return a2;
			}
			public void setA2(String a2) {
				this.a2 = a2;
			}
			public int getB1() {
				return b1;
			}
			public void setB1(int b1) {
				this.b1 = b1;
			}
		}
		A a = new A();
		System.out.println(JsonUtil.toJsonStr(a));
		setNullPropertyWithDefaultVal(a);
		System.out.println(JsonUtil.toJsonStr(a));
	}
	
	
	//获取字符串形式的当前时间
	public static String getCurrentDateStr(){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String str = sdf.format(date);
		return str;
	}

	//产生编号
	public static  String getRandomNo(){
		StringBuilder sb = new StringBuilder();
		sb.append(RandomStringUtils.randomAlphanumeric(10));
		String str = String.valueOf(Calendar.getInstance().getTimeInMillis());
		String timeStr = str.substring(5,str.length());
		sb.append(timeStr);
		return sb.toString();
	}
	
	//获取当前session的用户的Agent
	public static Agent getCurrentAgent(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		return (Agent)session.getAttribute(Constants.AGENT);
	}
	
	public static User getCurrentUser(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		return (User)session.getAttribute(Constants.USER);
	}
	
	//获取年月日
	public static String getYearMonthDay(){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(date);
		return str;
	}
	
	//获取中文月份
	public static String getChineseMonthStr(int i){
		return Constants.chineseMonthStrMap.get(i);
	}
	
	//md5加密
	//加密
	public static String md5Encode(String password)throws Exception{
		StringBuilder sb = new StringBuilder();
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("MD5");
	//		String str = "施凯文";
			byte[] bytes = password.getBytes("utf-8");
			messageDigest.update(bytes);
			byte[] result = messageDigest.digest();
			for(int i=0;i<result.length;i++){
				int val = result[i]&0xff;
				if(val<16) sb.append("0");
				sb.append(Integer.toHexString(val));
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
}
