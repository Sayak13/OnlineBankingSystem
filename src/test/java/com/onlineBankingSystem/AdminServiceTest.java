package com.onlineBankingSystem;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.onlineBankingSystem.model.Account;
import com.onlineBankingSystem.model.User;
import com.onlineBankingSystem.repository.AccountRepository;
import com.onlineBankingSystem.repository.UserRepository;
import com.onlineBankingSystem.service.AdminServiceImpl;

@ExtendWith(MockitoExtension.class)
public class AdminServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private AccountRepository accountRepository;

    @InjectMocks
    private AdminServiceImpl adminService;
    
    User user;
    Account account;

    @BeforeEach
    public void init() {
    	user = new User(1L, "Sayak Bose", "sayak@gmail.com", "7699025214", "EYCPB1016D", "West Bengal",
        		Date.valueOf(LocalDate.now()), "1234");
    	account = new Account();
		account.setAccountId(1L);
		account.setUserId(1L);
		account.setAccountType("Savings");
		account.setBalance(1000.0);
		account.setCreatedOn(new Timestamp(System.currentTimeMillis()));
		account.setAccountStatus("Active");
    }

    @Test
    public void testGetAllUsers() {
        List<User> users = Arrays.asList(user);

        when(userRepository.findAll()).thenReturn(users);

        List<User> result = adminService.getAllUsers();
        System.out.println(result.size());
        assertEquals(1, result.size());
    }

    @Test
    public void testGetAllAccounts() {
        List<Account> accounts = Arrays.asList(account);

        when(accountRepository.findAll()).thenReturn(accounts);

        List<Account> result = adminService.getAllAccounts();

        assertEquals(1, result.size());
    }

    @Test
    public void testGetAccount() {
        when(accountRepository.findById(1L)).thenReturn(Optional.of(account));

        Optional<Account> result = adminService.getAccount(1L);

        assertTrue(result.isPresent());
    }
    
    @Test
    public void testGetUser() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));

        Optional<User> result = adminService.getUser(1L);

        assertTrue(result.isPresent());
    }

}