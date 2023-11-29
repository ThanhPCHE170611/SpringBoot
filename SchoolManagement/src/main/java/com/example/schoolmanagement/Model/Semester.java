package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Table
@Entity
@Getter
@Setter
public class Semester {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String semester;
    private String Year;

    public Semester(String semestername, String year) {
        this.semester = semestername;
        this.Year = year;
    }

    public Semester() {
    }
}
