package com.drp.dict;

import java.util.List;

import com.drp.domain.AreaDataModel;

public interface DictMapper {

	//根据类型获得
	public List<Dict> getDictListByType(String type);
	
	//获取所有字典的对象
	public List<Dict> getAllDictObj();
	
	//获取最大的类型
	public String getMaxCategory();
	
	//根据该节点的子节点
	public List<Dict> getSubDict(Dict dict);
	
	//添加字典
	public void addDict(Dict dict);
	
	//修改字典
	public void modifyDict(Dict dict);
	
	//删除单个字典
	public void deleteDict(Dict dict);
		
	//删除主字典，并且递归删除子节点
	public void deleteMainDict(Dict dict);
	
	//获取所有省份
	public List<AreaDataModel> getAllProvince();
	
	//根据省份获取市
	public List<AreaDataModel> getCityByProvince(AreaDataModel areaDataModel);
	
	//根据市区获取县（区）
	public List<AreaDataModel> getAreaByCity(AreaDataModel areaDataModel);
	
	///根据dictId获取该字典
	public Dict getDictById(Dict dict);
	
	//获取药品分类
	public List<Dict> getFunctionCategory();
}
