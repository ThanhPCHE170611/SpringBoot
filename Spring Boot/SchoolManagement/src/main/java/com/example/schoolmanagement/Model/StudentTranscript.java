package com.example.schoolmanagement.Model;


import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Table
@Entity
@Getter
@Setter
public class StudentTranscript {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "student")
    private Users student;

    @ManyToOne
    @JoinColumn(name = "semester")
    private Semester semester;

    @ManyToOne
    @JoinColumn(name = "subject")
    private Subject subject;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="transcript_mark", joinColumns = @JoinColumn(name ="transcript_id"),
            inverseJoinColumns = @JoinColumn(name="mark_id"))
    private List<Mark> marks;
}
