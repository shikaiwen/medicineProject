package com.drp.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.struts2.interceptor.ParameterAware;

import com.drp.dao.MedicineService;
import com.drp.dao.StoreService;
import com.drp.dao.UserService;
import com.drp.domain.Medicine;
import com.drp.domain.StoreCard;
import com.drp.domain.StoreCardDetail;
import com.drp.util.CommonUtil;
import com.drp.util.JsonUtil;
import com.drp.util.ResultJsonModel;
import com.drp.util.WebUtil;
import com.opensymphony.xwork2.ActionSupport;

public class StoreAction extends ActionSupport implements ParameterAware{

	private String[] medicineNoArray;
	private String[] medicineDetailQuantityArray;
	private Map<String,String[]> params;
	private StoreService storeService;
	private StoreCard storeCard;
	private StoreCardDetail storeCardDetail;
	private List<StoreCard> storeCardList = new ArrayList<StoreCard>();
	private UserService userService;
	private MedicineService medicineService;
	private SqlSessionFactory sqlSessionFactory;
	private ResultJsonModel resultJsonModel ;
	
	private int quantity;//数量，用于在检测库存时使用
	
	/**
	 * 药品详细的编码规则
	 * 药品编号-2013/05/25-序列号
	 */
	
	//初始化库存
	public void initMedicineDetail(){
		try{
			System.out.println(JsonUtil.toJsonStr(params));
			//首先添加主单据信息
			
			
			if(null == storeCard){
				storeCard = new StoreCard();
			}
			Set<String> keySet = params.keySet();
			//获取药品编号
			storeCard.setCreateDate(new Date());
			storeCard.setCreator(CommonUtil.getCurrentUser());
			storeCard.setStoreId(CommonUtil.getRandomNo());
			storeService.addMainCard(storeCard);
			storeService.initMedicineDetail(params,storeCard);
			
			WebUtil.writeJsonToClient(storeCard);
		}catch(Exception e){
			e.printStackTrace();
		}
	}


	
	//查询入库情况
	public void selectInstoreInfo(){
		try{
			storeCardList = storeService.selectInstoreInfo(storeCard);
			System.out.println(JsonUtil.toJsonStr(storeCardList));
			
			for(int i=0;i<storeCardList.size();i++){
				StoreCard card = storeCardList.get(i);
				card.setCreator(userService.getUserById(card.getCreator()));
			}
			WebUtil.writeJsonToClient(storeCardList);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	
	//根据入库号查询整个入库情况
	public void getStoreCardByNo(){
		try{
			List<StoreCardDetail>  list = storeService.getDetail(storeCard);
			
			//查询出药品种类
		//	System.out.println(JsonUtil.toJsonStr(storeService.selectDistinctMedicineNo(storeCard)));;
			
			List<String> medicineNoList = getMedicineNoByStoreId(storeCard.getStoreId());
			
			Map<String,List<String>> map = new HashMap<String,List<String>>();
			
			for(int i=0;i<medicineNoList.size();i++){
				map.put(medicineNoList.get(i), new ArrayList<String>());
			}
			
			for(int i=0;i<list.size();i++){
				String medicineNo = list.get(i).getMedicine().getMedicineNo();
				List<String> strList = map.get(medicineNo);
				strList.add(list.get(i).getDetailNo());
			}
			
			List<Medicine> medicineObjList = new ArrayList<Medicine>();
			
			for(int i=0;i<medicineNoList.size();i++){
				Medicine m = new Medicine();
				m.setMedicineNo(medicineNoList.get(i));
				m = medicineService.getMedicineByNo(m);
				medicineObjList.add(m);
			}
			
			System.out.println(JsonUtil.toJsonStr(medicineObjList));
			System.out.println(JsonUtil.toJsonStr(map));
			
			
			
			ResultJsonModel rjm = new ResultJsonModel();
			
			rjm.addObject("medicines", medicineObjList);
			rjm.addObject("content", map);
			WebUtil.writeJsonToClient(rjm);
			//rjm.addObject(key, obj)
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	
	public List<String> getMedicineNoByStoreId(String storeId){
		List<String> strList = new ArrayList<String>();
		SqlSession session = sqlSessionFactory.openSession();
		try{
			Connection conn = session.getConnection();
			ResultSet rs = null;
			PreparedStatement pstmt = conn.prepareStatement("select distinct medicine_no from t_store_detail where store_id =?");
			pstmt.setString(1, storeId);
			rs = pstmt.executeQuery();
			while(rs.next()){
				strList.add(rs.getString("medicine_no"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return strList;
	}
	
	
	//检查库存情况
	public void checkStoreByMedicineNo(){
		try{
			ResultJsonModel rjm = new ResultJsonModel();
			int num = storeService.checkStoreByMedicineNo(storeCardDetail);
			if(num<quantity){
				rjm.addObject("status", "error");
				rjm.addObject("message", "目前缺货"+(quantity-num)+"件");
				WebUtil.writeJsonToClient(rjm);
			}else{
				rjm.addObject("status", "ok");
				rjm.addObject("message", "有货");
				WebUtil.writeJsonToClient(rjm);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public static void main(String[] args) {
		ResultJsonModel rjm = new ResultJsonModel();
		rjm.addObject("status", "error");
		rjm.addObject("message", "有货");
		System.out.println(JsonUtil.toJsonStr(rjm));
	}
	
	public StoreCardDetail getStoreCardDetail() {
		return storeCardDetail;
	}



	public void setStoreCardDetail(StoreCardDetail storeCardDetail) {
		this.storeCardDetail = storeCardDetail;
	}



	public SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}



	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}



	public MedicineService getMedicineService() {
		return medicineService;
	}



	public void setMedicineService(MedicineService medicineService) {
		this.medicineService = medicineService;
	}



	public String[] getMedicineNoArray() {
		return medicineNoArray;
	}


	public void setMedicineNoArray(String[] medicineNoArray) {
		this.medicineNoArray = medicineNoArray;
	}


	public String[] getMedicineDetailQuantityArray() {
		return medicineDetailQuantityArray;
	}


	public void setMedicineDetailQuantityArray(String[] medicineDetailQuantityArray) {
		this.medicineDetailQuantityArray = medicineDetailQuantityArray;
	}


	public void setParameters(Map<String, String[]> param) {
		this.params = param;
	}

	public StoreService getStoreService() {
		return storeService;
	}

	public void setStoreService(StoreService storeService) {
		this.storeService = storeService;
	}


	public StoreCard getStoreCard() {
		return storeCard;
	}


	public void setStoreCard(StoreCard storeCard) {
		this.storeCard = storeCard;
	}



	public List<StoreCard> getStoreCardList() {
		return storeCardList;
	}



	public void setStoreCardList(List<StoreCard> storeCardList) {
		this.storeCardList = storeCardList;
	}





	public ResultJsonModel getResultJsonModel() {
		return resultJsonModel;
	}



	public void setResultJsonModel(ResultJsonModel resultJsonModel) {
		this.resultJsonModel = resultJsonModel;
	}



	public int getQuantity() {
		return quantity;
	}



	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}



	public UserService getUserService() {
		return userService;
	}



	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
