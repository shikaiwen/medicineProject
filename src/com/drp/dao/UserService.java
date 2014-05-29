package com.drp.dao;

import java.util.List;

import com.drp.domain.User;
import com.drp.util.CommonUtil;

public class UserService {

	private UserMapper userMapper;
	
	//����û�
	public void addUser(User user){
		userMapper.addUser(user);
	}
	
	
	
	
	//��ȡ�����û�
	public List<User> getAllUser(){
		return userMapper.getAllUser();
	}
	
	//��ȡ�����û���Ŀ
	public int getAllUserCount(){
		return userMapper.getAllUserCount();
	}
	
	
	//ɾ�������û�
	public void deleteUser(User user){
		userMapper.deleteUser(user);
	}
	
	
	//ɾ������û�
	public void deleteMultipleUser(List<User> users){
		for(int i=0;i<users.size();i++){
			deleteUser(users.get(i));
		}
	}
	
	
	//�޸��û�
	public void modifyUser(User user){
		userMapper.modifyUser(user);
	}
	//����id��ѯ�û�
	public User getUserById(User user){
		return userMapper.getUserById(user);
	}
	
	//�޸�����
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
