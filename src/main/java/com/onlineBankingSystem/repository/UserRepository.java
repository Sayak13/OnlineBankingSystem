package com.onlineBankingSystem.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.onlineBankingSystem.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
	
	public Optional<User> findByPanNo(String panNo);
	
	public Optional<User> findByUserIdOrPanNo(Long userId, String panNo);
}
