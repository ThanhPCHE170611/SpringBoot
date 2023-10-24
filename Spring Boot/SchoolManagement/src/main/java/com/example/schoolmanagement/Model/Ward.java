package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table
@Getter
@Setter
public class Ward implements Serializable {
    @Id
    private Long id;
    private String wardname;

    @ManyToOne
    @JoinColumn(name="district")
    private District district;
    private String status;

    public Ward(long id, String wardname) {
        this.id = id;
        this.wardname = wardname;
        this.status = "active";
    }

    public Ward(long id, String wardname, District district) {
        this.id = id;
        this.wardname = wardname;
        this.status = "active";
        this.district = district;
    }

    public Ward() {
    }
}
