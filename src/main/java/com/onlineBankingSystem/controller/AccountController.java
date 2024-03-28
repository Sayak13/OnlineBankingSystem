package com.onlineBankingSystem.controller;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.onlineBankingSystem.model.Account;
import com.onlineBankingSystem.service.AccountService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/accountApi")
public class AccountController {
	@Autowired
    private AccountService accountService;

    @PostMapping("/create")
    public ModelAndView createAccount(Account account) {
        Account createdAccount = accountService.createAccount(account);
        ModelAndView mView = new ModelAndView("home");
        mView.addObject("req", "Home");
        if(createdAccount != null) {
        	mView.addObject("msg", "Account Successfully Created");
        }else {
        	mView.addObject("msg", "Sorry some error occured");
        }
        return mView;
    }

    @GetMapping("/getAllAccounts")
    public ResponseEntity<List<Account>> getAllAccounts() {
        List<Account> accountList = accountService.getAllAccount();
        if (!accountList.isEmpty()) {
            return new ResponseEntity<>(accountList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(Collections.emptyList(), HttpStatus.OK);
        }
    }

    @GetMapping("/getAccount/{id}")
    public ResponseEntity<Account> getAccountById(@PathVariable Long id) {
        Optional<Account> account = accountService.getAccount(id);
        return account.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }
    
    //new
    @GetMapping("/getAccountByUser/{id}")
    public ModelAndView getAccountByUserId(@PathVariable Long id) {
        ModelAndView mView = new ModelAndView("home");
        List<Account> accounts = accountService.getAccountByUserIdAndAccountStatus(id, "ACTIVE");
        
        mView.addObject("req", "Account Details");
        mView.addObject("accounts", accounts);
        return mView;
    }

    @PutMapping("/updateAccount/{id}")
    public ResponseEntity<Account> updateAccount(@PathVariable Long id, @RequestBody Account account) {
        Account updatedAccount = accountService.updateAccount(id, account);
        if (updatedAccount != null) {
            return new ResponseEntity<>(updatedAccount, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/delete")
    public ModelAndView deleteAccount(@RequestParam ("accountId") Long accountId,HttpSession session) {
    	ModelAndView mView = new ModelAndView("home");
    	mView.addObject("req", "Home");
    	if(session.getAttribute("userId")==null)
    		return mView;
    	long userId=(long) session.getAttribute("userId");
    	Optional<Account> OptionalAccount = accountService.getAccount(accountId);
    	if(OptionalAccount.isPresent()) {
    		if(OptionalAccount.get().getUserId()!=userId) {
    			return mView;
    		}
    	}
    	
        Account account = accountService.deleteAccount(accountId);
        if(account==null) {
        	mView.addObject("errors", "Something went wrong.");
        }else {
        	mView.addObject("msg", "Account Deleted Successfully!");
        }
    	System.out.println("delete Account method in controller" + accountId);
        return mView;
    }
}
