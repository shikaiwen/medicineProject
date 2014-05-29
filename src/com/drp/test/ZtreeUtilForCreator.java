package com.drp.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


public class ZtreeUtilForCreator {

	
	public static void main(String[] args) {
		
		
	}
	
	public static void test1(){
		
	}
	
	
	
	
	public static Connection getConnection(){
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
				System.out.println("exist");
				conn = DriverManager.getConnection("jdbc:oracle:thin:1521:orcl", "drp", "drp");
				stmt = conn.createStatement();
				rs = stmt.executeQuery("select * from t_user");
				System.out.println(conn);
				return conn;
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}

}
