package com.drp.action;
//package com.drp.action;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.ibatis.session.SqlSession;
//import org.apache.struts2.ServletActionContext;
//
//import com.drp.dao.UserMapper;
//import com.drp.domain.User;
//import com.drp.json.model.UserJsonModel;
//import com.drp.util.DBUtil;
//import com.drp.util.JsonUtil;
//import com.google.gson.Gson;
//import com.google.gson.reflect.TypeToken;
//import com.opensymphony.xwork2.ActionSupport;
//
//public class FindAllUser extends ActionSupport{
//
//
//	private int rows ;
//	private int page;
//	private String userId;
//	private String userName;
//	private String password;
//	private List<User> users = new ArrayList<User>();
//	public void myexecute() {
//		
//		
//		System.out.println("FindAllUser action invoked");
//		SqlSession session = DBUtil.getSession();
//		
//		UserMapper userMapper = session.getMapper(UserMapper.class);
//		
////		users = userMapper.getAllUser();
//		int endRecords = page * rows;
//		int startRecords = (page -1 )*rows;
//		
//		
//		Map conditions = new HashMap();
//		conditions.put("startRecords", startRecords);
//		conditions.put("endRecords", endRecords);
//		conditions.put("userName", userName);
//		conditions.put("password", password);
//		conditions.put("userId", userId);
//		users = userMapper.getResultByPage(conditions);
//		int total = userMapper.getAllUserCount();
//		
//
//		
//		
//		UserJsonModel jsonModel = new UserJsonModel();
//		jsonModel.setTotal(total);
//		jsonModel.setUsers(users);
//		
//		
//		String result = JsonUtil.toJsonStr(jsonModel);
//		System.out.println(result);
//		HttpServletResponse response = ServletActionContext.getResponse();
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = null;
//		try {
//			out = response.getWriter();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		out.write(result);
//		out.flush();
////		ActionContext ac = ActionContext.getContext();
////		HttpServletRequest request = ServletActionContext.getRequest();
////		String base = request.getProtocol() + "\\"+ request.getServletPath();
////		String result = JsonUtil.toJsonStr(users);
//	//	return "";
//	}
//	
//	
//	
//	
//	
//	public List<User> getUsers() {
//		return users;
//	}
//	public void setUsers(List<User> users) {
//		this.users = users;
//	}
//	public String getUserId() {
//		return userId;
//	}
//
//	public void setUserId(String userId) {
//		this.userId = userId;
//	}
//
////	public static void main(String[] args) {
////		
////		Gson gson = new Gson();
////		SqlSession session = DBUtil.getSession();
////		UserMapper userMapper = session.getMapper(UserMapper.class);
//////		List<User> users = userMapper.getAllUser();
////	//	List<User> users = userMapper.getResultByPage(10,6);
////		Map map = new HashMap();
////	//	map.put("result", users);
////	//	System.out.println(gson.toJson(users));
////		System.out.println(map);
////		
////	}
//
//	
//	public void jsonToObj(){
//		Type listType = new TypeToken<ArrayList<Map>>(){}.getType();
//		Gson gson = new Gson();
//		ArrayList<Map> map = gson.fromJson("{aa:bb}",listType);
//	}
//
//
//
//	public String getPassword() {
//		return password;
//	}
//
//	public void setPassword(String password) {
//		this.password = password;
//	}
//
//	public String getUserName() {
//		return userName;
//	}
//
//	public void setUserName(String userName) {
//		this.userName = userName;
//	}
//
//	public int getRows() {
//		return rows;
//	}
//
//	public void setRows(int rows) {
//		this.rows = rows;
//	}
//
//	public int getPage() {
//		return page;
//	}
//
//	public void setPage(int page) {
//		this.page = page;
//	}
//}
