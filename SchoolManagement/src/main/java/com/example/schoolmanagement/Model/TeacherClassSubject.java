package com.example.schoolmanagement.Model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "teacher_class")
@Getter
@Setter
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class TeacherClassSubject {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "rollnumber") // Relates to the teacher
    private Users teacher;

    @ManyToOne
    @JoinColumn(name = "classid") // Relates to the class
    private Class classTeaching;

    @ManyToOne
    @JoinColumn(name = "subjectcode") // Relates to the subject
    private Subject subjectTeaching;

    private String status;

    public TeacherClassSubject(Users teacher, Class classTeaching, Subject subjectTeaching) {
        this.teacher = teacher;
        this.classTeaching = classTeaching;
        this.subjectTeaching = subjectTeaching;
        this.status = "active";
    }

    public TeacherClassSubject() {

    }
}
