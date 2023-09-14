package com.example.myproject.Teacher;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Getter
@Setter
public class Teacher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String username;
    private String password;
    private boolean gender;

    // Getter và Setter

    public Teacher(String name, String username, String password, boolean gender) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.gender = gender;
    }

    public Teacher() {
    }
}

