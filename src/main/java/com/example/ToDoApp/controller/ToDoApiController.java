package com.example.ToDoApp.controller;

import com.example.ToDoApp.dto.ToDoItemDto;
import com.example.ToDoApp.model.ToDo;
import com.example.ToDoApp.model.User;
import com.example.ToDoApp.repo.IUserRepo;
import com.example.ToDoApp.service.ToDoService;
import com.example.ToDoApp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import com.example.ToDoApp.repo.IToDoRepo;


import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/api")
public class ToDoApiController {

    @Autowired
    private UserService userService;

    @Autowired
    private IToDoRepo toDoRepo;

    @Autowired
    private IUserRepo userRepo;
    private final ToDoService toDoService;

    public ToDoApiController(ToDoService toDoService) {
        this.toDoService = toDoService;
    }

    @GetMapping("/tasks")
    public ResponseEntity<List<ToDoItemDto>> getUserTasks(Authentication authentication) {
        String username = authentication.getName();

        // Запрашиваем пользователя из базы по username, чтобы получить ID
        User user = userService.findByUsername(username);
        Long userId = user.getId();

        List<ToDo> tasks = toDoService.getToDosByUserId(userId);

        List<ToDoItemDto> dtos = tasks.stream()
                .map(task -> new ToDoItemDto(task.getId(), task.getTitle(), task.getDate(), task.getStatus()))
                .collect(Collectors.toList());

        return ResponseEntity.ok(dtos);
    }
    @PostMapping("/tasks/manual")
    public ResponseEntity<?> createTask(@RequestBody ToDo task, Principal principal) {
        String username = principal.getName();
        User user = userRepo.findByUsername(username).orElseThrow();
        task.setUser(user); // СВЯЗЫВАЕМ с пользователем
        ToDo saved = toDoRepo.save(task);
        return ResponseEntity.ok(saved);
    }

    @PostMapping("/tasks")
    @ResponseBody
    public ResponseEntity<?> saveToDoItem(@RequestBody ToDo todo) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()
                || authentication.getPrincipal().equals("anonymousUser")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Not authenticated");
        }

        String username = authentication.getName();
        User user = userRepo.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));

        todo.setUser(user);

        if (toDoService.saveOrUpdateToDoItem(todo)) {
            return ResponseEntity.ok("Saved");
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Save failed");
    }

}
