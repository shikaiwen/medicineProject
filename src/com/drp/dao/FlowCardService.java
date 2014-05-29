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
	
	//保存流向单主信息
	public void saveFlowCard(FlowCard flowCard){
		flowCardMapper.saveFlowCard(flowCard);
	}
	
	//添加明细
	public void addFlowCardDetail(FlowCardDetail flowCardDetail){
		flowCardMapper.addFlowCardDetail(flowCardDetail);
		return ;
	}
	
	
	//获取明细的编号列表
	public List<String> getMedicineDetailListByNum(Map map ){
		List<String> list = flowCardMapper.getMedicineDetailListByNum(map);
		return list;
	}
	
	//分页查找
	public List<FlowCard> getResultByPage(Map map){
		
		return flowCardMapper.getResultByPage(map);
	}
	
	//根据条件获取流向单数目
	public int getFlowCardCountByCondition(Map map){
		int count = flowCardMapper.getFlowCardCountByCondition(map);
		return count;
	}
	
	//获取流向单明细
	public List<FlowCardDetail>getDetailedFlowCard(FlowCard flowCard){
		return flowCardMapper.getDetailedFlowCard(flowCard);
	}
	
	//获取药品明细条目
	public String getMedicineNoList(Map<String,String> map){
		return flowCardMapper.getMedicineNoList(map);
	}
	
	
	//从库存中删除药品明细信息
	public void deleteMedicineDetailNo(String s){
		flowCardMapper.deleteMedicineDetailNo(s);
	}
	
	
	//分销商确认收获，将订单状态改为已完成，流向单状态改为已收货
	public void changeOrderState(FlowCard flowCard){
		try{
			///将订单状态改为已完成
			Order order = new Order();
			order.setOrderId(flowCard.getFlowCardId());
			Dict dict = new Dict();
			dict.setDictId(Constants.ORDER_STATE_OVER);
			order.setOrderState(dict);
			orderService.submitOrder(order);
			//submitOrder
			
			//将流向单状态改为已发货
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
