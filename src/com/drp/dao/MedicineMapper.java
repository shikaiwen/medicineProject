package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.Medicine;

public interface MedicineMapper {

	//根据分页获取数据
	public List<Medicine> getResultByPage(Map map);
	
	//添加药品
	public void addMedicine(Medicine medicine);
	
	//修改药品
	public void modifyMedicine(Medicine medicine);
	
	//获取药品编号
	public int getMedicineSequenceNextVal();
	
	//获取药品数目
	public int getAllMedicineCount();
	
	//删除图片
	public void deletePic(Medicine medicine);
	
	//根据medicineNo查询
	public Medicine getMedicineByNo(Medicine m);
	
	//删除药品
	public void deleteMedicine(Medicine m);
}
