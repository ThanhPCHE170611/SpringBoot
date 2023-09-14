package com.example.myproject.Student;

import com.example.myproject.Class.Class;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Getter
@Setter
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;
    private String username;
    private String password;
    private boolean gender;
    @ManyToOne
    @JoinColumn(name = "classid")
    private Class studentClass;


    public Student(String name, String username, String password, boolean gender, Class studentClass) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.studentClass = studentClass;
    }

    public Student() {
    }
}
