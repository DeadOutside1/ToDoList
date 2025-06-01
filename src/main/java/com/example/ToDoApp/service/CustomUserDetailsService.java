package com.example.ToDoApp.service;

import com.example.ToDoApp.model.User;
import com.example.ToDoApp.repo.IUserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final IUserRepo userRepo;

    @Autowired
    public CustomUserDetailsService(IUserRepo userRepo) {
        this.userRepo = userRepo;
    }
    public List<User> getAllUsers(){
        return userRepo.findAll();
    }

    public Optional<User> getUserById(Long id){
        return userRepo.findById(id);
    }

    public Optional<User> findByUsername(String username){
        return userRepo.findByUsername(username);
    }

    public User createUser(User user){
        return userRepo.save(user);
    }


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));
        System.out.println("pidaras");
        return org.springframework.security.core.userdetails.User
                .builder()
                .username(user.getUsername())
                .password(user.getPassword()) // Здесь пароль должен быть уже закодирован
                .build();
    }
}