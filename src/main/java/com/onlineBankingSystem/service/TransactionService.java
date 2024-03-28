package com.onlineBankingSystem.service;

import java.util.List;

import com.onlineBankingSystem.model.Transaction;
import com.onlineBankingSystem.model.TransactionSearchRequest;

public interface TransactionService {
	Transaction createTransaction(Transaction transaction);
	
	List<Transaction> getAllTransactionByAccountIdAndTimePeriod(TransactionSearchRequest transactionSearchRequest);
}
