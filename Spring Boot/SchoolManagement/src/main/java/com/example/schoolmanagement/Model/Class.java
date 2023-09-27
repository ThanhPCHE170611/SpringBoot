package com.example.schoolmanagement.Model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Table
@Getter
@Setter
public class Class {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    private String classname;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="class_subject", joinColumns = @JoinColumn(name ="rollnumber"),
            inverseJoinColumns = @JoinColumn(name="subjectcode"))
    private List<Subject> subjects;

    @ManyToOne
    @JoinColumn(name = "organization")
    private Organization organization;


}
