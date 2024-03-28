package com.onlineBankingSystem.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long userId;
	private String name;
	private String email;
	private String phnNo;
	private String panNo;
	private String address;
	private Date dob;
	private String password;
	
	public User() {
		
	}

	public User(Long userId, String name, String email, String phnNo, String panNo, String address, Date dob,
			String password) {
		super();
		this.userId = userId;
		this.name = name;
		this.email = email;
		this.phnNo = phnNo;
		this.panNo = panNo;
		this.address = address;
		this.dob = dob;
		this.password = password;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", name=" + name + ", email=" + email + ", phnNo=" + phnNo + ", panNo="
				+ panNo + ", address=" + address + ", dob=" + dob + ", password=" + password + "]";
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhnNo() {
		return phnNo;
	}

	public void setPhnNo(String phnNo) {
		this.phnNo = phnNo;
	}

	public String getPanNo() {
		return panNo;
	}

	public void setPanNo(String panNo) {
		this.panNo = panNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
