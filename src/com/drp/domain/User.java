package com.drp.domain;

import java.util.Date;

import com.drp.util.MyDate;

/**
 * 用户信息 
 * @author Administrator
 *
 */
public class User {

	@Override
	public String toString() {
		return this.getClass().getName()+ "{userId=" + this.userId + ", username=" + this.userName + "}"; 
	}

	private String userId;
	private String userName;
	private String password;
	private String contactTel;
	private String email;
	private Date createDate;
	private int belongAgentId;
	private Agent agent;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getContactTel() {
		return contactTel;
	}
	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}


	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getBelongAgentId() {
		return belongAgentId;
	}
	public void setBelongAgentId(int belongAgentId) {
		this.belongAgentId = belongAgentId;
	}
	public Agent getAgent() {
		return agent;
	}
	public void setAgent(Agent agent) {
		this.agent = agent;
	}

	
	

}
