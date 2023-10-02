package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Setter
@Getter
public class Ethnic {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;
    private String ethnic;
    private String status;
}
