package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.dict.Dict;
import com.drp.domain.Medicine;
import com.drp.json.model.MedicineJsonModel;

public class MedicineService {

	
	
	private MedicineMapper medicineMapper;
	//��ҳ����ҩƷ
	public List<Medicine> getResultByPage(Map map){
		
		List<Medicine> medicineList = medicineMapper.getResultByPage(map);
		return medicineList;
	}
	

	//��ȡ����Ŀ
	public int getAllMedicineCount(){
		return medicineMapper.getAllMedicineCount();
	}
	
	//���ҩƷ
	public void addMedicine(Medicine medicine){
		medicineMapper.addMedicine(medicine);
	}

	//�޸�ҩƷ
	public void modifyMedicine(Medicine medicine){
		medicineMapper.modifyMedicine(medicine);
	}
	
	
	//��ȡ�����е���һ�����
	public int getMedicineSequenceNextVal(){
		int sequenceNo = medicineMapper.getMedicineSequenceNextVal();
		return sequenceNo;
	}
	
	//ɾ��ͼƬ
	public void deletePic(Medicine medicine){
		medicineMapper.deletePic(medicine);
	}
	
	
	//���ݴ����ѯ
	public Medicine getMedicineByNo(Medicine m){
		return medicineMapper.getMedicineByNo(m);
	}
	
	
	//ɾ��ҩƷ
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
