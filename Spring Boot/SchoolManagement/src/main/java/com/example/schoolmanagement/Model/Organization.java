package com.example.schoolmanagement.Model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Entity
@Table
@Setter
@Getter
public class Organization {
    @Id
    private String schoolcode;


    private String schoolname;

    @OneToOne
    @JoinColumn(name = "ward")
    private Ward ward;
    @OneToOne
    @JoinColumn(name = "district")
    private District district;
    @OneToOne
    @JoinColumn(name = "city")
    private District city;

    private String status;
    private Date operatingday;

    @OneToMany
    @JoinColumn(name = "class")
    private List<Class> aClass;

    private String path;


}
