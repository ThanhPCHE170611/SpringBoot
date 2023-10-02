package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Getter
@Setter
public class District {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String districname;

    @ManyToOne
    @JoinColumn(name="city")
    private City city;

    private String status;
}

