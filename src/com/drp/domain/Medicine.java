package com.drp.domain;

import com.drp.dict.Dict;

public class Medicine {

	private String medicineNo;
	private String medicineName;
//	private int functionType;
	private Dict functionType;
	private Dict manageType;
	private float price;
	private String approvalNumber;
	private String normalName;
	private String specification;
	private String ingredients;
	private Dict unit;
	private String manufacturer;
	private String descriptions;
	private String img;
	//private String useSpecialPrice;
	private Dict  useSpecialPrice;
	private String fixedPriceId;
	private String productLabel;
	private String usageDosage;
	
	
	
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


	public String getApprovalNumber() {
		return approvalNumber;
	}
	public void setApprovalNumber(String approvalNumber) {
		this.approvalNumber = approvalNumber;
	}
	public String getSpecification() {
		return specification;
	}
	public void setSpecification(String specification) {
		this.specification = specification;
	}
	public String getIngredients() {
		return ingredients;
	}
	public void setIngredients(String ingredients) {
		this.ingredients = ingredients;
	}


	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}


	public String getDescriptions() {
		return descriptions;
	}
	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}


	public Dict getUseSpecialPrice() {
		return useSpecialPrice;
	}
	public void setUseSpecialPrice(Dict useSpecialPrice) {
		this.useSpecialPrice = useSpecialPrice;
	}
	public String getFixedPriceId() {
		return fixedPriceId;
	}
	public void setFixedPriceId(String fixedPriceId) {
		this.fixedPriceId = fixedPriceId;
	}
	public String getProductLabel() {
		return productLabel;
	}
	public void setProductLabel(String productLabel) {
		this.productLabel = productLabel;
	}
	public String getUsageDosage() {
		return usageDosage;
	}
	public void setUsageDosage(String usageDosage) {
		this.usageDosage = usageDosage;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getNormalName() {
		return normalName;
	}
	public void setNormalName(String normalName) {
		this.normalName = normalName;
	}
	public Dict getFunctionType() {
		return functionType;
	}
	public void setFunctionType(Dict functionType) {
		this.functionType = functionType;
	}
	public Dict getManageType() {
		return manageType;
	}
	public void setManageType(Dict manageType) {
		this.manageType = manageType;
	}
	public Dict getUnit() {
		return unit;
	}
	public void setUnit(Dict unit) {
		this.unit = unit;
	}

	
	
	
	
	
}
