package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table
@Setter
@Getter
public class Organization {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long Id;

    private String schoolcode;



    private String schoolname;

    @ManyToOne(optional = true)
    @JoinColumn(name = "wardorganization")
    private Organization wardorganization;


    @OneToOne
    @JoinColumn(name = "ward")
    private Ward ward;

    private String status;
    private Date operatingday;

    @ManyToOne(optional = true)
    @JoinColumn(name = "classorganization")
    private Organization classorganization;

    @OneToMany
    @JoinColumn(name = "class")
    private List<Class> classes;


    private String path;


}
