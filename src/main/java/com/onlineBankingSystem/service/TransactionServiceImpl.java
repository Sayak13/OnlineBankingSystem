package com.onlineBankingSystem.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onlineBankingSystem.model.Transaction;
import com.onlineBankingSystem.model.TransactionSearchRequest;
import com.onlineBankingSystem.repository.TransactionRepository;

@Service
public class TransactionServiceImpl implements TransactionService {

	@Autowired
	TransactionRepository transactionRepository;
	
	@Override
	public Transaction createTransaction(Transaction transaction) {
		// TODO Auto-generated method stub
		Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
		transaction.setTransactionTime(currentTimestamp);
		transaction.setTransactionStatus("SUCCESS");
		return transactionRepository.save(transaction);
	}

	@Override
	public List<Transaction> getAllTransactionByAccountIdAndTimePeriod(TransactionSearchRequest transactionSearchRequest) {
		// TODO Auto-generated method stub
		Timestamp startTimestamp = Timestamp.valueOf(transactionSearchRequest.getStartDate().atStartOfDay());
		Timestamp endTimestamp = Timestamp.valueOf(transactionSearchRequest.getEndDate().plusDays(1).atStartOfDay());
		System.out.println("Transaction history of from "+startTimestamp+" to "+ endTimestamp);
		return 
				transactionRepository.findBySenderAccountIdOrReceiverAccountIdAndTransactionTimeGreaterThanEqualAndTransactionTimeLessThan
				(transactionSearchRequest.getAccountId(), transactionSearchRequest.getAccountId(), startTimestamp, endTimestamp);
	}

}
