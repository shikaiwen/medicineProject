package com.drp.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class StoreCard {

	private String storeId;
	private User creator;
	private Date createDate;
	
	private List<StoreCardDetail> detailList = new ArrayList<StoreCardDetail>();
	
	
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public User getCreator() {
		return creator;
	}
	public void setCreator(User creator) {
		this.creator = creator;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public List<StoreCardDetail> getDetailList() {
		return detailList;
	}
	public void setDetailList(List<StoreCardDetail> detailList) {
		this.detailList = detailList;
	}
	
	
	
	
}
