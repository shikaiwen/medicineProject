package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.dict.Dict;
import com.drp.domain.Medicine;
import com.drp.json.model.MedicineJsonModel;

public class MedicineService {

	
	
	private MedicineMapper medicineMapper;
	//分页查找药品
	public List<Medicine> getResultByPage(Map map){
		
		List<Medicine> medicineList = medicineMapper.getResultByPage(map);
		return medicineList;
	}
	

	//获取总数目
	public int getAllMedicineCount(){
		return medicineMapper.getAllMedicineCount();
	}
	
	//添加药品
	public void addMedicine(Medicine medicine){
		medicineMapper.addMedicine(medicine);
	}

	//修改药品
	public void modifyMedicine(Medicine medicine){
		medicineMapper.modifyMedicine(medicine);
	}
	
	
	//获取序列中的下一个编号
	public int getMedicineSequenceNextVal(){
		int sequenceNo = medicineMapper.getMedicineSequenceNextVal();
		return sequenceNo;
	}
	
	//删除图片
	public void deletePic(Medicine medicine){
		medicineMapper.deletePic(medicine);
	}
	
	
	//根据代码查询
	public Medicine getMedicineByNo(Medicine m){
		return medicineMapper.getMedicineByNo(m);
	}
	
	
	//删除药品
	public void deleteMedicine(Medicine m){
		medicineMapper.deleteMedicine(m);
	}
	
	public List<Dict> getDictObj(String type){
		return null;
	}

	public MedicineMapper getMedicineMapper() {
		return medicineMapper;
	}

	public void setMedicineMapper(MedicineMapper medicineMapper) {
		this.medicineMapper = medicineMapper;
	}

	
}
