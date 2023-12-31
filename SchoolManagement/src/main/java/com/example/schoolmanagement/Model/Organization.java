package com.example.schoolmanagement.Model;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table
@Setter
@Getter
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
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

    @OneToMany(mappedBy = "classOrganization")
    private List<Class> classOrganization;

    public Organization(Ward newWard) {
        this.ward = newWard;
        this.status = "active";
        Date currentDay = new Date();
        this.operatingday = currentDay;
    }

    public Organization(String schoolcode, String schoolname, Organization newWardOrganization) {
        this.schoolcode = schoolcode;
        this.schoolname = schoolname;
        this.wardorganization = newWardOrganization;
        this.status = "active";
        Date currentDay = new Date();
        this.operatingday = currentDay;
    }

    public Organization() {

    }
}
