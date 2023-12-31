package com.example.schoolmanagement.Model;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Comment;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@Table
@Getter
@Setter
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class Class {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    private String classname;
    @OneToMany(mappedBy = "classTeaching")
    @Comment("")
    private List<TeacherClassSubject> classTeachers;

    @ManyToOne
    @JoinColumn(name = "class_organization")
    private Organization classOrganization;

    public Class(String classname, Organization schoolOrganization) {
        this.classname = classname;
        this.classOrganization = schoolOrganization;
    }

    public Class() {

    }

    public Class(Long classid, String classname, Organization schoolOrganization) {
        this.Id = classid;
        this.classname = classname;
        this.classOrganization = schoolOrganization;
    }
}
