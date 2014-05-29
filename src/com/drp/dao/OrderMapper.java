package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.Order;
import com.drp.domain.OrderDetail;

public interface OrderMapper {

	//添加订单
	public void addOrder(Order order);
	
	//添加订单主信息
	public void addOrderMainInfo(Order order);
	
	//添加订单明细信息
	public void addOrderDetailInfo(OrderDetail detail);
		
	
	//根据页码查询
	public List<Order> getResultByPage(Map map);
	
	//根据条件获取订单数目
	public int getOrderCountByCondition(Map map);
	
	//删除订单主信息
	public void deleteOrderMain(Order order);
	
	//删除订单详细信息
	public void deleteOrderSub(Order order);
	
	//提交订单，也可用于其他状态
	public void submitOrder(Order order);
	
	//查询明细
	public List<OrderDetail> getDetailedOrder(Order order);
	
	//根据订单编号查询
	public Order getOrderById(Order order);
	
	//查询明细是否存在
	public int detailIsExist(Map<String,String> condition);
	
	//更新订单明细信息
	public void updateDetail(OrderDetail detail);
	
	//获取所有订单明细号
	public List<String> getDetailIdByOrderId(Map map);
	
	//删除订单明细
	public void deleteOrderDetail(Map map);
	
	//更新订单总金额
	public void updateTotalPrice(Map map);
}
