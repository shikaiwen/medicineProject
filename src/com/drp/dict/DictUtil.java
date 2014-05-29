package com.drp.dict;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DictUtil {

	private static DictUtil dictUtil;
	private DictMapper dictMapper;
	//单例管理
	static{
		if(dictUtil == null){
			dictUtil = new DictUtil();
		}
	}
	
	public static DictUtil getInstance(){
		return dictUtil;
	}

	
	//获取键值的Map集合，key是id，value是
	public  Map<Integer,String> getKeyValueMap(String type){
		Map<Integer,String> keyValueMap = new HashMap<Integer,String>();
		List<Dict> dictList = dictMapper.getDictListByType(type);
		for(Dict d : dictList){
			keyValueMap.put(d.getDictId(), d.getValue());
		}
		return keyValueMap;
	}

	public DictMapper getDictMapper() {
		return dictMapper;
	}

	public void setDictMapper(DictMapper dictMapper) {
		this.dictMapper = dictMapper;
	}

	
}
