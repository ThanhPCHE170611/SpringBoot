package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GeneratorType;

import javax.persistence.*;
import java.util.Date;

@Table
@Entity
@Getter
@Setter
public class ImportUserHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;
    private Date date;
    private String status;
    private String error;
}
