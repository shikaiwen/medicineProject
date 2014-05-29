package com.drp.dict;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;

import com.drp.domain.AreaDataModel;
import com.drp.util.CommonUtil;
import com.drp.util.Constants;
import com.drp.util.JsonUtil;
import com.drp.util.ResultJsonModel;
import com.drp.util.WebUtil;
import com.opensymphony.xwork2.ActionSupport;

public class DictAction extends ActionSupport{

	private Dict dict ;
	private List<Dict> dicts = null;
	private DictService dictService;
	private ResultJsonModel  resultJsonModel;
	private AreaDataModel areaDataModel;
	
	
	
	
	//返回<option>
	public void getDictHtml(){
		@SuppressWarnings("unused")
		String options = dictService.getDictHtml(dict.getcategory());
		WebUtil.WriteStrToClient(options);
	}
	
	//获取所有省份
	public void getAllProvince(){
		try{
			String provinceOptionStr = dictService.getAllProvince();
			System.out.println(provinceOptionStr);
			WebUtil.WriteStrToClient(provinceOptionStr);
		}catch(Exception e){
			e.printStackTrace();
		}

	}
	
	//根据省获取市区
	public void getCityByProvince(){
		try{
			String cityStr = dictService.getCityByProvince(areaDataModel);
			WebUtil.WriteStrToClient(cityStr);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	//根据市获取县
	public void getAreaByCity(){
		try{
			 String areaStr = dictService.getAreaByCity(areaDataModel);
			 WebUtil.WriteStrToClient(areaStr);
		}catch(Exception e){
			e.printStackTrace();
		}

	}
	
	 
	//返回字典树
	public void getTree(){
		String treeStr = null;
		try{
			 treeStr = dictService.getDictTree();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(null == dictService){
			ServletContext sc = ServletActionContext.getServletContext();
			WebApplicationContext wac=(WebApplicationContext)sc.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
			DictService dd = (DictService)wac.getBean("dictService");
			System.out.println(dd);
		}
		
		System.out.println(treeStr);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=gbk");
		PrintWriter out = null;
		try{
			out = response.getWriter();
			out.write(treeStr);
			out.flush();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//添加字典
	public void addDict(){
		try{
			String max = dictService.getMaxCategory();
			max = CommonUtil.computeNextValue(max);
			dict.setcategory(max);
			dictService.addDict(dict);
		}catch(Exception e){
			e.printStackTrace();
		}

	}
	
	//添加子类型
	public void addSubDict(){
		try{
			dictService.addDict(dict);
			resultJsonModel.addAsSimpleFormatResult("dict", dict);
			System.out.println(JsonUtil.toJsonStr(resultJsonModel));
			WebUtil.writeJsonToClient(resultJsonModel);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	//根据类型获取字典对象列表
	public void getDictByType(){
		dicts = dictService.getDictObj(dict);
		System.out.println(JsonUtil.toJsonStr(dicts));
		WebUtil.writeJsonToClient(dicts);
	}

	
	//根据字典,type是直接传递到对象中的category中
	public void getDictOptionByType(){
		List<Dict> dictList = dictService.getDictObj(dict);
		
		StringBuilder sb = new StringBuilder();
		sb.append("<option value='0'><--请选择--></option>").append("/n");
		for(int i=0;i<dictList.size();i++){
			Dict d = dictList.get(i);
			sb.append("<option value='").append(d.getDictId()+"'>").append(d.getDictName()).append("</option>");
			sb.append("/n");
		}
		WebUtil.WriteStrToClient(sb.toString());
	}
	
	public void getDictOptionByTypeWithNoHeader(){
		List<Dict> dictList = dictService.getDictObj(dict);
		
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<dictList.size();i++){
			Dict d = dictList.get(i);
			sb.append("<option value='").append(d.getDictId()+"'>").append(d.getDictName()).append("</option>");
			sb.append("/n");
		}
		WebUtil.WriteStrToClient(sb.toString());
	}
	
	//修改字典
 	public void modifyDict(){
		try{
			System.out.println("to modify");
			dictService.modifyDict(dict);
			WebUtil.writeJsonToClient(Constants.successStr);
		}catch(Exception e){
			e.printStackTrace();
		}

	}
	
	//删除主分类字典
	public void deleteMainDict(){
		try{
			dictService.deleteMainDict(dict);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	
	
	
	//删除多个子分类节点
	public void deleteMultipleDict(){
		try{
			dictService.deleteMultipleDict(dicts);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	
	//获取药品分类
	public void getFunctionCategory(){
		try{
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public DictService getDictService() {
		return dictService;
	}

	public void setDictService(DictService dictService) {
		this.dictService = dictService;
	}


	public Dict getDict() {
		return dict;
	}

	public void setDict(Dict dict) {
		this.dict = dict;
	}

	public List<Dict> getDicts() {
		return dicts;
	}

	public void setDicts(List<Dict> dicts) {
		this.dicts = dicts;
	}

	public ResultJsonModel getResultJsonModel() {
		return resultJsonModel;
	}

	public void setResultJsonModel(ResultJsonModel resultJsonModel) {
		this.resultJsonModel = resultJsonModel;
	}

	public AreaDataModel getAreaDataModel() {
		return areaDataModel;
	}

	public void setAreaDataModel(AreaDataModel areaDataModel) {
		this.areaDataModel = areaDataModel;
	}

	

}
