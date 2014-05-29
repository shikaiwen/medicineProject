package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.Order;
import com.drp.domain.OrderDetail;
import com.drp.util.CommonUtil;

public class OrderService {

	private OrderMapper orderMapper;
	
	//��Ӷ���
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
	
	//����ҳ���ѯ
	public List<Order> getResultByPage(Map map){
		return orderMapper.getResultByPage(map);
	}

	//��ѯ�������µļ�¼��
	public int getOrderCountByCondition(Map map){
		
		return orderMapper.getOrderCountByCondition(map);
	}
	//ɾ������
	public void deleteOrder(Order order){
		orderMapper.deleteOrderMain(order);
		orderMapper.deleteOrderSub(order);
	}
	
	//�ύ����,���Ը���ʵ��״̬�ı�
	public void submitOrder(Order order){
		orderMapper.submitOrder(order);
	}
	
	
	//��ѯ��ϸ
	public List<OrderDetail> getDetailedOrder(Order order){
		return orderMapper.getDetailedOrder(order);
	}
	
	
	//����id��ѯ����
	public Order getOrderById(Order order){
		return orderMapper.getOrderById(order);
	}
	
	
	//��ѯ��ϸ�Ƿ����
	public int detailIsExist(Map<String,String> condition){
		return orderMapper.detailIsExist(condition);
	}
	
	
	
	
	
	//��Ӷ�����ϸ
	public void addOrderDetailInfo(OrderDetail detail){
		detail.setDetailId(CommonUtil.getRandomNo());
		orderMapper.addOrderDetailInfo(detail);
		return ;
	}
	
	//���¶�����ϸ��Ϣ
	public void updateDetail(OrderDetail detail){
		orderMapper.updateDetail(detail);
	}
	
	//��ȡ���ж�����ϸ��
	public List<String> getDetailIdByOrderId(Map map){
		return orderMapper.getDetailIdByOrderId(map);
	}
	
	//ɾ��������ϸ
	public void deleteOrderDetail(Map map){
		orderMapper.deleteOrderDetail(map);
	}
	
	
	//���¶����ܽ��
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
