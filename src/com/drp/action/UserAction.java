package com.drp.action;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.drp.dao.AgentService;
import com.drp.dao.UserService;
import com.drp.domain.Agent;
import com.drp.domain.User;
import com.drp.json.model.UserJsonModel;
import com.drp.util.CommonUtil;
import com.drp.util.Constants;
import com.drp.util.JsonUtil;
import com.drp.util.WebUtil;
import com.opensymphony.xwork2.ActionSupport;

public class UserAction extends ActionSupport{

	private User user;
	private List<User> users;
	private UserService userService;
	private UserJsonModel userJsonModel;
	private AgentService agentService;
	
	//添加用户
	public void addUser(){
		try{
		//	CommonUtil.setNullPropertyWithDefaultVal(user);
			user.setCreateDate(new Date());
			String pwd = CommonUtil.md5Encode(user.getPassword());
			user.setPassword(pwd);
			userService.addUser(user);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	
	//查询所有用户模型
	public  void getAllUserJsonModle(){
		try{
			users = userService.getAllUser();
			for(int i=0;i<users.size();i++){
				User user = users.get(i);
				Agent agent = new Agent();
				agent.setAgentId(user.getBelongAgentId());
				agent = agentService.getAgentById(agent);
				user.setAgent(agent);
			}
				
			userJsonModel.setUsers(users);
			userJsonModel.setTotal(userService.getAllUserCount());
			System.out.println(JsonUtil.toJsonStr(userJsonModel));
			WebUtil.writeJsonToClient(userJsonModel);
		}catch(Exception e){
			e.printStackTrace();
		}

	}
	
	
	//删除单个用户
	public void deleteUser(){
		try{
			userService.deleteUser(user);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//删除多个用户
	public void deleteMultipleUser(){
		try{
			userService.deleteMultipleUser(users);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//修改用户
	public void modifyUser(){
		try{
			userService.modifyUser(user);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//检测用户是否存在
	public void checkIsExist(){
		try{
			HttpSession session = ServletActionContext.getRequest().getSession();
			User userNow = (User)session.getAttribute(Constants.USER);
			if(user != null){
				if(null != userNow){
						String realPassword = userNow.getPassword();
						String passwordNow = user.getPassword();
						passwordNow = CommonUtil.md5Encode(passwordNow); 
						
						if(realPassword.equals(passwordNow)){
							WebUtil.WriteStrToClient("yes");return;
						}
				}
			WebUtil.WriteStrToClient("no");
			}
		}catch(Exception e){
			e.printStackTrace();
		}

	}
	
	
	
	//修改密码
	public void modifyPassword(){
		try{
			String pwd = CommonUtil.md5Encode(user.getPassword());
			user.setPassword(pwd);
			userService.modifyPassword(user);
			HttpSession session = ServletActionContext.getRequest().getSession();
			User currentUser = (User)session.getAttribute(Constants.USER);
			currentUser.setPassword(pwd);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	
	
	
	
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}


	public UserJsonModel getUserJsonModel() {
		return userJsonModel;
	}


	public void setUserJsonModel(UserJsonModel userJsonModel) {
		this.userJsonModel = userJsonModel;
	}


	public List<User> getUsers() {
		return users;
	}


	public void setUsers(List<User> users) {
		this.users = users;
	}


	public AgentService getAgentService() {
		return agentService;
	}


	public void setAgentService(AgentService agentService) {
		this.agentService = agentService;
	}
	
	
	
	
	
	
}
