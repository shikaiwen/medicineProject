package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.User;

public interface UserMapper {

	
	/**
	 * 添加用户
	 * @param user
	 * @return
	 */
	public void addUser(User user);
	
	
	/**
	 * 查询所有用户
	 * @return
	 */
	public List<User> getAllUser();
	
	/**
	 * 查询用户数量
	 * @return
	 */
	public int getAllUserCount();
	
	//删除用户
	public void deleteUser(User user);
	
	//修改用户
	public void modifyUser(User user);
	
	
	//根据页数获取
	public List<User> getResultByPage(Map conditions);
	
	//获取用户
	public List<User> getUser(User user);
	
	//根据id获取用户
	public User getUserById(User user);
	
	//修改密码
	public void modifyPassword(User user);
	
}
