package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table
@Getter
@Setter
public class Subject {
    @Id
    private String subjectcode;

    private String subjectname;

    private String status;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="subject_organization", joinColumns = @JoinColumn(name ="subjectcode"),
            inverseJoinColumns = @JoinColumn(name="organizationid"))
    private Set<Organization> organizations;

    @OneToMany(mappedBy = "subjectTeaching")
    private List<TeacherClassSubject> subjectTeachers;

    public Subject(String subjectcode, String subjectname, Organization schoolOrganization) {
        this.subjectcode = subjectcode;
        this.subjectname = subjectname;
        this.status = "active";
        this.organizations = new HashSet<>();
        this.organizations.add(schoolOrganization);
    }

    public Subject() {

    }
}
