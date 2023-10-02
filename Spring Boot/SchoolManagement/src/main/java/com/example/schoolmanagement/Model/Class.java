package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

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
    private Set<Subject> subjects;

}
