package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.StoreCard;
import com.drp.domain.StoreCardDetail;

public interface StoreMapper {

	//添加明细
	public void initMedicineDetail(Map<String,String> map);
	
	//添加主信息
	public void addMainCard(StoreCard storeCard);
	
	//查询入库
	public List<StoreCard> selectInstoreInfo(StoreCard storeCard);
	
	//获取明细
	public List<StoreCardDetail> getDetail(StoreCard storeCard);
	
	//获取不同的
	public List<String> selectDistinctMedicineNo(StoreCard storeCard);
	
	//检查库存
	public int checkStoreByMedicineNo(StoreCardDetail storeCardDetail);
}
