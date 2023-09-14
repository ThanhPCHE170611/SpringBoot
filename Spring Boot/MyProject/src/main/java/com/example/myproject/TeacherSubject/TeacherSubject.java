package com.example.myproject.TeacherSubject;

import com.example.myproject.Subject.Subject;
import com.example.myproject.Teacher.Teacher;

import javax.persistence.*;

@Entity
public class TeacherSubject {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "teacherid")
    private Teacher teacher;

    @ManyToOne
    @JoinColumn(name = "subjectid")
    private Subject subject;

    public TeacherSubject() {
    }

    public TeacherSubject(Teacher teacher, Subject subject) {
        this.teacher = teacher;
        this.subject = subject;
    }
    // Getter và Setter
}

