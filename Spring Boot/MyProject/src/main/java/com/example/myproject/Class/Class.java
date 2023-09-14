package com.example.myproject.Class;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Getter
@Setter
public class Class {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String classname;

    public Class(String classname) {
        this.classname = classname;
    }

    public Class() {
    }
}
