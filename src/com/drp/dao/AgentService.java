package com.drp.dao;
import java.util.List;

import com.drp.domain.Agent;
import com.drp.domain.AreaDataModel;

public class AgentService {

	private AgentMapper agentMapper;
	
	//获取所有分销商
	public List<Agent> getAllAgent(){
		return agentMapper.getAllAgent();
	}
	
	
	//获取分销商树
	public String getAgentTreeStr(Agent agent){
		StringBuilder sb = new StringBuilder();
		sb.append("[");
		getData(new Agent(),sb);
		sb.append("]");
		System.out.println(sb.toString());
		return sb.toString();
	}
	
	public StringBuilder getData(Agent agent,StringBuilder sb){
		List<Agent> agents = getSubAgentList(agent);
		int count = 0;
		for(int i=0;i<agents.size();i++){
			Agent a = agents.get(i);
			if(!"Y".equals(a.getIsLeaf())){
				if(count >=1){
					sb.append(",");
				}
				sb.append("{");
				sb.append("name:").append("\"").append(a.getAgentName()).append("\"");
				sb.append(",open:true");
				sb.append(",agent_id:").append("\"").append(+a.getAgentId()).append("\"");
//				sb.append(",address:").append("\"").append(a.getAddress()).append("\"");
				sb.append(",contact_man:").append("\"").append(a.getContactMan()).append("\"");
				sb.append(",telephone:").append("\"").append(a.getTelephone()).append("\"");
				sb.append(",pid:").append("\"").append(a.getPid()).append("\"");
				sb.append(",agent_level:").append("\"").append(a.getAgentLevel()).append("\"");
				sb.append(",is_agent:").append("\"").append(a.getIsAgent()).append("\"");
				sb.append(",is_leaf:").append("\"").append(a.getIsLeaf()).append("\"");
				sb.append(",children:").append("[");
				getData(agents.get(i),sb);
				sb.append("]").append("}");
				count++;
			}else{
				if(count >=1){
					sb.append(",");
				}
				sb.append("{");
				sb.append("name:").append("\"").append(a.getAgentName()).append("\"");
				sb.append(",open:true");
				sb.append(",agent_id:").append("\"").append(+a.getAgentId()).append("\"");
//				sb.append(",address:").append("\"").append(a.getAddress()).append("\"");
				sb.append(",contact_man:").append("\"").append(a.getContactMan()).append("\"");
				sb.append(",telephone:").append("\"").append(a.getTelephone()).append("\"");
				sb.append(",pid:").append("\"").append(a.getPid()).append("\"");
				sb.append(",agent_level:").append("\"").append(a.getAgentLevel()).append("\"");
				sb.append(",is_agent:").append("\"").append(a.getIsAgent()).append("\"");
				sb.append(",is_leaf:").append("\"").append(a.getIsLeaf()).append("\"");
				sb.append("}");
				count ++;
			}
		}
			return null;
	}
	
	
	
	public void getStrById(StringBuilder sb,int pid){
//		List<Agent> agents = getAgentListByPid();
//		
//		int rootId = Constants.pid;
//		Agent rootAgent = null;
//		for(int i=0;i<agents.size();i++){
//			if(rootId == agents.get(i).getPid()){
//				rootAgent = agents.get(i);break;
//			}
//		}
	}
	
	
	//获取子节点
	public List<Agent> getSubAgentList(Agent agent){
		List<Agent> list = null;
		try{
			list =  agentMapper.getSubAgentList(agent);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	
	public Agent getAgentById(Agent agent){
		return agentMapper.getAgentById(agent);
	}
	
	//添加分销商
	public void addAgent(Agent agent){
		//检查是否改地址是否存在
		try{
			List<AreaDataModel> list = isAddressExist(agent.getAreaDataModel());
			if(list.size()>0){
				agent.setAreaDataModel(list.get(1));//获取第一条,应该只有一条
			}else{
				insertAddress(agent.getAreaDataModel());
				//agent.setAreaDataModel(dataModel);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		//将地址设置为AreaDataModel的id
		agent.setAddress(agent.getAreaDataModel().getId());
		agentMapper.addAgent(agent);

	}
	
	
	
	//判断该地址是否存在
	private List<AreaDataModel> isAddressExist(AreaDataModel areaDataModel){
		List<AreaDataModel> list = agentMapper.isAddressExist(areaDataModel);
		return list;
	}
	
	//插入字典
	public void  insertAddress(AreaDataModel dataModel){
		agentMapper.insertAddress(dataModel);
	}
	
	//删除分销商
	public void deleteAgent(Agent agent){
		agentMapper.deleteAgent(agent);
	}

	//根据id获取改地址对象
	public AreaDataModel getAddressById(AreaDataModel dataModel){
		return agentMapper.getAddressById(dataModel);
	}
	
	
	
	//将父亲节点设置为非叶子节点
	public void setParentToNonLeaf(Agent agent){
		agentMapper.setParentToNonLeaf(agent);
	}
	
	
	//修改Agent
	public void modifyAgent(Agent agent){
		try{
			if(null == agent.getAreaDataModel()){
				agent.setAreaDataModel(new AreaDataModel());
			}
			List<AreaDataModel> list = isAddressExist(agent.getAreaDataModel());
			if(list.size()>0){
				agent.setAreaDataModel(list.get(0));//获取第一条,应该只有一条
			}else{
				insertAddress(agent.getAreaDataModel());
				//agent.setAreaDataModel(dataModel);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		//将地址设置为AreaDataModel的id
		agent.setAddress(agent.getAreaDataModel().getId());
		agentMapper.modifyAgent(agent);
	}
	
	
	
	
	
	
	public AgentMapper getAgentMapper() {
		return agentMapper;
	}

	public void setAgentMapper(AgentMapper agentMapper) {
		this.agentMapper = agentMapper;
	}
	
}
