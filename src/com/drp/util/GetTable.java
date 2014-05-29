package com.drp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class GetTable {

	public static Connection getMySqlConnection(){
		Connection conn = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			 conn = DriverManager.getConnection("jdbc:mysql://10.90.87.15/k_test", "root","123456");
			 
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void main(String[] args) {
		System.out.println(getMySqlConnection());
		System.out.println(getOracleConnection());
	}
	public static void main2(String[] args) {
		try{
			execute();
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public static Connection getOracleConnection(){
		Connection conn = null;
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			 conn = DriverManager.getConnection("jdbc:oracle:thin:@10.90.87.15:1521:orcl", "stltqhs","123456");
			 
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}
	
	static String [] selectSqlArray = {"select * from t_province","select * from t_city","select * from t_area"};
	static String [] insertSqlArray = {"insert into t_province values(?,?,?)","insert into t_city values(?,?,?,?)","insert into t_area values(?,?,?,?)"};
	
	static int processIndex;
	
	public static void execute() throws Exception{
		Connection conn = getMySqlConnection();
		for(int i=0;i<selectSqlArray.length;i++){
		processIndex = i;
		
		String sql = selectSqlArray[i];
		Statement stmt = conn.createStatement();
		ResultSet rs = null;
		rs = stmt.executeQuery(sql);
		
		List<DataModel> dataModelList = new ArrayList<DataModel>();
		while(rs.next()){
			
			DataModel dm = new DataModel();
			dm.setId(rs.getInt(1));
			dm.setAreaId(rs.getInt(2));
			dm.setAreaName(rs.getString(3));
			if(processIndex!=0){
				dm.setPid(rs.getInt(4));
			}
			dataModelList.add(dm);
		}
		
	
		insertIntoOracle(dataModelList,insertSqlArray[i]);
		}
		
	}
	
	public static void insertIntoOracle(List<DataModel> dataModelList,String sql)throws Exception{
		Connection conn = getOracleConnection();
		String provinceSql = sql;
		
		PreparedStatement pstmt = conn.prepareStatement(provinceSql);
		
		for(int i=0;i<dataModelList.size();i++){
			DataModel dm = dataModelList.get(i);
			pstmt.setInt(1, dm.getId());
			pstmt.setInt(2, dm.getAreaId());
			pstmt.setString(3, dm.getAreaName());
			if(processIndex != 0){
				pstmt.setInt(4, dm.getPid());
			}
			pstmt.addBatch();
		}
		
		pstmt.executeBatch();
	}
}


class DataModel {
	private int id;
	private int areaId;
	private String areaName;
	
	private int pid;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAreaId() {
		return areaId;
	}
	public void setAreaId(int areaId) {
		this.areaId = areaId;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}

	
	
}
