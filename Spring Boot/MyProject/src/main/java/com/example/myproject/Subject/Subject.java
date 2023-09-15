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

    public Subject(Long id, String subjectname) {
        this.id = id;
        this.subjectname = subjectname;
    }
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Subject student = (Subject) obj;
        return id == student.id;
    }
}
