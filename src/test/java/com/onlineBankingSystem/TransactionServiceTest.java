package com.onlineBankingSystem;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.when;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.onlineBankingSystem.model.Transaction;
import com.onlineBankingSystem.model.TransactionSearchRequest;
import com.onlineBankingSystem.repository.TransactionRepository;
import com.onlineBankingSystem.service.TransactionServiceImpl;

@ExtendWith(MockitoExtension.class)
public class TransactionServiceTest {

    @InjectMocks
    private TransactionServiceImpl transactionService;

    @Mock
    private TransactionRepository transactionRepository;

    private Transaction transaction;
    private TransactionSearchRequest transactionSearchRequest;

    @BeforeEach
    public void setUp() {
        transaction = new Transaction(1L, 1L, 2L, 100.0, new Timestamp(System.currentTimeMillis()), "SUCCESS");
        transactionSearchRequest = new TransactionSearchRequest(1L, LocalDate.now(), LocalDate.now());
    }

    @Test
    public void createTransactionTest() {
        when(transactionRepository.save(transaction)).thenReturn(transaction);
        Transaction createdTransaction = transactionService.createTransaction(transaction);
        assertNotNull(createdTransaction);
        assertEquals(1, createdTransaction.getTransactionId());
        assertEquals(1, createdTransaction.getSenderAccountId());
        assertEquals(2, createdTransaction.getReceiverAccountId());
        assertEquals(100.0, createdTransaction.getAmount());
        assertNotNull(createdTransaction.getTransactionTime());
        assertEquals("SUCCESS", createdTransaction.getTransactionStatus());
    }

//    @Test
//    public void getAllTransactionByAccountIdAndTimePeriodTest() {
//        when(transactionRepository.findBySenderAccountIdOrReceiverAccountIdAndTransactionTimeGreaterThanEqualAndTransactionTimeLessThan(1L, 1L, new Timestamp(System.currentTimeMillis()), new Timestamp(System.currentTimeMillis()))).thenReturn(Arrays.asList(transaction));
//        List<Transaction> transactions = transactionService.getAllTransactionByAccountIdAndTimePeriod(transactionSearchRequest);
//        assertNotNull(transactions);
//        assertEquals(1, transactions.size());
//        assertEquals(1, transactions.get(0).getTransactionId());
//        assertEquals(1, transactions.get(0).getSenderAccountId());
//        assertEquals(2, transactions.get(0).getReceiverAccountId());
//        assertEquals(100.0, transactions.get(0).getAmount());
//        assertNotNull(transactions.get(0).getTransactionTime());
//        assertEquals("SUCCESS", transactions.get(0).getTransactionStatus());
//    }
}
