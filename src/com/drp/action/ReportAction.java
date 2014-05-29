package com.drp.action;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.struts2.ServletActionContext;

import com.drp.dao.ReportService;
import com.drp.domain.MedicineSaleInfo;
import com.drp.util.CommonUtil;
import com.drp.util.DBUtil;
import com.drp.util.JsonUtil;
import com.drp.util.WebUtil;
import com.opensymphony.xwork2.ActionSupport;

public class ReportAction extends ActionSupport{

	
	private String startDate;
	private String endDate;
	//�����ͳ��
	private String sumYear;
	private List<String> medicineNoArray ;
	private ReportService reportService;
	
	//����������
	public  void generateReport(){
		ServletContext servletContext = ServletActionContext.getServletContext();
		String path = servletContext.getRealPath("/");
		String jasperPath = path+"jasper\\report1.jasper";
		Map<String,Object> parameters = new HashMap<String,Object>();
		//�˴���ʱ���ģ���Ϊ������������Ĳ�����������
		parameters.put("createDate", sumYear);
		try{
			String htmlPath = "jasper/jasper.html";
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperPath, parameters, getConn());
			JasperExportManager.exportReportToHtmlFile(jasperPrint,path+htmlPath);
			System.out.println(htmlPath);
			WebUtil.WriteStrToClient(htmlPath);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	public static void main(String[] args) {
		try{
			Map<String,Object> parameters = new HashMap<String,Object>();
			//�˴���ʱ���ģ���Ϊ������������Ĳ�����������
			parameters.put("createDate", "2013");
			JasperPrint jasperPrint = JasperFillManager.fillReport("f:\\t2.jasper", parameters, getConn());
			JasperExportManager.exportReportToPdfFile(jasperPrint,"f:\\aa.pdf");
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public static Connection getConn(){
		DBUtil util = new DBUtil();
		SqlSessionFactory factory = util.getSqlSessionFactory();
		SqlSession session = factory.openSession();
		Connection conn = session.getConnection();
		return conn;
	}
	
	//��ѯҩƷ�������
	public void queryMedicineSaleInfo(){
		try{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			map.put("medicineNoArray", medicineNoArray);
			map.put("length",medicineNoArray.size());
			System.out.println(JsonUtil.toJsonStr(map));
			System.out.println(map.get("endDate"));
			List<MedicineSaleInfo> medicineList = reportService.queryMedicineSaleInfo(map);
			System.out.println(JsonUtil.toJsonStr(medicineList));
			String result = generateChartXml(medicineList);
			WebUtil.WriteStrToClient(result); 
			System.out.println(result);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public String generateChartXml(List<MedicineSaleInfo> medicineList){
		List<String> queryMonthStrList = new ArrayList();
		queryMonthStrList.add("2013-05");
		queryMonthStrList.add("2013-06");
		Map<String,Map<String,MedicineSaleInfo>> medicineNoMap = new Hashtable<String,Map<String,MedicineSaleInfo>>();
		//��ÿ��ҩƷ�ŵ�һ��list��
		for(MedicineSaleInfo m : medicineList){
			String medicineNo = m.getMedicineNo();
			if(!medicineNoMap.containsKey(medicineNo)){
				//List<MedicineSaleInfo> list = new ArrayList<MedicineSaleInfo>();
				Map<String,MedicineSaleInfo> map = new HashMap<String,MedicineSaleInfo>();
				map.put(m.getCreateDate(), m);
				medicineNoMap.put(medicineNo,map);
			}else{
				Map<String,MedicineSaleInfo> map = medicineNoMap.get(medicineNo);
				map.put(m.getCreateDate(), m);
			}
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append("<chart caption='�������' xAxisName='�·�' yAxisName='���' numberPrefix='��'> ");
		sb.append("<categories>");
		for(String mon : queryMonthStrList){
			  int month = Integer.parseInt(mon.split("-")[1]);
			  String dateStr = CommonUtil.getChineseMonthStr(month);//�����·�
			sb.append("<category Label='").append(dateStr).append("'/>");
		}
		sb.append("</categories>");
		//��ȡkey����
		System.out.println(JsonUtil.toJsonStr(medicineNoMap));
		Set<String> keySet = medicineNoMap.keySet();
		for(String key :keySet){
			Map<String,MedicineSaleInfo> saleInfo = medicineNoMap.get(key);
			System.out.println(JsonUtil.toJsonStr(saleInfo));
			String create_date = (String)saleInfo.keySet().toArray()[0];
		//����ҩƷ�����е�ͳ���·�
			sb.append("<dataset seriesName='").append(saleInfo.get(create_date).getMedicineName()).append("'>");
		//���������ڱ���
		for(String mon : queryMonthStrList){
			if(saleInfo.containsKey(mon)){
				MedicineSaleInfo info = saleInfo.get(mon);
				sb.append("<set value='").append(info.getTotalMoney()).append("'/>");
			}else{
				//���û�и��·�ͳ�Ƶ���Ϣ������Ϊ0
				sb.append("<set value='").append(0).append("'/>");
			}
		}
		sb.append("</dataset>");
		}
		sb.append("</chart>");
		return sb.toString();
	}
	
	
	public ReportService getReportService() {
		return reportService;
	}
	public void setReportService(ReportService reportService) {
		this.reportService = reportService;
	}

	public List<String> getMedicineNoArray() {
		return medicineNoArray;
	}

	public void setMedicineNoArray(List<String> medicineNoArray) {
		this.medicineNoArray = medicineNoArray;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getSumYear() {
		return sumYear;
	}
	public void setSumYear(String sumYear) {
		this.sumYear = sumYear;
	}
	
	
	//String rootPath = servletContext.getContextPath();
//	String rootPath = servletContext.getRealPath("/");
//	String fileName = rootPath+"jasper/report1.jasper";System.out.println(fileName);
//	HttpServletResponse response = ServletActionContext.getResponse();
//	byte[] bb;
	//	bb = JasperRunManager.runReportToPdf(new FileInputStream(reportFile), parameters, conn);
	//	bb = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters,conn);
	//	String str = JasperRunManager.runReportToHtmlFile(reportFile.getPath(), parameters);
	//	JasperRunManager.
	//	JasperRunManager.runReportToPdf(sourceFileName, parameters)
	
}
