package com.drp.domain;

import java.util.Date;

import com.drp.dict.Dict;

public class FlowCard {

	private String flowCardId;
	private Agent agent;
	private float totalMoney;
	private User creator;
	private Dict flowCardState;
	private Date createDate;
	public String getFlowCardId() {
		return flowCardId;
	}
	public void setFlowCardId(String flowCardId) {
		this.flowCardId = flowCardId;
	}
	public Agent getAgent() {
		return agent;
	}
	public void setAgent(Agent agent) {
		this.agent = agent;
	}
	public float getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(float totalMoney) {
		this.totalMoney = totalMoney;
	}
	public User getCreator() {
		return creator;
	}
	public void setCreator(User creator) {
		this.creator = creator;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Dict getFlowCardState() {
		return flowCardState;
	}
	public void setFlowCardState(Dict flowCardState) {
		this.flowCardState = flowCardState;
	}
	
}
