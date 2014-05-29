package com.drp.domain;

public class MedicineSaleInfo implements Comparable{

	

	
	
	
	public int compareTo(Object obj) {
		
		return this.createDate.compareTo((String)obj);
	}
	
	
	
	private String medicineNo;
	private String medicineName;
	private int quantity;
	private float totalMoney;
	private String createDate;
	public String getMedicineNo() {
		return medicineNo;
	}
	public void setMedicineNo(String medicineNo) {
		this.medicineNo = medicineNo;
	}
	public String getMedicineName() {
		return medicineName;
	}
	public void setMedicineName(String medicineName) {
		this.medicineName = medicineName;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public float getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(float totalMoney) {
		this.totalMoney = totalMoney;
	}

	
}
