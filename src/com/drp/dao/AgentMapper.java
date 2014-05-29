package com.drp.dao;

import java.util.List;

import com.drp.domain.Agent;
import com.drp.domain.AreaDataModel;


public interface AgentMapper {

	public List<Agent> getAllAgent();
	
	public void addAgent(Agent agent);
	
	public void deleteAgent(Agent agent);
	
	//�޸ķ�����
	public void modifyAgent(Agent agent);
	
	//��ȡ�ӷ�����
	public List<Agent> getSubAgentList(Agent agent);
	
	//����id��ȡ
	public Agent getAgentById(Agent agent);
	
	//���Address�Ƿ����,����еĻ��򷵻�List
	public List<AreaDataModel> isAddressExist(AreaDataModel areaDataModel);
	
	//�����ַ
	public void insertAddress(AreaDataModel areaDataModel);
	
	//����id��ȡ
	public AreaDataModel getAddressById(AreaDataModel model);
	
	//���¸��ڵ�Ϊ��Ҷ��
	public void setParentToNonLeaf(Agent agent);
	
}
