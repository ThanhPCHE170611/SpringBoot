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
    private int Id;

    @OneToOne(optional = true)
    @JoinColumn(name = "student")
    private Users student;

    @OneToOne(optional = true)
    @JoinColumn(name = "teacher")
    private Users teacher;

    @ManyToOne
    @JoinColumn(name = "old_class_id")
    private Class oldClass;

    @ManyToOne
    @JoinColumn(name = "new_class_id")
    private Class newClass;

    private String status;
    private String reason;
}

