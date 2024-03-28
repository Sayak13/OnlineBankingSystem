package com.onlineBankingSystem.model;

import java.sql.Timestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Transaction {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long transactionId;
	private long senderAccountId;
	private long receiverAccountId;
	private double amount;
	private Timestamp transactionTime;
	private String transactionStatus;
	
	public Transaction() {
		
	}

	public Transaction(long transactionId, long senderAccountId, long receiverAccountId, double amount,
			Timestamp transactionTime, String transactionStatus) {
		super();
		this.transactionId = transactionId;
		this.senderAccountId = senderAccountId;
		this.receiverAccountId = receiverAccountId;
		this.amount = amount;
		this.transactionTime = transactionTime;
		this.transactionStatus = transactionStatus;
	}

	public long getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(long transactionId) {
		this.transactionId = transactionId;
	}

	public long getSenderAccountId() {
		return senderAccountId;
	}

	public void setSenderAccountId(long senderAccountId) {
		this.senderAccountId = senderAccountId;
	}

	public long getReceiverAccountId() {
		return receiverAccountId;
	}

	public void setReceiverAccountId(long receiverAccountId) {
		this.receiverAccountId = receiverAccountId;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Timestamp getTransactionTime() {
		return transactionTime;
	}

	public void setTransactionTime(Timestamp transactionTime) {
		this.transactionTime = transactionTime;
	}

	public String getTransactionStatus() {
		return transactionStatus;
	}

	public void setTransactionStatus(String transactionStatus) {
		this.transactionStatus = transactionStatus;
	}
}
