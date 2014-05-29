package com.drp.util;

import java.util.HashMap;
import java.util.Map;

public class Constants {

	public static final String Y = "Y";
	public static final String N = "N";
	
	//�������ĸ��ڵ�
	public static final int pid = 0;
	
	//����״̬
	public static final String status = "status";
	public static final String STATUS = "STATUS";
	
	//�ɹ�״̬
	public static final String success = "ok";
	//ʧ��״̬
	public static final String fail = "error";
	
	
	//Э��ͷ
	public static final String ContentType_TEXT_HTML_GBK = "text/html;charset= gbk";
	
	
	//ͨ�ò����ɹ���JSON�ַ���
	public static final String successStr = "{\"ok\":\"true\"}";
	
	//����ʧ��ʱJSON�ַ���
	public static final String errorStr = "{\"ok\":false}";
	
	//��������key,����Լ����˾��ô��������Ǹ���������Ĭ�ϵ�
	public static final String result_out = "result_out";
	
	
	//�ֵ�����
	public static final String AGENT_LEVEL = "A";
	
	
	//ҩƷ������кų��ȣ���������+����0��
	public static final int MEDICINE_NO_LENGTH = 6;
	
	
	//�ļ���ַ
	public static final String UPLOAD_DIRECTORY = "uploadFiles";
	
	//Ĭ�ϵ�ͼƬ�����ʽ
	public static final String DEFAULT_IMG_SUFFIX = ".png";
	public static final String DEFAULT_IMG_FORMAT = "png";
	
	//session����ʱĿ¼,���ڴ����ʱ�ļ�,sessionʧЧʱɾ��
	public static final String SESSION_TEMP_DIRECTORY = "sessionTemp";
	
	//����ͼƬ��ͼƬ����
	public static final String No_IMAGE_NAME = "no-images.jpg"; 
	
	
	//��½�û���
	public static final String USER = "USER";
	//����Agent
	public static final String AGENT = "AGENT";
	
	//�û���������ʾ��Ϣ
	public static final String USER_NOT_EXIST = "*���û�������";
	
	
	//����״̬
	public static final int ORDER_STATE_DRAFT = 241;
	public static final int ORDER_STATE_SUBMIT = 242;
	public static final int ORDER_STATE_EXPORT = 243;
	public static final int ORDER_STATE_OVER = 244;
	public static final int ORDER_STATE_SEND = 262;
	
	//����״̬
	public static final int FLOWCARD_STATE_SENDED = 253;
	public static final int FLOWCARD_STATE_RECEIVED = 254;
	public static final int FLOWCARD_STATE_OVER = 255;
	
	static Map<Integer,String> chineseMonthStrMap = null;
	
	static {
		chineseMonthStrMap = new HashMap<Integer,String>();
		chineseMonthStrMap.put(1, "һ��");
		chineseMonthStrMap.put(2, "����");
		chineseMonthStrMap.put(3, "����");
		chineseMonthStrMap.put(4, "����");
		chineseMonthStrMap.put(5, "����");
		chineseMonthStrMap.put(6, "����");
		chineseMonthStrMap.put(7, "����");
		chineseMonthStrMap.put(8, "����");
		chineseMonthStrMap.put(9, "����");
		chineseMonthStrMap.put(10, "ʮ��");
		chineseMonthStrMap.put(11, "ʮһ��");
		chineseMonthStrMap.put(12, "ʮ����");
	}
	
	//�Ƿ�Ϊ����Ա
	public static int IS_ADMIN = 100;
	
	//�����̼���
	public static int AGENT_LEVEL_1 = 194;
	public static int AGENT_LEVEL_2 = 199;
	public static int AGENT_LEVEL_3 = 256;
	
	//�Ƿ��ֵ�
	public static int YES = 222;
	public static int NO = 223;
}
