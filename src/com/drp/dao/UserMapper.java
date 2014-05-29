package com.drp.dao;

import java.util.List;
import java.util.Map;

import com.drp.domain.User;

public interface UserMapper {

	
	/**
	 * ����û�
	 * @param user
	 * @return
	 */
	public void addUser(User user);
	
	
	/**
	 * ��ѯ�����û�
	 * @return
	 */
	public List<User> getAllUser();
	
	/**
	 * ��ѯ�û�����
	 * @return
	 */
	public int getAllUserCount();
	
	//ɾ���û�
	public void deleteUser(User user);
	
	//�޸��û�
	public void modifyUser(User user);
	
	
	//����ҳ����ȡ
	public List<User> getResultByPage(Map conditions);
	
	//��ȡ�û�
	public List<User> getUser(User user);
	
	//����id��ȡ�û�
	public User getUserById(User user);
	
	//�޸�����
	public void modifyPassword(User user);
	
}
