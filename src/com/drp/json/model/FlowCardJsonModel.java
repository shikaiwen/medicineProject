package com.drp.json.model;

import java.util.ArrayList;
import java.util.List;

import com.drp.domain.FlowCard;

public class FlowCardJsonModel {

	private int total;
	private List<FlowCard> rows;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List<FlowCard> getRows() {
		return rows;
	}
	public void setRows(List<FlowCard> rows) {
		this.rows = rows;
	}

	
}
