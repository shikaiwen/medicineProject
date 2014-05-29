package com.drp.domain;

public class OrderDetail {

	private Order order;
	private String detailId;
	private String medicineNo;
	private Medicine medicine;
	private int quantity;
	private float price;
	
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}


	public String getDetailId() {
		return detailId;
	}
	public void setDetailId(String detailId) {
		this.detailId = detailId;
	}
	public String getMedicineNo() {
		return medicineNo;
	}
	public void setMedicineNo(String medicineNo) {
		this.medicineNo = medicineNo;
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
	public Medicine getMedicine() {
		return medicine;
	}
	public void setMedicine(Medicine medicine) {
		this.medicine = medicine;
	}
	
	
	
}
