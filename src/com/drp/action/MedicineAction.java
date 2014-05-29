package com.drp.action;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.struts2.ServletActionContext;

import com.drp.dao.MedicineService;
import com.drp.dict.Dict;
import com.drp.dict.DictService;
import com.drp.domain.Agent;
import com.drp.domain.Medicine;
import com.drp.json.model.MedicineJsonModel;
import com.drp.util.Constants;
import com.drp.util.JsonUtil;
import com.drp.util.WebUtil;
import com.opensymphony.xwork2.ActionSupport;

public class MedicineAction extends ActionSupport{

	private int rows ;
	private int page;
	private Medicine medicine;
	private MedicineService medicineService;
	private DictService dictService;
	private File imgFile;
	private String imgFileFileName;
	private String imgFileContentType;
	private List<Medicine> medicineList;
	
	//����ҳ�����Ҽ�¼
	public void getResultByPage(){
		try{
			if(page == 0) page = 1;
			Map map = new HashMap();
			int startRecords = (page -1)*rows;
			int endRecords = page * rows;
			map.put("startRecords", startRecords);
			map.put("endRecords", endRecords);
			
			//���ò�ѯ����
			if(null != medicine){
				map.put("functionType", medicine.getFunctionType().getDictId());
				map.put("manageType", medicine.getManageType().getDictId());
				map.put("medicineNo", medicine.getMedicineNo());
				map.put("medicineName", medicine.getMedicineName());
				map.put("normalName", medicine.getNormalName());
			}
			System.out.println(JsonUtil.toJsonStr(map));
			List<Medicine> medicineList = medicineService.getResultByPage(map);
			//���ֵ��������ֺ�ֵ���ú�
			for(int i=0;i<medicineList.size();i++){
				Medicine m = medicineList.get(i);
				m.setFunctionType(dictService.getDictById(m.getFunctionType()));
				m.setManageType(dictService.getDictById(m.getManageType()));
				m.setUseSpecialPrice(dictService.getDictById(m.getUseSpecialPrice()));
				m.setUnit(dictService.getDictById(m.getUnit()));
			}
			
			int count = medicineService.getAllMedicineCount();
		//	System.out.println(JsonUtil.toJsonStr(medicineList));
			MedicineJsonModel mjm = new MedicineJsonModel();
			mjm.setRows(medicineList);
			mjm.setTotal(count);
			//���ü۸�
			setPrice(medicineList);
			System.out.println(JsonUtil.toJsonStr(mjm));
			WebUtil.writeJsonToClient(mjm);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	private void setPrice(List<Medicine> medicineList){
		HttpSession session = ServletActionContext.getRequest().getSession();
		Agent agent = (Agent)session.getAttribute(Constants.AGENT);
		int agentId = agent.getAgentId();
		if(agentId != 100){//������ǹ����û�
		Dict dict = new Dict();
		float rate = 0.0f;
		if(Constants.AGENT_LEVEL_1 == agent.getAgentLevel()){
			dict.setDictId(259);
			dict = dictService.getDictById(dict);
			rate = Float.parseFloat(dict.getValue());
		}else if(Constants.AGENT_LEVEL_2 == agent.getAgentLevel()){
			dict.setDictId(260);
			dict = dictService.getDictById(dict);
			rate = Float.parseFloat(dict.getValue());
		}else if(Constants.AGENT_LEVEL_3==agent.getAgentLevel()){
			dict.setDictId(261);
			dict = dictService.getDictById(dict);
			rate = Float.parseFloat(dict.getValue());
		}
			
		for(int i=0;i<medicineList.size();i++){
			Medicine m = medicineList.get(i);
			int useSpecialPrice = m.getUseSpecialPrice().getDictId();
			//���û��ʹ������۸�
			if(useSpecialPrice == Constants.NO){
				float price = rate * m.getPrice();
				String style = "0.0";
				DecimalFormat df = new DecimalFormat();
				df.applyPattern(style);
				String result = df.format(price);
				m.setPrice(Float.parseFloat(result));
				System.out.println(price);
			}
		}
		}
		
	}
	
	public void addMedicine(){
		//����ļ��Ǵ���
//		String sessionTempFile  = ServletActionContext.getServletContext().getRealPath("/")+Constants.SESSION_TEMP_DIRECTORY;
//		HttpSession session = ServletActionContext.getRequest().getSession();
//		File sessionFile = new File(sessionTempFile+"\\"+session.getId()+Constants.DEFAULT_IMG_SUFFIX);
//		
//		if(sessionFile.exists()){
//			String path = ServletActionContext.getServletContext().getRealPath("/")+Constants.UPLOAD_DIRECTORY;
//			String fileName = getFileName();
//			String fileNameStr = path+"\\"+fileName+Constants.DEFAULT_IMG_SUFFIX;
//			File file = new File(fileNameStr);
//			
//			try{
//				BufferedImage bi = ImageIO.read(sessionFile);
//				ImageIO.write(bi, Constants.DEFAULT_IMG_FORMAT, file);
//			}catch(Exception e){
//				e.printStackTrace();
//			}
//			medicine.setImg(fileName+Constants.DEFAULT_IMG_SUFFIX);
//		}
		
		try{
			if(null == medicine.getImg()||"".equals(medicine.getImg())){
				medicine.setImg(Constants.No_IMAGE_NAME);
			}
			medicine.setMedicineNo(this.getMedicineNo());
			medicineService.addMedicine(medicine);
			
			//��ɺ�medicine����д�ؿͻ���
			System.out.println(JsonUtil.toJsonStr(medicine));
			WebUtil.writeJsonToClient(medicine);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	//�޸�ҩƷ
	public void  modifyMedicine(){
		try{
			medicineService.modifyMedicine(medicine);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	
	//�ϴ��ļ�
	public String uploadImg() throws Exception{
		
		
 		BufferedImage bImage = ImageIO.read(imgFile);
		if(null == bImage){
			return "";
		}
		
		String directory = ServletActionContext.getServletContext().getRealPath("/")+Constants.UPLOAD_DIRECTORY;
		String fileName = getFileName();
		File file = new File(directory+"\\"+fileName+Constants.DEFAULT_IMG_SUFFIX);
		ImageIO.write(bImage, Constants.DEFAULT_IMG_FORMAT, file);
		if(medicine == null){
			medicine = new Medicine();
			medicine.setImg(fileName+Constants.DEFAULT_IMG_SUFFIX);
		}
		//WebUtil.WriteStrToClient("uploadOk");
		return "uploadOver";
	}
	
	
	//ɾ��ͼƬ,�������Ĳ����ǽ�ͼƬ����Ϊ����ͼƬ
	public void deletePic(){
		medicine.setImg(Constants.No_IMAGE_NAME);
		medicineService.deletePic(medicine);
		WebUtil.WriteStrToClient(Constants.successStr);
	}
	
	
	
	//���ʱɾ��������ͼƬ
	public void deleteInAddPic(){
		String directory = ServletActionContext.getServletContext().getRealPath("/")+Constants.UPLOAD_DIRECTORY;
		File file = new File(directory+"\\"+medicine.getImg());
		file.delete();
		WebUtil.WriteStrToClient(Constants.successStr);
	}
	
	//�޸�ʱ�ϴ��ļ�
	public String modifyUploadImg(){
		try{
	 		BufferedImage bImage = ImageIO.read(imgFile);
			if(null == bImage){
				return "";
			}
			String directory = ServletActionContext.getServletContext().getRealPath("/")+Constants.UPLOAD_DIRECTORY;
			String fileName = getFileName();
			File file = new File(directory+"\\"+fileName+Constants.DEFAULT_IMG_SUFFIX);
			ImageIO.write(bImage, Constants.DEFAULT_IMG_FORMAT, file);
			if(medicine == null){
				medicine = new Medicine();
			}
			medicine.setImg(fileName+Constants.DEFAULT_IMG_SUFFIX);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "modifyUploadOver";
	}
	
	//�޸�ʱɾ��ͼƬ
	public void deleteInModifyPic(){
		String directory = ServletActionContext.getServletContext().getRealPath("/")+Constants.UPLOAD_DIRECTORY;
		File file = new File(directory+"\\"+medicine.getImg());
		file.delete();
		//ɾ�����ݿ�ͼƬ�ֶ�
		medicine.setImg(Constants.No_IMAGE_NAME);
		medicineService.deletePic(medicine);
		WebUtil.WriteStrToClient(Constants.successStr);
	}
	
	/**
	 * �����ļ���
	 * ����:10λ����ַ���+8λʱ�����
	 * @return
	 */
	private String getFileName(){
		StringBuilder sb = new StringBuilder();
		sb.append(RandomStringUtils.randomAlphanumeric(10));
		String str = String.valueOf(Calendar.getInstance().getTimeInMillis());
		String timeStr = str.substring(5,str.length());
		sb.append(timeStr);
		return sb.toString();
	}
	

	
	
	//���ڲ���ҩƷ���
	public String getMedicineNo(){
		StringBuilder sb = new StringBuilder();
		try{
		//	medicine = new Medicine();
		//	medicine.setFunctionType("DISGT");
		//	DictUtil dictUtil = DictUtil.getInstance();
		//	Map<Integer,String> keyValueMap = dictUtil.getKeyValueMap(medicine.getFunctionType());
			Map<Integer,String> keyValueMap = dictService.getKeyValueMap("G");
			int sequenceNo = medicineService.getMedicineSequenceNextVal();
			String sequenceStr = String.valueOf(sequenceNo);
			int zeroNum = Constants.MEDICINE_NO_LENGTH - sequenceStr.length();
			for(int i=0;i<zeroNum;i++){
				sb.append("0");
			}
			sb.append(sequenceStr);
			sb.insert(0, keyValueMap.get(medicine.getFunctionType().getDictId()));
		}catch(Exception e){
			e.printStackTrace();
		}
		return sb.toString();
	}
	

	
	
	//ɾ��ҩƷ
	public void deleteMedicine(){
		try{
			//��ȡ��ϸ����
			for(int i=0;i<medicineList.size();i++){
				Medicine m = medicineList.get(i);
				m = medicineService.getMedicineByNo(m);
				medicineList.set(i, m);
			}
			
			String directory = ServletActionContext.getServletContext().getRealPath("/")+Constants.UPLOAD_DIRECTORY;
			for(int i=0;i<medicineList.size();i++){
				Medicine m = medicineList.get(i);
				medicineService.deleteMedicine(m);
				if(!Constants.No_IMAGE_NAME.equals(m.getImg())){
					File file = new File(directory+"\\"+m.getImg());
					file.delete();
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}

		
	}
	


	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public Medicine getMedicine() {
		return medicine;
	}
	public void setMedicine(Medicine medicine) {
		this.medicine = medicine;
	}


	public MedicineService getMedicineService() {
		return medicineService;
	}


	public void setMedicineService(MedicineService medicineService) {
		this.medicineService = medicineService;
	}


	public DictService getDictService() {
		return dictService;
	}


	public void setDictService(DictService dictService) {
		this.dictService = dictService;
	}

	public File getImgFile() {
		return imgFile;
	}

	public void setImgFile(File imgFile) {
		this.imgFile = imgFile;
	}

	public String getImgFileFileName() {
		return imgFileFileName;
	}

	public void setImgFileFileName(String imgFileFileName) {
		this.imgFileFileName = imgFileFileName;
	}

	public String getImgFileContentType() {
		return imgFileContentType;
	}

	public void setImgFileContentType(String imgFileContentType) {
		this.imgFileContentType = imgFileContentType;
	}
	public List<Medicine> getMedicineList() {
		return medicineList;
	}
	public void setMedicineList(List<Medicine> medicineList) {
		this.medicineList = medicineList;
	}
}
