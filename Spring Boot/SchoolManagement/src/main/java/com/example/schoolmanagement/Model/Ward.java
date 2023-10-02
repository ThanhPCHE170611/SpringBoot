package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Getter
@Setter
public class Ward {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String wardname;

    @ManyToOne
    @JoinColumn(name="district")
    private District district;
    private String status;
}
