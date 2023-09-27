package com.example.schoolmanagement.Model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Table
@Entity
@Getter
@Setter
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private String rollNumber;

    private String username;
    private String password;
    private String email;

    //Orgarnizaion
    @OneToOne
    @JoinColumn(name = "gender")
    private Gender gender;

    @OneToOne
    @JoinColumn(name = "ethnic")
    private Ethnic ethnic;

    @OneToOne
    @JoinColumn(name = "religion")
    private Religion religions;
    private String picture;
    private String hobbies;
    private String address;
    private String hometown;
    private String parrentName;
    private String status;
    @ManyToOne
    @JoinColumn(name = "teacher_roll_number")
    private Users teacher;
    private double markAverage;
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="user_role", joinColumns = @JoinColumn(name ="rollnumber"),
            inverseJoinColumns = @JoinColumn(name="id"))
    private List<Role> roles;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="teacher_subject", joinColumns = @JoinColumn(name ="rollnumber"),
            inverseJoinColumns = @JoinColumn(name="subjectcode"))
    private List<Subject> subjects;

    @OneToOne
    @JoinColumn(name = "teacher_class")
    private Class teacherclass;

    @ManyToOne
    @JoinColumn(name = "student_class")
    private Class studentclass;

    private Date lastchangepassword;
}
