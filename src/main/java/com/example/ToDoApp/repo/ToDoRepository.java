package com.example.ToDoApp.repo;

import com.example.ToDoApp.model.ToDo;
import com.example.ToDoApp.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ToDoRepository extends JpaRepository<ToDo, Long> {
    List<ToDo> findByUser(User user);
    List<ToDo> findByUserUsername(String username);
}
