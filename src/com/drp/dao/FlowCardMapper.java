package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.FlowCard;
import com.drp.domain.FlowCardDetail;

public interface FlowCardMapper {

	//�������
	public void saveFlowCard(FlowCard flowCard);
	
	
	//�����ϸ
	public void addFlowCardDetail(FlowCardDetail flowCardDetail);
	
	//��ȡ��ϸ�ı���б�
	public List<String> getMedicineDetailListByNum(Map map);
	
	//��ҳ����
	public List<FlowCard> getResultByPage(Map map);
	
	//����������ȡ������Ŀ
	public int getFlowCardCountByCondition(Map map);
	
	//��ѯ��ϸ
	public List<FlowCardDetail> getDetailedFlowCard(FlowCard flowCard);
	
	//��ȡҩƷ��ϸ��Ŀ
	public String getMedicineNoList(Map<String,String> map);
	
	//�ӿ����ɾ��
	public void deleteMedicineDetailNo(String s);
	
	//����״̬��Ϊ�ѷ���
	public void changeOrderState(FlowCard flowCard);
}
