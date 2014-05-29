package com.drp.test;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.apache.velocity.app.VelocityEngine;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

import com.drp.dao.AgentService;
import com.drp.domain.Agent;
import com.drp.util.DBUtil;
import com.drp.util.JsonUtil;
import com.drp.util.WebUtil;
import com.opensymphony.xwork2.ActionSupport;

public class ZtreeComponentAction extends ActionSupport{


	private AgentService agentService;
	
	private String idColumn;
	private String pidColumn;
	private String sql;
	private String treeName;
	private String treeCode;
	private String nodeName;
	private String base;
	private String treeData;
	
	
	public void generateStr(){
		
		List<Agent> list = agentService.getAllAgent();
		System.out.println(JsonUtil.toJsonStr(list));
		WebUtil.writeJsonToClient(list);
	}


	
	public void test1(){
		saveTreeConfig();
		List<Map<Object,Object>> resultList = getTreeObj("");
		System.out.println(JsonUtil.toJsonStr(resultList));
		//生成页面
		
		
		generateTreePage();
		WebUtil.writeJsonToClient(resultList);
	}
	
	//生成树的jsp页面
	public void generateTreePage(){
		try{
			HttpServletRequest request = ServletActionContext.getRequest();
			String realPath =request .getRealPath("/");
			
		//	Properties initData = new Properties();
		//	String absolutePath = new File(Thread.currentThread().getContextClassLoader().getResource("").getFile()).getParentFile().getParentFile().getPath();
		//	initData.put("file.resource.loader.path", absolutePath+"tempate");
		//	Velocity.init(initData);
		//	Template template = Velocity.getTemplate("treePage.vm");
			VelocityContext vContext = new VelocityContext();
			vContext.put("idColumn", idColumn);
			vContext.put("pidColumn", pidColumn);
			vContext.put("sql", sql.trim());
			vContext.put("nodeName", nodeName);
			
			StringWriter sw = new StringWriter();
			Velocity.evaluate(vContext, sw, "ttst",new InputStreamReader(Thread.currentThread().getContextClassLoader().getResourceAsStream("treePage.vm")));
			Velocity velocity = new Velocity();
			FileOutputStream fos = new FileOutputStream(realPath+"ztree_pages\\"+treeCode+".jsp");
//			BufferedWriter bWriter = new BufferedWriter(new OutputStreamWriter(fos));
			
			System.out.println(sw.toString());
			OutputStreamWriter os = new OutputStreamWriter(fos);
			String str = sw.toString();
			os.write(str);
			
			os.flush();
			os.close();

		//	template.merge(vContext, bWriter);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	
	public static void shouldInJsp(String sql){

	}
	
	
	public List<Map<Object,Object>> getTreeObj(String sql){
		if("".equals(sql)||sql == null){
			sql = this.sql;
		}
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List<String> columnNameList = new ArrayList<String>();
		List<Map<Object,Object>> resultList = new ArrayList<Map<Object,Object>>();
		try{
			System.out.println(idColumn+" "+pidColumn+" "+sql);
			conn = DBUtil.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			for(int i=0;i<columnCount;i++){
				String columnName = rsmd.getColumnName(i+1);//columnname是从1开始
				columnNameList.add(columnName);
			}
			
			while(rs.next()){
				Map<Object,Object> map = new HashMap<Object,Object>();
				for(int i=0;i<columnNameList.size();i++){
					map.put(columnNameList.get(i).toLowerCase(), rs.getString(columnNameList.get(i)));
				}
				resultList.add(map);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return resultList;
	}
	
	public  byte[] buffer = new byte[200];
	public  void saveTreeConfig(){
		try{
			HttpServletRequest request = ServletActionContext.getRequest();
			String contextPath = request.getContextPath();
			String realPath = ServletActionContext.getServletContext().getRealPath("/");
			File templateFile  = new File(realPath+"ztree\\template.xml"); 
			FileInputStream fis = new FileInputStream(templateFile);
			
			
			SAXBuilder builder = new SAXBuilder();
			Document doc = builder.build(fis);
			Document outputDoc = doc.clone();
			
			Element rootElt = outputDoc.getRootElement();
			Element treeNameElt = rootElt.getChild("treeName");treeNameElt.setText(treeName);
			Element treeCodeElt = rootElt.getChild("treeCode");treeCodeElt.setText(treeCode);
			Element idColumnElt = rootElt.getChild("idColumn");idColumnElt.setText(idColumn);
			Element pidColumnElt = rootElt.getChild("pidColumn");pidColumnElt.setText(pidColumn);
			Element sqlElt = rootElt.getChild("sql");sqlElt.setText(sql);
			XMLOutputter outputter = new XMLOutputter();
			outputter.setFormat(Format.getPrettyFormat().setEncoding("GBK"));
			FileOutputStream docStream =  new FileOutputStream(new File(realPath+"\\ztree\\"+treeCode+"_"+"config.xml"));
			outputter.output(outputDoc,docStream);
			docStream.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public String showTree(){
		HttpServletRequest request = ServletActionContext.getRequest();
		List<Map<Object,Object>> resultList = new ArrayList<Map<Object,Object>>();
		try{
			String realPath = ServletActionContext.getServletContext().getRealPath("/");
			FileInputStream fis = new FileInputStream(realPath+"ztree/"+treeCode+"_config.xml");
			SAXBuilder builder = new SAXBuilder();
			Document doc = builder.build(fis);
			Element rootElt = doc.getRootElement();
			String sql = rootElt.getChildText("sql");
			resultList = getTreeObj(sql);
			
			treeData = JsonUtil.toJsonStr(resultList);
			VelocityEngine ve = new VelocityEngine();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		base = request.getScheme()+"//"+request.getServerName()+":"+request.getServerPort()+"/"+request.getContextPath();
		return "showTree";
	}
	
	
	public static void main(String[] args) {
		tempTest();
	}
	public static void tempTest(){
		try{
			SAXBuilder builder = new SAXBuilder();
			Document doc = builder.build(Thread.currentThread().getContextClassLoader().getResourceAsStream("template.xml"));
			Element rootElt = doc.getRootElement();
			Element elt = rootElt.getChild("treeName");
//			System.out.println(elt.getChildText(cname));
			List<Element> childrenList = rootElt.getChildren();;
			for(Element e : childrenList){
				System.out.println(e.getName());
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public AgentService getAgentService() {
		return agentService;
	}

	public void setAgentService(AgentService agentService) {
		this.agentService = agentService;
	}

	public String getIdColumn() {
		return idColumn;
	}
	public void setIdColumn(String idColumn) {
		this.idColumn = idColumn;
	}

	public String getPidColumn() {
		return pidColumn;
	}

	public void setPidColumn(String pidColumn) {
		this.pidColumn = pidColumn;
	}
	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}



	public String getTreeName() {
		return treeName;
	}



	public void setTreeName(String treeName) {
		this.treeName = treeName;
	}



	public String getTreeCode() {
		return treeCode;
	}
	public void setTreeCode(String treeCode) {
		this.treeCode = treeCode;
	}



	public String getTreeData() {
		return treeData;
	}



	public void setTreeData(String treeData) {
		this.treeData = treeData;
	}



	public byte[] getBuffer() {
		return buffer;
	}



	public void setBuffer(byte[] buffer) {
		this.buffer = buffer;
	}



	public String getBase() {
		return base;
	}



	public void setBase(String base) {
		this.base = base;
	}



	public String getNodeName() {
		return nodeName;
	}



	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	
	
}
