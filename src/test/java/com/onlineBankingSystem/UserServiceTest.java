package com.onlineBankingSystem;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.onlineBankingSystem.model.User;
import com.onlineBankingSystem.repository.UserRepository;
import com.onlineBankingSystem.service.UserServiceImpl;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @InjectMocks
    private UserServiceImpl userService;

    @Mock
    private UserRepository userRepository;

    private User user;

    @BeforeEach
    public void setUp() {
        user = new User(1L, "Sayak Bose", "sayak@gmail.com", "7699025214", "EYCPB1016D", "West Bengal",
        		Date.valueOf(LocalDate.now()), "1234");
    }

    @Test
    public void testCreateUser() {
        when(userRepository.save(user)).thenReturn(user);

        User result = userService.createUser(user);

        assertNotNull(result);
        assertEquals(user, result);
    }

    @Test
    public void testCheckIfExists() {
        String panNo = "EYCPB1016D";
        when(userRepository.findByPanNo(panNo)).thenReturn(Optional.of(user));

        boolean result = userService.checkIfExists(panNo);

        assertTrue(result);
    }


    @Test
    public void testCheckIfExistsUsingId() {
        Long id = 1L;
        when(userRepository.findById(id)).thenReturn(Optional.of(user));

        boolean result = userService.checkIfExistsUsingId(id);

        assertTrue(result);
    }

    @Test
    void testGetAllUsers() {
        List<User> users = new ArrayList<>();
        users.add(new User());
        users.add(new User());

        when(userRepository.findAll()).thenReturn(users);

        List<User> result = userService.getAllUsers();

        assertEquals(users, result);
    }

    @Test
    void testGetUser() {
        User user = new User();
        Long id = 1L;

        when(userRepository.findById(id)).thenReturn(Optional.of(user));

        Optional<User> result = userService.getUser(id);

        assertEquals(Optional.of(user), result);
    }

    
}