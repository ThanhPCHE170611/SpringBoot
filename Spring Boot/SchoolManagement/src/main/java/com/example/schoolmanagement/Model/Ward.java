package com.example.schoolmanagement.Model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table
@Getter
@Setter
public class Ward {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String wardname;

    @ManyToOne
    @JoinColumn(name="district")
    private District district;
}
