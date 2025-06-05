package com.example.ToDoApp.service;

import com.example.ToDoApp.repo.IToDoRepo;
import com.example.ToDoApp.model.ToDo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class ToDoService {

    @Autowired
    IToDoRepo repo;

    public List<ToDo> getAllToDoItems() {
        ArrayList<ToDo> todoList =  new ArrayList<>();
        repo.findAll().forEach(todo -> todoList.add(todo));

        return todoList;
    }

    public ToDo getToDoItemById(Long id) {
        return repo.findById(id).get();
    }

    public boolean updateStatus(Long id) {
        ToDo todo = getToDoItemById(id);
        todo.setStatus("Completed");

        return saveOrUpdateToDoItem(todo);
    }

    public boolean saveOrUpdateToDoItem(ToDo todo) {

        todo.setDate(LocalDate.now());
        ToDo updatedObj = repo.save(todo);
        if(getToDoItemById(updatedObj.getId()) != null){

            return true;
        }

        return false;
    }

    public boolean deleteToDoItem(Long id) {
        repo.deleteById(id);

        if(repo.findById(id).isEmpty()){
            return true;
        }

        return false;
    }
    public List<ToDo> getToDosByUserId(Long userId) {
        return repo.findByUser_Id(userId);
    }

}
