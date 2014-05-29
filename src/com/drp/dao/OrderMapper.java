package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.Order;
import com.drp.domain.OrderDetail;

public interface OrderMapper {

	//��Ӷ���
	public void addOrder(Order order);
	
	//��Ӷ�������Ϣ
	public void addOrderMainInfo(Order order);
	
	//��Ӷ�����ϸ��Ϣ
	public void addOrderDetailInfo(OrderDetail detail);
		
	
	//����ҳ���ѯ
	public List<Order> getResultByPage(Map map);
	
	//����������ȡ������Ŀ
	public int getOrderCountByCondition(Map map);
	
	//ɾ����������Ϣ
	public void deleteOrderMain(Order order);
	
	//ɾ��������ϸ��Ϣ
	public void deleteOrderSub(Order order);
	
	//�ύ������Ҳ����������״̬
	public void submitOrder(Order order);
	
	//��ѯ��ϸ
	public List<OrderDetail> getDetailedOrder(Order order);
	
	//���ݶ�����Ų�ѯ
	public Order getOrderById(Order order);
	
	//��ѯ��ϸ�Ƿ����
	public int detailIsExist(Map<String,String> condition);
	
	//���¶�����ϸ��Ϣ
	public void updateDetail(OrderDetail detail);
	
	//��ȡ���ж�����ϸ��
	public List<String> getDetailIdByOrderId(Map map);
	
	//ɾ��������ϸ
	public void deleteOrderDetail(Map map);
	
	//���¶����ܽ��
	public void updateTotalPrice(Map map);
}
