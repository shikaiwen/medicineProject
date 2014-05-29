package com.drp.domain;

public class Agent {

	private int agentId;
	private String agentName;
	private String contactMan;
	private String telephone;
	private String fixedPhone;
	private String email;
	private String isAgent;
	private String isLeaf;
	private int pid;
	private int agentLevel;
	private String createDate;
	private String detailedAddress;
	private AreaDataModel areaDataModel;
	private int address;
	public int getAgentId() {
		return agentId;
	}
	public void setAgentId(int agentId) {
		this.agentId = agentId;
	}
	public String getAgentName() {
		return agentName;
	}
	public void setAgentName(String agentName) {
		this.agentName = agentName;
	}
	public String getContactMan() {
		return contactMan;
	}
	public void setContactMan(String contactMan) {
		this.contactMan = contactMan;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getFixedPhone() {
		return fixedPhone;
	}
	public void setFixedPhone(String fixedPhone) {
		this.fixedPhone = fixedPhone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getIsAgent() {
		return isAgent;
	}
	public void setIsAgent(String isAgent) {
		this.isAgent = isAgent;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}


	public int getAgentLevel() {
		return agentLevel;
	}
	public void setAgentLevel(int agentLevel) {
		this.agentLevel = agentLevel;
	}
	public String getIsLeaf() {
		return isLeaf;
	}
	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}
	public AreaDataModel getAreaDataModel() {
		return areaDataModel;
	}
	public void setAreaDataModel(AreaDataModel areaDataModel) {
		this.areaDataModel = areaDataModel;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public int getAddress() {
		return address;
	}
	public void setAddress(int address) {
		this.address = address;
	}
	public String getDetailedAddress() {
		return detailedAddress;
	}
	public void setDetailedAddress(String detailedAddress) {
		this.detailedAddress = detailedAddress;
	}


	
	
	
}
