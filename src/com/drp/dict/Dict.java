package com.drp.dict;

public class Dict {

	private int dictId;
	private String dictName;
	private String category;
	private int pid;
	private String is_leaf;
	private String is_main;
	private String value;
	private String isValueDict;
	public int getDictId() {
		return dictId;
	}
	public void setDictId(int dictId) {
		this.dictId = dictId;
	}
	public String getDictName() {
		return dictName  ==null?"":dictName;
	}
	public void setDictName(String dictName) {
		this.dictName = dictName;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getcategory() {
		return category;
	}
	public void setcategory(String category) {
		this.category = category;
	}
	public String getCategory() {
		return category ==null?"":category ;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getIs_leaf() {
		return is_leaf ==null?"":is_leaf;
	}
	public void setIs_leaf(String is_leaf) {
		this.is_leaf = is_leaf;
	}
	public String getIs_main() {
		return is_main==null?"":is_main;
	}
	public void setIs_main(String is_main) {
		this.is_main = is_main;
	}


	public String getValue() {
		return value==null?"":value;
	}
	public void setValue(String value) {
		this.value = value ;
	}
	public String getIsValueDict() {
		return isValueDict ==null?"":isValueDict;
	}
	public void setIsValueDict(String isValueDict) {
		this.isValueDict = isValueDict;
	}


	

	
	
	
}
