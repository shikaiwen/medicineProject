package com.drp.domain;

public class AreaDataModel {

	/**
	 * ����ͨ�õĵ���ģ�Ͱ���ʡ����
	 */
	//��id���ڱ��о���Ϊt_address������
	private int id;
	private int areaId;
	private String areaName;
	private int pid;
	
	
	
	
	
	private int provinceId;
	private String provinceName;
	private int cityId;
	private String cityName;
	
	
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAreaId() {
		return areaId;
	}
	public void setAreaId(int areaId) {
		this.areaId = areaId;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(int provinceId) {
		this.provinceId = provinceId;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	public int getCityId() {
		return cityId;
	}
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getStrFormat(){
		
		return provinceName+cityName+areaName;
	}
	
	
}
