package com.drp.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.drp.domain.StoreCard;
import com.drp.domain.StoreCardDetail;
import com.drp.util.CommonUtil;
import com.drp.util.JsonUtil;

public class StoreService {

	private StoreMapper storeMapper;
	
	public void addMainCard(StoreCard storeCard){
		storeMapper.addMainCard(storeCard);
		
	}
	
	
	//初始化数据
	public void initMedicineDetail(Map<String,String[]> params,StoreCard storeCard){
		
		Set<String> keySet = params.keySet();
		
		Iterator<String> keyIter = keySet.iterator();
		
		List<Map<String,String>> insertList = new ArrayList<Map<String,String>>();
		for(;keyIter.hasNext();){
			String keyStr = keyIter.next();
			int quantity = Integer.valueOf(params.get(keyStr)[0]);
			for(;quantity>0;quantity--){
				Map <String,String> map = new HashMap<String,String>();
				map.put("medicineNo",keyStr);
				map.put("medicineDetailNo", getDetailNo(keyStr));
				map.put("storeId", storeCard.getStoreId());
				map.put("userId",storeCard.getCreator().getUserId());
				
				insertList.add(map);
			
			}
		}
		System.out.println(JsonUtil.toJsonStr(insertList));
		//插入
		for(int i=0;i<insertList.size();i++){
			Map<String,String> map = insertList.get(i);
			storeMapper.initMedicineDetail(map);
		}
		
	}
	
	//获取明细的编号
	public String getDetailNo(String medicineNo){
		String dateStr = CommonUtil.getYearMonthDay();
		return medicineNo +"-"+ dateStr +"-"+ CommonUtil.getRandomNo();
	}
	
	//查询入库情况
	public List<StoreCard> selectInstoreInfo(StoreCard storeCard){
		return storeMapper.selectInstoreInfo(storeCard);
	}
	
	//根据id查询特定入库单
	public List<StoreCardDetail> getDetail(StoreCard storeCard){
	//	storeMapper.getStoreCardByNo()
		 List<StoreCardDetail> detailList = storeMapper.getDetail(storeCard);
		 return detailList;
	}
	
	
	//查询
	public List<String> selectDistinctMedicineNo(StoreCard storeCard){
		return storeMapper.selectDistinctMedicineNo(storeCard);
	}
	
	//检查库存
	public int checkStoreByMedicineNo(StoreCardDetail storeCardDetail){
		return storeMapper.checkStoreByMedicineNo(storeCardDetail);
	}
	
	
	public StoreMapper getStoreMapper() {
		return storeMapper;
	}
	public void setStoreMapper(StoreMapper storeMapper) {
		this.storeMapper = storeMapper;
	}
	
	
	
	
}
