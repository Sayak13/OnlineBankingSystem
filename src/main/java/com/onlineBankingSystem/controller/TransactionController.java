package com.onlineBankingSystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.onlineBankingSystem.model.Transaction;
import com.onlineBankingSystem.model.TransactionSearchRequest;
import com.onlineBankingSystem.service.AccountService;
import com.onlineBankingSystem.service.TransactionService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/transactionApi")
public class TransactionController {
	
	@Autowired
	TransactionService transactionService;
	
	@Autowired
	AccountService accountService;
	
	@GetMapping("/newTransaction")
	public ModelAndView newTransaction(HttpSession session) {
		ModelAndView mView = new ModelAndView("transaction");
		mView.addObject("req", "NEW TRANSACTION");
		long userId = (long) session.getAttribute("userId");
		mView.addObject("accounts", accountService.getAccountByUserIdAndAccountStatus(userId, "ACTIVE"));
		return mView;
	}
	
	@GetMapping("/transactionHistory")
	public ModelAndView transactionHistory(HttpSession session) {
		ModelAndView mView = new ModelAndView("transaction");
		mView.addObject("req", "TRANSACTION HISTORY FORM");
		long userId = (long) session.getAttribute("userId");
		mView.addObject("accounts", accountService.getAccountByUserIdAndAccountStatus(userId, "ACTIVE"));
		return mView;
	}
	
	
	@PostMapping("/create")
	public ModelAndView createTransaction(Transaction transaction) {
		ModelAndView mView = new ModelAndView("home"); 
		mView.addObject("req", "Home");
		if(accountService.getAccount(transaction.getReceiverAccountId()).isPresent() && accountService.getActiveAccountById(transaction.getReceiverAccountId()).isEmpty()) {
			
			if(accountService.getAccount(transaction.getSenderAccountId()).get().getBalance() >= 
					transaction.getAmount()) {
				boolean flag=true;
				flag = accountService.updateBalance(transaction.getReceiverAccountId(), transaction.getAmount());
				flag = accountService.updateBalance(transaction.getSenderAccountId(), (transaction.getAmount()*(-1)));
				if(flag) {
					transactionService.createTransaction(transaction);
				}else {
					mView.addObject("errors", "SOMETHING WENT WRONG");
				}
			}else {
				mView.addObject("errors", "INSUFFICIENT BALANCE");
			}
		}else {
			mView.addObject("errors", "INVALID ACCOUNT ID");
		}
		return mView;
	}
	
	@PostMapping("/transactionhistory")
	public ModelAndView getTransactionHistory(TransactionSearchRequest transactionSearchRequest) {
		ModelAndView mView= new ModelAndView("transaction");
		mView.addObject("req", "TRANSACTION HISTORY");
		mView.addObject("accountId", transactionSearchRequest.getAccountId());
		List<Transaction> transactions = transactionService.getAllTransactionByAccountIdAndTimePeriod(transactionSearchRequest);
		mView.addObject("transactions", transactions);
		
		return mView;
	}
}
