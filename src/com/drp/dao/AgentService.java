package com.drp.dao;
import java.util.List;

import com.drp.domain.Agent;
import com.drp.domain.AreaDataModel;

public class AgentService {

	private AgentMapper agentMapper;
	
	//��ȡ���з�����
	public List<Agent> getAllAgent(){
		return agentMapper.getAllAgent();
	}
	
	
	//��ȡ��������
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
	
	
	//��ȡ�ӽڵ�
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
	
	//��ӷ�����
	public void addAgent(Agent agent){
		//����Ƿ�ĵ�ַ�Ƿ����
		try{
			List<AreaDataModel> list = isAddressExist(agent.getAreaDataModel());
			if(list.size()>0){
				agent.setAreaDataModel(list.get(1));//��ȡ��һ��,Ӧ��ֻ��һ��
			}else{
				insertAddress(agent.getAreaDataModel());
				//agent.setAreaDataModel(dataModel);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		//����ַ����ΪAreaDataModel��id
		agent.setAddress(agent.getAreaDataModel().getId());
		agentMapper.addAgent(agent);

	}
	
	
	
	//�жϸõ�ַ�Ƿ����
	private List<AreaDataModel> isAddressExist(AreaDataModel areaDataModel){
		List<AreaDataModel> list = agentMapper.isAddressExist(areaDataModel);
		return list;
	}
	
	//�����ֵ�
	public void  insertAddress(AreaDataModel dataModel){
		agentMapper.insertAddress(dataModel);
	}
	
	//ɾ��������
	public void deleteAgent(Agent agent){
		agentMapper.deleteAgent(agent);
	}

	//����id��ȡ�ĵ�ַ����
	public AreaDataModel getAddressById(AreaDataModel dataModel){
		return agentMapper.getAddressById(dataModel);
	}
	
	
	
	//�����׽ڵ�����Ϊ��Ҷ�ӽڵ�
	public void setParentToNonLeaf(Agent agent){
		agentMapper.setParentToNonLeaf(agent);
	}
	
	
	//�޸�Agent
	public void modifyAgent(Agent agent){
		try{
			if(null == agent.getAreaDataModel()){
				agent.setAreaDataModel(new AreaDataModel());
			}
			List<AreaDataModel> list = isAddressExist(agent.getAreaDataModel());
			if(list.size()>0){
				agent.setAreaDataModel(list.get(0));//��ȡ��һ��,Ӧ��ֻ��һ��
			}else{
				insertAddress(agent.getAreaDataModel());
				//agent.setAreaDataModel(dataModel);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		//����ַ����ΪAreaDataModel��id
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
