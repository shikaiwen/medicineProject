package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.MedicineSaleInfo;

public interface ReportMapper {

	//��ѯҩƷ�������
	public List<MedicineSaleInfo> queryMedicineSaleInfo(Map map);
}
