package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.StoreCard;
import com.drp.domain.StoreCardDetail;

public interface StoreMapper {

	//�����ϸ
	public void initMedicineDetail(Map<String,String> map);
	
	//�������Ϣ
	public void addMainCard(StoreCard storeCard);
	
	//��ѯ���
	public List<StoreCard> selectInstoreInfo(StoreCard storeCard);
	
	//��ȡ��ϸ
	public List<StoreCardDetail> getDetail(StoreCard storeCard);
	
	//��ȡ��ͬ��
	public List<String> selectDistinctMedicineNo(StoreCard storeCard);
	
	//�����
	public int checkStoreByMedicineNo(StoreCardDetail storeCardDetail);
}
