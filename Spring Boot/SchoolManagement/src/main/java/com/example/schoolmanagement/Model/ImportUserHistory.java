package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GeneratorType;

import javax.persistence.*;
import java.sql.Date;
import java.util.List;

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
    private String hexString;
    @OneToMany
    private List<Users> students;
    @Column(length = 1000)
    private String path;
    @ManyToOne
    private Users author;

    @OneToMany
    private List<Error> errors;

    public ImportUserHistory(Users author, Date currentDate, List<Error> errorTotal, int id) {
        this.author = author;
        this.date = currentDate;
        this.status = "fail";
        this.path = "/excelfiles/" + author.getRollNumber() + "_" + currentDate + "_"+ id+ ".xlsx";
        this.errors = errorTotal;
    }

    public ImportUserHistory() {

    }

    public ImportUserHistory(Users author, Date currentDate, int id){
        this.author = author;
        this.date = currentDate;
        this.status = "success";
        this.path = "/excelfiles/" + author.getRollNumber() + "_" + currentDate + "_"+ id+".xlsx";
    }
}
