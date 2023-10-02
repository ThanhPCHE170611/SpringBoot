package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
@Getter
@Setter
public class Subject {
    @Id
    private String subjectcode;

    private String subjectname;
    private String status;
}
