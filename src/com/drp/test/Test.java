package com.drp.test;

import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Test {

	public static void main(String[] args) throws Exception{
		//testFloat();
		//test2();
	//	System.out.println("fcb0631c419d1e6abd84641e8a1e8232".length());
		md5Test();
	}
	
	public static void md5Test()throws Exception{
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("MD5");
			String str = "Ê©¿­ÎÄ";
			byte[] bytes = str.getBytes("utf-8");
			messageDigest.update(bytes);
			byte[] result = messageDigest.digest();
			StringBuilder sb = new StringBuilder();
			for(int i=0;i<result.length;i++){
				int val = result[i]&0xff;
				if(val<16) sb.append("0");
				sb.append(Integer.toHexString(val));
			}
				
			System.out.println(sb.toString());
	//		BASE64Encoder  encoder = new BASE64Encoder();
	//		new sun.misc.BASE64Encoder();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
	}
	
	public static void test2()throws Exception {
		OutputStreamWriter writer = new OutputStreamWriter(new FileOutputStream("f:\\test.txt"));
		String s = null;
		writer.write(s);
		writer.flush();
		//writer.write(arg0)
	}
	
	public static void testFloat(){
		
		int i = 9;
		System.out.println(i);
		System.out.println((float)9);
	}
}
