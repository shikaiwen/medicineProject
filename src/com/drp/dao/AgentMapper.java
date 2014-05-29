package com.drp.dao;

import java.util.List;

import com.drp.domain.Agent;
import com.drp.domain.AreaDataModel;


public interface AgentMapper {

	public List<Agent> getAllAgent();
	
	public void addAgent(Agent agent);
	
	public void deleteAgent(Agent agent);
	
	//修改分销商
	public void modifyAgent(Agent agent);
	
	//获取子分销商
	public List<Agent> getSubAgentList(Agent agent);
	
	//根据id获取
	public Agent getAgentById(Agent agent);
	
	//检查Address是否存在,如果有的话则返回List
	public List<AreaDataModel> isAddressExist(AreaDataModel areaDataModel);
	
	//插入地址
	public void insertAddress(AreaDataModel areaDataModel);
	
	//根据id获取
	public AreaDataModel getAddressById(AreaDataModel model);
	
	//更新父节点为非叶子
	public void setParentToNonLeaf(Agent agent);
	
}
