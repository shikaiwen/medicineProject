package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.dict.Dict;
import com.drp.domain.FlowCard;
import com.drp.domain.FlowCardDetail;
import com.drp.domain.Order;
import com.drp.util.Constants;


public class FlowCardService {

	private FlowCardMapper flowCardMapper;
	private OrderService orderService;
	
	//������������Ϣ
	public void saveFlowCard(FlowCard flowCard){
		flowCardMapper.saveFlowCard(flowCard);
	}
	
	//�����ϸ
	public void addFlowCardDetail(FlowCardDetail flowCardDetail){
		flowCardMapper.addFlowCardDetail(flowCardDetail);
		return ;
	}
	
	
	//��ȡ��ϸ�ı���б�
	public List<String> getMedicineDetailListByNum(Map map ){
		List<String> list = flowCardMapper.getMedicineDetailListByNum(map);
		return list;
	}
	
	//��ҳ����
	public List<FlowCard> getResultByPage(Map map){
		
		return flowCardMapper.getResultByPage(map);
	}
	
	//����������ȡ������Ŀ
	public int getFlowCardCountByCondition(Map map){
		int count = flowCardMapper.getFlowCardCountByCondition(map);
		return count;
	}
	
	//��ȡ������ϸ
	public List<FlowCardDetail>getDetailedFlowCard(FlowCard flowCard){
		return flowCardMapper.getDetailedFlowCard(flowCard);
	}
	
	//��ȡҩƷ��ϸ��Ŀ
	public String getMedicineNoList(Map<String,String> map){
		return flowCardMapper.getMedicineNoList(map);
	}
	
	
	//�ӿ����ɾ��ҩƷ��ϸ��Ϣ
	public void deleteMedicineDetailNo(String s){
		flowCardMapper.deleteMedicineDetailNo(s);
	}
	
	
	//������ȷ���ջ񣬽�����״̬��Ϊ����ɣ�����״̬��Ϊ���ջ�
	public void changeOrderState(FlowCard flowCard){
		try{
			///������״̬��Ϊ�����
			Order order = new Order();
			order.setOrderId(flowCard.getFlowCardId());
			Dict dict = new Dict();
			dict.setDictId(Constants.ORDER_STATE_OVER);
			order.setOrderState(dict);
			orderService.submitOrder(order);
			//submitOrder
			
			//������״̬��Ϊ�ѷ���
			dict.setDictId(Constants.FLOWCARD_STATE_RECEIVED);
			flowCard.setFlowCardState(dict);
			flowCardMapper.changeOrderState(flowCard);
		}catch(Exception e){
			e.printStackTrace();
		}
	
	
		
	}
	
	
	
	
	
	

	public OrderService getOrderService() {
		return orderService;
	}

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	public FlowCardMapper getFlowCardMapper() {
		return flowCardMapper;
	}
	public void setFlowCardMapper(FlowCardMapper flowCardMapper) {
		this.flowCardMapper = flowCardMapper;
	}
	
	
	
	
	
	
	
	
	
	
	
}
