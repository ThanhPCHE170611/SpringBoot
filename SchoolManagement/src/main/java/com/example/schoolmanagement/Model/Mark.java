package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Getter
@Setter
public class Mark {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private double mark;

    private double weight;

    public Mark(double i, double i1) {
        this.mark = i;
        this.weight = i1;
    }

    public Mark() {
    }

    public Mark(Long id, double mark, double weight) {
        this.id = id;
        this.mark = mark;
        this.weight = weight;
    }
}
