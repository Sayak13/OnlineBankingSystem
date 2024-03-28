package com.onlineBankingSystem.model;

import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;


@Entity
public class Account {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long accountId;
	@Column(name = "userId", nullable = true)
	private Long userId;
	private String accountType;
	private double balance;
	private Timestamp createdOn;
	private String accountStatus;

	@Override
	public String toString() {
		return "Account [accountId=" + accountId + ", userId=" + userId + ", accountType=" + accountType + ", balance="
				+ balance + ", createdOn=" + createdOn + ", accountStatus=" + accountStatus + "]";
	}
	
	public Account() {
		
	}

	public Account(long accountId, Long userId, String accountType, double balance, Timestamp 	createdOn, String accountStatus) {
		super();
		this.accountId = accountId;
		this.userId = userId;
		this.accountType = accountType;
		this.balance = balance;
		this.createdOn = createdOn;
		this.accountStatus = accountStatus;
	}

	public long getAccountId() {
		return accountId;
	}

	public void setAccountId(long accountId) {
		this.accountId = accountId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public String getAccountStatus() {
		return accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}

}
