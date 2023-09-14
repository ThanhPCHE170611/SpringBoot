package com.example.myproject.ClassChangeRequest;

import com.example.myproject.Class.Class;
import com.example.myproject.Student.Student;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Getter
@Setter
public class ClassChangeRequest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String status;

    @OneToOne
    @JoinColumn(name = "studentid")
    private Student student;
    @ManyToOne
    @JoinColumn(name = "old_class_id")
    private Class oldClass;
    @ManyToOne
    @JoinColumn(name = "new_class_id")
    private Class newClass;

    public ClassChangeRequest(String status, Student student, Class oldClass, Class newClass) {
        this.status = status;
        this.student = student;
        this.oldClass = oldClass;
        this.newClass = newClass;
    }

    public ClassChangeRequest() {
    }
}
