package com.drp.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.google.gson.JsonArray;

public class WebUtil {

	//默认contentType类型
	private static final String contentTypeStr = "text/html;charset=gbk";
	
	
	//将数据直接写到客户端
	public static void writeJsonToClient(Object object){
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(contentTypeStr);
		PrintWriter out = null;
		try{
			out = response.getWriter();
			out.write(JsonUtil.toJsonStr(object));
			out.flush();
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	

	//将字符串写到客户端
	public static void WriteStrToClient(String str){
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constants.ContentType_TEXT_HTML_GBK);
		if(null == str) str="";
		try{
			PrintWriter out = response.getWriter();
			out.write(str);
			out.flush();
		}catch(Exception e){
			e.printStackTrace();
		}

		
	}
	
	
}
