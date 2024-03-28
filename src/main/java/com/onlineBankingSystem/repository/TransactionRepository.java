package com.onlineBankingSystem.repository;

import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.onlineBankingSystem.model.Transaction;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, Long> {

	@Query("SELECT t FROM Transaction t WHERE " +
            "(t.senderAccountId = :accountId OR t.receiverAccountId = :receiverAccountId) AND " +
            "t.transactionTime >= :startDate AND t.transactionTime < :endDate")
    List<Transaction> findBySenderAccountIdOrReceiverAccountIdAndTransactionTimeGreaterThanEqualAndTransactionTimeLessThan(
            @Param("accountId") Long accountId,
            @Param("receiverAccountId") Long receiverAccountId,
            @Param("startDate") Timestamp startDate,
            @Param("endDate") Timestamp endDate);
}
