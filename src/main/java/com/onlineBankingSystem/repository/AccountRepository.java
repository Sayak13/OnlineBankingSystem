package com.onlineBankingSystem.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.onlineBankingSystem.model.Account;

@Repository
public interface AccountRepository extends JpaRepository<Account, Long> {

	List<Account> findByUserIdAndAccountStatus(Long id, String accountStatus);
	
	@Query("SELECT a FROM Account a WHERE a.accountId = :accountId AND (userId IS NULL OR accountStatus = 'INACTIVE')")
	Optional<Account> findActiveAccountById(Long accountId);
}
