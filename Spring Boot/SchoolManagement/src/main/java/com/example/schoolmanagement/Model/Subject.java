package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.List;

@Entity
@Table
@Getter
@Setter
public class Subject {
    @Id
    private String subjectcode;

    private String subjectname;

    private String status;

    @OneToMany(mappedBy = "subjectTeaching")
    private List<TeacherClassSubject> subjectTeachers;

}
