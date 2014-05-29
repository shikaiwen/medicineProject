package com.drp.domain;

import java.util.Date;
import java.util.List;

import com.drp.dict.Dict;

public class Order {

	private String orderId;
	private Agent agent;
	private Dict orderState;
	private User creator;
	private float totalMoney;
	private Date orderDate;
	
	private List<OrderDetail> orderDetail;
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public Agent getAgent() {
		return agent;
	}
	public void setAgent(Agent agent) {
		this.agent = agent;
	}


	public Dict getOrderState() {
		return orderState;
	}
	public void setOrderState(Dict orderState) {
		this.orderState = orderState;
	}
	public User getCreator() {
		return creator;
	}
	public void setCreator(User creator) {
		this.creator = creator;
	}
	public float getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(float totalMoney) {
		this.totalMoney = totalMoney;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public List<OrderDetail> getOrderDetail() {
		return orderDetail;
	}
	public void setOrderDetail(List<OrderDetail> orderDetail) {
		this.orderDetail = orderDetail;
	}
	
}
