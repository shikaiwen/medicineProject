package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.MedicineSaleInfo;

public interface ReportMapper {

	//查询药品销售情况
	public List<MedicineSaleInfo> queryMedicineSaleInfo(Map map);
}
