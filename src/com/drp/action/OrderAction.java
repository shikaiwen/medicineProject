package com.drp.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.ServletActionContext;

import com.drp.dao.AgentService;
import com.drp.dao.MedicineService;
import com.drp.dao.OrderService;
import com.drp.dao.UserService;
import com.drp.dict.Dict;
import com.drp.dict.DictService;
import com.drp.domain.Agent;
import com.drp.domain.AreaDataModel;
import com.drp.domain.Medicine;
import com.drp.domain.Order;
import com.drp.domain.OrderDetail;
import com.drp.imp_exp.ExportSend;
import com.drp.json.model.OrderJsonModel;
import com.drp.util.CommonUtil;
import com.drp.util.Constants;
import com.drp.util.JsonUtil;
import com.drp.util.ResultJsonModel;
import com.drp.util.WebUtil;
import com.drp.util.XmlReader;
import com.opensymphony.xwork2.ActionSupport;

public class OrderAction extends ActionSupport {

	private int page;
	private int rows;
	
	private String orderDateFrom;
	private String orderDateTo;
	private int operator;
	
	private Order order;
	private List<Order> orderList = new ArrayList<Order>();
	private OrderDetail orderDetail;
	private List<OrderDetail> detailList = new ArrayList<OrderDetail>();
	private OrderService orderService;
	private ResultJsonModel resultJsonModel;
	private DictService dictService;
	private UserService userService;
	private AgentService agentService;
	private MedicineService medicineService;
	private int[] agentIdArray = new int[20];
	private File xlsFile;//���붩��ʱʹ��
	private String prepare;
	
