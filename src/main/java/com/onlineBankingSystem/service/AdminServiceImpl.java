package com.onlineBankingSystem.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onlineBankingSystem.model.Account;
import com.onlineBankingSystem.model.User;
import com.onlineBankingSystem.repository.AccountRepository;
import com.onlineBankingSystem.repository.UserRepository;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	UserRepository userRepository;

	@Autowired
	AccountRepository accountRepository;

	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return userRepository.findAll();
	}

	@Override
	public List<Account> getAllAccounts() {
		// TODO Auto-generated method stub
		return accountRepository.findAll();
	}

	@Override
	public void deleteUser(Long userId) {
		userRepository.deleteById(userId);
	}

	@Override
	public Account deleteAccount(Long id) {
		// TODO Auto-generated method stub
		Optional<Account> existingAccountOptional = accountRepository.findById(id);

		if (existingAccountOptional.isPresent()) {
			Account existingAccount = existingAccountOptional.get();
			existingAccount.setAccountStatus("INACTIVE");

			return accountRepository.save(existingAccount);
		} else {
			return null;
		}
	}

	@Override
	public Optional<User> getUser(Long userId) {
		// TODO Auto-generated method stub
		Optional<User> user = userRepository.findById(userId);
		return user;
	}

	@Override
	public Optional<Account> getAccount(Long accountId) {
		// TODO Auto-generated method stub
		Optional<Account> account = accountRepository.findById(accountId);
		return account;
	}

	@Override
	public User updateUser(User user) {
		Optional<User> existingUserOptional = userRepository.findById(user.getUserId());

		if (existingUserOptional.isPresent()) {

			User existingUser = existingUserOptional.get();
			existingUser.setName(user.getName());
			existingUser.setEmail(user.getEmail());
			existingUser.setPhnNo(user.getPhnNo());
			existingUser.setAddress(user.getAddress());
			existingUser.setDob(user.getDob());

			return userRepository.save(existingUser);
		} else {
			return null;
		}
	}

	@Override
	public Account updateAccount(Account account) {
		Optional<Account> existingAccountOptional = accountRepository.findById(account.getAccountId());

		if (existingAccountOptional.isPresent()) {
			Account existingAccount = existingAccountOptional.get();
			existingAccount.setAccountType(account.getAccountType());
			existingAccount.setBalance(account.getBalance());
			existingAccount.setAccountStatus(account.getAccountStatus());

			return accountRepository.save(existingAccount);
		} else {
			return null;
		}
	}

}
