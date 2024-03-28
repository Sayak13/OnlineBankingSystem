package com.onlineBankingSystem.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.onlineBankingSystem.model.Account;
import com.onlineBankingSystem.model.User;
import com.onlineBankingSystem.service.AdminService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/adminApi")
public class AdminController {

	@Autowired
	AdminService adminService;

	@GetMapping("/adminHome")
	public ModelAndView adminHome() {
		ModelAndView mView = new ModelAndView("adminHome");
		mView.addObject("req", "");
		return mView;
	}

	@GetMapping("/allUsers")
	public ModelAndView getAllUsers() {
		ModelAndView mView = new ModelAndView("adminHome");
		mView.addObject("req", "Users");
		mView.addObject("users", adminService.getAllUsers());
		return mView;
	}

	@GetMapping("/allAccounts")
	public ModelAndView getAllAccounts() {
		ModelAndView mView = new ModelAndView("adminHome");
		mView.addObject("req", "Accounts");
		mView.addObject("accounts", adminService.getAllAccounts());
		return mView;
	}
	
	@PostMapping("/getUser")
	public ModelAndView getUser(@RequestParam Long userId) {
		ModelAndView mView = new ModelAndView("adminHome");
		Optional<User> user = adminService.getUser(userId);
		if(user.isPresent()) {
			mView.addObject("user", user.get());
		}else {
			mView.addObject("user",null);
		}
		
		mView.addObject("req", "User");
		return mView;
	}
	
	@PostMapping("/getAccount")
	public ModelAndView getAccount(@RequestParam Long accountId) {
		ModelAndView mView = new ModelAndView("adminHome");
		Optional<Account> accOptional = adminService.getAccount(accountId);
		if(accOptional.isPresent()) {
			mView.addObject("account", accOptional.get());
		}else {
			mView.addObject("account", null);
		}
		
		mView.addObject("req", "Account");
		return mView;
	}
	
	@GetMapping("updateUser/{userId}")
	public ModelAndView updateUserGet(@PathVariable long userId) {
		ModelAndView mView = new ModelAndView("updateUserAdmin");
		Optional<User> optional= adminService.getUser(userId);
		if(optional.isEmpty()) {
			mView.addObject("errors", "Some Error Occured!");
			return mView;
		}
		mView.addObject("user", optional.get());
		return mView;
	}
	
	@PostMapping("/updateUser")
	public ModelAndView updateUserPost(User user) {
		ModelAndView mView = new ModelAndView("adminHome");
		user=adminService.updateUser(user);
		if(user==null) {
			mView.addObject("errors", "Some error Occured!");
		}
		mView.addObject("req", "Users");
		mView.addObject("users", adminService.getAllUsers());
		return mView;
	}
	
	@GetMapping("updateAccount/{accountId}")
	public ModelAndView updateAccountGet(@PathVariable Long accountId) {
		ModelAndView mView = new ModelAndView("updateAccountAdmin");
		Optional<Account> optional= adminService.getAccount(accountId);
		if(optional.isEmpty()) {
			mView.addObject("errors", "Some Error Occured!");
			return mView;
		}
		mView.addObject("account", optional.get());
		return mView;
	}
	
	@PostMapping("/updateAccount")
	public ModelAndView updateAccountPost(Account account) {
		ModelAndView mView = new ModelAndView("adminHome");
		account=adminService.updateAccount(account);
		if(account==null) {
			mView.addObject("errors", "Some error Occured!");
		}
		mView.addObject("req", "Accounts");
		mView.addObject("accounts", adminService.getAllAccounts());
		return mView;
	}
	
	@GetMapping("/deleteUser")
	public ModelAndView deleteuser(@RequestParam ("userId") Long userId, HttpSession session) {
		ModelAndView mView = new ModelAndView("adminHome");
		if(session.getAttribute("admin")==null) {
    		return new ModelAndView("login");
    	}
		
		adminService.deleteUser(userId);
		mView.addObject("req", "Users");
		mView.addObject("users", adminService.getAllUsers());
		return mView;
	}
	
	
	@PostMapping("/deleteAccount")
    public ModelAndView deleteAccount(@RequestParam ("accountId") Long accountId,HttpSession session) {
    	ModelAndView mView = new ModelAndView("adminHome");
    	if(session.getAttribute("admin")==null) {
    		return new ModelAndView("login");
    	}
    	
        Account account = adminService.deleteAccount(accountId);
        if(account==null) {
        	mView.addObject("errors", "Something went wrong.");
        }else {
        	mView.addObject("msg", "Account Deleted Successfully!");
        	mView.addObject("req", "Accounts");
    		mView.addObject("accounts", adminService.getAllAccounts());
        }
    	System.out.println("delete Account method in controller" + accountId);
        return mView;
    }
}
