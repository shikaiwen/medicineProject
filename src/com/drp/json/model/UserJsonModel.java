package com.drp.json.model;

import java.util.ArrayList;
import java.util.List;

import com.drp.domain.User;
import com.google.gson.Gson;

public class UserJsonModel {

	private int total;
	private List<User> rows = new ArrayList<User>();
	
	
	public static void main(String[] args) {
		
		
		List<User> us = new ArrayList<User>();
		
		UserJsonModel model = new UserJsonModel();
		model.setTotal(20);
		model.setUsers(us);
		
		Gson gson = new Gson();
		System.out.println(gson.toJson(model));
		
		
	}



	

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}


	public List<User> getUsers() {
		return rows;
	}

	public void setUsers(List<User> users) {
		this.rows = users;
	}
	
	
	
}
