package com.drp.dict;

import java.util.List;

import com.drp.domain.AreaDataModel;

public interface DictMapper {

	//�������ͻ��
	public List<Dict> getDictListByType(String type);
	
	//��ȡ�����ֵ�Ķ���
	public List<Dict> getAllDictObj();
	
	//��ȡ��������
	public String getMaxCategory();
	
	//���ݸýڵ���ӽڵ�
	public List<Dict> getSubDict(Dict dict);
	
	//����ֵ�
	public void addDict(Dict dict);
	
	//�޸��ֵ�
	public void modifyDict(Dict dict);
	
	//ɾ�������ֵ�
	public void deleteDict(Dict dict);
		
	//ɾ�����ֵ䣬���ҵݹ�ɾ���ӽڵ�
	public void deleteMainDict(Dict dict);
	
	//��ȡ����ʡ��
	public List<AreaDataModel> getAllProvince();
	
	//����ʡ�ݻ�ȡ��
	public List<AreaDataModel> getCityByProvince(AreaDataModel areaDataModel);
	
	//����������ȡ�أ�����
	public List<AreaDataModel> getAreaByCity(AreaDataModel areaDataModel);
	
	///����dictId��ȡ���ֵ�
	public Dict getDictById(Dict dict);
	
	//��ȡҩƷ����
	public List<Dict> getFunctionCategory();
}
