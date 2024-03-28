	package com.onlineBankingSystem.service;

import java.util.List;
import java.util.Optional;

import com.onlineBankingSystem.model.Account;
import com.onlineBankingSystem.model.User;

public interface AdminService {
	
	public List<User> getAllUsers();
	
	public List<Account> getAllAccounts();
	
	public Optional<Account> getAccount(Long accountId);
	
	public Optional<User> getUser(Long userId);
	
	public Account deleteAccount(Long accountId);
	
	public void deleteUser(Long userId);
	
	public Account updateAccount(Account account);
	
	public User updateUser(User user);
}
