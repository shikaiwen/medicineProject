package com.drp.util;

import java.util.Date;

public class MyDate extends Date{

	private Date date;
	
	@Override
	public String toString() {
		if(null == date){
			date = new Date();
		}
		return date.toLocaleString();
	}


	public void setDate(Date date) {
		this.date = date;
	}
	
	
	
}
