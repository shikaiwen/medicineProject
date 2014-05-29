package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.Medicine;

public interface MedicineMapper {

	//���ݷ�ҳ��ȡ����
	public List<Medicine> getResultByPage(Map map);
	
	//���ҩƷ
	public void addMedicine(Medicine medicine);
	
	//�޸�ҩƷ
	public void modifyMedicine(Medicine medicine);
	
	//��ȡҩƷ���
	public int getMedicineSequenceNextVal();
	
	//��ȡҩƷ��Ŀ
	public int getAllMedicineCount();
	
	//ɾ��ͼƬ
	public void deletePic(Medicine medicine);
	
	//����medicineNo��ѯ
	public Medicine getMedicineByNo(Medicine m);
	
	//ɾ��ҩƷ
	public void deleteMedicine(Medicine m);
}
