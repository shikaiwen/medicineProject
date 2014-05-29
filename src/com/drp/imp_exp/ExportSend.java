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
		headerRow.createCell(3).setCellValue("发货明细");
		Row titleRow = sheet.createRow(1);
		titleRow.createCell(0).setCellValue("药品编号");
		titleRow.createCell(1).setCellValue("药品名称");
		titleRow.createCell(2).setCellValue("通用名称");
		titleRow.createCell(3).setCellValue("产品批号");
		titleRow.createCell(4).setCellValue("数量");
		titleRow.createCell(5).setCellValue("分销商名称");
		titleRow.createCell(6).setCellValue("联系电话");
		titleRow.createCell(7).setCellValue("地址");
	}
	
	public static void main(String[] args)throws Exception {
		test1();
	}
}
