package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.FlowCard;
import com.drp.domain.FlowCardDetail;

public interface FlowCardMapper {

	//添加流向单
	public void saveFlowCard(FlowCard flowCard);
	
	
	//添加明细
	public void addFlowCardDetail(FlowCardDetail flowCardDetail);
	
	//获取明细的编号列表
	public List<String> getMedicineDetailListByNum(Map map);
	
	//分页查找
	public List<FlowCard> getResultByPage(Map map);
	
	//根据条件获取流向单数目
	public int getFlowCardCountByCondition(Map map);
	
	//查询明细
	public List<FlowCardDetail> getDetailedFlowCard(FlowCard flowCard);
	
	//获取药品明细条目
	public String getMedicineNoList(Map<String,String> map);
	
	//从库存中删除
	public void deleteMedicineDetailNo(String s);
	
	//流向单状态改为已发货
	public void changeOrderState(FlowCard flowCard);
}
