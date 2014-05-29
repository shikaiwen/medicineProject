package com.drp.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.drp.dao.AgentService;
import com.drp.dao.FlowCardService;
import com.drp.dao.MedicineService;
import com.drp.dao.OrderService;
import com.drp.dao.UserService;
import com.drp.dict.Dict;
import com.drp.dict.DictService;
import com.drp.domain.Agent;
import com.drp.domain.AreaDataModel;
import com.drp.domain.FlowCard;
import com.drp.domain.FlowCardDetail;
import com.drp.domain.Medicine;
import com.drp.domain.Order;
import com.drp.domain.OrderDetail;
import com.drp.json.model.FlowCardJsonModel;
import com.drp.util.CommonUtil;
import com.drp.util.Constants;
import com.drp.util.JsonUtil;
import com.drp.util.ResultJsonModel;
import com.drp.util.WebUtil;
import com.opensymphony.xwork2.ActionSupport;

public class FlowCardAction extends ActionSupport{

	private int page;
	private int rows;
	private FlowCard flowCard;
	private FlowCardDetail flowCardDetail;
	private List<FlowCard> flowCardList;
	private List<FlowCardDetail> flowCardDetailList;
	private FlowCardService flowCardService;
	private OrderService orderService;
	private AgentService agentService;
	private DictService dictService;
	private FlowCardJsonModel flowCardJsonModel;
	private UserService userService;
	private MedicineService medicineService;
	
	
	//查询条件
	private Date flowCardDateFrom;
	private Date flowCardDateTo;
	private int flowCardState;
	private String creatorName;
	
	
	//这两个变量是在查询药品明细编号时使用
	private String flowCardId;
	private String flowCardDetailId;
	
