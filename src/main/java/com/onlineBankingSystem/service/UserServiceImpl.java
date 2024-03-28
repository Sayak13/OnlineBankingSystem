package com.onlineBankingSystem.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onlineBankingSystem.model.User;
import com.onlineBankingSystem.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	public UserRepository userRepository;
	
	@Override
	public User createUser(User user) {
		// TODO Auto-generated method stub
		return userRepository.save(user);
	}

	@Override
	public boolean checkIfExists(String panNo) {
		// TODO Auto-generated method stub
		Optional<User> user= userRepository.findByPanNo(panNo);
		return user.isPresent();
	}
	
	@Override
	public boolean checkIfAdmin(User user) {
		return(user.getUserId()== -1 && user.getPassword().equals("admin"));
	}
	
	@Override
	public boolean checkIfExistsUsingId(Long id) {
		Optional<User> existingUserOptional = userRepository.findById(id);
		return existingUserOptional.isPresent();
	}

	@Override
	public User validateUser(User user) {
		// TODO Auto-generated method stub
		Optional<User> existingUserOptional = userRepository.findByUserIdOrPanNo(user.getUserId(), user.getPanNo());
		if(existingUserOptional.isPresent()) {
			User existingUser = existingUserOptional.get();
			if(existingUser.getPassword().equals(user.getPassword())) {
				return existingUser;
			}
		}
		return null;
	}

	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return userRepository.findAll();
	}

	@Override
	public Optional<User> getUser(Long id) {
		// TODO Auto-generated method stub
		return userRepository.findById(id);
	}

	@Override
	public User updateUser(Long id, User user) {
		Optional<User> existingUserOptional = userRepository.findById(id);
		
        if (existingUserOptional.isPresent()) {
        	
            User existingUser = existingUserOptional.get();
            existingUser.setName(user.getName());
            existingUser.setEmail(user.getEmail());
            existingUser.setPhnNo(user.getPhnNo());
            existingUser.setAddress(user.getAddress());
            existingUser.setDob(user.getDob());

            return userRepository.save(existingUser);
        } else {
            return null;
        }
	}

	@Override
	public void deleteUser(Long id) {
		// TODO Auto-generated method stub
		userRepository.deleteById(id);
	}

}
