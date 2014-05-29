package com.drp.util;

import java.util.HashMap;
import java.util.Map;

public class Constants {

	public static final String Y = "Y";
	public static final String N = "N";
	
	//整棵树的父节点
	public static final int pid = 0;
	
	//操作状态
	public static final String status = "status";
	public static final String STATUS = "STATUS";
	
	//成功状态
	public static final String success = "ok";
	//失败状态
	public static final String fail = "error";
	
	
	//协议头
	public static final String ContentType_TEXT_HTML_GBK = "text/html;charset= gbk";
	
	
	//通用操作成功的JSON字符串
	public static final String successStr = "{\"ok\":\"true\"}";
	
	//操作失败时JSON字符串
	public static final String errorStr = "{\"ok\":false}";
	
	//输出对象的key,如果自己传了就用传进来的那个，否则用默认的
	public static final String result_out = "result_out";
	
	
	//字典类型
	public static final String AGENT_LEVEL = "A";
	
	
	//药品编号序列号长度（整数部分+补的0）
	public static final int MEDICINE_NO_LENGTH = 6;
	
	
	//文件地址
	public static final String UPLOAD_DIRECTORY = "uploadFiles";
	
	//默认的图片输出格式
	public static final String DEFAULT_IMG_SUFFIX = ".png";
	public static final String DEFAULT_IMG_FORMAT = "png";
	
	//session的临时目录,用于存放临时文件,session失效时删除
	public static final String SESSION_TEMP_DIRECTORY = "sessionTemp";
	
	//暂无图片的图片名称
	public static final String No_IMAGE_NAME = "no-images.jpg"; 
	
	
	//登陆用户名
	public static final String USER = "USER";
	//所属Agent
	public static final String AGENT = "AGENT";
	
	//用户不存在提示信息
	public static final String USER_NOT_EXIST = "*该用户不存在";
	
	
	//订单状态
	public static final int ORDER_STATE_DRAFT = 241;
	public static final int ORDER_STATE_SUBMIT = 242;
	public static final int ORDER_STATE_EXPORT = 243;
	public static final int ORDER_STATE_OVER = 244;
	public static final int ORDER_STATE_SEND = 262;
	
	//流向单状态
	public static final int FLOWCARD_STATE_SENDED = 253;
	public static final int FLOWCARD_STATE_RECEIVED = 254;
	public static final int FLOWCARD_STATE_OVER = 255;
	
	static Map<Integer,String> chineseMonthStrMap = null;
	
	static {
		chineseMonthStrMap = new HashMap<Integer,String>();
		chineseMonthStrMap.put(1, "一月");
		chineseMonthStrMap.put(2, "二月");
		chineseMonthStrMap.put(3, "三月");
		chineseMonthStrMap.put(4, "四月");
		chineseMonthStrMap.put(5, "五月");
		chineseMonthStrMap.put(6, "六月");
		chineseMonthStrMap.put(7, "七月");
		chineseMonthStrMap.put(8, "八月");
		chineseMonthStrMap.put(9, "九月");
		chineseMonthStrMap.put(10, "十月");
		chineseMonthStrMap.put(11, "十一月");
		chineseMonthStrMap.put(12, "十二月");
	}
	
	//是否为管理员
	public static int IS_ADMIN = 100;
	
	//分销商级别
	public static int AGENT_LEVEL_1 = 194;
	public static int AGENT_LEVEL_2 = 199;
	public static int AGENT_LEVEL_3 = 256;
	
	//是否字典
	public static int YES = 222;
	public static int NO = 223;
}
