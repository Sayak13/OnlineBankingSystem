package com.onlineBankingSystem.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.onlineBankingSystem.model.User;
import com.onlineBankingSystem.service.UserService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/userApi")
public class UserController {
	@Autowired
	public UserService userService;
	
	@GetMapping("/index")
	public ModelAndView loginSignup() {
		ModelAndView mView = new ModelAndView();
		mView.setViewName("login");
		
		return mView;
	}
	
	@GetMapping("/home")
	public ModelAndView home() {
		ModelAndView mView = new ModelAndView();
		mView.setViewName("home");
		mView.addObject("req", "Home");
		return mView;
	}
	
	@PostMapping("/create")
    public ModelAndView createUser(User user) {
		ModelAndView mView = new ModelAndView();
		mView.setViewName("login");
		if (userService.checkIfExists(user.getPanNo())) {
	        //return new ResponseEntity<>("Email already exists", HttpStatus.CONFLICT);
			mView.addObject("msg", "User already exists");
			return mView;
	    }
	    // Continue with account creation
	    userService.createUser(user);
	    //mView.addObject("msg", "");
		return mView;
    }
	
	@PostMapping("/login")
    public ModelAndView login(User user, HttpSession session) {
		User validateUser = userService.validateUser(user);

		ModelAndView mView = new ModelAndView();
		
		// Check if the user is Admin
		System.out.println(user.getUserId());
		if(userService.checkIfAdmin(user)) {
			mView.setViewName("adminHome");
			mView.addObject("req", "");
			session.setAttribute("admin", "Admin");
		}
		else if(!userService.checkIfExistsUsingId(user.getUserId()) && !userService.checkIfExists(user.getPanNo())) {
			mView.setViewName("login");
			mView.addObject("errors", "Invalid User ID or Pan No");
			if(session.getAttribute("user")!=null) {
				session.invalidate();
			}
		}
		else if(validateUser==null) {
			mView.setViewName("login");
			mView.addObject("errors", "Invalid Credentials");
			if(session.getAttribute("user")!=null) {
				session.invalidate();
			}
		}
		else {
			validateUser.setPassword("");
			mView.setViewName("home");
			mView.addObject("req", "Home");
			session.setAttribute("user", validateUser);
			session.setAttribute("userId", validateUser.getUserId());
		}
		return mView;
    }
	
	@GetMapping("/update")
	public ModelAndView updateUserPage() {
		ModelAndView mView = new ModelAndView("updateUser");
		return mView;
	}
	
	@PostMapping("/update")
	public ModelAndView updateUser(User user, HttpSession session) {
		ModelAndView mView=new ModelAndView("updateUser");
		userService.updateUser(user.getUserId(), user);
		session.setAttribute("user", user);
		mView.addObject("msg", "User profile successfully updated.");
		return mView;
	}
	
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mView = new ModelAndView("login");
		mView.addObject("msg", "You have successfully logged out.");
		return mView;
	}
	
	@GetMapping("deleteUser/{id}")
	public ModelAndView deleteUser(@PathVariable Long id, HttpSession session) {
		ModelAndView mView = new ModelAndView("login");
		mView.addObject("msg", "Some error Occured");
		if(session.getAttribute("userId") != null && session.getAttribute("userId").equals(id)) {
			userService.deleteUser(id);
			session.invalidate();
			mView.addObject("msg", "Account Deleted Successfully");
		}
		System.out.println("Delete Profile");
		return mView;
	}
}
