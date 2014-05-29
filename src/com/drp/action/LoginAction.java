package com.drp.action;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.drp.dao.AgentMapper;
import com.drp.dao.UserMapper;
import com.drp.domain.Agent;
import com.drp.domain.User;
import com.drp.util.CommonUtil;
import com.drp.util.Constants;
import com.drp.util.JsonUtil;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport{

	private User user;
	private UserMapper userMapper;
	private AgentMapper agentMapper;
	
	//注销用户
	public void logOut(){
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.removeAttribute(Constants.USER);
		HttpServletResponse resp = ServletActionContext.getResponse();
		try{
			resp.sendRedirect("../login.jsp");
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	
	
	public String execute() throws Exception {
		List<User> users = null;
		try{
			System.out.println(JsonUtil.toJsonStr(users));
			
			 String pwd = CommonUtil.md5Encode(user.getPassword());
			 user.setPassword(pwd);
			 users = userMapper.getUser(user);
			 
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(users==null||users.size() != 1){
			this.addActionError(Constants.USER_NOT_EXIST);
			return ERROR;
		}
		//如果成功
		HttpSession session = ServletActionContext.getRequest().getSession();
		//获取user所在的Agent
		user = users.get(0);
		Agent agent = new Agent();
		agent.setAgentId(user.getBelongAgentId());
		agent = agentMapper.getAgentById(agent);
		session.setAttribute(Constants.AGENT, agent);
		session.setAttribute(Constants.USER,user);
		
		if(Constants.IS_ADMIN==user.getBelongAgentId()){
			return SUCCESS;
		}else{
			return "agentMain";
		}
		
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public UserMapper getUserMapper() {
		return userMapper;
	}

	public void setUserMapper(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	public AgentMapper getAgentMapper() {
		return agentMapper;
	}

	public void setAgentMapper(AgentMapper agentMapper) {
		this.agentMapper = agentMapper;
	}
	
	
}
