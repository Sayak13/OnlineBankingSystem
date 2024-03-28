package com.onlineBankingSystem.service;

import java.util.List;
import java.util.Optional;

import com.onlineBankingSystem.model.User;

public interface UserService {
	User createUser(User user);
	
	boolean checkIfExists(String panNo);
	
	boolean checkIfExistsUsingId(Long id);
	
	User validateUser(User user);
	
	List<User> getAllUsers();
	
	Optional<User> getUser(Long id);
	
	User updateUser(Long id, User user);
	
	void deleteUser(Long id);
	
	boolean checkIfAdmin(User user);
}
