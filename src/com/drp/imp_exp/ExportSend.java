package com.drp.imp_exp;

import java.io.FileOutputStream;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class ExportSend {

	public static void test1()throws Exception{
		Workbook wb = new HSSFWorkbook();
	    Sheet sheet1 = wb.createSheet();
	    createFiexedContent(sheet1);
	    
	    FileOutputStream fos = new FileOutputStream("h:\\workbook.xls");
	    wb.write(fos);
	    fos.close();
	}
	
	
	public static void createFiexedContent(Sheet sheet){
		Row headerRow = sheet.createRow(0);
		headerRow.createCell(3).setCellValue("������ϸ");
		Row titleRow = sheet.createRow(1);
		titleRow.createCell(0).setCellValue("ҩƷ���");
		titleRow.createCell(1).setCellValue("ҩƷ����");
		titleRow.createCell(2).setCellValue("ͨ������");
		titleRow.createCell(3).setCellValue("��Ʒ����");
		titleRow.createCell(4).setCellValue("����");
		titleRow.createCell(5).setCellValue("����������");
		titleRow.createCell(6).setCellValue("��ϵ�绰");
		titleRow.createCell(7).setCellValue("��ַ");
	}
	
	public static void main(String[] args)throws Exception {
		test1();
	}
}
