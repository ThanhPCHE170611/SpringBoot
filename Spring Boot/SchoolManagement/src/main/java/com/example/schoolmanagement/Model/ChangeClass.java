package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Table
@Entity
@Getter
@Setter
public class ChangeClass {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(optional = true)
    @JoinColumn(name = "student")
    private Users student;


    @ManyToOne
    @JoinColumn(name = "old_class_id")
    private Class oldClass;

    @ManyToOne
    @JoinColumn(name = "new_class_id")
    private Class newClass;

    @ManyToOne
    @JoinColumn(name = "semester")
    private Semester semester;

    private String status;
    private String reason;

    public ChangeClass(Users user, Class olcClass, Class newClass, Semester semester) {
        this.student = user;
        this.oldClass = olcClass;
        this.newClass = newClass;
        this.semester = semester;
        status = "process";
    }

    public ChangeClass() {
    }
}

