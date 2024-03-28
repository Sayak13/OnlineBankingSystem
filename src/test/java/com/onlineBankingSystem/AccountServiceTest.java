package com.onlineBankingSystem;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.onlineBankingSystem.model.Account;
import com.onlineBankingSystem.repository.AccountRepository;
import com.onlineBankingSystem.service.AccountServiceImpl;

@ExtendWith(MockitoExtension.class)
public class AccountServiceTest {

	@Mock
	private AccountRepository accountRepository;

	@InjectMocks
	private AccountServiceImpl accountService;

	private Account account;

	@BeforeEach
	public void setUp() {
		account = new Account();
		account.setAccountId(1L);
		account.setUserId(1L);
		account.setAccountType("Savings");
		account.setBalance(1000.0);
		account.setCreatedOn(new Timestamp(System.currentTimeMillis()));
		account.setAccountStatus("Active");
	}

	@Test
	public void testCreateAccount() {
		when(accountRepository.save(account)).thenReturn(account);
		Account createdAccount = accountService.createAccount(account);
		assertEquals(account, createdAccount);
	}

	@Test
	public void testGetAllAccount() {
		List<Account> accounts = new ArrayList<>();
		accounts.add(account);
		when(accountRepository.findAll()).thenReturn(accounts);
		List<Account> retrievedAccounts = accountService.getAllAccount();
		assertEquals(accounts, retrievedAccounts);
	}

	@Test
	public void testGetAccount() {
		when(accountRepository.findById(account.getAccountId())).thenReturn(Optional.of(account));
		Optional<Account> retrievedAccount = accountService.getAccount(account.getAccountId());
		assertEquals(Optional.of(account), retrievedAccount);
	}

	@Test
	public void testUpdateAccount() {
		Account updatedAccount = new Account(1L, 1L, "CHECKING", 2000.00, Timestamp.valueOf("2021-01-01 00:00:00"),
				"ACTIVE");

		when(accountRepository.findById(1L)).thenReturn(Optional.of(account));
		when(accountRepository.save(account)).thenReturn(updatedAccount);

		Account result = accountService.updateAccount(1L, updatedAccount);

		assertNotNull(result);
		assertEquals("CHECKING", result.getAccountType());
		assertEquals(2000.00, result.getBalance());
		assertEquals("ACTIVE", result.getAccountStatus());
	}

	@Test
	public void testGetAccountByUserIdAndAccountStatus() {
		List<Account> accounts = new ArrayList<>();
		accounts.add(account);

		when(accountRepository.findByUserIdAndAccountStatus(1L, "ACTIVE")).thenReturn(accounts);

		List<Account> result = accountService.getAccountByUserIdAndAccountStatus(1L, "ACTIVE");

		assertFalse(result.isEmpty());
		assertEquals(1, result.size());
		assertEquals(account, result.get(0));
	}

	@Test
	public void testGetActiveAccountById() {
		when(accountRepository.findActiveAccountById(1L)).thenReturn(Optional.of(account));

		Optional<Account> result = accountService.getActiveAccountById(1L);

		assertTrue(result.isPresent());
		assertEquals(account, result.get());
	}

}
