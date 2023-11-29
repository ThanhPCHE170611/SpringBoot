package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table
@Getter
@Setter
public class District implements Serializable {
    @Id
    private Long id;
    private String districname;

    @ManyToOne
    @JoinColumn(name="city")
    private City city;

    private String status;

    public District(long id, String distict) {
        this.id = id;
        this.districname = distict;
        this.status = "active";
    }

    public District(long id, String distict, City city) {
        this.id = id;
        this.districname = distict;
        this.status = "active";
        this.city = city;
    }

    public District() {

    }
}

