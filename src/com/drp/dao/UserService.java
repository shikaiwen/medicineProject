package com.drp.dao;

import java.util.List;

import com.drp.domain.User;
import com.drp.util.CommonUtil;

public class UserService {

	private UserMapper userMapper;
	
	//添加用户
	public void addUser(User user){
		userMapper.addUser(user);
	}
	
	
	
	
	//获取所有用户
	public List<User> getAllUser(){
		return userMapper.getAllUser();
	}
	
	//获取所有用户数目
	public int getAllUserCount(){
		return userMapper.getAllUserCount();
	}
	
	
	//删除单个用户
	public void deleteUser(User user){
		userMapper.deleteUser(user);
	}
	
	
	//删除多个用户
	public void deleteMultipleUser(List<User> users){
		for(int i=0;i<users.size();i++){
			deleteUser(users.get(i));
		}
	}
	
	
	//修改用户
	public void modifyUser(User user){
		userMapper.modifyUser(user);
	}
	//根据id查询用户
	public User getUserById(User user){
		return userMapper.getUserById(user);
	}
	
	//修改密码
	public void modifyPassword(User user){
		User u = CommonUtil.getCurrentUser();
		user.setUserId(u.getUserId());
		userMapper.modifyPassword(user);
	}
	
	public UserMapper getUserMapper() {
		return userMapper;
	}
	public void setUserMapper(UserMapper userMapper) {
		this.userMapper = userMapper;
	}
	
	
}
