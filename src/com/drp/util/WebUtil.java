package com.drp.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.google.gson.JsonArray;

public class WebUtil {

	//Ĭ��contentType����
	private static final String contentTypeStr = "text/html;charset=gbk";
	
	
	//������ֱ��д���ͻ���
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
	

	//���ַ���д���ͻ���
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
