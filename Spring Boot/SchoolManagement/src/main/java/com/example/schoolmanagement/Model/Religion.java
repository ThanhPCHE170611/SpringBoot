package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Table
@Entity
@Getter
@Setter
public class Religion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    private String religion;
    private String status;
}
