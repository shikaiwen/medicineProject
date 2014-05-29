package com.drp.dict;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.drp.domain.AreaDataModel;
import com.drp.util.Constants;
import com.drp.util.JsonUtil;

public class DictService {

	public DictService() {
		System.out.println("DictService��ʼ���˰���������");
	}
	
	private  List<Dict> dicts;
	
	private DictMapper dictMapper;
	
	//��������ȡ�������
	public List<Dict> getDictObj(Dict dict){
		return dictMapper.getDictListByType(dict.getcategory());
	}
	
	//��ȡ������������html������
	public String getDictHtml(String type){
		List<Dict> objList = dictMapper.getDictListByType(type);
		StringBuilder option = new StringBuilder();
		for(Dict d:objList){
			option.append("<option value='"+d.getDictId()+"'>");
			option.append(d.getDictName()+"</option>");
			option.append("\n");
		}
		return option.toString();
	}
	
	public  String getDictTree(){
		List<Dict> dictObjs = dictMapper.getAllDictObj();
		System.out.println(JsonUtil.toJsonStr(dictObjs));
		dicts = dictObjs;
		StringBuilder sb = new StringBuilder();
		sb.append("[");
		directStr(sb,Constants.pid);
		sb.append("]");
		System.out.println(sb.toString());
		return sb.toString();
	}
	
	private String directStr(StringBuilder sb,int id){
		for(int i=0;i<dicts.size();i++){
			Dict dict = dicts.get(i);
			if(dict.getPid()==id){
				//�������ӽڵ����
				sb.append("{");
				sb.append("name:").append("\"").append(dict.getDictName()).append("\"");
				sb.append(",open:true");
				sb.append(",id:").append("\"").append(+dict.getDictId()).append("\"");
				sb.append(",category:").append("\"").append(dict.getcategory()).append("\"");
				sb.append(",isValueDict:").append("\"").append(dict.getIsValueDict()).append("\"");
				sb.append(",value:").append("\"").append(dict.getValue()).append("\"");
				sb.append(",pid:").append("\"").append(dict.getPid()).append("\"");
				if("N".equals(dict.getIs_leaf())){
					sb.append(",children:").append("[");
					for(int j=0;j<dicts.size();j++){
						Dict sub = dicts.get(j);
						if(dict.getDictId()==sub.getPid()){
							sb.append("{");
							sb.append("name:").append("\"").append(sub.getDictName()).append("\"");
							sb.append(",open:true");
							sb.append(",id:").append("\"").append(+sub.getDictId()).append("\"");
							sb.append(",category:").append("\"").append(sub.getcategory()).append("\"");
							sb.append(",isValueDict:").append("\"").append(sub.getIsValueDict()).append("\"");
							sb.append(",value:").append("\"").append(sub.getValue()).append("\"");
							sb.append(",pid:").append("\"").append(sub.getPid()).append("\"");
							sb.append("},");
						}
					}
 					if(sb.charAt(sb.length()-1)==','){
 						sb.deleteCharAt(sb.length()-1);
					}
					sb.append("]");
				}
				sb.append("}");
			}
		}
		return "";
	}
	

	//����ֵ�
	public void addDict(Dict dict){
		dictMapper.addDict(dict);
	}
	
	//�޸��ֵ�
	public void modifyDict(Dict dict){
		dictMapper.modifyDict(dict);
	}
	
	
	//ɾ����dict
	public void deleteMainDict(Dict dict){
		dictMapper.deleteMainDict(dict);
	}
	
	//ɾ������Dict
	public void deleteDict(Dict dict){
		dictMapper.deleteDict(dict);
	}
	
	//ɾ�����Dict
	public void deleteMultipleDict(List<Dict> dicts){
		for(int i=0;i<dicts.size();i++){
			deleteDict(dicts.get(i));
		}
	}
	
	//����������
	public  String getMaxCategory(){
		String maxCategory = dictMapper.getMaxCategory();
		return maxCategory;
	}


	//��ȡ����ʡ��
	public String getAllProvince(){
		List<AreaDataModel> dataModel = dictMapper.getAllProvince();
		return areaOptionConverter(dataModel);
	}
	
	//����ʡ�ݻ�ȡ����
	public String getCityByProvince(AreaDataModel areaDataModel){
		List<AreaDataModel> dataModel = dictMapper.getCityByProvince(areaDataModel);
		return areaOptionConverter(dataModel);
	}
	
	//����������ȡ�أ�����
	public String getAreaByCity(AreaDataModel areaDataModel){
		List<AreaDataModel> dataModel = dictMapper.getAreaByCity(areaDataModel);
		return areaOptionConverter(dataModel);
	}
	
	public String areaOptionConverter(List<AreaDataModel> areaDataModel){
		StringBuilder options = new StringBuilder();
		options.append("<option><--��ѡ��--></option>").append("\n");
		for(int i=0;i<areaDataModel.size();i++){
			AreaDataModel model = areaDataModel.get(i);
			options.append("<option value='"+model.getAreaId()+"'>");
			options.append(model.getAreaName()).append("</option>");
			options.append("\n");
		}
		return options.toString();
	}
	
	
	
	//����dictId��ȡ���ֵ�
	public Dict getDictById(Dict dict){
		Dict d = dictMapper.getDictById(dict);
		return d;
	}
	
	
	//��ȡ��ֵ��Map���ϣ�key��id��value��
	public  Map<Integer,String> getKeyValueMap(String type){
		Map<Integer,String> keyValueMap = new HashMap<Integer,String>();
		List<Dict> dictList = dictMapper.getDictListByType(type);
		for(Dict d : dictList){
			keyValueMap.put(d.getDictId(), d.getValue());
		}
		return keyValueMap;
	}
	
	public List<Dict> getDicts() {
		return dicts;
	}

	public void setDicts(List<Dict> dicts) {
		this.dicts = dicts;
	}

	public DictMapper getDictMapper() {
		return dictMapper;
	}

	public void setDictMapper(DictMapper dictMapper) {
		this.dictMapper = dictMapper;
	}


	
	
}