	//检查是否有该订单,如果有则返回分销商信息
	public void checkFlowCardIsValid(){
		if(null != flowCard ){
			Order order = new Order();
			order.setOrderId(flowCard.getFlowCardId());
			order = orderService.getOrderById(order);
			Agent agent = new Agent();
			agent.setAgentId(order.getAgent().getAgentId());
			agent = agentService.getAgentById(agent);
			AreaDataModel areaDataModel = new AreaDataModel();
			areaDataModel.setId(agent.getAddress());
			areaDataModel = agentService.getAddressById(areaDataModel);
			ResultJsonModel rjm = new ResultJsonModel();
			rjm.addObject("address", areaDataModel.getStrFormat());
			rjm.addObject("agent", agent);
			WebUtil.writeJsonToClient(rjm);
		}else{
			WebUtil.WriteStrToClient(Constants.errorStr);
		}
	}
	
	
	//保存流向单
	public void saveFlowCard(){
		System.out.println(JsonUtil.toJsonStr(flowCard));
		//保存主信息
		try{
			Dict dict = new Dict();
			dict.setDictId(Constants.FLOWCARD_STATE_SENDED);
			flowCard.setFlowCardState(dict);
			flowCard.setCreateDate(new Date());
			flowCardService.saveFlowCard(flowCard);
			
			
			//改变订单状态
			Order order = new Order();
			Dict d = new Dict();
			d.setDictId(Constants.ORDER_STATE_SEND);
			order.setOrderState(d);
			order.setOrderId(flowCard.getFlowCardId());
			orderService.submitOrder(order);
			
			//保存明细
			Map map = new HashMap();
			
			for(int i=0;i<flowCardDetailList.size();i++){
				FlowCardDetail detail = flowCardDetailList.get(i);
				map.put("medicineNo", detail.getMedicine().getMedicineNo());
				map.put("num",detail.getQuantity());
				List<String> strList = flowCardService.getMedicineDetailListByNum(map);
				
				//从库存中删除这些药品
				for(String s : strList){
					flowCardService.deleteMedicineDetailNo(s);
				}
				
				StringBuilder sb = new StringBuilder(strList.toString());
				sb.deleteCharAt(0).deleteCharAt(sb.length()-1);
				detail.setMedicineNoList(sb.toString());
				//flowCardService.a
				detail.setFlowCardId(flowCard.getFlowCardId());
				detail.setFlowCardDetailId(CommonUtil.getRandomNo());
				flowCardService.addFlowCardDetail(detail);
				System.out.println(JsonUtil.toJsonStr(strList));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	
	//根据页数查找记录
	public void getResultByPage(){
		try{
			if(page == 0) page = 1;
			Map map = new HashMap();
			int startRecords = (page -1)*rows;
			int endRecords = page * rows;
			map.put("startRecords", startRecords);
			map.put("endRecords", endRecords);
			map.put("flowCardDateFrom", flowCardDateFrom);
			map.put("flowCardDateTo", flowCardDateTo);
			map.put("flowCardState", flowCardState);
			map.put("flowCardId", flowCardId);
			map.put("creatorName",creatorName);
			if(null != flowCard){
//				flowCard = new FlowCard();
//				map.put("orderId", flowCard.getFlowCardId());
//				map.put("userName",flowCard.getCreator().getUserName());
//				map.put("totalMoney", flowCard.getTotalMoney());
//				map.put("flowCardState", flowCard.getFlowCardState().getDictId());
			}
			
			System.out.println(JsonUtil.toJsonStr(map));
			List<FlowCard> flowCardList = flowCardService.getResultByPage(map);
			System.out.println(JsonUtil.toJsonStr(flowCardList));
			for(int i=0;i<flowCardList.size();i++){
				FlowCard flow = flowCardList.get(i);
				flow.setFlowCardState(dictService.getDictById(flow.getFlowCardState()));
				flow.setCreator(userService.getUserById(flow.getCreator()));
				flow.setAgent(agentService.getAgentById(flow.getAgent()));
			}
			//将字典类型名字和值设置好
//			for(int i=0;i<orderList.size();i++){
//				Order m = orderList.get(i);
//			}
			
			int count = flowCardService.getFlowCardCountByCondition(map);
			flowCardJsonModel.setTotal(count);
			flowCardJsonModel.setRows(flowCardList);
			System.out.println(JsonUtil.toJsonStr(flowCardJsonModel));
			WebUtil.writeJsonToClient(flowCardJsonModel);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//获取流向单的详细条目
	public String getDetailedFlowCard(){
		try{
			List<FlowCardDetail> tt =  flowCardService.getDetailedFlowCard(flowCard);
			System.out.println(JsonUtil.toJsonStr(tt));
			for(int i=0;i<tt.size();i++){
				Medicine medi = tt.get(i).getMedicine();
				Medicine m = medicineService.getMedicineByNo(medi);
				tt.get(i).setMedicine(m);
			}
			
			System.out.println(JsonUtil.toJsonStr(tt));
			flowCardDetailList = tt;
		}catch(Exception e ){
			e.printStackTrace();
		}
		return "showFlowCardDetail";
	}
	
	//发货单查看明细
	public String showSendInfo(){
		getDetailedFlowCard();
		//WebUtil.writeJsonToClient(flowCardDetail);
		return "showSendInfo";
	}
	
	
	//查询药品详细条目
	public void getMedicineNoList(){
		String medicineNoList = null;
		try{
			Map <String,String> map = new HashMap<String,String>();
			map.put("flowCardId", flowCardId);
			map.put("flowCardDetailId",flowCardDetailId);
			medicineNoList = flowCardService.getMedicineNoList(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		WebUtil.WriteStrToClient(medicineNoList);
	}
	
	
	//分销商确认收获，将订单状态改为已完成，流向单状态改为已收货
	public void changeOrderState(){
		try{
			Dict dict = new Dict();
			dict.setDictId(Constants.ORDER_STATE_OVER);
			Order order = new Order();
			order.setOrderId(flowCard.getFlowCardId());
			order.setOrderState(dict);
			orderService.submitOrder(order);
			
			//更新流向单状态
			dict.setDictId(Constants.FLOWCARD_STATE_RECEIVED);
			flowCard.setFlowCardState(dict);
			flowCardService.changeOrderState(flowCard);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	public FlowCard getFlowCard() {
		return flowCard;
	}

	public void setFlowCard(FlowCard flowCard) {
		this.flowCard = flowCard;
	}

	public FlowCardDetail getFlowCardDetail() {
		return flowCardDetail;
	}

	public void setFlowCardDetail(FlowCardDetail flowCardDetail) {
		this.flowCardDetail = flowCardDetail;
	}

	public List<FlowCard> getFlowCardList() {
		return flowCardList;
	}

	public void setFlowCardList(List<FlowCard> flowCardList) {
		this.flowCardList = flowCardList;
	}

	public List<FlowCardDetail> getFlowCardDetailList() {
		return flowCardDetailList;
	}

	public void setFlowCardDetailList(List<FlowCardDetail> flowCardDetailList) {
		this.flowCardDetailList = flowCardDetailList;
	}


	public FlowCardService getFlowCardService() {
		return flowCardService;
	}


	public void setFlowCardService(FlowCardService flowCardService) {
		this.flowCardService = flowCardService;
	}


	public OrderService getOrderService() {
		return orderService;
	}


	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}


	public AgentService getAgentService() {
		return agentService;
	}


	public void setAgentService(AgentService agentService) {
		this.agentService = agentService;
	}

	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}


	public DictService getDictService() {
		return dictService;
	}


	public void setDictService(DictService dictService) {
		this.dictService = dictService;
	}
	public FlowCardJsonModel getFlowCardJsonModel() {
		return flowCardJsonModel;
	}
	public void setFlowCardJsonModel(FlowCardJsonModel flowCardJsonModel) {
		this.flowCardJsonModel = flowCardJsonModel;
	}
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public MedicineService getMedicineService() {
		return medicineService;
	}
	public void setMedicineService(MedicineService medicineService) {
		this.medicineService = medicineService;
	}


	public String getFlowCardId() {
		return flowCardId;
	}


	public void setFlowCardId(String flowCardId) {
		this.flowCardId = flowCardId;
	}


	public String getFlowCardDetailId() {
		return flowCardDetailId;
	}
	public void setFlowCardDetailId(String flowCardDetailId) {
		this.flowCardDetailId = flowCardDetailId;
	}


	public Date getFlowCardDateFrom() {
		return flowCardDateFrom;
	}


	public void setFlowCardDateFrom(Date flowCardDateFrom) {
		this.flowCardDateFrom = flowCardDateFrom;
	}


	public Date getFlowCardDateTo() {
		return flowCardDateTo;
	}


	public void setFlowCardDateTo(Date flowCardDateTo) {
		this.flowCardDateTo = flowCardDateTo;
	}



	public int getFlowCardState() {
		return flowCardState;
	}


	public void setFlowCardState(int flowCardState) {
		this.flowCardState = flowCardState;
	}


	public String getCreatorName() {
		return creatorName;
	}


	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
