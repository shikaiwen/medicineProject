package com.drp.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.drp.dao.AgentService;
import com.drp.dict.Dict;
import com.drp.dict.DictService;
import com.drp.domain.Agent;
import com.drp.domain.AreaDataModel;
import com.drp.util.CommonUtil;
import com.drp.util.Constants;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ValueStack;


public class AgentAction extends ActionSupport{

	private Agent agent;
	private List<Agent> agents;
	private AgentService agentService;
	private DictService dictService;
	
	//��ȡ��������
	public void getTree(){
		String treeStr = "";
		try{
			treeStr = agentService.getAgentTreeStr(agent);
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text/html;charset= gbk");
			response.getWriter().write(treeStr);
			response.getWriter().flush();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//�鿴������
	public String toViewAgent(){
		try{
			agent = agentService.getAgentById(agent);
			Temp tempObj = new Temp();
			ValueStack valueStack = ActionContext.getContext().getValueStack();
			Dict d = new Dict();
			d.setDictId(agent.getAgentLevel());
			Dict dict = dictService.getDictById(d);
			//�������̼���������ӵ�ValueStack
			tempObj.setAgent_level(dict.getDictName());
			//���ݵ�ַid��ȡ��ַ
			AreaDataModel adm = new AreaDataModel();
			adm.setId(agent.getAddress());
			adm = agentService.getAddressById(adm);
			tempObj.setAddress(adm.getProvinceName()+adm.getCityName()+adm.getAreaName()+(agent.getDetailedAddress()==null?"":agent.getDetailedAddress()));
			valueStack.push(tempObj);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "showAgentInfo";
	}
	
	public String toViewRegion(){
		try{
			agent = agentService.getAgentById(agent);
			Temp tempObj = new Temp();
			ValueStack valueStack = ActionContext.getContext().getValueStack();
			//���ݵ�ַid��ȡ��ַ
			AreaDataModel adm = new AreaDataModel();
			adm.setId(agent.getAddress());
			adm = agentService.getAddressById(adm);
			tempObj.setAddress(adm.getProvinceName()+adm.getCityName()+adm.getAreaName());
			valueStack.push(tempObj);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "showRegionInfo";
	}
	
	//��ӷ�����
	public String addAgent(){
		Temp tempObj = new Temp();
		try{
		ValueStack valueStack = ActionContext.getContext().getValueStack();
		Dict d = new Dict();
		d.setDictId(agent.getAgentLevel()); 
		Dict dict = dictService.getDictById(d);
		//�������̼���������ӵ�ValueStack
		if(null != dict){
			tempObj.setAgent_level(dict.getDictName());
		}
		AreaDataModel adm = agent.getAreaDataModel();
		tempObj.setAddress(adm.getProvinceName()+adm.getCityName()+adm.getAreaName()+(agent.getDetailedAddress()==null?"":agent.getDetailedAddress()));
		valueStack.push(tempObj);
		//���õ�ַ
		AreaDataModel m = new AreaDataModel();
		m.setId(agent.getAddress());
		if(agentService.getAddressById(m) != null){
			
		}
		//����ַ��ӵ�ValueStack
		agent.setCreateDate(CommonUtil.getCurrentDateStr());
		if(null == agent.getIsLeaf()){
			agent.setIsLeaf(Constants.Y);
		}
		agentService.addAgent(agent);
		agentService.setParentToNonLeaf(agent);
		}catch(Exception e){
			e.printStackTrace();
		}
	return "afterAdd";	
	}
	
	//�������
	public String addRegion(){
		Temp tempObj = new Temp();
		try{
		ValueStack valueStack = ActionContext.getContext().getValueStack();
		AreaDataModel adm = agent.getAreaDataModel();
		tempObj.setAddress(adm.getProvinceName()+adm.getCityName()+adm.getAreaName());
		valueStack.push(tempObj);
		//����ַ��ӵ�ValueStack
		agent.setCreateDate(CommonUtil.getCurrentDateStr());
		if(null == agent.getIsLeaf()){
			agent.setIsLeaf(Constants.Y);
		}
		//����ϸ��ַλ��Ϊ���ַ���
		agent.setDetailedAddress("");
		agentService.addAgent(agent);
		//�����׽ڵ�����Ϊ�ǽڵ�
		agentService.setParentToNonLeaf(agent);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "afterAddRegion";
	}
	
	//�޸ķ�����
	public String modifyAgent(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String prepare = request.getParameter("prepare");
		if(Constants.Y.equals(prepare)){
			try{
				agent = agentService.getAgentById(agent);
				Temp tempObj = new Temp();
				ValueStack valueStack = ActionContext.getContext().getValueStack();
				//���ݵ�ַid��ȡ��ַ
				AreaDataModel adm = new AreaDataModel();
				adm.setId(agent.getAddress());
				adm = agentService.getAddressById(adm);
				agent.setAreaDataModel(adm);
			}catch(Exception e){
				e.printStackTrace();
			}
			return "toModifyAgent";
		}
		
		//ִ�е�����˵�����������޸Ĳ���
		try{
			agentService.modifyAgent(agent);
		}catch(Exception e){
			e.printStackTrace();
		}
		//ת����ͼ
		ValueStack valueStack = ActionContext.getContext().getValueStack();
		Dict d = new Dict();
		d.setDictId(agent.getAgentLevel());
		Dict dict = dictService.getDictById(d);
		Temp tempObj = new Temp();
		AreaDataModel adm = agent.getAreaDataModel();
		tempObj.setAgent_level(dict.getDictName());
		tempObj.setAddress(adm.getProvinceName()+adm.getCityName()+adm.getAreaName()+(agent.getDetailedAddress()==null?"":agent.getDetailedAddress()));
		valueStack.push(tempObj);
		if(Constants.Y.equals(agent.getIsAgent())){
			return "showAgentInfo";
		}else{
			return "showRegionInfo";
		}
	}
	
	//�޸�����
	public String modifyRegion(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String prepare = request.getParameter("prepare");
		if(Constants.Y.equals(prepare)){
			try{
				agent = agentService.getAgentById(agent);
				Temp tempObj = new Temp();
				ValueStack valueStack = ActionContext.getContext().getValueStack();
				
				//���ݵ�ַid��ȡ��ַ
				AreaDataModel adm = new AreaDataModel();
				adm.setId(agent.getAddress());
				adm = agentService.getAddressById(adm);
				agent.setAreaDataModel(adm);
			}catch(Exception e){
				e.printStackTrace();
			}
			return "toModifyRegion";
		}
		//ִ�е�����˵�����������޸Ĳ���
		try{
			agentService.modifyAgent(agent);
		}catch(Exception e){
			e.printStackTrace();
		}
		//ת����ͼ
		ValueStack valueStack = ActionContext.getContext().getValueStack();
		Temp tempObj = new Temp();
		AreaDataModel adm = agent.getAreaDataModel();
		tempObj.setAddress(adm.getProvinceName()+adm.getCityName()+adm.getAreaName());
		valueStack.push(tempObj);
		if(Constants.Y.equals(agent.getIsAgent())){
			return "showRegionInfo";
		}else{
			return "showRegionInfo";
		}
	}
	
	//ɾ�������� ��������
	public void deleteAgent(){
		try{
			agentService.deleteAgent(agent);
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public Agent getAgent() {
		return agent;
	}

	public void setAgent(Agent agent) {
		this.agent = agent;
	}

	public List<Agent> getAgents() {
		return agents;
	}

	public void setAgents(List<Agent> agents) {
		this.agents = agents;
	}

	public AgentService getAgentService() {
		return agentService;
	}

	public void setAgentService(AgentService agentService) {
		this.agentService = agentService;
	}

	public DictService getDictService() {
		return dictService;
	}

	public void setDictService(DictService dictService) {
		this.dictService = dictService;
	}
}

class Temp {
	public String agent_level;
	private String address;
	public String getAgent_level() {
		return agent_level;
	}
	public void setAgent_level(String agent_level) {
		this.agent_level = agent_level;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
