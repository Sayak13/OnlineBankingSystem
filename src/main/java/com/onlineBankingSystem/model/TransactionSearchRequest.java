package com.onlineBankingSystem.model;

import java.time.LocalDate;

public class TransactionSearchRequest {
	private long accountId;
	private LocalDate startDate;
	private LocalDate endDate;
	
	public TransactionSearchRequest() {
		super();
	}

	public TransactionSearchRequest(long accountId, LocalDate startDate, LocalDate endDate) {
		super();
		this.accountId = accountId;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public long getAccountId() {
		return accountId;
	}

	public void setAccountId(long accountId) {
		this.accountId = accountId;
	}

	public LocalDate getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public LocalDate getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "TransactionSearchRequest [accountId=" + accountId + ", startDate=" + startDate + ", endDate=" + endDate
				+ "]";
	}
}
