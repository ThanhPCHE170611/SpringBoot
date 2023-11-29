package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table
@Getter
@Setter
public class Error {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String error;

    private String rowNumber;


    public Error(String string, int index) {
        this.error = string;
        this.rowNumber = "Dòng " + index;
    }

    public Error() {

    }
}
