package com.drp.util;


import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.mybatis.spring.transaction.SpringManagedTransaction;

public class DBUtil {

	public static void main(String[] args) throws Exception {
		DBUtil d = new DBUtil();
		SpringManagedTransaction smt = null;
		
		
	}
	
	public static SqlSessionFactory sessionFactory = getSqlSessionFactory();
	public static SqlSession session = getSession();
	
	public static SqlSession getSession(){
		return sessionFactory.openSession();
	}
	
	public static Connection getConnection(){
		return session.getConnection();
	}
	
//	public static SqlSession getSession(){
//		SqlSessionFactory factory = getSqlSessionFactory();
//		return factory.openSession();
//	}
	
	
	public static SqlSessionFactory getSqlSessionFactory()
	{
		String resource = "mybatis_config.xml";
		InputStream inputStream = null;
		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			e.printStackTrace();
		}
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		System.out.println(sqlSessionFactory);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		System.out.println(sqlSession);
		Connection conn = sqlSession.getConnection();
		System.out.println(conn);
		System.out.println("-------获取连接成功----------");
		return sqlSessionFactory;
	}


	public SqlSessionFactory getSessionFactory() {
		return sessionFactory;
	}


	public void setSessionFactory(SqlSessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	
	
	
	
//	public static void test(){
//		try{
//			int i = 0;
//		System.out.println(i);
//				Class clazz = Class.forName("oracle.jdbc.driver.OracleDriver");
//				System.out.println(clazz.getName());
//	
//					Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","drp", "drp" );
//					System.out.println(conn);
//					 Statement stmt = conn.createStatement();
//					 ResultSet rs = stmt.executeQuery("select user_id,user_name from t_user");
//					 rs.next();
//					 System.out.println(rs.getString(1));
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//}
}
