package com.drp.json.model;

import java.util.List;

import com.drp.domain.Order;

public class OrderJsonModel {

	private int total;
	
	private List<Order> rows;

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<Order> getRows() {
		return rows;
	}

	public void setRows(List<Order> rows) {
		this.rows = rows;
	}




	}
	
	
	
