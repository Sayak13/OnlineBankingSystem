package com.onlineBankingSystem.service;

import java.util.List;
import java.util.Optional;

import com.onlineBankingSystem.model.Account;

public interface AccountService {
	Account createAccount(Account account);

	List<Account> getAllAccount();

	Optional<Account> getAccount(Long id);
	
	//List<Account> getAccountByUserId(Long id);

	Account updateAccount(Long id, Account account);
	
	boolean updateBalance(Long id, double balance);

	Account deleteAccount(Long id);

	List<Account> getAccountByUserIdAndAccountStatus(Long id, String accountStatus);
	
	Optional<Account> getActiveAccountById(Long accountId);
}
