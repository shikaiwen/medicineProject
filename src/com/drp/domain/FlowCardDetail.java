package com.drp.domain;

import java.util.List;

public class FlowCardDetail {

	private String flowCardDetailId;
	private Medicine medicine;
	private float price;
	private int quantity;
	private String  medicineNoList;
	private String flowCardId;
	public Medicine getMedicine() {
		return medicine;
	}
	public void setMedicine(Medicine medicine) {
		this.medicine = medicine;
	}
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getFlowCardDetailId() {
		return flowCardDetailId;
	}
	public void setFlowCardDetailId(String flowCardDetailId) {
		this.flowCardDetailId = flowCardDetailId;
	}
	public String getMedicineNoList() {
		return medicineNoList;
	}
	public void setMedicineNoList(String medicineNoList) {
		this.medicineNoList = medicineNoList;
	}
	public String getFlowCardId() {
		return flowCardId;
	}
	public void setFlowCardId(String flowCardId) {
		this.flowCardId = flowCardId;
	}


	
}
