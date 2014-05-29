package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.Order;
import com.drp.domain.OrderDetail;
import com.drp.util.CommonUtil;

public class OrderService {

	private OrderMapper orderMapper;
	
	//添加订单
	public void addOrder(Order order){
		
		orderMapper.addOrderMainInfo(order);
		
		for(int i=0;i<order.getOrderDetail().size();i++){
			OrderDetail detail = order.getOrderDetail().get(i);
			detail.setDetailId(CommonUtil.getRandomNo());
			detail.setOrder(order);
			orderMapper.addOrderDetailInfo(detail);
		}
		
		//orderMapper.addOrder(order);
	}
	
	//根据页码查询
	public List<Order> getResultByPage(Map map){
		return orderMapper.getResultByPage(map);
	}

	//查询该条件下的记录数
	public int getOrderCountByCondition(Map map){
		
		return orderMapper.getOrderCountByCondition(map);
	}
	//删除订单
	public void deleteOrder(Order order){
		orderMapper.deleteOrderMain(order);
		orderMapper.deleteOrderSub(order);
	}
	
	//提交订单,可以根据实际状态改变
	public void submitOrder(Order order){
		orderMapper.submitOrder(order);
	}
	
	
	//查询明细
	public List<OrderDetail> getDetailedOrder(Order order){
		return orderMapper.getDetailedOrder(order);
	}
	
	
	//根据id查询订单
	public Order getOrderById(Order order){
		return orderMapper.getOrderById(order);
	}
	
	
	//查询明细是否存在
	public int detailIsExist(Map<String,String> condition){
		return orderMapper.detailIsExist(condition);
	}
	
	
	
	
	
	//添加订单明细
	public void addOrderDetailInfo(OrderDetail detail){
		detail.setDetailId(CommonUtil.getRandomNo());
		orderMapper.addOrderDetailInfo(detail);
		return ;
	}
	
	//更新订单明细信息
	public void updateDetail(OrderDetail detail){
		orderMapper.updateDetail(detail);
	}
	
	//获取所有订单明细号
	public List<String> getDetailIdByOrderId(Map map){
		return orderMapper.getDetailIdByOrderId(map);
	}
	
	//删除订单明细
	public void deleteOrderDetail(Map map){
		orderMapper.deleteOrderDetail(map);
	}
	
	
	//更新订单总金额
	public void updateTotalPrice(Map map){
		orderMapper.updateTotalPrice(map);
	}
	
	
	
	
	
	
	
	public OrderMapper getOrderMapper() {
		return orderMapper;
	}

	public void setOrderMapper(OrderMapper orderMapper) {
		this.orderMapper = orderMapper;
	}
	
	
	
	
	
}
