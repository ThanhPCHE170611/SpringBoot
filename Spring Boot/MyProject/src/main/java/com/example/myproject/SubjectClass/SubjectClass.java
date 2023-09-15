package com.example.myproject.SubjectClass;

import com.example.myproject.Class.Class;
import com.example.myproject.Subject.Subject;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@Table
public class SubjectClass {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "subjectid")
    private Subject subject;

    @ManyToOne
    @JoinColumn(name = "classid")
    private Class classEntity;

    // Getter và Setter


    public SubjectClass(Subject subject, Class classEntity) {
        this.subject = subject;
        this.classEntity = classEntity;
    }

    public SubjectClass() {
    }

}