	//��Ӷ���
 	public void addOrder(){
		try{
			
			order.setOrderId(CommonUtil.getRandomNo());
			Dict orderState = new Dict();orderState.setDictId(Constants.ORDER_STATE_DRAFT);
			order.setOrderState(orderState);
			order.setOrderDate(new Date());
			order.setOrderDetail(detailList);
			order.setAgent(CommonUtil.getCurrentAgent());
			orderService.addOrder(order);
			resultJsonModel.addAsSimpleFormatResult("orderId", order.getOrderId());
			resultJsonModel.addAsSimpleFormatResult("orderState", Constants.ORDER_STATE_DRAFT);
			resultJsonModel.addAsSimpleFormatResult("msg", "ok");
			WebUtil.writeJsonToClient(resultJsonModel);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	
	//�޸Ķ������
	public String modifyOrder(){
		System.out.println(JsonUtil.toJsonStr(order));
		if(Constants.Y.equals(this.prepare)){
			System.out.println(this.prepare);
			System.out.println(JsonUtil.toJsonStr(order));
			return "toModify";
		}

		return "";
	}
	
	public void realModify(){
		
		//�����ܽ��
		Map<String,Object> totalMoneyMap = new HashMap<String,Object>();
		totalMoneyMap.put("orderId", order.getOrderId());
		totalMoneyMap.put("totalMoney",order.getTotalMoney());
		
		orderService.updateTotalPrice(totalMoneyMap);
		
		try{
			//�����޸Ķ���
			for(int i =0;i<detailList.size();i++){
				OrderDetail detail = detailList.get(i);
				Map<String,String> map = new HashMap<String,String>();
				map.put("orderId", order.getOrderId());
				map.put("detailId", detail.getDetailId());
				int result = orderService.detailIsExist(map);
				detail.setOrder(order);
				//��������ڣ���˵���ǣ�����ӵ�ҩƷ��ϸ
				if(result ==0){
					orderService.addOrderDetailInfo(detail);
				}else{
					//���������ͼ۸�
					orderService.updateDetail(detail);
				}
			}
			@SuppressWarnings("rawtypes")
			Map map = new HashMap();
			map.put("orderId", order.getOrderId());
			List<String> detailStrList = orderService.getDetailIdByOrderId(map);
			
			Map<String,String> toDeleteMap = new HashMap<String,String>();
			//�����е�ǰ��ϸ��û�е���ϸ�г���
			for(String detailId : detailStrList){
				for(int i=0;i<detailList.size();i++){
					
					String detailNo = detailList.get(i).getDetailId();
					if(detailId.equals(detailNo)){
						break;
					}else{
						if(i == (detailList.size()-1)){
							//˵������ϸ���Ѿ���ɾ����
							//�����ݿ�ɾ��������ϸ
							toDeleteMap.put("orderId",order.getOrderId());
							toDeleteMap.put("detailId", detailId);
							orderService.deleteOrderDetail(toDeleteMap);
						}
					}
				}
			}			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		

		
	}
	
	public void getModifyData(){
		order = orderService.getOrderById(order);
		detailList = orderService.getDetailedOrder(order);
		for(int i=0;i<detailList.size();i++){
			Medicine m = detailList.get(i).getMedicine();
			m = medicineService.getMedicineByNo(m);
			detailList.get(i).setMedicine(m);
			System.out.println(JsonUtil.toJsonStr(detailList));
		}
		order.setOrderDetail(detailList);
		System.out.println(JsonUtil.toJsonStr(order));
		WebUtil.writeJsonToClient(JsonUtil.toJsonStr(order));
	}
	
	
	//����ҳ�����Ҽ�¼
	public void getResultByPage(){
		//��ȡ����������
		Agent ag = (Agent)ServletActionContext.getRequest().getSession().getAttribute(Constants.AGENT);
		try{
			if(page == 0) page = 1;
			Map map = new HashMap();
			int startRecords = (page -1)*rows;
			int endRecords = page * rows;
			map.put("startRecords", startRecords);
			map.put("endRecords", endRecords);
			map.put("orderDateFrom", orderDateFrom);
			map.put("orderDateTo", orderDateTo);
			map.put("operator", operator);
			map.put("agent", ag);//�˴���agent����������
		//	map.put("agentId", ag.getAgentId());
			if(null != order){
				//order = new Order();
				map.put("orderId", order.getOrderId());
				map.put("userName",order.getCreator().getUserName());
				map.put("totalMoney", order.getTotalMoney());
				map.put("orderState", order.getOrderState().getDictId());
			}
			
			System.out.println(JsonUtil.toJsonStr(map));
			List<Order> orderList = orderService.getResultByPage(map);
			System.out.println(JsonUtil.toJsonStr(orderList));
			for(int i=0;i<orderList.size();i++){
				Order o = orderList.get(i);
				o.setOrderState(dictService.getDictById(o.getOrderState()));
				o.setCreator(userService.getUserById(o.getCreator()));
				o.setAgent(agentService.getAgentById(o.getAgent()));
			}
			//���ֵ��������ֺ�ֵ���ú�
//			for(int i=0;i<orderList.size();i++){
//				Order m = orderList.get(i);
//			}
			
			int count = orderService.getOrderCountByCondition(map);
		//	System.out.println(JsonUtil.toJsonStr(medicineList));
			OrderJsonModel ojm = new OrderJsonModel();
			ojm.setRows(orderList);
			ojm.setTotal(count);
			System.out.println(JsonUtil.toJsonStr(ojm));
			WebUtil.writeJsonToClient(ojm);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	//ɾ������������ϸ��Ϣ,ֻ�ܵ���ɾ��
	public void deleteOrder(){
		try{
			if(null != orderList){
				for(int i=0;i<orderList.size();i++){
					Order order = orderList.get(i);
					orderService.deleteOrder(order);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//�ύ����
	//�ύ����
	public void submitOrder(){
		try{
			//order = new Order();
			Dict d = new Dict();
			d.setDictId(Constants.ORDER_STATE_SUBMIT);
			order.setOrderState(d);
			orderService.submitOrder(order);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//״̬�ĳɷ���
	public void sendState(Order order){
		try{
	//		order = new Order();
			Dict d = new Dict();
			d.setDictId(Constants.ORDER_STATE_EXPORT);
			order.setOrderState(d);
			orderService.submitOrder(order); //�ô˷����ı�״̬
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//������ϸ
	//�鿴������ϸ���
	public String getDetailedOrder(){
		try{
			List<OrderDetail> tt =  orderService.getDetailedOrder(order);
			System.out.println(JsonUtil.toJsonStr(tt));
			for(int i=0;i<tt.size();i++){
				Medicine medi = tt.get(i).getMedicine();
				Medicine m = medicineService.getMedicineByNo(medi);
				
				tt.get(i).setMedicine(m);
			}
			
			detailList = tt;
			System.out.println(JsonUtil.toJsonStr(detailList));
		}catch(Exception e ){
			e.printStackTrace();
		}

		return "showDetail";
	}
	
	//��������
	public void exportOrder(){
		//����״̬
		System.out.println(JsonUtil.toJsonStr(order));
		for(int i=0;i<orderList.size();i++){
			sendState(orderList.get(i));
		}
		
		
		List<List<OrderDetail>> mainList = new ArrayList<List<OrderDetail>>();
		try{
			for(int i=0;i<orderList.size();i++){
				Order order_2 = orderList.get(i);
				List<OrderDetail> tt =  orderService.getDetailedOrder(order_2);
				System.out.println(JsonUtil.toJsonStr(tt));
				for(int j=0;j<tt.size();j++){
					Medicine medi = tt.get(j).getMedicine();
					Medicine m = medicineService.getMedicineByNo(medi);
					tt.get(j).setMedicine(m);
				}
				mainList.add(tt);
			}
			
		System.out.println(JsonUtil.toJsonStr(mainList));
		}catch(Exception e ){
			e.printStackTrace();
		}
		generate(mainList);
	}
	
	
	public void generate(List<List<OrderDetail>> mainList ){
		try{
			Workbook wb = new HSSFWorkbook();
		    Sheet sheet1 = wb.createSheet();
		    ExportSend.createFiexedContent(sheet1);
		    int rowIndex = 2;
			for(int m = 0;m<mainList.size();m++){
				List<OrderDetail> list = mainList.get(m);
				Agent agent = new Agent();
				agent.setAgentId(agentIdArray[m]);
				agent = agentService.getAgentById(agent);
				AreaDataModel areaModel = new AreaDataModel();
				areaModel.setId(agent.getAddress());
				areaModel = agentService.getAddressById(areaModel);
					for(int i=0;i<list.size();i++){
						OrderDetail detail = list.get(i);
						Row row = sheet1.createRow(rowIndex);
						row.createCell(0).setCellValue(detail.getMedicine().getMedicineNo());//ҩƷ���
						row.createCell(1).setCellValue(detail.getMedicine().getMedicineName());
						row.createCell(2).setCellValue(detail.getMedicine().getNormalName());
						row.createCell(3).setCellValue(detail.getMedicine().getApprovalNumber());
						row.createCell(4).setCellValue(detail.getQuantity());
						row.createCell(5).setCellValue(agent.getAgentName());
						row.createCell(6).setCellValue(agent.getTelephone());
						row.createCell(7).setCellValue(areaModel.getStrFormat()+agent.getDetailedAddress());
						rowIndex ++ ;
					}
			}
		 //   FileOutputStream fos = new FileOutputStream("h:\\workbook.xls");

		    
		    HttpServletResponse response = ServletActionContext.getResponse();
		    response.setContentType("application/octet-stream");
		    String fileName = "������";
		    fileName = new String(fileName.getBytes("GBK"),"iso-8859-1");
		    response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
		    OutputStream os = response.getOutputStream();
		    wb.write(os);
		    os.flush();
		}catch(Exception e){
			e.printStackTrace();
		}
		

	}
	
	public  void main(String[] args) {
		importOrder();
	}
	
	//���붩��
	public  void importOrder(){
		Workbook wb = null;
		try{
			wb = new HSSFWorkbook(new FileInputStream(xlsFile));
		}catch(Exception e){
			try{
				wb = new XSSFWorkbook(new FileInputStream(xlsFile));
			}catch(Exception e2){
				WebUtil.WriteStrToClient(Constants.errorStr);
				return;
			}
		}
		List<OrderDetail> detailOrder = null;
	 try{
		 detailOrder =new ArrayList<OrderDetail>();
		 Sheet sheet = wb.getSheetAt(0);
		    for (Iterator<Row> rit = sheet.rowIterator(); rit.hasNext(); ) {
		        Row row = rit.next();
		        int rowNum = row.getRowNum();
		        if(rowNum==0 || rowNum ==1){
		        	System.out.println("this is row "+rowNum);continue;
		        }
		        
		        OrderDetail orderDetail = new OrderDetail();
		        Medicine m = new Medicine();
		        Cell medicineNoCell = row.getCell(0);//���
		        Cell medicineNameCell = row.getCell(1);
		        Cell quantityCell = row.getCell(2);
		        
		        m.setMedicineNo(medicineNoCell.getStringCellValue());
		        m.setMedicineName(medicineNameCell.getStringCellValue());
		        orderDetail.setMedicine(m);
		        orderDetail.setQuantity((int)quantityCell.getNumericCellValue());
		        detailOrder.add(orderDetail);
		    }
		   // System.out.println(JsonUtil.toJsonStr(detailOrder));
		   }catch(Exception e){
			   e.printStackTrace();
			   WebUtil.WriteStrToClient(Constants.errorStr);
				return;
	 }
	 
	 
	 for(int i=0;i<detailOrder.size();i++){
		 OrderDetail dOrder = detailOrder.get(i);
		 Medicine m = detailOrder.get(i).getMedicine();
		 m = medicineService.getMedicineByNo(m);
		 //���mΪnull����˵����ҩƷ�����ڣ��Ӷ�����ϸ��ɾ��
		 if(null== m){
			 detailOrder.remove(i);
			 continue;
		 }
		 dOrder.setMedicine(m);
	 }
	 String detailOrderListStr = JsonUtil.toJsonStr(detailOrder);
	 String function = XmlReader.getSubTextById("OrderAction_importOrder");
	 MessageFormat form = new MessageFormat(function);
	 Object [] args = {detailOrderListStr};
	 String outScript = form.format(args);//�ű�
	 StringBuilder sb = new StringBuilder();//outScript
	 sb.insert(0, "<script>");
	 sb.append(outScript);
	 sb.append("</script>");
	 
	 WebUtil.WriteStrToClient(sb.toString());
	 
}
	
	
	
	
	
	
	
	public MedicineService getMedicineService() {
		return medicineService;
	}

	public void setMedicineService(MedicineService medicineService) {
		this.medicineService = medicineService;
	}

	public String getOrderDateFrom() {
		return orderDateFrom;
	}

	public void setOrderDateFrom(String orderDateFrom) {
		this.orderDateFrom = orderDateFrom;
	}

	public String getOrderDateTo() {
		return orderDateTo;
	}

	public void setOrderDateTo(String orderDateTo) {
		this.orderDateTo = orderDateTo;
	}


	public int getOperator() {
		return operator;
	}

	public void setOperator(int operator) {
		this.operator = operator;
	}


	public AgentService getAgentService() {
		return agentService;
	}

	public void setAgentService(AgentService agentService) {
		this.agentService = agentService;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public DictService getDictService() {
		return dictService;
	}

	public void setDictService(DictService dictService) {
		this.dictService = dictService;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public List<OrderDetail> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<OrderDetail> detailList) {
		this.detailList = detailList;
	}

	public OrderService getOrderService() {
		return orderService;
	}

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public OrderDetail getOrderDetail() {
		return orderDetail;
	}
	public void setOrderDetail(OrderDetail orderDetail) {
		this.orderDetail = orderDetail;
	}

	public ResultJsonModel getResultJsonModel() {
		return resultJsonModel;
	}

	public void setResultJsonModel(ResultJsonModel resultJsonModel) {
		this.resultJsonModel = resultJsonModel;
	}

	public List<Order> getOrderList() {
		return orderList;
	}

	public void setOrderList(List<Order> orderList) {
		this.orderList = orderList;
	}

	public int[] getAgentIdArray() {
		return agentIdArray;
	}

	public void setAgentIdArray(int[] agentIdArray) {
		this.agentIdArray = agentIdArray;
	}

	public File getXlsFile() {
		return xlsFile;
	}

	public void setXlsFile(File xlsFile) {
		this.xlsFile = xlsFile;
	}
	public String getPrepare() {
		return prepare;
	}
	public void setPrepare(String prepare) {
		this.prepare = prepare;
	}


	

	
}
