package com.example.ToDoApp.dto;

import java.time.LocalDate;

public class ToDoItemDto {
    private Long id;
    private String title;
    private LocalDate date;
    private String status;

    public ToDoItemDto(Long id, String title, LocalDate date, String status) {
        this.id = id;
        this.title = title;
        this.date = date;
        this.status = status;
    }

    // Геттеры и сеттеры
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
