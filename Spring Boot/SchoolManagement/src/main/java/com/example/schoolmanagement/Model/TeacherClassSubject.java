package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "teacher_class")
@Getter
@Setter
public class TeacherClassSubject {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "rollnumber") // Relates to the teacher
    private Users teacher;

    @ManyToOne
    @JoinColumn(name = "classid") // Relates to the class
    private Class classTeaching;

    @ManyToOne
    @JoinColumn(name = "subjectcode") // Relates to the subject
    private Subject subjectTeaching;

}
