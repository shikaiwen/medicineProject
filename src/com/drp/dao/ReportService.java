package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.MedicineSaleInfo;

public class ReportService {


	private ReportMapper reportMapper;
	//��ѯҩƷ�������
	public List<MedicineSaleInfo> queryMedicineSaleInfo(Map map){
		List<MedicineSaleInfo> list = reportMapper.queryMedicineSaleInfo(map);
		return list;
	}
	public ReportMapper getReportMapper() {
		return reportMapper;
	}
	public void setReportMapper(ReportMapper reportMapper) {
		this.reportMapper = reportMapper;
	}
	
	
	
	
}
