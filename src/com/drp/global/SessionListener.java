package com.drp.global;

import java.io.File;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.struts2.ServletActionContext;

import com.drp.util.Constants;

public class SessionListener implements HttpSessionListener{

	public SessionListener() {
		System.out.println("----------sessionListener对象创建成功----------------");
	}
	
	public void sessionCreated(HttpSessionEvent event) {
		System.out.println("-----------------------session created--------------------------------------");
	}

	//当session失效时删除临时图片文件等其他操作
	public void sessionDestroyed(HttpSessionEvent event) {
		System.out.println("-----------------------session destoryed--------------------------------------");

		HttpSession session = event.getSession();
		String id = session.getId();
		
		String appPath = ServletActionContext.getServletContext().getRealPath("/");
		String tempFile = appPath + Constants.SESSION_TEMP_DIRECTORY +id+Constants.DEFAULT_IMG_SUFFIX;
		File file = new File(tempFile);
		file.delete();
		//Files.deleteIfExists(tempFile);
	}

}
