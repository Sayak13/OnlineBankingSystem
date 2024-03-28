package com.onlineBankingSystem.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onlineBankingSystem.model.Account;
import com.onlineBankingSystem.repository.AccountRepository;

@Service
public class AccountServiceImpl implements AccountService {
	
	@Autowired
    private AccountRepository accountRepository;

	@Override
	public Account createAccount(Account account) {
		// TODO Auto-generated method stub
		Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
    	account.setCreatedOn(currentTimestamp);
    	System.out.println(account.getUserId());
		return accountRepository.save(account);
	}

	@Override
	public List<Account> getAllAccount() {
		// TODO Auto-generated method stub
		return accountRepository.findAll();
	}

	@Override
	public Optional<Account> getAccount(Long id) {
		// TODO Auto-generated method stub
		return accountRepository.findById(id);
	}

	@Override
	public Account updateAccount(Long id, Account account) {
		Optional<Account> existingAccountOptional = accountRepository.findById(id);

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
	
	//For Transactions
	@Override
	public boolean updateBalance(Long id, double balance) {
		Optional<Account> existingAccountOptional = accountRepository.findById(id);
		
		if (existingAccountOptional.isPresent()) {
			Account existingAccount = existingAccountOptional.get();
			existingAccount.setBalance(existingAccount.getBalance()+balance);
			
			accountRepository.save(existingAccount);
			return true;
		}
		
		return false;
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
	public List<Account> getAccountByUserIdAndAccountStatus(Long id, String accountStatus) {
		// TODO Auto-generated method stub
		return accountRepository.findByUserIdAndAccountStatus(id, accountStatus);
	}

	@Override
	public Optional<Account> getActiveAccountById(Long accountId) {
		// TODO Auto-generated method stub
		return accountRepository.findActiveAccountById(accountId);
	}

}
