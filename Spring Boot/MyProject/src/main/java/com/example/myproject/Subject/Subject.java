package com.example.myproject.Subject;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Getter
@Setter
public class Subject {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String subjectname;

    public Subject(String subjectname) {
        this.subjectname = subjectname;
    }

    public Subject() {
    }
}
