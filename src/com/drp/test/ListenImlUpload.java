package com.drp.test;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class ListenImlUpload {

	public static void main(String[]args){
		listen();
	}
	
	public static byte[] buff = new byte[200];
	                                     
	public static void listen(){
		try{
			ServerSocket ss = new ServerSocket(20000);
			while(true){
				Socket s = ss.accept();
				InputStream is = s.getInputStream();
				FileOutputStream fos = new FileOutputStream("h://uploadImg.png");
				int b = 0;
				while(true){
					if(b == -1){
						fos.close();break;
					}
					fos.write(buff, 0,b);
				}
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
}
